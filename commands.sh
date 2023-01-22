#!/bin/bash

cd libsetplay
./configure
make -j8
cp lib/libsetplay.a ../bahiart/libs/libsetplay/lib/
make -j8 -C ../bahiart




