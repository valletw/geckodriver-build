#!/bin/bash

cross_file="./CROSS."
gecko_file="./GECKO_RELEASE"

if [ $# -ne 1 ]; then
    echo "$0 <target_name>"
    exit 1
elif [ ! -f "./CROSS.$1" ]; then
    echo "Target name not preconfigured (check '${cross_file}<target_name>' file)"
    exit 2
else
    # Prepare build arguments.
    args="--build-arg GECKO_RELEASE=$(cat "${gecko_file}")"
    args+=" $(sed 's/^/--build-arg /g' < "${cross_file}$1" | tr '\n' ' ')"
    # Clean previous build.
    rm -rf build/*
    # Run build with buildkit for output feature.
    # shellcheck disable=SC2086
    DOCKER_BUILDKIT=1 docker build ${args} -t "gecko-build:$1" -o build .
fi
