#!/bin/bash

PASSPORT=""
VALID_COUNT=0
REQUIRED="byr
iyr
eyr
hgt
hcl
ecl
pid
"

while read -r LINE
do
  if [[ "$LINE" != "" ]]
  then
    PASSPORT="${PASSPORT} ${LINE}"
  else
    VALID=1
    for REQUIRED_FIELD in ${REQUIRED}
    do
      if ! echo "$PASSPORT" | grep -q " ${REQUIRED_FIELD}:"
      then
        VALID=0
      fi
    done
    if [[ $VALID -eq 1 ]]
    then
      VALID_COUNT=$((VALID_COUNT + 1))
    fi
    PASSPORT=""
  fi
done < input
for REQUIRED_FIELD in ${REQUIRED}
do
  if ! echo "$PASSPORT" | grep -q " ${REQUIRED_FIELD}:"
  then
    VALID=0
  fi
done
if [[ $VALID -eq 1 ]]
then
  VALID_COUNT=$((VALID_COUNT + 1))
fi

echo "$VALID_COUNT"
