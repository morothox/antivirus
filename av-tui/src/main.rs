use std::io::{BufRead, BufReader};
use std::process::{Command, Stdio};
use std::time::Duration;

use ratatui::{
    backend::CrosstermBackend,
    crossterm::{
        event::{self, DisableMouseCapture, EnableMouseCapture, Event, KeyCode},
        execute,
        terminal::{disable_raw_mode, enable_raw_mode, EnterAlternateScreen, LeaveAlternateScreen},
    },
    widgets::{Paragraph, Wrap},
    Terminal,
};
use serde::Deserialize;

#[derive(Deserialize)]
struct ScanResult {
    path: String,
    #[allow(dead_code)]
    sha256: String,
    result: String,
}

struct App {
    results: Vec<ScanResult>,
    selected: usize,
    status: String,
    target_path: String,
}

impl App {
    fn new(target_path: &str) -> Self {
        Self {
            results: Vec::new(),
            selected: 0,
            status: String::from("Idle"),
            target_path: target_path.to_string(),
        }
    }
}

fn scan_directory() -> std::io::Result<Vec<ScanResult>> {
    let mut results = Vec::new();

    let mut child = Command::new("python3")
        .arg("/home/morothox/Project/Cs50/finalproject/scanner.py")
        .arg("-d")
        .arg("/home/morothox/Project/Cs50/finalproject/av.db")
        .arg("-f")
        .arg("/home/morothox/Project/Cs50/finalproject/testdir")
        .stdout(Stdio::piped())
        .spawn()?;

    let stdout = child.stdout.take().expect("child has no stdout");
    let reader = BufReader::new(stdout);

    for line in reader.lines().flatten() {
        if let Ok(scan_result) = serde_json::from_str::<ScanResult>(&line) {
            results.push(scan_result);
        }
    }

    Ok(results)
}

fn run_tui(app: &mut App) -> std::io::Result<()> {
    enable_raw_mode()?;
    let mut stdout = std::io::stdout();
    execute!(stdout, EnterAlternateScreen, EnableMouseCapture)?;
    let backend = CrosstermBackend::new(stdout);
    let mut terminal = Terminal::new(backend)?;

    loop {
        // Draw UI
        terminal.draw(|f| {
            let header = format!(
                "🦠 AV Scanner | 📂 {} | 📊 {} files",
                app.target_path,
                app.results.len()
            );

            let mut output = String::new();

            for (idx, result) in app.results.iter().enumerate() {
                let marker = if idx == app.selected { "→" } else { " " };
                let icon = if result.result.contains("Virus") { "🦠" } else { "✅" };
                output.push_str(&format!("{} {} {} - {}\n", marker, icon, result.path, result.result));
            }

            output.push_str("\n[q] Quit | [↓↑] Navigate");

            let full_text = format!("{}\n\n{}", header, output);
            let paragraph = Paragraph::new(full_text).wrap(Wrap { trim: true });
            f.render_widget(paragraph, f.area());
        })?;

        // Handle input
        let timeout = Duration::from_millis(100);
        if !event::poll(timeout)? {
            continue;
        }

        let Event::Key(key) = event::read()? else {
            continue;
        };

        match key.code {
            KeyCode::Char('q') => break,
            KeyCode::Down => {
                if app.selected < app.results.len().saturating_sub(1) {
                    app.selected += 1;
                }
            }
            KeyCode::Up => {
                if app.selected > 0 {
                    app.selected -= 1;
                }
            }
            _ => {}
        }
    }

    // Cleanup
    disable_raw_mode()?;
    execute!(
        terminal.backend_mut(),
        LeaveAlternateScreen,
        DisableMouseCapture
    )?;
    terminal.show_cursor()?;

    Ok(())
}

fn main() -> std::io::Result<()> {
    let mut app = App::new("/home/morothox/test");

    app.status = String::from("Scanning...");
    let scan_results = scan_directory()?;
    app.results.extend(scan_results);
    app.status = format!("Scanned {} files", app.results.len());

    run_tui(&mut app)?;

    Ok(())
}
