#!/usr/bin/env bash

user=compromyse

docker run -it --rm -v "$(pwd)/src:/home/$user/src" -v "$HOME/.ssh:/home/$user/.ssh" lineage
