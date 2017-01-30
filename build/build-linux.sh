#!/usr/bin/env bash
# Run this script from the projects root directory
BASEDIR=${PWD}
DISTDIR="${BASEDIR}/dist"
PROJECTDIR=qt-apps-qmllive
cd ..
sudo rm -rf docker-build
cp -r ${PROJECTDIR} docker-build
cd docker-build
./build/docker/AppImage/build.sh
mkdir -p "${DISTDIR}"
mv *.AppImage "${DISTDIR}"
cd ..
sudo rm -rf docker-build
