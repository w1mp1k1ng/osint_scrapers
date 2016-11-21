#!/bin/bash
# created 2014jun24
# last modified 2014jun24

LABEL="bambenek_dga"

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

OUTPUT_DIRECTORY="/mnt/projects/sources/bambenek/content/domain"
THIRDPARTY_DIRECTORY="/mnt/projects/sources/thirdparty_domains/content"

OUTPUT="${LABEL}.${DATE}.content"

PAGE1="http://osint.bambenekconsulting.com/feeds/dga-feed.txt"

META0="nwrsa_third_party_ioc_domain,"
META1=",third party publicized iocs,Bambenek Consulting,http:\/\/firstwat.ch\/bekfp0"

# First grab the DGA Feed
/usr/bin/curl --silent ${PAGE1} | /bin/egrep -v '^#|^<' | /bin/sed -e "s/,.*$//" > ${OUTPUT_DIRECTORY}/${OUTPUT}

# Remove any existing Bambenek content files from the thirdparty_domains
# directory
/bin/rm ${THIRDPARTY_DIRECTORY}/${LABEL}*

# Sort and unique all the content files and place in the thirdparty_domains
# content directory
#/bin/sort -u ${OUTPUT_DIRECTORY}/${LABEL}* | /bin/sed -e "s/^/${META0}/" -e "s/$/${META1}/" > ${THIRDPARTY_DIRECTORY}/${OUTPUT}
/bin/sort -u ${OUTPUT_DIRECTORY}/${LABEL}* | /bin/sed -e "s/$/${META1}/" > ${THIRDPARTY_DIRECTORY}/${OUTPUT}