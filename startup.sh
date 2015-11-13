#!/bin/bash

HAPROXY="/etc/haproxy"
PIDFILE="/var/run/haproxy.pid"
CONFIG_FILE=${HAPROXY}/haproxy.cfg
TEMPLATE=${HAPROXY}/haproxy.template

haproxy -f "$CONFIG_FILE" -p "$PIDFILE" -D -st $(cat ${PIDFILE})

env

/usr/local/bin/consul-template -consul ${CONSUL_PORT_8500_TCP_ADDR:-172.17.0.1}:${CONSUL_PORT_8500_TCP_PORT:-8500} \
    -template "${TEMPLATE}:${CONFIG_FILE}:/hap.sh" \
    -log-level debug
