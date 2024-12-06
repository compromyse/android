#!/usr/bin/env python3

import sys

if len(sys.argv) != 3:
    print(f'Usage: {sys.argv[0]} ONE TWO')

one = open(sys.argv[1]).read().split('\n')
two = open(sys.argv[2]).read().split('\n')

print(f'{sys.argv[2]} doesn\'t contain:\n')
for i in one:
    if i not in two:
        print(i)

print('\n\n\n')
print(f'{sys.argv[1]} doesn\'t contain:\n')
for i in two:
    if i not in one:
        print(i)
