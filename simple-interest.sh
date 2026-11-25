#!/usr/bin/env bash

set -euo pipefail

read -r -p "Enter principal: " principal
read -r -p "Enter rate of interest: " rate
read -r -p "Enter time period: " time

number_pattern='^[0-9]+([.][0-9]+)?$'
for value in "$principal" "$rate" "$time"; do
  if [[ ! $value =~ $number_pattern ]]; then
    printf 'Error: principal, rate, and time must be non-negative numbers.\n' >&2
    exit 1
  fi
done

interest=$(awk -v principal="$principal" -v rate="$rate" -v time="$time" \
  'BEGIN { printf "%.2f", (principal * rate * time) / 100 }')
printf 'Simple interest: %s\n' "$interest"
