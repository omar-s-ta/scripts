#!/usr/bin/env bash

##### dependiencies: logger.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/logger.sh"

##### end of dependencies

#####
## This file contains general utility functions that can be used in any script
##
## NOTE: To avoid name clashes with other scripts
## * Functions used outside of this script are prefixed with `_`
## * Helper functions for this script are prefixed with `utils_`
##
## Please stick to the guidelines
#####

## Requires `usage` function
_parse_help_argument() {
  for arg in "$@"; do
    case $arg in
    -h | --help) usage ;;
    esac
  done
}

_validate_positive_integer() {
  local var_name="$1"
  local var_value="${!var_name}"
  if ! [[ $var_value =~ ^[1-9][0-9]*$ ]]; then
    log ERROR "${var_name} is not a positive integer"
    return 1
  fi
}

_validate_integer() {
  local var_name="$1"
  local var_value="${!var_name}"
  if ! [[ $var_value =~ ^[0-9]+$ ]]; then
    log ERROR "${var_name} is not an integer"
    return 1
  fi
}

_validate_boolean() {
  local var_name="$1"
  local var_value="${!var_name}"
  if [[ "${var_value}" != "true" && "${var_value}" != "false" ]]; then
    log ERROR "${var_name} must be 'true' or 'false'. Got '${var_value}'."
    return 1
  fi
}

_validate_required() {
  local var_name="$1"
  if [ -z "${!var_name+x}" ]; then
    log ERROR "--${var_name} is required."
    return 1
  fi
}

_validate_is_set() {
  local var_name="$1"
  if [ -z "${!var_name}" ]; then
    log ERROR "'${var_name}' function parameter is required."
    return 1
  fi
}

_confirm_action() {
  local prompt=$1
  read -rp "${prompt} [y/N] " choice
  case "$choice" in
  y | Y) return 0 ;;
  *) return 1 ;;
  esac
}

_trap_kill_pid() {
  local pid=$1
  trap "kill $pid" SIGINT SIGTERM ERR EXIT
}
