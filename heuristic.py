from dataclasses import dataclass
from collections import defaultdict
import re
import pefile
import sqlite3

filename = "7z2600-x64.exe"

# low
#
#         viele Treffer →→ kleiner positiver Score
#
#         wenige Treffer →→ 0 oder kleiner negativer Score
#
#     moderate
#
#         viele Treffer →→ kleiner negativer oder neutraler Score, je nach Kategorie
#
#         wenige Treffer →→ negativer Score mit Faktor 2
#
#     high
#
#         schon einzelne Treffer sind relevant
#
#         viele Treffer →→ klar negativer Score mit Faktor 2 oder 3


@dataclass
class FILE:
    """Class for keeping track of each virus and point"""

    x: int
    y: int
    filename: str
    categories: list

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
        for obj in calls:
            lenght = len(obj) - 2
            count = obj["count"]
            result = count / lenght

            if result >= 2 / 3:
                self.x += 1
            else:
                self.x -= 1

            self.categories.append(obj["name"])


v1 = FILE(0, 0, filename=filename, categories=[])

con = sqlite3.connect("av.db")
cur = con.cursor()

query = cur.execute("SELECT * FROM apis")


for row in query:
    print(row)


# v1.check_api()
#
# v1.analyze_categories()
#
# print(v1)
