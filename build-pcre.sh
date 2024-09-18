#!/bin/bash
set -e

PCRE_VER=8.45
PCRE_PREFIX=/opt/pcre
wget https://downloads.sourceforge.net/project/pcre/pcre/${PCRE_VER}/pcre-${PCRE_VER}.tar.gz

rm -fr pcre-$PCRE_VER
tar -xf pcre-$PCRE_VER.tar.gz
cd pcre-$PCRE_VER
./configure --prefix=$PCRE_PREFIX --enable-jit --enable-utf --enable-unicode-properties > build.log 2>&1

make -j$(nproc)
mkdir fakeroot
make install DESTDIR=$PWD/fakeroot
tar -czf pcre-$PCRE_VER-x64-focal.tar.gz -C fakeroot opt

