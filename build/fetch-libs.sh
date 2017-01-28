#!/usr/bin/env bash

cd build
mkdir -p libs
cd libs

arch=x64
extension=tar.gz
package=$(wget -qO- https://dl.bintray.com/machinekoder/QtQuickVcp-Development/ | grep ${arch} | grep ${extension} | tail -n 1 | awk -F"\"" '{print $4}')
url=https://dl.bintray.com/machinekoder/QtQuickVcp-Development/${package:1}
mkdir -p output && wget -O qtquickvcp-${arch}.tar.gz ${url}

arch=armv7
extension=tar.gz
package=$(wget -qO- https://dl.bintray.com/machinekoder/QtQuickVcp-Development/ | grep ${arch} | grep ${extension} | tail -n 1 | awk -F"\"" '{print $4}')
url=https://dl.bintray.com/machinekoder/QtQuickVcp-Development/${package:1}
mkdir -p output && wget -O qtquickvcp-${arch}.tar.gz ${url}

rm -r output
