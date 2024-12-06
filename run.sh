#!/usr/bin/env bash

if [ -z "$1" ]; then
  echo "Usage: $0 [directory]"
  exit
fi

user=compromyse

docker run -it --rm -v "$(pwd)/$1:/home/$user/src" -v "$HOME/.ssh:/home/$user/.ssh" lineage
