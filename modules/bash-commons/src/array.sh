#!/usr/bin/env bash

# Returns 0 when the given item is in the given array; Returns 1 when the given item is not in the given array;
array_contains () {
  local -r expected="$1"
  local -r array=("${@:2}")
  local item

  for item in "${array[@]}"; do
    if [[ "${item}" == "${expected}" ]]; then
      return 0
    fi
  done

  return 1
}
