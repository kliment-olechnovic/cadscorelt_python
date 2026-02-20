#!/bin/bash

cd $(dirname "$0")/..

rm -rf "./workvenv"

python3 -m venv workvenv

source ./workvenv/bin/activate

python -m pip install --upgrade pip build twine

deactivate

exit 0
