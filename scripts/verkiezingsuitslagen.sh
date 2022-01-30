#!/usr/bin/bash
# get data on dutch election results
# source: https://data.overheid.nl/dataset/verkiezingsuitslag-tweede-kamer-2021
# info on EML format: https://en.wikipedia.org/wiki/Election_Markup_Language

# create data folders
eml=data/elections/eml/tk2021/
csv=data/elections/csv/tk2021/
mkdir -p $eml
mkdir -p $csv

# download .eml files

# download and uncompress all three parts
parts=( 1 2 3 )
for i in "${parts[@]}"; do
    archive="tk2021_${i}.zip"
    wget -O $archive "https://data.overheid.nl/sites/default/files/dataset/39e9bad4-4667-453f-ba6a-4733a956f6f8/resources/EML_bestanden_TK2021_deel_${i}.zip"
    unzip -u $archive -d $eml
    rm $archive
done

# convert eml files to csv

git clone https://github.com/DIRKMJK/kiesraad.git
cd kiesraad

# prepare python env with deps
python -m venv ./env
source ./env/bin/activate
python -m pip install --upgrade pip
pip install pandas xmltodict selenium bs4

cp ../scripts/eml2csv.py eml2csv.py
python eml2csv.py ../$eml ../$csv
cd ..

# simplify file names
for filename in $csv/*.csv; do
    echo $filename
    [ -f "$filename" ] || continue
    mv "$filename" "${filename/Telling_TK2021_gemeente_}"
done
