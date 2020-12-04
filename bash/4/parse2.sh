#!/bin/bash

echo "I'M SORRY THIS IS GROSS I AM WINE DRUNK"

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
      BYR=$(echo "$PASSPORT" | sed -e 's/.*byr://' | sed -e 's/ .*//')
      IYR=$(echo "$PASSPORT" | sed -e 's/.*iyr://' | sed -e 's/ .*//')
      EYR=$(echo "$PASSPORT" | sed -e 's/.*eyr://' | sed -e 's/ .*//')
      HGT=$(echo "$PASSPORT" | sed -e 's/.*hgt://' | sed -e 's/ .*//')
      HCL=$(echo "$PASSPORT" | sed -e 's/.*hcl://' | sed -e 's/ .*//')
      ECL=$(echo "$PASSPORT" | sed -e 's/.*ecl://' | sed -e 's/ .*//')
      PID=$(echo "$PASSPORT" | sed -e 's/.*pid://' | sed -e 's/ .*//')
      # Check BYR IYR and EYR
      if ! echo "$BYR" | grep -Eq '^[0-9]{4}$'
      then
        PASSPORT=""
        continue
      elif ! echo "$IYR" | grep -Eq '^[0-9]{4}$'
      then
        PASSPORT=""
        continue
      elif ! echo "$EYR" | grep -Eq '^[0-9]{4}$'
      then
        PASSPORT=""
        continue
      fi
      if [[ ($BYR -ge 1920 && $BYR -le 2002) && ($IYR -ge 2010 && $IYR -le 2020) && ($EYR -ge 2020 && $EYR -le 2030)]]
      then
        # Check HGT
        if echo "$HGT" | grep -q "cm"
        then
          HGT=${HGT//cm/}
          if [[ ! ($HGT -ge 150 && $HGT -le 193) ]]
          then
            PASSPORT=""
            continue
          fi
        elif echo "$HGT" | grep -q "in"
        then
          HGT=${HGT//in/}
          if [[ ! ($HGT -ge 59 && $HGT -le 76) ]]
          then
            PASSPORT=""
            continue
          fi
        else
          PASSPORT=""
          continue;
        fi
        # Check HCL
        if ! echo "$HCL" | grep -Eq '^#[0-9a-z]{6}$'
        then
          PASSPORT=""
          continue
        fi
        # Check ECL
        if [[ ! ( $ECL == "amb" || $ECL == "blu" || $ECL == "brn" || $ECL == "gry" || $ECL == "grn" || $ECL == "hzl" || $ECL == "oth") ]]
        then
          PASSPORT=""
          continue
        fi
        # Check PID
        if ! echo "$PID" | grep -Eq '^[0-9]{9}$'
        then
          PASSPORT=""
          continue
        fi
        VALID_COUNT=$((VALID_COUNT + 1))
      fi
    fi
    PASSPORT=""
  fi
done < input
#Check last field
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
  BYR=$(echo "$PASSPORT" | sed -e 's/.*byr://' | sed -e 's/ .*//')
  IYR=$(echo "$PASSPORT" | sed -e 's/.*iyr://' | sed -e 's/ .*//')
  EYR=$(echo "$PASSPORT" | sed -e 's/.*eyr://' | sed -e 's/ .*//')
  HGT=$(echo "$PASSPORT" | sed -e 's/.*hgt://' | sed -e 's/ .*//')
  HCL=$(echo "$PASSPORT" | sed -e 's/.*hcl://' | sed -e 's/ .*//')
  ECL=$(echo "$PASSPORT" | sed -e 's/.*ecl://' | sed -e 's/ .*//')
  PID=$(echo "$PASSPORT" | sed -e 's/.*pid://' | sed -e 's/ .*//')
  # Check BYR IYR and EYR
  if ! echo "$BYR" | grep -Eq '^[0-9]{4}'
  then
    VALID=0
  elif ! echo "$IYR" | grep -Eq '^[0-9]{4}'
  then
    VALID=0
  elif ! echo "$EYR" | grep -Eq '^[0-9]{4}'
  then
    VALID=0
  fi
  if [[ ($BYR -ge 1920 && $BYR -le 2002) && ($IYR -ge 2010 && $IYR -le 2020) && ($EYR -ge 2020 && $EYR -le 2030)]]
  then
    # Check HGT
    if echo "$HGT" | grep -q "cm"
    then
      HGT=${HGT//cm/}
      if [[ ! ($HGT -ge 150 && $HGT -le 193) ]]
      then
        VALID=0
      fi
    elif echo "$HGT" | grep -q "in"
    then
      HGT=${HGT//in/}
      if [[ ! ($HGT -ge 59 && $HGT -le 76) ]]
      then
        VALID=0
      fi
    else
      VALID=0
    fi
    # Check HCL
    if ! echo "$HCL" | grep -Eq '^#[0-9a-z]{6}$'
    then
      VALID=0
    fi
    # Check ECL
    if [[ ! ( $ECL == "amb" || $ECL == "blu" || $ECL == "brn" || $ECL == "gry" || $ECL == "grn" || $ECL == "hzl" || $ECL == "oth") ]]
    then
      VALID=0
    fi
    # Check PID
    if ! echo "$PID" | grep -Eq '^[0-9]{9}$'
    then
      VALID=0
    fi
    if [[ $VALID -eq 1 ]]
    then
      VALID_COUNT=$((VALID_COUNT + 1))
    fi
  fi
fi
echo "$VALID_COUNT"
