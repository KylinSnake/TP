#!/usr/bin/sh

INSTALL_DIR=$1
BUILD_DIR=$2
CUR=`pwd`
cd $BUILD_DIR

if [ ! -d "libuv" ];then
	git clone "https://github.com/libuv/libuv.git"
	cd libuv
else
	cd lbuv
	git pull
fi

mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DBUILD_SHARED_LIBS=ON -DCMAKE_INSTALL_LIBDIR=lib ../
cmake --build . --target install

echo "Success to build libuv"
cd $CUR
