#!/bin/sh

LANG=C
PATH=/usr/local/bin:/bin:/usr/bin
export LANG PATH

test $# -ge 1 || exit

( find ${1+"$@"} -type d | sed -e 's/$/\//'
  find ${1+"$@"} \! -type d ) | sort | tar -cf - --no-recursion -T -
