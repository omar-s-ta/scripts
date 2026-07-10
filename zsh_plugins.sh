#!/usr/bin/env bash

##### dependiencies:
##### end of dependencies

#####
## oh-my-zsh plugin list.
##
## Sourced from ~/.zshrc BEFORE ~/.oh-my-zsh/oh-my-zsh.sh, which reads the
## `plugins` array to decide what to load. Must be sourced early — setting it
## after oh-my-zsh.sh has already run has no effect.
##
## Add wisely: too many plugins slow down shell startup (completion-heavy ones
## like kubectl / terraform / docker / gcloud cost the most).
##
## NOTE: history-substring-search is intentionally NOT listed here. It must be
## sourced AFTER zsh-syntax-highlighting, so ~/.zshrc sources it manually at the
## end instead. fzf and gcloud here replace what used to be sourced directly.
##
## REQUIRES (install first): most of these plugins only add aliases/completion
## for an underlying CLI — the CLI itself must be installed separately or the
## aliases point at nothing.
##   git              -> git                       (brew install git)
##   kubectl          -> kubectl                   (brew install kubectl)
##   terraform        -> terraform                 (brew install terraform)
##   docker           -> docker CLI                (brew install docker / Docker Desktop)
##   golang           -> go                        (brew install go)
##   rust             -> cargo/rustc               (brew install rust, or rustup)
##   gcloud           -> google-cloud-sdk          (installed at ~/google-cloud-sdk)
##   fzf              -> fzf                        (brew install fzf)
## No extra install needed: sudo, extract, colored-man-pages, copypath, z,
##   command-not-found (a modern Homebrew ships the handler built-in at
##   .../Library/Homebrew/command-not-found/handler.sh, which the plugin sources
##   automatically — the old `brew tap homebrew/command-not-found` is deprecated
##   and now empty, so do NOT run it. Suggestions only appear on a real TTY.)
## (extract still needs the matching archive tool, e.g. 7z/unrar, per file type).
##
## was (original two-plugin list):
##   plugins=(git history-substring-search)
#####

plugins=(
  git
  kubectl
  terraform
  docker
  golang
  rust
  gcloud
  fzf
  sudo
  extract
  colored-man-pages
  command-not-found
  copypath
  z
)
