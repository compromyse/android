#!/usr/bin/env bash

cat $1 | grep "<project " | grep -o 'path="[^"]*"' | sed 's/path="//g' | sed 's/"//g'
