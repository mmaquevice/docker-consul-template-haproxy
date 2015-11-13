docker-consul-template-haproxy
==============================

forked from https://github.com/AnalogJ/docker-consul-template-haproxy.
DockerHub Repository: https://registry.hub.docker.com/u/shayashibara/docker-consul-template-haproxy/

## Overview

This repository contains a scripts for creating image with haproxy and consul-template.

## Requirements

- Docker (Tested on 1.4.1)
- Consul (Tested on 0.5.0)

## Usage

```
docker run -d -p 80:80 -e "CONSUL_PORT_8500_TCP_ADDR=10.133.84.127" -e "CONSUL_PORT_8500_TCP_PORT=8500" --name hap mmaquevice/consul-template-haproxy:1.0
```
