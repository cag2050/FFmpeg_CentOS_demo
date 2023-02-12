### FFmpeg库的使用

#### 说明：
1. 在CentOS下编译和执行
2. 在demo目录下添加cpp文件，运行./build.sh都会被编译；如果想看到执行结果，可以在output文件夹执行相应二进制程序，或将执行命令添加到build.sh文件
3. 【10.1.4 在工程中引入动态库】（https://weread.qq.com/web/reader/0ab32a10813ab6d6fg015082 ）这部分内容，我因为没有下载到shared和dev两个版本，是通过运行make install命令，从includes的默认路径/usr/local/include复制头文件目录到dep/FFmpeg/include，在库文件的默认目录/usr/local/lib复制静态库文件到dep/FFmpeg/libs
4. 编译参数查看：执行output文件夹下的ffmpeg-info

#### 在CentOS系统中编译FFmpeg(静态编译)：
1. git clone https://git.ffmpeg.org/ffmpeg.git
2. ./configure --disable-x86asm【具体编译参数，会调整；静态编译，默认编译成静态库；运行./configure --help输出的内容节选（[no]是指默认值）：Configuration options
: --disable-static         do not build static libraries [no]、--enable-shared          build shared libraries [no]】
3. make
4. make install

#### 编译报错及解决
1.报错：
```
/app/CLionProjects/FFmpeg_CentOS_demo/demo/cmd-dir.cpp: 在函数‘int list_op(const char*)’中:
/app/CLionProjects/FFmpeg_CentOS_demo/dep/FFmpeg/include/libavutil/error.h:122:95: 错误：taking address of temporary array
     av_make_error_string((char[AV_ERROR_MAX_STRING_SIZE]){0}, AV_ERROR_MAX_STRING_SIZE, errnum)
                                                                                               ^
/app/CLionProjects/FFmpeg_CentOS_demo/demo/cmd-dir.cpp:55:68: 附注：in expansion of macro ‘av_err2str’
         av_log(NULL, AV_LOG_ERROR, "Cannot open directory: %s.\n", av_err2str(ret));
                                                                    ^
/app/CLionProjects/FFmpeg_CentOS_demo/dep/FFmpeg/include/libavutil/error.h:122:95: 错误：taking address of temporary array
     av_make_error_string((char[AV_ERROR_MAX_STRING_SIZE]){0}, AV_ERROR_MAX_STRING_SIZE, errnum)
                                                                                               ^
/app/CLionProjects/FFmpeg_CentOS_demo/demo/cmd-dir.cpp:63:20: 附注：in expansion of macro ‘av_err2str’
                    av_err2str(ret));
                    ^
```
解决：https://blog.csdn.net/lizhijian21/article/details/102795395

