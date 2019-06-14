#!/usr/bin/env bash

echo 'Custom log level'
log CUSTOM 'Custom level message'

echo
echo 'Custom log level (colored)'
# shellcheck disable=SC1117
export LOG_COLOR_SUCCESS="\033[1;92m"
log SUCCESS 'Success level message'
