#!/bin/sh

BUILD=1
CLEAN=0
PARAM=
PREFIX=
FILTER=

for opt in $@
do
  cmd=`echo $opt | tr [a-z] [A-Z]`
  case "$cmd" in 
    ALL)
      BUILD=1
      CLEAN=1
      ;;

    BUILD)
      BUILD=1
      CLEAN=0
      ;;

    CLEAN)
      BUILD=0
      CLEAN=1
      ;;

     *)
       if [ ${cmd:0:7} == 'PREFIX=' ]; then
		   PREFIX=${opt:7}
	   elif [ ${cmd:0:7} == 'FILTER=' ]; then
		   FILTER=${opt:7}
	   else
		   PARAM="$PARAM $opt "
	   fi
       ;;

  esac
done

SCRIPT_NAME=`readlink -f $0`
FOLDER=`dirname ${SCRIPT_NAME}`
BUILD_DIR=${FOLDER}/build

mkdir -p $BUILD_DIR

if [ -z "$PREFIX" ]; then
	PREFIX=$FOLDER
fi

ROOT=${PREFIX}/usr

if [ -d "${ROOT}" ]; then
	if [ $CLEAN -eq 1 ]; then
		rm -rf $BUILD_DIR/*
	fi
fi

if [ $BUILD -eq 1 ]; then
	if [ ! -d "${ROOT}" ]; then
		echo "create ${ROOT}"
		mkdir -p $ROOT
		mkdir -p $ROOT/bin
		mkdir -p $ROOT/include
		mkdir -p $ROOT/lib64
		mkdir -p $ROOT/lib
		mkdir -p $ROOT/resource
		mkdir -p $ROOT/share
	fi
	for i in `ls --color=none ${FOLDER}/project/*.sh`
	do
		if [ ! -z "$FILTER" ];then
			if [ "$i" != "${FOLDER}/project/${FILTER}.sh" ];then
				echo "$i is filter out by $FILTER"
				continue
			fi
		fi
		$i $ROOT $BUILD_DIR $PARAM
		if [ $? -ne 0 ];then
			echo "Failed on $i $ROOT, exit..."
			exit 1
		fi
	done
fi

echo "Please set environment variable TP_PATH=$ROOT manually"
