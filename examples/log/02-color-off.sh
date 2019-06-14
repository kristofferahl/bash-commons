#!/usr/bin/env bash

echo 'Turn off colored output'
export LOG_COLOR_OFF=true

log_trace 'Trace level message' # Not displayed cause of the default log level (DEBUG)
log_debug 'Debug level message'
log_info 'Info level message'
log_warn 'Warn level message'
log_error 'Error level message'

export LOG_COLOR_OFF=false
