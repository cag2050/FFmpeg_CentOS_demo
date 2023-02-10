### FFmpeg库的使用

#### 说明：
1. 在CentOS下编译和执行
2. 在demo目录下添加cpp文件，运行./build.sh都会被编译；如果想看到执行结果，可以在output文件夹执行相应二进制程序，或将执行命令添加到build.sh文件
3. 【10.1.4 在工程中引入动态库】（https://weread.qq.com/web/reader/0ab32a10813ab6d6fg015082 ）这部分内容，我因为没有下载到shared和dev两个版本，是通过运行make install命令，从includes的默认路径/usr/local/include复制头文件目录到dep/FFmpeg/include，在库文件的默认目录/usr/local/lib复制静态库文件到dep/FFmpeg/libs

#### 在CentOS系统中编译FFmpeg(静态编译)：
1. git clone https://git.ffmpeg.org/ffmpeg.git
2. ./configure --disable-x86asm【静态编译，默认编译成静态库；运行./configure --help输出的内容节选（[no]是指默认值）：Configuration options: --disable-static         do not build static libraries [no]、--enable-shared          build shared libraries [no]】
3. make
4. make install

参考 | 说明
--- | ---
书籍《FFmpeg音视频开发基础与实战》10.1 使用CMake构建工程 | https://weread.qq.com/web/reader/0ab32a10813ab6d6fg015082k9bf32f301f9bf31c7ff0a60
书籍《FFmpeg音视频开发基础与实战》配套源码 | https://gitee.com/yinwenjie-1/ffmpeg-tutorial
