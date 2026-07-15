#!/usr/bin/env bash

alias cp='cp -v'
alias rm='rm -v'
alias mv='mv -v'

# eza — modern ls. Guarded so hosts without it keep plain ls.
# `command ls` / `\ls` still reach the real ls for scripts.
if command -v eza >/dev/null 2>&1; then
  alias ls='eza --group-directories-first --icons=auto'
  alias ll='eza -l  --git --group-directories-first --icons=auto'
  alias la='eza -la --git --group-directories-first --icons=auto'
  alias lt='eza --tree --level=2 --icons=auto'
fi

# bat — modern cat with syntax highlighting. `--paging=never` keeps cat-like
# behavior; use `catp` for the paged view. `command cat` / `\cat` stay plain.
if command -v bat >/dev/null 2>&1; then
  alias cat='bat --paging=never'
  alias catp='bat'
fi
