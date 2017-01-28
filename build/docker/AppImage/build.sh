#!/bin/bash
# Run this script from the projects root directory

set -e # exit on error
set -x # echo commands

project=qmllive
sudo docker pull machinekoder/qtquickvcp-docker-linux-x64:latest
sudo docker rm ${project}-linux-x64 || true
sudo docker run --name ${project}-linux-x64 -i -v \
     "${PWD}:/${project}" machinekoder/qtquickvcp-docker-linux-x64:latest \
     /bin/bash -c "/${project}/build/Linux/portable/Recipe"

mv build.release/QmlLiveBench.AppImage QmlLiveBench.AppImage
