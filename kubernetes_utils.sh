#!/usr/bin/env bash

#####
## This file contains utility functions to interact with kubernetes
## Some functions require the `ES_PORT` variable to be set
##
## NOTE: To avoid name clashes with other scripts
## * Functions used outside of this script are prefixed with `kubernetes_`
## * Helper functions for this script are prefixed with `kubernetes_utils_`
##
## Please stick to the guidelines
#####

##### dependiencies:
##### logger.sh
##### utils.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/logger.sh"
source "${SCRIPT_DIR}/utils.sh"

##### end of dependencies

kubernetes_get_contexts() {
  kubectl config get-contexts --output name
}

kubernetes_get_current_context() {
  kubectl config current-context
}

kubernetes_set_context() {
  local context="$1"

  _validate_is_set context || return 1

  log INFO "Setting kubernetes context to: $context"

  kubectl config use-context "$context" >/dev/null || {
    log ERROR "Failed to set context to: $context"
    return 1
  }
}

kubernetes_port_forward() {
  local namespace="$1"
  local target="$2"
  local port="$3"

  kubectl port-forward \
    --namespace "${namespace}" \
    "${target}" \
    "${port}:9200" >/dev/null &

  local pid=$!
  log INFO "Port-forward to ${target} started with PID: $pid"

  echo "$pid"
}
