#!/usr/bin/env bash

##### dependiencies: utils.sh

. "${ZSH_SCRIPTS_DIR:-$HOME/.local/share/scripts}/utils.sh"

##### end of dependencies

#####
## This file contains common helper compile/run commands for various
## programming languages.
##
## NOTE: To avoid name clashes with other scripts
## * Functions used outside of this script are prefixed with `cr_cmd_`
## * Helper functions for this script are prefixed with `cr_cmd_utils_`
##
## Please stick to the guidelines
#####

cr_cmd_rust_competitive_manifest() {
  cargo run --color=always --bin "$1" --profile dev --manifest-path "$HOME/development/sebres/rust-solver/tasks/$1/Cargo.toml"
}

cr_cmd_cpp() {
  local version="$1"
  local name="$2"

  if [[ -f "$name".cpp ]]; then
    g++ -g -std=c++"$version" -Wall "$name".cpp -o "$name"
  else
    echo "File $name does not exist"
    return 1
  fi
}
