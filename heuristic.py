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

    def check_categories(self):
        con = sqlite3.connect("av.db")
        cur = con.cursor()

        query = cur.execute("SELECT api_name FROM apis")
        categories = {}

        pe = pefile.PE(self.filename)

        for lib in pe.DIRECTORY_ENTRY_IMPORT:
            for func in lib.imports:
                
                name = func.name.decode('utf-8', errors='replace')
                
                danger = cur.execute("SELECT name, danger FROM groups WHERE group_id = (SELECT group_id FROM apis WHERE api_name = ?)", (name,))
                row = danger.fetchone()
                if row is not None:
                    if row[0] in categories:
                        key = row[0]
                        categories[key] += 1

                    else:
                        key = row[0]
                        categories[key] = 1
        
        return(categories)
    
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



v1.check_api()
#
# v1.analyze_categories()
#
# print(v1)
