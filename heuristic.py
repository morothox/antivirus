from dataclasses import dataclass
from collections import defaultdict
import re
import pefile

filename = "7z2600-x64.exe"


@dataclass
class FILE:
    """Class for keeping track of each virus and point"""

    x: int
    y: int
    filename: str

    def count(self):
        return self.x + self.y

    def check_api(self):
        pe = pefile.PE(self.filename)

        for obj in calls:
            for lib in pe.DIRECTORY_ENTRY_IMPORT:
                for func in lib.imports:
                    name = func.name
                    if name is not None and name in obj:
                        obj[name] += 1
                        obj["count"] += 1

        return calls

    def analyze_categories(self):

    
    gui = {
    b"MessageBoxW": 0,
    b"ShowWindow": 0,
    b"GetMessageW": 0,
    b"DispatchMessageW": 0,
    b"CreateDialogParamW": 0,
    b"SendMessageW": 0,
    b"CoInitialize": 0,
    "count": 0,
}

registry = {
    b"RegCreateKeyExW": 0,
    b"RegSetValueExW": 0,
    b"RegOpenKeyExW": 0,
    b"RegCloseKey": 0,
    b"RegQueryValueExW": 0,
    b"RegDeleteKeyW": 0,
    "count": 0,
}

calls = [gui, registry]

v1 = FILE(0, 0, filename=filename)

res = v1.check_api()

print(calls)


