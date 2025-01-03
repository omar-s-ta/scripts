#!/usr/bin/env bash

##### dependiencies:
##### end of dependencies

#####
## This file contains general utility functions that can be used in any script
##
## NOTE: To avoid name clashes with other scripts
## * Functions used outside of this script are prefixed with `git`
## * Helper functions for this script are prefixed with `git_utils_`
##
## Please stick to the guidelines
#####

##### helper functions

GIT_UTILS_TRUE=0
GIT_UTILS_FALSE=1

##### end of helper functions

git_main() {
  git checkout main
  git pull
}

git_master() {
  git checkout master
  git pull
}

## Can be used with zsh change-working-directory `chpwd` hook
git_is_default_branch() {
  local _branch_name="$1"
  local -r default_branches=("main" "master")

  for branch in "${default_branches[@]}"; do
    if [[ "$_branch_name" == "$branch" ]]; then
      return $GIT_UTILS_TRUE
    fi
  done

  return $GIT_UTILS_FALSE
}

git_set_upstream() {
  git push --set-upstream origin "$(git branch --show-current)"
}

git_link_local_to_upstream() {
  local remote_branch_name="$1"
  git branch --set-upstream-to=origin/"$remote_branch_name"
}

git_commit_push() {
  git commit -m "$1"
  git push
}

git_commit_set_upstream() {
  git commit -m "$1"
  git_set_upstream
}

git_add_commit_push() {
  git add .
  git commit -m "$1"
  git push
}

git_add_commit_set_upstream() {
  git add .
  git commit -m "$1"
  git_set_upstream
}
