#!/bin/bash

cd /debirf/minimal && \
debirf make --skip --no-initrd --no-warning . && \
debirf make --skip --no-warning --initrd-only . && \
debirf makeiso .