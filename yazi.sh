#!/usr/bin/env bash

##### dependiencies:
##### end of dependencies

#####
## yazi file-manager helper.
##
## Requires the `yazi` binary (brew install yazi).
##
## NOTE: the entry function is intentionally named `y` (not prefixed like the
## other scripts) because it's meant to be typed as a quick command — this is
## yazi's own official shell wrapper.
#####

# Open yazi and cd to the directory it exits in.
y() {
	local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
	command yazi "$@" --cwd-file="$tmp"
	IFS= read -r -d '' cwd < "$tmp"
	[ "$cwd" != "$PWD" ] && [ -d "$cwd" ] && builtin cd -- "$cwd"
	command rm -f -- "$tmp"
}
