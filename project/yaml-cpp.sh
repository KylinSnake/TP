#!/usr/bin/sh

INSTALL_DIR=$1
BUILD_DIR=$2
CUR=`pwd`
cd $BUILD_DIR
if [ ! -d "yaml-cpp" ];then
	git clone https://github.com/jbeder/yaml-cpp.git
	cd yaml-cpp
else
	cd yaml-cpp
	git pull
fi

mkdir -p build
cd build
cmake -DBUILD_SHARED_LIBS=ON -DYAML_CPP_BUILD_TESTS=off -DCMAKE_INSTALL_PREFIX=${INSTALL_DIR}/ ../
make install
if [ $? -eq 0 ]; then
	echo "Success to build yaml-cpp"
else
	echo "Failed to build yaml-cpp"
fi
cd $CUR
