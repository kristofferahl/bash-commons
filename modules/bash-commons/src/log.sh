#!/usr/bin/env bash

export LOG_SOURCED_TS
export LOG_LEVEL
export LOG_COLOR_OFF
export LOG_FORMAT

LOG_SOURCED_TS=$(date +%s)
LOG_LEVEL="${LOG_LEVEL:-DEBUG}"
LOG_COLOR_OFF=${LOG_COLOR_OFF:-false}
LOG_FORMAT="${LOG_FORMAT:-[<ts>] [<script>] <color_start>[<level>]<color_end> <message>}"

# shellcheck disable=SC1117
export LOG_COLOR_TRACE="\033[0;90m"
# shellcheck disable=SC1117
export LOG_COLOR_DEBUG=''
# shellcheck disable=SC1117
export LOG_COLOR_INFO="\033[1;94m"
# shellcheck disable=SC1117
export LOG_COLOR_WARN="\033[0;93m"
# shellcheck disable=SC1117
export LOG_COLOR_ERROR="\033[0;91m"

log() {
  local -r level="${1:?}"
  # shellcheck disable=SC2034
  local -r message="${*:2}"
  # shellcheck disable=SC1117
  local -r color_reset="\033[0m"
  local -r levels=('TRACE' 'DEBUG' 'INFO' 'WARN' 'ERROR')
  local -r format_keys=('ts_utc' 'ts_since' 'ts' 'level_short' 'level' 'script' 'color_start' 'color_end' 'message')
  local -r user_level_index=$(log_index_of "${level:?}" "${levels[*]}")
  local -r default_level_index=$(log_index_of "${LOG_LEVEL:?}" "${levels[*]}")

  if [[ ${user_level_index} -ge ${default_level_index} || ${user_level_index} == '' ]]; then
    local -r ts="$(date +"%Y-%m-%d %H:%M:%S")"
    # shellcheck disable=SC2034
    local -r ts_utc="$(date -u -Iseconds)"
    # shellcheck disable=SC2034
    local -r ts_since="$(printf "%04g" $(($(date +%s) - ${LOG_SOURCED_TS:?})))"
    # shellcheck disable=SC2034
    local -r level_short="${level:0:4}"
    local -r script="$(basename "${BASH_SOURCE[2]:-$0}")"
    local -r color="LOG_COLOR_${level:?}"
    local color_start="${!color}"
    local color_end="${color_reset:?}"
    [[ "${LOG_COLOR_OFF}" == true ]] && color_start='' && color_end=''

    local formatted="${LOG_FORMAT:?}"
    for key in ${format_keys[*]}; do
      local key_regex="(.*)\\<${key}\\>(.*)"
      while [[ $formatted =~ $key_regex ]]; do
        formatted="${formatted/<${key}>/${!key}}"
      done
    done

    echo -e "${color_end}${formatted:?}${color_end}"
  fi
}

log_index_of() {
  value="${1}"
  arr=(${2:?})
  for i in "${!arr[@]}"; do
    if [[ "${arr[$i]}" == "${value}" ]]; then
      echo "${i}"
    fi
  done
}

log_trace() { log TRACE "$@"; }
log_debug() { log DEBUG "$@"; }
log_info() { log INFO "$@"; }
log_warn() { log WARN "$@"; }
log_error() { log ERROR "$@"; }
