#!/bin/bash
# Created 20160913

LABEL="spamhaus_edrop"

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

OUTPUT_DIRECTORY="/mnt/projects/sources/spamhaus_edrop/content"

TEMPOUTPUT=/tmp/${LABEL}.$$

OUTPUT="${LABEL}.${DATE}.content"

PAGE1="https://www.spamhaus.org/drop/edrop.txt"

META1="spamhaus_edrop_list_ip,suspect"

# Grab the EDROP file
/usr/bin/curl --silent ${PAGE1} | /bin/egrep -v '^#|^<|^;' | /bin/sed -e 's/ *//g' > ${TEMPOUTPUT}

# Clear the content file
/bin/echo -n "" > ${OUTPUT_DIRECTORY}/${OUTPUT}

if [ -f ${TEMPOUTPUT} ]; then
  for LINE in `cat ${TEMPOUTPUT}`
  do
    CIDR=`echo ${LINE} | /bin/awk -F';' '{print $1}'`
    SBL=`echo ${LINE} | /bin/awk -F';' '{print $2}'`
    MIN=`/mnt/projects/sources/spamhaus_edrop/cidr-to-ip.sh ${CIDR} | /usr/bin/head -1`
    MAX=`/mnt/projects/sources/spamhaus_edrop/cidr-to-ip.sh ${CIDR} | /usr/bin/tail -1`
    /bin/echo "${MIN},${MAX},${META1},${SBL}" >> ${OUTPUT_DIRECTORY}/${OUTPUT}
  done
  /bin/rm ${TEMPOUTPUT}
else
  /bin/echo "No valid file found."
fi
