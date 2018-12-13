#!/bin/bash

docker run --rm --name debirf-instance-x -ti $(cat tag) /bin/bash

# -v $PWD/output:/armbian-build/build/output
