OPENSSL_VER=3.0.15
OPENSSL_PATCH_VER=3.0.15
OPENSSL_PREFIX=/opt/ssl
wget https://github.com/openssl/openssl/releases/download/openssl-$OPENSSL_VER/openssl-$OPENSSL_VER.tar.gz
rm -fr openssl-$OPENSSL_VER
tar -xf openssl-$OPENSSL_VER.tar.gz
cd openssl-$OPENSSL_VER

patch -p1 < ../openresty/patches/openssl-$OPENSSL_PATCH_VER-sess_set_get_cb_yield.patch;
./config shared enable-ssl3 enable-ssl3-method -g --prefix=$OPENSSL_PREFIX --libdir=lib -DPURIFY > build.log 2>&1
make -j$(nproc)
mkdir fakeroot
make install_sw DESTDIR=$PWD/fakeroot
tar -czf openssl-$OPENSSL_VER-x64-focal.tar.gz -C fakeroot opt

