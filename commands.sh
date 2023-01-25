#!/bin/bash

cd libsetplay
./configure
make clean
make -j8
cd ../bahiart
make clean
rm libs/libsetplay/lib/*
cp ../libsetplay/lib/libsetplay.a libs/libsetplay/lib/
make -j8




