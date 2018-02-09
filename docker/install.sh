#!/bin/sh
set -e

apk add git
git clone https://github.com/sstephenson/bats.git
cd bats
./install.sh /usr/local
