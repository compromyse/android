#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 [directory]"
  exit
fi

user=compromyse

pushd $1
docker run -it --rm -v "$(pwd):/home/$user/src" -v "$HOME/.ssh:/home/$user/.ssh" lineage
popd
