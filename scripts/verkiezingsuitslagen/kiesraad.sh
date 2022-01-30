#!/usr/bin/bash
# get and prepare the kiesraad project, to convert EML files to CSV

git clone https://github.com/DIRKMJK/kiesraad.git
cp scripts/verkiezingsuitslagen/eml2csv.py kiesraad/eml2csv.py
cd kiesraad

# prepare python env with deps
python -m venv ./env
source ./env/bin/activate
python -m pip install --upgrade pip
pip install pandas xmltodict selenium bs4
