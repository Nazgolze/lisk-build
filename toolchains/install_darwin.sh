#!/bin/bash

cd "$(cd -P -- "$(dirname -- "$0")" && pwd -P)" || exit 2
. "$(pwd)/../shared.sh"

if [ ! "$(uname -s)" == "Darwin" ]; then
  echo "Invalid operating system. Aborting."
  exit 1
fi

# shellcheck disable=SC2034
# ignoring the failure due to shell indirection
CMDS=("ruby" "curl")
check_cmds CMDS[@]

ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"
exec_cmd "brew install autoconf automake git libtool md5sha1sum homebrew/versions/node012 postgresql wget"
