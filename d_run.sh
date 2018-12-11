#!/bin/bash

docker run --rm -ti $(cat tag) /bin/bash

# --name debirf-instance
# -v $PWD/output:/armbian-build/build/output