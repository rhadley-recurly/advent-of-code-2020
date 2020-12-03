#!/bin/bash

ANSWER=0

while read -r line
do
  LETTER=$(echo "$line" | cut -f 2 -d " " | sed -e 's/://')
  POS1=$(echo "$line" | cut -f 1 -d '-')
  POS2=$(echo "$line" | sed -e 's/ .*//' | cut -f 2 -d '-')
  PASSWORD=$(echo "$line" | cut -f 2 -d ':')

  CHAR1=${PASSWORD:POS1:1}
  CHAR2=${PASSWORD:POS2:1}

  if [[ "$CHAR1" == "$LETTER" && "$CHAR2" == "$LETTER" ]]
  then
    continue
  elif [[ "$CHAR1" == "$LETTER" || "$CHAR2" == "$LETTER" ]]
  then
    ANSWER=$((ANSWER + 1))
  fi
done < inputs

echo "$ANSWER"
