#!/usr/bin/env bash

##### dependiencies:
##### end of dependencies

#####
## Entry point for the ~/scripts helpers, sourced from ~/.zshrc.
##
## Sources every *.sh in this directory (except this file itself), so ~/.zshrc
## only needs to source this one file instead of listing each helper by hand.
## New scripts dropped into this directory are picked up automatically on the
## next shell.
##
## Each helper self-sources its own dependencies (see the "dependencies" header
## in each file), so alphabetical load order is safe.
#####

_zshrc_init_dir="${ZSH_SCRIPTS_DIR:-$HOME/.local/share/scripts}"

for _script in "${_zshrc_init_dir}"/*.sh; do
  case "${_script##*/}" in
    # zshrc_init.sh: this file — sourcing it would recurse.
    # zsh_plugins.sh: sourced directly from ~/.zshrc before oh-my-zsh loads.
    zshrc_init.sh | zsh_plugins.sh) continue ;;
  esac
  # shellcheck source=/dev/null
  . "${_script}"
done

unset _script _zshrc_init_dir
