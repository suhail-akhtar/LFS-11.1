#!/bin/bash
if [ "$(whoami)" != "root" ]; then
 echo "Script must be run as user: root"
 exit 255
fi
#Header
cd $LFS/sources
tar xvf gettext-0.21.tar.xz
cd gettext-0.21
./configure --disable-shared

make 

cp -v gettext-tools/src/{msgfmt,msgmerge,xgettext} /usr/bin


# Footer
cd $LFS/sources
rm -rf gettext-0.21
echo "Done - gettext-0.21.tar.xz"