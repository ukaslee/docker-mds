#!/bin/bash

sudo xhost +
sudo docker run -it --rm -e DISPLAY=unix$DISPLAY \
	-v /tmp/.X11-unix:/tmp/.X11-unix \
	-v /home/ukas/Projects/vega-7010_bmc:/home/mds/projects/vega-7010_bmc \
	mds:12.0.0 /bin/bash
