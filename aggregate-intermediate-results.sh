#!/bin/sh

for FILE in intermediate/*.log
do
  # Is grep -e "->" reliable???
  grep -e "Checking Scala library dependencies in" \
       -e "[[]success[]] Total time:" \
       -e "->" \
       -e "dependency updates for" \
       -e "Project loading failed" < "${FILE}" |
    grep -v "[[]warn[]]" 

  # separate each project with an empty line
  echo ""
done