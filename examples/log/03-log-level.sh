#!/usr/bin/env bash

echo 'Only displaying INFO and above'
export LOG_LEVEL='INFO'

log_trace 'Trace level message' # Not displayed cause of the default log level (INFO)
log_debug 'Debug level message' # Not displayed cause of the default log level (INFO)
log_info 'Info level message'
log_warn 'Warn level message'
log_error 'Error level message'

export LOG_LEVEL='DEBUG'
