#!/usr/bin/env ksh
# -*- coding: utf-8 -*-

function fzf::exist {
    if ! type -p fzf >/dev/null; then
        echo 0
        return
    fi
    echo 1
}

function jq::exist {
    if ! type -p jq >/dev/null; then
        echo 0
        return
    fi
    echo 1
}

function brew::exist {
    if ! type -p brew >/dev/null; then
        echo 0
        return
    fi
    echo 1
}

function nvm::exist {
    # if [ -z "$(which nvm)"]; then
    if ! type nvm >/dev/null; then
        echo 1
        return
    fi
    echo 0
}

function node::exist {
    if ! type -p node >/dev/null; then
        echo 0
        return
    fi
    echo 1
}

function yarn::exist {
    if ! type -p yarn >/dev/null; then
        echo 0
        return
    fi
    echo 1
}

function jq::install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${YARN_MESSAGE_BREW_NOT_FOUND}"
        return
    fi
    brew install jq
}

function fzf::install {
    if [ "$(brew::exist)" -eq 0 ]; then
        message_warning "${YARN_MESSAGE_BREW_NOT_FOUND}"
        return
    fi
    brew install fzf
}

function nvm::install {
    if [ "$(nvm::exist)" -eq 0 ]; then
        message_warning "${YARN_MESSAGE_NVM_NOT_FOUND}"
        return
    fi
}

function node::install {
    if [ "$(nvm::exist)" -eq 0 ]; then
        message_warning "${YARN_MESSAGE_NVM_NOT_FOUND}"
        return
    fi

    nvm install lts
}

if [ "$(fzf::exist)" -eq 0 ]; then fzf::install; fi
if [ "$(jq::exist)" -eq 0 ]; then jq::install; fi
if [ "$(nvm::exist)" -eq 0 ]; then nvm::install; fi
if [ "$(node::exist)" -eq 0 ]; then node::install; fi
