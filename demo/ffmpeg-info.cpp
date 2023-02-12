#include <iostream>

extern "C" {
#include "libavcodec/avcodec.h"
#include <libavformat/avformat.h>
#include "libavutil/avutil.h"
}

int main(int arg, char **argv) {
    // 打印ffmpeg的信息
    std::cout << "av_version_info():" << av_version_info() << std::endl;
    std::cout << "avcodec_configuration():" << avcodec_configuration() << std::endl;
    return 0;
}