#!/usr/bin/env bash

#####
## This file contains utility functions to interact with Elasticsearch
## Some functions require the `ES_HOST` and `ES_PORT` variables to be set
##
## NOTE: To avoid name clashes with other scripts
## * Functions used outside of this script are prefixed with `es_`
## * Helper functions for this script are prefixed with `es_utils_`
##
## Please stick to the guidelines
#####

##### dependencies:
##### logger.sh
##### utils.sh

SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "${SCRIPT_DIR}/logger.sh"
source "${SCRIPT_DIR}/utils.sh"

##### end of dependencies

##### globals

: "${ES_HOST:=localhost}"
: "${ES_PORT:=9208}"
# Replace with target es-client
: "${ES_CLIENT_SERVICE:=some-es-client}"

##### end of globals

es_cluster_health() {
  curl --silent --fail --max-time 5 "http://${ES_HOST}:${ES_PORT}/_cluster/health"
}

es_connection_check() {
  if ! es_cluster_health >/dev/null; then
    log ERROR "Could not connect to Elasticsearch at ${ES_HOST}:${ES_PORT}"
    return 1
  fi
}

es_get_index_with_name() {
  local index="$1"

  _validate_is_set index || return 1

  curl --silent "http://${ES_HOST}:${ES_PORT}/_cat/indices?h=index" | grep --extended-regexp "${index}" || true
}

es_index_check() {
  local index="$1"

  _validate_is_set index || return 1

  if ! es_get_index_with_name "${index}" >/dev/null; then
    log WARN "Index '${index}' does not exist"
    return 1
  fi
}

es_get_project_indices() {
  local project_key="$1"

  _validate_is_set project_key || return 1

  local search_pattern="${project_key}-some-index-pattern"
  curl --silent "http://${ES_HOST}:${ES_PORT}/_cat/indices?h=index" | grep --extended-regexp "${search_pattern}" || true
}

es_delete_index() {
  local index="$1"

  _validate_is_set index || return 1

  if ! curl --silent --fail --request DELETE "http://${ES_HOST}:${ES_PORT}/${index}"; then
    log ERROR "Failed to delete '${index}'"
    return 1
  fi
}

es_update_index_nested_objects_mapping_limit() {
  local index="$1"
  local docs_limit="$2"

  _validate_is_set index || return 1
  _validate_positive_integer docs_limit || return 1

  log INFO "Updating nested objects mapping limit for ${index}..."

  if ! curl --silent --fail \
    --request PUT \
    --header "Content-Type: application/json" \
    --data '{"index": {"mapping.nested_objects.limit": '"${docs_limit}"'}}' \
    "http://${ES_HOST}:${ES_PORT}/${index}/_settings"; then

    log ERROR "Failed to update index nested objects mapping limit for ${index}"
    return 1
  fi
}
