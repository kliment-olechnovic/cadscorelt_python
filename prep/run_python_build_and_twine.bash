#!/bin/bash

cd "$(dirname $0)/.."

set -e

source ./workvenv/bin/activate

rm -rf ./cadscorelt.egg-info
rm -f ./dist/*.tar.gz
rm -f ./dist/*.whl

python3 -m build

rm -f ./dist/*.whl

cd ./dist
ls cibw-wheels-*.zip | xargs -L 1 unzip
cd -

twine upload dist/*.tar.gz dist/*.whl --verbose

