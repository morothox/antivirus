import hashlib
import sqlite3
import argparse
from pathlib import Path
import json


def emit(event: dict):
    print(json.dumps(event, ensure_ascii=False), flush=True)


def hash_file(path):
    h = hashlib.sha256()
    with open(path, "rb") as f:
        for chunk in iter(lambda: f.read(8192), b""):
            h.update(chunk)
    return h.hexdigest()


def analyze_hash(cur, sha):
    cur.execute("SELECT document FROM hashes WHERE hash = ?", (sha,))
    row = cur.fetchone()
    if row is None:
        return "No virus"
    return row[0]


def scan_file(path, cur):
    try:
        sha = hash_file(path)
        result = analyze_hash(cur, sha)
        # print(f"{path}: {result}")
        emit(
            {"type": "scan_result", "path": str(path), "sha256": sha, "result": result}
        )
    except (PermissionError, OSError) as e:
        # print(f"{path}: ERROR ({e})")
        emit({"type": "scan_error", "path": str(path), "error": str(e)})


def main():
    parser = argparse.ArgumentParser(description="Virusscanner")
    parser.add_argument(
        "-d", "--db_path", type=Path, required=True, help="Path to your database"
    )
    parser.add_argument(
        "-f",
        "--file_path",
        type=Path,
        required=True,
        help="Path to the file or directory you want to scan",
    )
    args = parser.parse_args()

    conn = sqlite3.connect(args.db_path)
    cur = conn.cursor()

    try:
        if args.file_path.is_file():
            scan_file(args.file_path, cur)

        elif args.file_path.is_dir():
            for path in args.file_path.rglob("*"):
                if path.is_file():
                    scan_file(path, cur)

        else:
            print("Invalid path")
    finally:
        cur.close()
        conn.close()


if __name__ == "__main__":
    main()
