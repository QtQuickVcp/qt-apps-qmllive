#!/usr/bin/env bash

cd build
mkdir -p libs
cd libs

arch=x64
extension=tar.gz
os=Linux
url=https://dl.bintray.com/machinekoder/QtQuickVcp-Development/QtQuickVcp_Development-latest-${os}-${arch}.${extension}
wget -O qtquickvcp-${arch}.tar.gz ${url}
