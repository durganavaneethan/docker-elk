#!/bin/bash
set -x
git clone -b V1.4 https://github.com/durganavaneethan/docker-elk.git
cd docker-elk
docker-compose up -d
docker pull durganavanee/observability_poc_logstash:v2.0
sleep 20
docker pull durganavanee/observability_poc_elasticsearch:v2.0
sleep 20
docker pull durganavanee/observability_poc_kibana:v2.0
sleep 20
docker images
docker ps
sleep 30
curl --user elastic:changeme -XPUT 'localhost:9200/idx'
curl --user elastic:changeme -XGET 'localhost:9200/idx'
curl --user elastic:changeme -XPOST 'localhost:5601/api/saved_objects/index-pattern' -H 'Content-Type: application/json' -H 'kbn-version: 7.12.0' -u elastic:changeme -d '{"attributes":{"title":"logstash-*","timeFieldName":"@timestamp"}}'
