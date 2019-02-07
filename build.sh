#!/bin/bash

set -o errexit -o nounset -o pipefail -o xtrace

PYTHON_VERSION=3.7.2

# this must not be plain python as otherwise the system Python gets overridden
PACKAGE_NAME=python3.7

# sources need to be available for build-deb
sed --in-place=~orig 's/# deb-src/deb-src/' /etc/apt/sources.list

apt-get update
apt-get upgrade

# install things we need for this script
apt-get install --assume-yes \
    checkinstall \
    wget \

# install things to compile Python
apt-get build-dep --assume-yes python3.5

# download the latest version (from https://www.python.org/downloads/source/)
wget https://www.python.org/ftp/python/${PYTHON_VERSION}/Python-${PYTHON_VERSION}.tgz

tar xvf Python-${PYTHON_VERSION}.tgz
cd Python-${PYTHON_VERSION}

# enabling optimizations requires running tests which takes a long time but results in a faster Python
./configure \
    --enable-optimizations \
    --with-ensurepip=install \

# compile as much as possible in parallel
make --jobs 4

# use altinstall to not replace the system Python
checkinstall --pkgname ${PACKAGE_NAME} --pkgversion ${PYTHON_VERSION} --default make altinstall
