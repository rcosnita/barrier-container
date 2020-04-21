#!/usr/bin/env bash
set -eo pipefail

CFG=$(cat ${1} | jq .)
echo "Waiting using cfg: ${CFG}"

FINAL_WAIT_SECONDS=5
WAIT_PERIOD=1

function get_key() {
    key=${1}
    json=${2}
    echo ${CFG} | jq --arg key=${key} -r .$key
}

svc_name=$(get_key "host" ${CFG})
svc_port=$(get_key "port" ${CFG})
svc_type=$(get_key "type" ${CFG})

function wait_for_port_default() {
    svc_name="${svc_name%\"}"
    svc_name="${svc_name#\"}"

    had_to_wait=false

    echo "Waiting for ${svc_name}:${svc_port}."
    while ! $(nc -z ${svc_name} ${svc_port}); do
        had_to_wait=true
        echo "Waiting for ${svc_name}:${svc_port}."
        sleep ${WAIT_PERIOD}
    done

    if ${had_to_wait}; then
        echo "Service ${svc_name} is ready. Cooling down in ${FINAL_WAIT_SECONDS}."
        sleep ${FINAL_WAIT_SECONDS}
    else
        echo "Service ${svc_name} is ready."
    fi
}

wait_for_port_default