#!/usr/bin/python3
# inspired by: https://github.com/DIRKMJK/kiesraad#parse-eml-files
# usage: python kiesraad.py path/to/eml/files path/to/write/csv/files
import sys
from pathlib import Path
from kiesraad import parse_eml
source = Path(sys.argv[1])
dfs = parse_eml.parse_eml(source)
target = Path(sys.argv[2])
target.mkdir(exist_ok=True)
for name, df in dfs.items():
    path = target / name.replace('.eml_aggregate', '.csv')
    print(path)
    df.to_csv(path, index=False)
