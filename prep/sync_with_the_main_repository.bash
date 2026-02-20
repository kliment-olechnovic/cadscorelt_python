#!/bin/bash

cd "$(dirname $0)/.."

MAINREPODIR="${HOME}/git/voronota/expansion_lt_cadscore/"

VERSIONID="$(cat ${MAINREPODIR}/latest_release_version.txt)"
SOURCE_PACKAGE_NAME="$(${MAINREPODIR}/package.bash print-name-and-exit)"
SOURCE_PACKAGE_FILE="${MAINREPODIR}/packages_for_release/${SOURCE_PACKAGE_NAME}.tar.gz"

if [ ! -s "$SOURCE_PACKAGE_FILE" ]
then
	SOURCE_PACKAGE_NAME="$(${MAINREPODIR}/package.bash)"
	SOURCE_PACKAGE_FILE="${MAINREPODIR}/packages_for_release/${SOURCE_PACKAGE_NAME}.tar.gz"
fi

mkdir -p ./tmp
cp "$SOURCE_PACKAGE_FILE" "./tmp/"
cd "./tmp"
tar -xf "$(basename ${SOURCE_PACKAGE_FILE})"
cd ..

SOURCE_PACKAGE_DIR="./tmp/${SOURCE_PACKAGE_NAME}"

rm -r "./cpp"
mkdir "./cpp"
cp -r \
  "${SOURCE_PACKAGE_DIR}/src/voronotalt" \
  "${SOURCE_PACKAGE_DIR}/src/voronotalt_cli" \
  "${SOURCE_PACKAGE_DIR}/src/cadscorelt" \
  "${SOURCE_PACKAGE_DIR}/src/cadscorelt_cli" \
  "./cpp/"

rm -r "./cadscorelt"
mkdir "./cadscorelt"
cp "${MAINREPODIR}/swig/cadscorelt/__init__.py" \
  "${MAINREPODIR}/swig/cadscorelt/pandas_interface.py" \
  "${MAINREPODIR}/swig/cadscorelt/biotite_interface.py" \
  "${MAINREPODIR}/swig/cadscorelt/gemmi_interface.py" \
  "${MAINREPODIR}/swig/cadscorelt/biopython_interface.py" \
  "./cadscorelt/"

cp \
  "${MAINREPODIR}/swig/cadscorelt.h" \
  "${MAINREPODIR}/swig/cadscorelt_python.i" \
  "${MAINREPODIR}/swig/README.md" \
  "./"

rm -r "./tests/input"
cp -r \
  "${MAINREPODIR}/swig/tests/input" \
  "./tests/"

cat "./setup.py" \
| sed "s|version=\"\S\+\",|version=\"${VERSIONID}\",|" \
> "./tmp/setup.py"

mv "./tmp/setup.py" "./setup.py"
rm -r "./tmp"

