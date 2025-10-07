#!/usr/bin/env bash

##### dependiencies: logger.sh

. "${HOME}/scripts/logger.sh"

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

##### constants

UTILS_TRUE=0
UTILS_FALSE=1

##### end of constants

##### helper functions
## add helper/private functions for this script here
##### end of helper functions

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

  ## TODO: Make it shell-agnostic, same for every other instance.
  local var_value="${!var_name}"

  if ! [[ $var_value =~ ^[1-9][0-9]*$ ]]; then
    log ERROR "${var_name} is not a positive integer"
    return $UTILS_FALSE
  fi
}

_validate_integer() {
  local var_name="$1"
  local var_value="${!var_name}"
  if ! [[ $var_value =~ ^[0-9]+$ ]]; then
    log ERROR "${var_name} is not an integer"
    return $UTILS_FALSE
  fi
}

_validate_boolean() {
  local var_name="$1"
  local var_value="${!var_name}"
  if [[ "${var_value}" != "true" && "${var_value}" != "false" ]]; then
    log ERROR "${var_name} must be 'true' or 'false'. Got '${var_value}'."
    return $UTILS_FALSE
  fi
}

_validate_required() {
  local var_name="$1"
  if [ -z "${!var_name+x}" ]; then
    log ERROR "--${var_name} is required."
    return $UTILS_FALSE
  fi
}

_validate_is_set() {
  local var_name="$1"
  if [ -z "${!var_name}" ]; then
    log ERROR "'${var_name}' function parameter is required."
    return $UTILS_FALSE
  fi
}

_confirm_action() {
  local prompt=$1
  read -rp "${prompt} [y/N] " choice
  case "$choice" in
  y | Y) return $UTILS_TRUE ;;
  *) return $UTILS_FALSE ;;
  esac
}

_trap_kill_pid() {
  local pid=$1
  trap 'kill $pid' SIGINT SIGTERM ERR EXIT
}

_colorize_output() {
  "$@" 1> >(sed $'s/^/\x1b[32m/;s/$/\x1b[0m/') \
  2> >(sed $'s/^/\x1b[31m/;s/$/\x1b[0m/' >&2)
}

_self_task() {
  echo "- [ ] #s-task $1" >>"$HOME/omar.abdelrahman.de@gmail.com - Google Drive/My Drive/obsidian-vault/00-09 Administration/02 Tasks/02.00 Tasks.md"
}
