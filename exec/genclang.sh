#!/bin/bash

rm -rf $PWD/text
find $PWD -type f -name '*.h' |sed 's#\(.*\)/.*#\1#' | sed 's/^\(.\{0\}\)/\1-I/' |sort -u > $PWD/.clang_complete 
