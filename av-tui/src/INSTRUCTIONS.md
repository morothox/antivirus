# AV-TUI Project - Zusammenfassung & Leitfaden

## Projekt: Antivirus TUI in Rust

**Ziel:** Eine Terminal-UI (TUI) für einen selbstgeschriebenen Antivirus (Python-Backend) mit Rust und ratatui.

**Stand:** 2026-03-30

---

## Was du gelernt hast

### Rust-Grundlagen

| Konzept | Erklärung |
|---------|-----------|
| **Vec\<T\>** | Dynamische Liste, wie `list` in Python |
| **String vs &str** | `String` = besitzt Speicher (heap), `&str` = nur Referenz (Slice) |
| **&reference** | `&x` = "leiht" sich x, ohne ownership zu übernehmen |
| **Result\<T, E\>** | Error-Handling: `Ok(value)` oder `Err(error)` |
| **? Operator** | Bei Error → sofort zurück; bei Ok → value extrahieren |
| **struct** | Datenstruktur mit Feldern |
| **impl** | Methods für einen struct (wie `class` in Python) |
| **fn new() -\> Self** | Konstruktor für einen struct |
| **Closures** ` \|x\| { ... } ` | Anonyme Funktionen, wie `lambda` in Python |
| **match** | Pattern matching, wie `match/case` in anderen Sprachen |
| **loop** | Unendliche Schleife, bis `break` |
| **enumerate()** | Iteriert mit (index, item) |
| **format!()** | String-Formatierung, wie f-strings in Python |
| **push_str()** | Text an String anhängen |

### JSON-Parsing

```rust
use serde::Deserialize;

#[derive(Deserialize)]
struct ScanResult {
    path: String,
    result: String,
}

let parsed: ScanResult = serde_json::from_str(&line)?;
```

### TUI mit ratatui

| Komponente | Was es ist |
|------------|-------------|
| **Terminal** | Dein Fenster, init/rest |
| **Alternate Screen** | Terminal leeren (wie vim/nano) |
| **enable_raw_mode()** | Tasten direkt lesen |
| **Frame** | Zeichenbereich, jeder Loop neu gezeichnet |
| **Widget** | UI-Element (Paragraph, List, Block) |
| **Event-Loop** | Zeichnen → Auf Tasten warten → Wiederholen |

### Dependencies (Cargo.toml)

```toml
[dependencies]
serde = { version = "1.0", features = ["derive"] }
serde_json = "1.0"
ratatui = "0.30"
crossterm = "0.29"
```

---

## Was noch fehlt / Als nächstes

### Kurzfristig (nächste Schritte)

1. **Selection highlighten** – Ausgewähltes Ergebnis mit Farbe hervorheben
   - `ratatui::text::{Line, Span}` für farbige Teile
   - `Style` mit `fg(Color)` und `bg(Color)`

2. **Borders/Layout** – Schönen Rahmen um die Ergebnisse
   - `ratatui::widgets::Block`

3. **Scrollen** – Wenn mehr Ergebnisse als Platz
   - Offset berechnen, nur sichtbare zeigen

### Mittelfristig

4. **Details-Ansicht** – Enter = Details des ausgewählten Files
   - SHA256 anzeigen, Dateigröße, etc.

5. **Aktionen** – Tasten für Quarantäne, Löschen, etc.

6. **Real-time Scan** – Während TUI läuft scannen

### Langfristig

7. **Rust vertiefen** – Ownership, Borrowing, Lifetimes verstehen
8. **Ratatui Widgets** – List, Table, Gauge, etc.
9. **Refactoring** – Code modularer machen

---

## Code-Struktur (aktuell)

```
src/
└── main.rs
    ├── ScanResult (struct)   # JSON-Struktur
    ├── App (struct)          # State: results, selected, status
    ├── scan_directory()      # Python-Scanner aufrufen
    ├── run_tui()             # TUI-Loop
    └── main()                # Start
```

---

## Wichtige Befehle

```bash
# Kompilieren und laufen
cargo run

# Nur kompilieren (Warnings checken)
cargo check

# Optimiert kompilieren
cargo build --release

# Lint/Format
cargo fmt
cargo clippy
```

---

## Lern-Ressourcen

- **Rust Book:** https://doc.rust-lang.org/book/
- **Ratatui Examples:** https://github.com/ratatui-org/ratatui/tree/master/examples
- **Serne Docs:** https://serde.rs/

---

## Konfiguration

### Neovim LSP (rust-analyzer)

```bash
# Installieren
sudo pacman -S rust-analyzer
```

LazyVim aktiviert es automatisch wenn im PATH.

---

## Nächste Session

Starte mit `/teaching` oder sag einfach "weiter"!

Ziele für nächste Session:
- [ ] Selection mit Farbe highlighten
- [ ] Borders um die UI
- [ ] Scrollen bei vielen Ergebnissen

Viel Erfolg! 🦠🚀
