#!/usr/bin/env bash

fail_test() {
  {
    if [ "$#" -eq 0 ]; then
      cat -
    else
      printf "\\n%s\\n" "$@"
    fi
  } >&2
  echo
  return 1
}

assert_success() {
  if [ "${status:-}" -ne 0 ]; then
    fail_test "command failed with exit code ${status:-}" "${output:-}"
  fi
}

assert_failure() {
  if [ "${status:-}" -eq 0 ]; then
    fail_test "expected failed exit code"
  fi
}

assert_equal() {
  if [ "$1" != "$2" ]; then
    {
      echo
      echo "expected : $1"
      echo "actual   : $2"
    } | fail_test
  fi
}

assert_contains() {
  if ! echo "$2" | grep -q -F "$1"; then
    {
      echo
      echo "expected   : $2"
      echo "to contain : $1"
    } | fail_test
  fi
}

assert_output_equals() {
  local expected
  if [[ $# -eq 0 ]]; then
    expected="$(cat -)"
  else
    expected="$1"
  fi
  assert_equal "$expected" "${output}"
}

assert_output_contains() {
  local expected
  if [[ $# -eq 0 ]]; then
    expected="$(cat -)"
  else
    expected="$1"
  fi
  assert_contains "$expected" "${output}"
}
