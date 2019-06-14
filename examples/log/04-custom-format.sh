#!/usr/bin/env bash

echo 'Custom format 1'
export LOG_FORMAT='<color_start>▪<color_end> [<ts_since>][<color_start><script><color_end>] <message>'
log_trace 'Trace level message'
log_debug 'Debug level message'
log_info 'Info level message'
log_warn 'Warn level message'
log_error 'Error level message'

echo
echo 'Custom format 2'
export LOG_FORMAT='<color_start>[<level_short>]<color_end> [<ts_utc>] [<script>] <message>'
log_trace 'Trace level message'
log_debug 'Debug level message'
log_info 'Info level message'
log_warn 'Warn level message'
log_error 'Error level message'
