#!/bin/bash
if [ "$(whoami)" != "root" ]; then
 echo "Script must be run as user: root"
 exit 255
fi
#Header
cd $LFS/sources
tar xvf eudev-3.2.11.tar.gz
cd eudev-3.2.11
./configure --prefix=/usr           \
            --bindir=/usr/sbin      \
            --sysconfdir=/etc       \
            --enable-manpages       \
            --disable-static

make 

mkdir -pv /usr/lib/udev/rules.d
mkdir -pv /etc/udev/rules.d

make check

make install

tar -xvf ../udev-lfs-20171102.tar.xz
make -f udev-lfs-20171102/Makefile.lfs install

udevadm hwdb --update


# Footer
cd $LFS/sources
rm -rf eudev-3.2.11
echo "Done - eudev-3.2.11.tar.gz"