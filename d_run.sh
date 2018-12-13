#!/bin/bash

docker run --rm --name debirf-instance-0 -ti $(cat tag) /bin/bash

# -v $PWD/output:/armbian-build/build/output
