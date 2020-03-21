#!/bin/bash

set -e

config() {
  CLI_DIR="cli"
  AVAILABLE_COMMANDS=( $( ls "${CLI_DIR}" ) )
  COMMAND=""
}

display_help() {
  echo "Steve Utils CLI"
  echo "Set of Steve automation and debugging commands"
  echo
  echo "Run one of the following commands:"
  echo "  ${AVAILABLE_COMMANDS[@]}"
  echo
  echo "All commands are configurable via environment variables."
}

parse_args() {
  while [[ "${#}" -gt 0 ]]; do
    case "${1}" in
      -h|--help) display_help; exit 0;;
      *) COMMAND="${1}"; shift 1;;
    esac
  done
}

command_exists() {
  local command="${1}"
  local result="$( find "${CLI_DIR}" -name "${command}" )"
  if [[ result == "" ]]; then
    echo "false"
  fi
  echo "true"
}

run_command() {
    local cmd="${1}"
    shift 1
   "./${CLI_DIR}/${cmd}/run.sh" "${@}"
}

main() {
  config
  parse_args "${@}"

  local exists="$( command_exists "${COMMAND}" )"
  if [[ "${exists}" == "false" ]]; then
    echo "Command ${COMMAND} not found"
    display_help
    exit 1
  fi

  run_command "${@}"
}

main "${@}"
