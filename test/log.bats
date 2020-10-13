#!/usr/bin/env bats

# shellcheck source=/dev/null
source "${BATS_TEST_DIRNAME:?}/../modules/bash-commons/src/log.sh"
source "${BATS_TEST_DIRNAME:?}/helper.sh"

export LOG_COLOR_OFF=true
export LOG_LEVEL='TRACE'

@test "log_trace : given a message, should log with level trace" {
  run log_trace "foo"
  assert_success
  assert_output_contains "[TRACE] foo"
}

@test "log_debug : given a message, should log with level debug" {
  run log_debug "foo"
  assert_success
  assert_output_contains "[DEBUG] foo"
}

@test "log_info : given a message, should log with level info" {
  run log_info "foo"
  assert_success
  assert_output_contains "[INFO] foo"
}

@test "log_warn : given a message, should log with level warn" {
  run log_warn "foo"
  assert_success
  assert_output_contains "[WARN] foo"
}

@test "log_error : given a message, should log with level error" {
  run log_error "foo"
  assert_success
  assert_output_contains "[ERROR] foo"
}

@test "LOG_FORMAT : given level, should output expected" {
  export LOG_FORMAT='<level>'
  run log_error "foo"
  assert_success
  assert_output_equals "ERROR"
}

@test "LOG_FORMAT : given level_short, should output expected" {
  export LOG_FORMAT='<level_short>'
  run log_error "foo"
  assert_success
  assert_output_equals "ERRO"
}

@test "LOG_FORMAT : given message, should output expected" {
  export LOG_FORMAT='<message>'
  run log_error "foo"
  assert_success
  assert_output_equals "foo"
}

@test "LOG_FORMAT : given ts, should output expected" {
  export LOG_FORMAT='<ts>'
  run log_error "foo"
  assert_success
  assert_output_equals "$(date +"%Y-%m-%d %H:%M:%S")"
}

@test "LOG_FORMAT : given ts_utc, should output expected" {
  export LOG_FORMAT='<ts_utc>'
  run log_error "foo"
  assert_success
  assert_output_equals "$(date -u -Iseconds)"
}

@test "LOG_FORMAT : given ts_since, should output expected" {
  export LOG_FORMAT='<ts_since>'
  local sleep_seconds=3
  sleep ${sleep_seconds:?} # Used to simulate time since loading the log script
  run log_error "foo"
  assert_success
  assert_output_equals "000${sleep_seconds:?}"
}

@test "LOG_FORMAT : given script, should output expected" {
  export LOG_FORMAT='<script>'
  run log_error "foo"
  assert_success
  assert_output_equals "bats-exec-test"
}

@test "LOG_LEVEL : given info, should output expected" {
  export LOG_LEVEL='INFO'
  export LOG_FORMAT='<level>'

  run log_debug "foo"
  assert_success
  assert_output_equals ""

  run log_info "foo"
  assert_success
  assert_output_equals "INFO"

  run log_error "foo"
  assert_success
  assert_output_equals "ERROR"
}

@test "LOG_LEVEL : given error, should output expected" {
  export LOG_LEVEL='ERROR'
  export LOG_FORMAT='<level>'

  run log_debug "foo"
  assert_success
  assert_output_equals ""

  run log_info "foo"
  assert_success
  assert_output_equals ""

  run log_error "foo"
  assert_success
  assert_output_equals "ERROR"
}
