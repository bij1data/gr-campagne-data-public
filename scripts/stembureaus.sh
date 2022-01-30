#!/usr/bin/bash
# download data on voting locations for municipalities relevant for BIJ1, and offer them in CSV format
# currently using the location data for voting locations from elections TK2021
# data source: https://ckan.dataplatform.nl/dataset/stembureaus-tweede-kamerverkiezingen-2021/resource/eb2c1546-7f8d-41d4-9719-61b53b6d2111
# reason we're using the API to get data by municipality is we couldn't find a
# way to download the full dataset...

# create a virtual environment
python3 -m venv ./env
# active the virtual env
source ./env/bin/activate
# install python dependencies
pip install -r requirements.txt

mkdir -p data/stembureaus/by_municipality/
# for each municipality that BIJ1 is running in for GR2022
municipalities=( Amsterdam Rotterdam Utrecht Almere Delft )
for gemeente in "${municipalities[@]}"; do
	# download and filter data
	curl 'https://ckan.dataplatform.nl/api/3/action/datastore_search' -H 'Content-Type: application/x-www-form-urlencoded' --data-raw "%7B%22resource_id%22%3A%22eb2c1546-7f8d-41d4-9719-61b53b6d2111%22%2C%22q%22%3A%22%22%2C%22filters%22%3A%7B%22Gemeente%22%3A%22${gemeente}%22%7D%2C%22limit%22%3A1000%2C%22offset%22%3A0%7D" --compressed | jq '.result.records' > "${gemeente}.json"
	# convert to csv
    python -c "import pandas as pd; pd.read_json('${gemeente}.json').to_csv('data/stembureaus/by_municipality/${gemeente}.csv', index=False)"
	rm "${gemeente}.json"
done
# combine CSVs
head -n 1 data/stembureaus/by_municipality/Amsterdam.csv > data/stembureaus/combined.csv
for gemeente in data/stembureaus/by_municipality/*.csv; do     
    tail -n+2 "$gemeente";
done >> data/stembureaus/combined.csv
