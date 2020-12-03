#!/bin/bash

echo "Sorry this one takes forever"

while read -r num1; do
  while read -r num2; do
    while read -r num3; do
      sum=$((num1 + num2 + num3))
      if [[ "$sum" -eq "2020" ]]; then
        echo $((num1 * num2 * num3))
        exit
      fi
    done < inputs
  done < inputs
done < inputs
