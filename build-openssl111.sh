OPENSSL_VER=1.1.1w
OPENSSL_PATCH_VER=1.1.1f
OPENSSL_PREFIX=/opt/ssl
wget https://github.com/openssl/openssl/releases/download/OpenSSL_1_1_1w/openssl-$OPENSSL_VER.tar.gz
rm -fr openssl-$OPENSSL_VER
tar -xf openssl-$OPENSSL_VER.tar.gz
cd openssl-$OPENSSL_VER

patch -p1 < ../openresty/patches/openssl-$OPENSSL_PATCH_VER-sess_set_get_cb_yield.patch;
./config shared enable-ssl3 enable-ssl3-method -g --prefix=$OPENSSL_PREFIX --libdir=lib -DPURIFY > build.log 2>&1
make -j$(nproc)
mkdir fakeroot
make install_sw DESTDIR=fakeroot
tar -czf openssl-$OPENSSL_VER-x64-focal.tar.gz fakeroot opt

