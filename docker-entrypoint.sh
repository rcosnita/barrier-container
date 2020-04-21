#!/usr/bin/env bash
set -eo pipefail

CFG_PATH=${1:-/configuration.json}

function wait_services() {
    echo "Waiting for services: $(jq -cr .[] ${CFG_PATH})"

    for cfg in $(jq -cr .[] ${CFG_PATH});
    do
        echo ${cfg} > tmp/$(uuidgen).json
    done

    find ./tmp -name '*.json' -type f | xargs -n 1 -P5 ./files/wait-service.sh
    rm -f tmp/*.json

    echo "Finished waiting for services: ${CFG_PATH}."
}

wait_services