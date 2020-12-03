#!/bin/bash

ANSWER=0

while read -r line
do
  LETTER=$(echo "$line" | cut -f 2 -d " " | sed -e 's/://')
  MIN=$(echo "$line" | cut -f 1 -d '-')
  MAX=$(echo "$line" | sed -e 's/ .*//' | cut -f 2 -d '-')
  PASSWORD=$(echo "$line" | cut -f 2 -d ':')

  NUM=$(echo "$PASSWORD" | grep -o "$LETTER" | wc -l)
  if [[ "$NUM" -lt "$MIN" ]]
  then
    continue
  elif [[ "$NUM" -gt "$MAX" ]]
  then
    continue
  else
    ANSWER=$((ANSWER + 1))
  fi
done < inputs

echo "$ANSWER"
