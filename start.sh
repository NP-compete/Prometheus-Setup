#!/bin/bash

## Start Prometheus
docker run -d --net=host -v prometheus.yml:/etc/prometheus/prometheus.yml --name prometheus-server prom/prometheus

## Start Node Exporter
docker run -d -v "/proc:/host/proc" -v "/sys:/host/sys" -v "/:/rootfs" --net="host" --name=prometheus quay.io/prometheus/node-exporter:v0.13.0 -collector.procfs /host/proc -collector.sysfs /host/sys -collector.filesystem.ignored-mount-points "^/(sys|proc|dev|host|etc)($|/)"

## Ask if user wants to view raw metrics
curl localhost:9100/metrics
