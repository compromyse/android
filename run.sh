#!/usr/bin/env bash

user=compromyse

docker run -it --rm -v "$(pwd):/home/$user/lineage" lineage
