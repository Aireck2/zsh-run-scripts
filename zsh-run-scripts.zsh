#!/usr/bin/env ksh
# -*- coding: utf-8 -*-
#
# Authors:
#   Erick Escriba <erickescribaa@gmail.com>
#
RUNNER_PLUGIN_DIR="$(dirname "${0}")"
RUNNER_SOURCE_PATH="${RUNNER_PLUGIN_DIR}"/src

# shellcheck source=/dev/null
source "${RUNNER_SOURCE_PATH}"/base.zsh

# shellcheck source=/dev/null
source "${RUNNER_SOURCE_PATH}"/search.zsh

function scripts::run {
    local command
    local runner
    runner="$(search::runner)"
    command="$(search::scripts)"

    if [ -z "${command}" ]; then
        return
    fi

    env "${runner} ${command}" && zle accept-line
}

zle -N scripts::run
bindkey '^Xy' scripts::run
