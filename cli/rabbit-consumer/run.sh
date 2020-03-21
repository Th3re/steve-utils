#!/usr/bin/env bash

config() {
    GIT_ROOT="$( git rev-parse --show-toplevel )"
}

display_help() {
    echo "Steve RabbitMQ topic consumer"
    echo "Usage:"
    echo "${1} <ENVIRONMENT PATH>"
}

parse_args() {
    while [[ "${#}" -gt 0 ]]; do
        case "${1}" in
            -h|--help) display_help; exit 0;;
            *) ENV="${1}"; shift 1;;
        esac
    done
}

main() {
    config
    parse_args "${@}"
    source "${ENV}"
    echo "Running rabbit topic consumer with env: ${ENV}"
    "${GIT_ROOT}/cli/rabbit-consumer/main.py" "${@}"
}

main "${@}"
