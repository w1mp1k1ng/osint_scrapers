#!/bin/bash
# Created 20160913

LABEL="tor_nodes_ip"

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

OUTPUT_DIRECTORY="/mnt/projects/sources/tor_nodes_ip/content"

#TEMPOUTPUT=/tmp/${LABEL}.$$
#
OUTPUT="${LABEL}.${DATE}.content"

PAGE1="https://www.dan.me.uk/torlist/"

META1=",tor-node-ip,suspicious"

# Grab the file
#/usr/bin/curl --silent ${PAGE1} | /bin/egrep -v '^#|^<|^;' | /bin/sed -e "s/$/,${META1}/" > ${OUTPUT_DIRECTORY}/${OUTPUT}
/usr/bin/w3m -dump ${PAGE1} | /bin/egrep -v '^#|^<|^;' | /bin/sed -e "s/$/${META1}/" > ${OUTPUT_DIRECTORY}/${OUTPUT}