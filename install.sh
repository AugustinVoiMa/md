#!/bin/bash

DEFAULT_SRC_TARGET=/usr/local/src/md
DEFAULT_BIN_REP=/usr/local/bin/

SRC_TARGET=${SRC_TARGET:-$DEFAULT_SRC_TARGET}
BIN_REP=${BIN_TARGET:-$DEFAULT_BIN_REP}


DEP_MISSING=""
DEP_INSTALL=0

function install_if_missing {
  type $1 >/dev/null 2>&1 || { DEP_INSTALL=1; DEP_MISSING=$DEP_MISSING" "$1; }
}

install_if_missing markdown ;
install_if_missing w3m ;

if [ $DEP_INSTALL = 1 ]; then
  echo install $DEP_MISSING;
  apt-get -y install $DEP_MISSING;
fi

sudo mkdir -p $SRC_TARGET $BIN_REP;

sudo cp md.sh README.md LICENSE $SRC_TARGET;
if [ ! -e $BIN_REP/md ]; then
  sudo ln -s -T $SRC_TARGET/md.sh $BIN_REP/md;
fi

sudo chmod a+x $BIN_REP/md;
