#!/bin/sh

# cd to the current directory as it runs other shell scripts
cd "$(dirname "$0")" || exit

############################################################
# Kill the child (background) processes on Ctrl+C = (SIG)INT
############################################################
# This script runs check-region.sh in the background
# https://superuser.com/questions/543915/whats-a-reliable-technique-for-killing-background-processes-on-script-terminati/562804
trap 'kill -- -$$' INT

######################################
# 1.1 Parse the argument
######################################
DIR_NAME=$1
if [ -z "${DIR_NAME}" ] ; then 
  >&2 echo "ERROR: The argument for the directory name must be passed"
  exit 1
fi

######################################
# 2. Main processing
######################################
mkdir -p intermediate

for SBT_PROJECT_DIRECTORY in $(./list-sbt-directories.sh "${DIR_NAME}")
do
  FILE_NAME="intermediate/$(echo "${SBT_PROJECT_DIRECTORY}" | sed -e 's/^[.][.][/]/_/g' | sed -e 's/[/]/-/g').log"
  echo "Checking Scala library dependencies in ${SBT_PROJECT_DIRECTORY}" | tee "${FILE_NAME}" 
  ./sbt-updates.sh "${SBT_PROJECT_DIRECTORY}" >> "${FILE_NAME}"

  # Parallelizing the run by `&` did not work somehow, as it requires sbt coursier to avoid waiting on locks,
  # but soursier encountered weird errors.
  #
  # ./sbt-updates.sh "${SBT_PROJECT_DIRECTORY}" >> "${FILE_NAME}" &  
done

######################################
# 3. Wait until the children complete
######################################
echo "Wait until all the child processes are finished..."

#Somehow VARIABLE=$(jobs -p) gets empty. So, need to use a file.
TEMP_FILE=$(mktemp)
jobs -p > "${TEMP_FILE}"

# Read and go through the ${TEMP_FILE} lines
while IFS= read -r PID
do
  wait "${PID}"
done < "${TEMP_FILE}"

rm "${TEMP_FILE}"

######################################
# 4. Produce the final output
######################################
./aggregate-intermediate-results.sh > output.log

echo "------------------------------------"
echo " Finished !! "
echo "------------------------------------"
echo "The result is available in $(pwd)/output.log"