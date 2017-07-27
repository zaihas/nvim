#!/bin/bash

# remove cscsope files
rm -rf $PWD/cscope.files
rm -rf $PWD/cscope.out

# get path
CURR_PATH=
#CURR_COMPILER_PATH=/home/zaihas/tools/gcc-arm-launchpad-4-8
CURR_COMPILER_PATH=

# find path to library
echo "--- generate cscope file ---"
find $CURR_COMPILER_PATH $PWD -name '*.c' -o -name '*.h' -o -name 'Make*' -o -name '*.mk' > $PWD/cscope.files

# cscope it now
cscope -b -k
