#!/bin/bash
# Created 20160913

LABEL="sshipblacklist"

YYYY=`/bin/date +%Y`
MM=`/bin/date +%m`
DD=`/bin/date +%d`

if [ -n "${1}" ]; then
  YYYY=${1}
fi

if [ -n "${2}" ]; then
  MM=${2}
fi

if [ -n "${3}" ]; then
  DD=${3}
fi

DATE="${YYYY}${MM}${DD}"

OUTPUT_DIRECTORY="/mnt/projects/sources/sshipblacklist/content"

#TEMPOUTPUT=/tmp/${LABEL}.$$
#
OUTPUT="${LABEL}.${DATE}.content"

PAGE1="http://www.openbl.org/lists/date_all.txt"

META1="SSH IP BlackList,suspicious"

# Grab the file
/usr/bin/curl --silent ${PAGE1} | /bin/egrep -v '^#|^<|^;' | /bin/sed -e "s/	/,${META1},/" > ${OUTPUT_DIRECTORY}/${OUTPUT}

## Clear the content file
#/bin/echo -n "" > ${OUTPUT_DIRECTORY}/${OUTPUT}

#if [ -f ${TEMPOUTPUT} ]; then
#  for LINE in `cat ${TEMPOUTPUT}`
#  do
#    IP=`echo ${LINE} | /bin/awk -F';' '{print $1}'`
#    DATE=`echo ${LINE} | /bin/awk -F';' '{print $2}'`
#    /bin/echo "${IP},${META1},${DATE}" >> ${OUTPUT_DIRECTORY}/${OUTPUT}
#  done
##  /bin/rm ${TEMPOUTPUT}
#else
#  /bin/echo "No valid file found."
#fi
