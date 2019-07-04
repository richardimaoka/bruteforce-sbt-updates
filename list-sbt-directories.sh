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
# Using temp file according to https://github.com/koalaman/shellcheck/wiki/SC2044
TEMP_FILE=$(mktemp)
find -s "${DIR_NAME}" -type d -depth 1 > "${TEMP_FILE}"
while IFS= read -r SUB_DIRECTORY
do
  if ./is-scala-directory.sh "${SUB_DIRECTORY}" 1>/dev/null 2>&1 ; then
    echo "${SUB_DIRECTORY}" 
  fi
done < "${TEMP_FILE}"

rm "${TEMP_FILE}"
