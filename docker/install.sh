#!/bin/sh
set -e

apk add git
git clone https://github.com/bats-core/bats-core.git
cd bats-core
./install.sh /usr/local
