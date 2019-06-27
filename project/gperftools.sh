#!/usr/bin/sh

INSTALL_DIR=$1
BUILD_DIR=$2
CUR=`pwd`
cd $BUILD_DIR

if [ ! -d "gperftools" ];then
	git clone "https://github.com/gperftools/gperftools.git"
	cd gperftools
else
	cd gperftools
	git pull
fi

./autogen.sh
./configure --prefix=$INSTALL_DIR
if [ $? -ne 0 ];then
	echo "Autogen.sh fails, make sure that you have \"sudo yum install autoconf automake libtool\""
	exit 1
fi

make
if [ $? -ne 0 ];then
	echo "Failed to build gperftools"
	exit 1
fi

make install
echo "Success to build gperftools"
cd $CUR
