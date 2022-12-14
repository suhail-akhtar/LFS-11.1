#!/bin/bash
if [ "$(whoami)" != "root" ]; then
 echo "Script must be run as user: root"
 exit 255
fi
#Header
cd $LFS/sources
tar xvf util-linux-2.37.4.tar.xz
cd util-linux-2.37.4
./configure ADJTIME_PATH=/var/lib/hwclock/adjtime   \
            --bindir=/usr/bin    \
            --libdir=/usr/lib    \
            --sbindir=/usr/sbin  \
            --docdir=/usr/share/doc/util-linux-2.37.4 \
            --disable-chfn-chsh  \
            --disable-login      \
            --disable-nologin    \
            --disable-su         \
            --disable-setpriv    \
            --disable-runuser    \
            --disable-pylibmount \
            --disable-static     \
            --without-python     \
            --without-systemd    \
            --without-systemdsystemunitdir

make 

bash tests/run.sh --srcdir=$PWD --builddir=$PWD

rm tests/ts/lsns/ioctl_ns

chown -Rv tester .
su tester -c "make -k check"

make install


# Footer
cd $LFS/sources
rm -rf util-linux-2.37.4
echo "Done - util-linux-2.37.4.tar.xz"