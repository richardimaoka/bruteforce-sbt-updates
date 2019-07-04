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
cd "${DIR_NAME}" || exit

# -Dsbt.log.noformat=true otherwise the color code messes up square blackets in log
# like '[info]' becoming '[0m0info0m0]'
sbt -Dsbt.log.noformat=true dependencyUpdates
