#!/usr/bin/sh

INSTALL_DIR=$1
BUILD_DIR=$2
CUR=`pwd`
cd $BUILD_DIR

if [ ! -d "leveldb" ];then
	git clone "https://github.com/google/leveldb.git"
	cd leveldb
else
	cd leveldb
	git pull
fi

#sudo install autoconf automake libtool curl make g++ unzip
mkdir -p build
cd build
cmake -DCMAKE_INSTALL_PREFIX=$INSTALL_DIR -DBUILD_SHARED_LIBS=ON ../
cmake --build . --target install

echo "Success to build LevelDb"
cd $CUR
