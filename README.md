docker-consul-template-haproxy
==============================

forked from https://github.com/AnalogJ/docker-consul-template-haproxy.
DockerHub Repository: https://registry.hub.docker.com/u/shayashibara/docker-consul-template-haproxy/

## Overview

This repository contains a Dockerfile to create an ubuntu:14.04 based image with : 
- haproxy 1.6.2
- consul-template 0.11.1

## Requirements

- Docker (Tested on 1.9.0)
- Consul (Tested on 0.11.1)

## Usage

```
docker run -d -p [FRONT_END_PORT]:[FRONT_END_PORT] -e "CONSUL_PORT_8500_TCP_ADDR=[CONSUL_IP]" -e "CONSUL_PORT_8500_TCP_PORT=[CONSUL_PORT]" --name hap mmaquevice/consul-template-haproxy

docker run -d --name tomcat-n1 -e SERVICE_NAME=tomcat -e SERVICE_TAGS=java -P tomcat:6
```
