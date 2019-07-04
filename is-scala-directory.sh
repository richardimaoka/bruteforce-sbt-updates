#!/bin/sh

######################################
# 1. Parse argument
######################################
DIR_NAME=$1
if [ -z "${DIR_NAME}" ] ; then 
  >&2 echo "ERROR: The argument for the directory name must be passed"
  exit 1
fi

######################################
# 2. Main processing
######################################
if find "${DIR_NAME}/build.sbt" >/dev/null 2>&1 ; then
  echo "$(pwd) is a Scala diractory"
  exit 0
else
  >&2 echo "$(pwd) is not a Scala directory"
  exit 1
fi
