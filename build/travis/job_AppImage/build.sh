#!/bin/bash
# Run this script from QtQuickVcp's root directory

# Build portable Linux AppImages and upload them to Bintray. AppImages will
# always be uploaded unless a list of specific branches is passed in. e.g.:
#    $   build.sh  --upload-branches  master  my-branch-1  my-branch-2
# Builds will be for the native architecture (64 bit) unless another is
# specified for cross-compiling. (e.g. build.sh --i686 or build.sh --armhf)

set -e # exit on error
set -x # echo commands

# create a full clone
#git fetch --unshallow
# find out version number
release=1
git describe --exact-match HEAD 2> /dev/null || release=0
if [ $release -eq 0 ]; then
    date="$(date -u +%Y%m%d%H%M)"

    branch="$TRAVIS_BRANCH"
    [ "$branch" ] || branch="$(git rev-parse --abbrev-ref HEAD)"

    revision="$(echo "$TRAVIS_COMMIT" | cut -c 1-7)"
    [ "$revision" ] || revision="$(git rev-parse --short HEAD)"
    version="${date}-${branch}-${revision}"
else
    version="$(git describe --tags)"
    upload=true
fi

revisionfile="./src/revision.h"
echo "#define REVISION \"${version}\"" > ${revisionfile}

# fetch QtQuickVcp libs
./build/fetch-libs.sh

# Build AppImage depending on arch specified in $1 if cross-compiling, else default build x86_64
projectdir=qt-apps-qmllive
case "$1" in

  * )
    [ "$1" == "--x86_64" ] && shift || true
    # Build QtQuickVcp AppImage inside native (64-bit x86) Docker image
    docker run -i -v "${PWD}:/${projectdir}" machinekoder/qtquickvcp-docker-linux-x64:latest \
           /bin/bash -c "/${projectdir}/build/Linux/portable/Recipe"
    platform="x64"
    ;;
esac

# Should the AppImage be uploaded?
# upload is already on release
if [ "${upload}" != "true" ]; then
    if [ "$1" == "--upload-branches" ] && [ "$2" != "ALL" ]; then
        # User passed in a list of zero or more branches so only upload those listed
        shift
        for upload_branch in "$@" ; do
            [ "$branch" == "$upload_branch" ] && upload=true || true # bypass `set -e`
        done
    else
        # No list passed in (or specified "ALL"), so upload on every branch
        upload=true
    fi
    # skip pull requests
    if [ "${TRAVIS_PULL_REQUEST}" != "false" ]; then
        upload=
    fi
fi

if [ "${upload}" ]; then
    # rename binaries
    packagename=QmlLiveBench
    if [ $release -eq 1 ]; then
        target="${packagename}"
    else
        target="${packagename}_Development"
    fi
    mv build.release/${packagename}.AppImage ${target}-${version}-${platform}.AppImage
    # Upload AppImage to Bintray
    ./build/travis/job_AppImage/bintray_app.sh ${packagename}*.AppImage
else
  echo "On branch '$branch' so AppImage will not be uploaded." >&2
fi
