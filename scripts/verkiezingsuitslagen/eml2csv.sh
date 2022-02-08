#!/usr/bin/bash
# get data on dutch election results
# meant for data from https://data.overheid.nl/community/organization/kiesraad
# info on EML format: https://en.wikipedia.org/wiki/Election_Markup_Language
# usage: eml2csv.sh dataset_name_to_put_results zip_url
# example: eml2csv.sh gr2018 https://data.overheid.nl/OpenDataSets/verkiezingen2018/GR2018.zip

# bash kiesraad.sh

name=$1
url=$2

# create data folders
eml=data/elections/eml/$name/
csv=data/elections/csv/$name/
mkdir -p $eml
mkdir -p $csv

# download .eml files

# download and extract
archive=`echo ${url##*/}`
wget -O $archive $url
unzip -u $archive -d $eml
rm $archive

# convert eml files to csv

cd kiesraad
source ./env/bin/activate
python eml2csv.py ../$eml ../$csv
cd ..

# simplify file names
for src in $csv/*.csv; do
    echo $src
    [ -f "$src" ] || continue
    src_file=`echo ${src##*/}`
    dest_file="${src_file##*_}"
    # ^ note that this selector is bugged for municipality names
    # containing underscores, e.g. Sint_Anthonis in dataset tk2021.
    dest="${src/$src_file/$dest_file}"
    mv "$src" "$dest"
done
