#!/bin/bash
set -e

PCRE2_VER=10.42
PCRE2_PREFIX=/opt/pcre2
wget https://github.com/PCRE2Project/pcre2/releases/download/pcre2-${PCRE2_VER}/pcre2-${PCRE2_VER}.tar.gz

rm -fr pcre2-$PCRE2_VER
tar -xf pcre2-$PCRE2_VER.tar.gz
cd pcre2-$PCRE2_VER
./configure --prefix=$PCRE2_PREFIX --enable-jit --enable-utf > build.log 2>&1

make -j$(nproc)
mkdir fakeroot
make install DESTDIR=$PWD/fakeroot
tar -czf pcre2-$PCRE2_VER-x64-focal.tar.gz -C fakeroot opt

