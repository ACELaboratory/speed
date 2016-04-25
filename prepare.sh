#! /bin/bash
cd csv
sed -i 's/,/./g' *.csv
sed -i 's/;/,/g' *.csv