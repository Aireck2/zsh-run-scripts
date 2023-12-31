#!/usr/bin/env ksh
# -*- coding: utf-8 -*-
export default_package_name="yarn"
function package-lock::exist {
    if [ -f package-lock.json ]; then
        echo 1
        return
    fi
    echo 0
}

function yarn-lock::exist {
    if [ -f yarn-lock ]; then
        echo 1
        return
    fi
    echo 0
}

function pnpm-lock::exist {
    if [ -f pnpm-lock.yaml ]; then
        echo 1
        return
    fi
    echo 0
}

function bun-lock::exist {
    if [ -f bun.lockb ]; then
        echo 1
        return
    fi
    echo 0
}

function package::exist {
    if [ -f package.json ]; then
        echo 1
        return
    fi
    echo 0
}

function scripts::list {
    if [ "$(package::exist)" -eq 0 ]; then
        message_info "Not found package.json"
        return
    fi
    less package.json | jq -r ".scripts" | jq -r 'to_entries[] | [.key, .value] | @tsv'
}

function dependencies::list {
    if [ "$(package::exist)" -eq 0 ]; then
        message_info "Not found package.json"
        return
    fi
    less package.json | jq -r ".dependencies" | jq -r 'to_entries[] | [.key, .value] | @tsv'
}

function search::scripts {
    local command
    read -r command <<<$(scripts::list |
        fzf |
        awk '{print $1}')
    if [ -z "${command}" ]; then
        return
    fi
    echo "${command}"
}

function search::runner {
    if [ "$(package-lock::exist)" -eq 1 ]; then
        echo "npm"
        return
    elif [ "$(yarn-lock::exist)" -eq 1 ]; then
        echo "yarn"
        return
    elif [ "$(pnpm-lock::exist)" -eq 1 ]; then
        echo "pnpm"
        return
    elif [ "$(bun-lock::exist)" -eq 1 ]; then
        echo "bun"
        return
    else
        echo "yarn"
        return
    fi
}
