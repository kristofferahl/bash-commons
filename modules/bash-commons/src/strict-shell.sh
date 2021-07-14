#!/usr/bin/env bash

# https://www.davidpashley.com/articles/writing-robust-shell-scripts/

# Exit on non true return values
set -o errexit

# No unbound variables
set -o nounset

# Break pipes on failure
set -o pipefail
