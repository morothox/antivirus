# FileScanner

#### Video Demo: <URL HERE>

#### Description

This project was created to scan files by hashing virus files from their bytes. The program starts by hashing a file with "Sha256", after that it will compare that hash with a SQLite database that saves malicious hashes. If both hashes match, the program will return the name of the virus, if not it will just return "No Virus". Lastly scan_file() combines all of the functions and returns the path of the files and with what virus they are infected. If they are clean it will return "No virus". The main function checks CMD arguments with argparse, first it checks for file paths, if the file is just a normal file it will call the scan function; if not it will scan the entire Dictionary and then for every file call the scan function.

Usage:

```bash
python scanner.py -d path/to/database.db -f path/to/file_or_directory
```

- `-d` / `--db_path`: path to the SQLite database that contains the table `hashes(hash, document)`.
- `-f` / `--file_path`: path to a single file or to a directory that should be scanned.
