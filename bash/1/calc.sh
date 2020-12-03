#!/bin/bash

while read -r num1; do
  while read -r num2; do
    sum=$((num1 + num2))
    if [[ "$sum" -eq "2020" ]]; then
      echo $((num1 * num2))
      exit
    fi
  done < inputs
done < inputs
