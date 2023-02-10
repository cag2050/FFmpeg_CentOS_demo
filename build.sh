#!/bin/bash
rm -rf output
mkdir output
cd output

cmake ..
make

# 要执行的二进制文件
./hello-world
./cmd-dir
./ffmpeg-demo1