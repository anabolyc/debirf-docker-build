#!/bin/bash

docker run --rm --privileged -v $PWD/output:/armbian-build/build/output -ti $(cat tag) /bin/bash