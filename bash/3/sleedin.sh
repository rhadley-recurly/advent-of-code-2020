#!/bin/bash

RIGHT="$1"
DOWN="$2"

if [[ "$DOWN" == "" ]]
then
  echo "Usage $0 RIGHT DOWN"
  echo "Debug: $0 RIGHT DOWN LINENUM"
  exit
fi

LINE=0
COL=0
TREE_COUNT=0
DOWN_COUNT=0

while read -r TREES
do
  LINE=$((LINE + 1))

  #Figure out line number
  if [[ $DOWN_COUNT -ne $DOWN ]]
  then
    DOWN_COUNT=$((DOWN_COUNT + 1))
    continue
  fi
  DOWN_COUNT=1

  #Figure out column 
  COL=$((COL + RIGHT))
  if [[ $COL -ge ${#TREES} ]]
  then
    COL=$((COL - ${#TREES}))
  fi

  #DEBUG
  if [[ "$3" != "" ]]
  then
    if [[ "$LINE" -eq "$3" ]]
    then
      echo "$TREES"
      echo "$COL"
      echo "${TREES:$COL:1}"
      exit
    fi
  fi

  #Check if hit a tree
  if [[ "${TREES:$COL:1}" == "#" ]]
  then
    TREE_COUNT=$((TREE_COUNT + 1))
  fi
done < input

echo ${TREE_COUNT}
