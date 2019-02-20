#!/usr/bin/sh

ROOT=$1
FOLDER=$ROOT/include/catch2

if [ -f "$FOLDER/catch.hpp" ];then
	echo "Catch2 is installed already."
	exit 0
fi

if [ ! -d "$FOLDER" ];then
	mkdir $FOLDER
fi
wget -P $FOLDER https://github.com/catchorg/Catch2/releases/download/v2.6.1/catch.hpp
if [ $? -eq 0 ]; then
	echo "Success on catch2"
else
	echo "Failed on catch2"
	exit 1
fi
