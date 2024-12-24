#!/usr/bin/env bash

#####
## This file contains functions for logging and printing messages to stdout
## The log level can be set using the LOG_LEVEL environment variable
## The log levels are DEBUG, INFO, WARN, ERROR
##
## NOTE:
## * Prefix all helper functions with `logger_` to avoid name clashes with other scripts
##
#####

##### globals

: "${G_LOG_LEVEL_DEBUG:=0}"
: "${G_LOG_LEVEL_INFO:=1}"
: "${G_LOG_LEVEL_WARN:=2}"
: "${G_LOG_LEVEL_ERROR:=3}"

##### end of globals

##### helper functions

logger_to_upper() {
  echo "$1" | tr '[:lower:]' '[:upper:]'
}

logger_get_level_number() {
  case "$(logger_to_upper "$1")" in
  "DEBUG") echo "${G_LOG_LEVEL_DEBUG}" ;;
  "INFO") echo "${G_LOG_LEVEL_INFO}" ;;
  "WARN") echo "${G_LOG_LEVEL_WARN}" ;;
  "ERROR") echo "${G_LOG_LEVEL_ERROR}" ;;
  *)
    echo "ERROR: Invalid log level: $1" >&2
    exit 1
    ;;
  esac
}

##### end of helper functions

## Tags the message to stdout with the current timestamp and log level
## Useful for simple logging where you do not want to filter logs based on log level
## Usage: plog <level> <message>
plog() {
  local level=$1
  shift
  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [${level}] $*"
}

## Log messages based on the log level set in the LOG_LEVEL environment variable
## export LOG_LEVEL=DEBUG
## Usage: log <level> <message>
log() {
  local level
  level=$(logger_to_upper "$1")
  local current_level=${LOG_LEVEL:-"INFO"}
  shift

  # If the current log level is less than the level of the message, then do not log
  [[ $(logger_get_level_number "${level}") -ge $(logger_get_level_number "${current_level}") ]] || return

  echo "[$(date +'%Y-%m-%dT%H:%M:%S%z')] [${level}] $*"
}
