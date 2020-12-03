#!/bin/bash

NUM1=$(./sleedin.sh 1 1)
NUM2=$(./sleedin.sh 3 1)
NUM3=$(./sleedin.sh 5 1)
NUM4=$(./sleedin.sh 7 1)
NUM5=$(./sleedin.sh 1 2)

echo "$NUM1 * $NUM2 * $NUM3 * $NUM4 * $NUM5"

TOTAL=$(( NUM1 * NUM2 * NUM3 * NUM4 * NUM5))

echo $TOTAL
