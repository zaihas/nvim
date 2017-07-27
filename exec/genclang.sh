#!/bin/bash

# remove dependent file
rm -rf $PWD/text

# generate clang files
echo "--- generate clang file ---"
find $PWD -type f -name '*.h' |sed 's#\(.*\)/.*#\1#' | sed 's/^\(.\{0\}\)/\1-I/' |sort -u > $PWD/.clang_complete 