2.报错
```
[ 33%] Linking CXX executable cmd-dir
../dep/FFmpeg/libs/libavformat.a(rtmpproto.o)：在函数‘rtmp_uncompress_swfplayer’中：
/app/CLionProjects/ffmpeg/libavformat/rtmpproto.c:1080：对‘inflateInit_’未定义的引用
/app/CLionProjects/ffmpeg/libavformat/rtmpproto.c:1090：对‘inflate’未定义的引用
/app/CLionProjects/ffmpeg/libavformat/rtmpproto.c:1108：对‘inflateEnd’未定义的引用
/app/CLionProjects/ffmpeg/libavformat/rtmpproto.c:1108：对‘inflateEnd’未定义的引用
../dep/FFmpeg/libs/libavformat.a(udp.o)：在函数‘udp_close’中：
/app/CLionProjects/ffmpeg/libavformat/udp.c:1134：对‘pthread_join’未定义的引用
/app/CLionProjects/ffmpeg/libavformat/udp.c:1131：对‘pthread_cancel’未定义的引用
../dep/FFmpeg/libs/libavformat.a(udp.o)：在函数‘udp_open’中：
/app/CLionProjects/ffmpeg/libavformat/udp.c:953：对‘pthread_create’未定义的引用
../dep/FFmpeg/libs/libavformat.a(async.o)：在函数‘async_close’中：
/app/CLionProjects/ffmpeg/libavformat/async.c:327：对‘pthread_join’未定义的引用
../dep/FFmpeg/libs/libavformat.a(async.o)：在函数‘async_open’中：
/app/CLionProjects/ffmpeg/libavformat/async.c:294：对‘pthread_create’未定义的引用
../dep/FFmpeg/libs/libavformat.a(http.o)：在函数‘http_close’中：
/app/CLionProjects/ffmpeg/libavformat/http.c:1880：对‘inflateEnd’未定义的引用
../dep/FFmpeg/libs/libavformat.a(http.o)：在函数‘parse_content_encoding’中：
/app/CLionProjects/ffmpeg/libavformat/http.c:850：对‘inflateEnd’未定义的引用
/app/CLionProjects/ffmpeg/libavformat/http.c:851：对‘inflateInit2_’未定义的引用
/app/CLionProjects/ffmpeg/libavformat/http.c:856：对‘zlibCompileFlags’未定义的引用
../dep/FFmpeg/libs/libavformat.a(http.o)：在函数‘http_buf_read_compressed’中：
/app/CLionProjects/ffmpeg/libavformat/http.c:1657：对‘inflate’未定义的引用
../dep/FFmpeg/libs/libavutil.a(crc.o)：在函数‘av_crc_get_table’中：
/app/CLionProjects/ffmpeg/libavutil/crc.c:382：对‘pthread_once’未定义的引用
/app/CLionProjects/ffmpeg/libavutil/crc.c:379：对‘pthread_once’未定义的引用
/app/CLionProjects/ffmpeg/libavutil/crc.c:378：对‘pthread_once’未定义的引用
/app/CLionProjects/ffmpeg/libavutil/crc.c:380：对‘pthread_once’未定义的引用
/app/CLionProjects/ffmpeg/libavutil/crc.c:381：对‘pthread_once’未定义的引用
../dep/FFmpeg/libs/libavutil.a(crc.o):/app/CLionProjects/ffmpeg/libavutil/crc.c:383: 跟着更多未定义的参考到 pthread_once
collect2: 错误：ld 返回 1
make[2]: *** [cmd-dir] 错误 1
make[1]: *** [CMakeFiles/cmd-dir.dir/all] 错误 2
make: *** [all] 错误 2
```
解决：缺少库pthread、z，CMakeLists.txt文件的target_link_libraries链接这2个库；参考：https://blog.csdn.net/qichuangguo/article/details/116052135

3.报错：
```
[ 33%] Linking CXX executable cmd-dir
CMakeFiles/cmd-dir.dir/demo/cmd-dir.cpp.o：在函数‘av_make_error_string’中：
cmd-dir.cpp:(.text+0x24)：对‘av_strerror’未定义的引用
CMakeFiles/cmd-dir.dir/demo/cmd-dir.cpp.o：在函数‘list_op(char const*)’中：
cmd-dir.cpp:(.text+0x3e7)：对‘avio_open_dir’未定义的引用
cmd-dir.cpp:(.text+0x424)：对‘av_log’未定义的引用
cmd-dir.cpp:(.text+0x443)：对‘avio_read_dir’未定义的引用
cmd-dir.cpp:(.text+0x480)：对‘av_log’未定义的引用
cmd-dir.cpp:(.text+0x55d)：对‘av_log’未定义的引用
cmd-dir.cpp:(.text+0x5e7)：对‘av_log’未定义的引用
cmd-dir.cpp:(.text+0x5ff)：对‘avio_free_directory_entry’未定义的引用
cmd-dir.cpp:(.text+0x614)：对‘avio_close_dir’未定义的引用
CMakeFiles/cmd-dir.dir/demo/cmd-dir.cpp.o：在函数‘main’中：
cmd-dir.cpp:(.text+0x72e)：对‘av_log_set_level’未定义的引用
cmd-dir.cpp:(.text+0x74f)：对‘avformat_network_init’未定义的引用
cmd-dir.cpp:(.text+0x76a)：对‘avformat_network_deinit’未定义的引用
collect2: 错误：ld 返回 1
make[2]: *** [cmd-dir] 错误 1
make[1]: *** [CMakeFiles/cmd-dir.dir/all] 错误 2
make: *** [all] 错误 2
```
解决：CMakeLists.txt文件中，target_link_libraries引用ffmpeg库的顺序不对，调整成文件内所示

4.使用ffprobe分析yuv文件，报错：Picture size 0x0 is invalid，原因：yuv是原始格式数据，采集到的是什么样，存储的就是什么样，ffprobe并不知道分辨率；分辨率可以在解码的过程中获取到；解决：指定-video_size参数

参考 | 说明
--- | ---
书籍《FFmpeg音视频开发基础与实战》10.1 使用CMake构建工程 | https://weread.qq.com/web/reader/0ab32a10813ab6d6fg015082k9bf32f301f9bf31c7ff0a60
书籍《FFmpeg音视频开发基础与实战》配套源码 | https://gitee.com/yinwenjie-1/ffmpeg-tutorial
