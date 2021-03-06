#!/usr/bin/sh

INSTALL_DIR=$1
BUILD_DIR=$2
CUR=`pwd`
cd $BUILD_DIR
FILE="protobuf-cpp-3.6.1.tar.gz"

if [ ! -f "${BUILD_DIR}/${FILE}" ];then
	wget -P ${BUILD_DIR} "https://github.com/protocolbuffers/protobuf/releases/download/v3.6.1/${FILE}"
fi

if [ ! -d "protobuf-3.6.1" ];then
	tar zxvf ${FILE}
fi

cd protobuf-3.6.1
./configure --prefix=$INSTALL_DIR
make
if [ $? -ne 0 ];then
	echo "Failed to build protobuf-cpp"
	exit 1
fi
make install
echo "Success to build protobuf-cpp"
cd $CUR
