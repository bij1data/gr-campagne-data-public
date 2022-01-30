#!/usr/bin/bash
# get data on dutch election results
# datasets taken from: https://data.overheid.nl/community/organization/kiesraad

bash kiesraad.sh
script=scripts/verkiezingsuitslagen/eml2csv.sh

bash $script ep2009 http://data.overheid.nl/OpenDataSets/EML_bestanden_EP2009.zip
bash $script tk2010 https://data.overheid.nl/OpenDataSets/EML_bestanden_TK2010.zip
bash $script tk2012 https://data.overheid.nl/OpenDataSets/EML_bestanden_TK2012.zip
bash $script gr2014 https://data.overheid.nl/OpenDataSets/EML_bestanden_GR2014.zip
bash $script ep2014 https://data.overheid.nl/OpenDataSets/EML_bestanden_EP2014.zip
bash $script ws2015 https://data.overheid.nl/OpenDataSets/EML_bestanden_WS2015.zip
bash $script ps2015 https://data.overheid.nl/OpenDataSets/EML_bestanden_PS2015.zip
bash $script tk2017 https://data.overheid.nl/OpenDataSets/verkiezingen2017/Dataset_TK2017.zip
bash $script gr2018 https://data.overheid.nl/OpenDataSets/verkiezingen2018/GR2018.zip
bash $script ws2019 https://data.overheid.nl/OpenDataSets/verkiezingen/EMLbestandenWS2019.zip
bash $script ps2019 https://data.overheid.nl/OpenDataSets/verkiezingen/EMLbestandenPS2019.zip
bash $script ek2019 http://data.overheid.nl/sites/default/files/dataset/625c1d0a-32bf-40b3-9079-bbff00f28667/resources/EML_bestanden_EK2019.zip
bash $script ep2019 https://data.overheid.nl/OpenDataSets/verkiezingen/EMLbestandenEP2019.zip

tk2021=( 1 2 3 )
for i in "${tk2021[@]}"; do
    bash $script tk2021 "https://data.overheid.nl/sites/default/files/dataset/39e9bad4-4667-453f-ba6a-4733a956f6f8/resources/EML_bestanden_TK2021_deel_${i}.zip"
done
