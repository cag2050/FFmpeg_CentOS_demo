#!/bin/bash
rm -rf output
mkdir output
cd output

cmake ..
make

# 要执行的二进制文件
./hello-world
./cmd-dir .
./ffmpeg-info
./video_encoder ../video/bus_cif.yuv ../video/bus_cif.h264 libx264