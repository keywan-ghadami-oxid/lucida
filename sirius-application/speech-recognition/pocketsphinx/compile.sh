#!/usr/bin/env bash

hash unzip 2>/dev/null || {
  echo >&2 "$0: [ERROR] unzip is not installed. Aborting."
  exit 1
}

# set number of threads when building
THREADS=4

# build and install sphinxbase
if [ ! -d sphinxbase-master ]; then
  unzip -q -o sphinxbase.zip
  cd sphinxbase-master;
  ./autogen.sh 1> /dev/null
  cd ..;
fi

cd sphinxbase-master;
make -j $THREADS 1> /dev/null
sudo make install 1> /dev/null
cd ..;
echo "sphinxbase done"

# build and install pocketsphinx
if [ ! -d pocketsphinx-master ]; then
  unzip -q -o pocketsphinx.zip
  cd pocketsphinx-master;
  ./autogen.sh 1> /dev/null
  cd ..;
fi

# tweaked file that includes timing
cd pocketsphinx-master;
make -j $THREADS 1> /dev/null
sudo make install 1> /dev/null
cd ..;
echo "pocketsphinx done"