#!/bin/bash

cd $(dirname "$0")

rm -rf "./output"
mkdir -p "./output"

####################################################################

rm -rf "./testvenv"

python3 -m venv testvenv

source ./testvenv/bin/activate

pip install cadscorelt

pip install biotite

pip install gemmi

pip install biopython

pip install pandas

####################################################################

find ./input/ -type f -name '*.py' \
| while read -r SCRIPTFILE
do
	SCRIPTNAME="$(basename ${SCRIPTFILE})"
	
	python3 -B "${SCRIPTFILE}" > "./output/${SCRIPTNAME}.output.txt"
done

################################################################################

git status -s ./output/

