#!/bin/sh

for FILE in intermediate/*.log
do
  grep -v "[[]info[]] Loading" < "${FILE}" | \
    grep -v "[[]info[]] Resolving " | 
    grep -v "[[]info[]] Updating ProjectRef(" | \
    grep -v "[[]info[]] Done updating" | \
    grep -v "[[]info[]] Done compiling"
  
  # separate each project with an empty line
  echo ""
done