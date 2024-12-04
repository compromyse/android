#!/usr/bin/env bash

user=compromyse

docker run -it --rm -v "$(pwd)/src:/home/$user/src" lineage
