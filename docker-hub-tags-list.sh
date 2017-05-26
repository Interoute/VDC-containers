#!/bin/bash

# docker-hub-tags-list.sh
# The 'docker' command line does not display the list of tags within a repo on Docker Hub
# This shell script will generate the full list of tags for a given repo name, using a Docker API function
# Takes 1 argument which is the required repo name (no quote marks). Example: 
#   $ ./docker-hub-tags-list.sh ubuntu
# (file permissions will need to be set to 'a+x' to allow execution)

# Requires: 'jq' command line program [https://stedolan.github.io/jq/] which is standard install in CoreOS

repo="$1"
reponame="$1"

if [[ "${repo}" != */* ]]; then
    repo="library/${repo}"
fi

url="https://registry.hub.docker.com/v1/repositories/${repo}/tags"
##curl -s -S "${url}" | jq '.[]["name"]' | sed 's/^"\(.*\)"$/\1/' | sort
curl -s -S "${url}" | jq '.[]["name"]' | sed "s/^\"\(.*\)\"$/\1/" | awk -vT=$reponame '{ print T ":" $0 }' | sort

##curl -s -S "${url}" | jq '.[] | {layer: .layer, name: .name}' 

