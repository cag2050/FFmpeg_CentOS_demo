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
./video_encoder ../video/encode_input_352x288_I420_cif.yuv ../video/encode_output.h264 libx264
./video_decoder ../video/decode_input.h264 ../video/decode_output.yuv