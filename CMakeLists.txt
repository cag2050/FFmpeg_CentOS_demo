cmake_minimum_required(VERSION 3.5 FATAL_ERROR)
project(FFmpeg_CentOS_demo)
set(CMAKE_CXX_STANDARD 11)

include_directories(${PROJECT_SOURCE_DIR}/inc)
include_directories(${PROJECT_SOURCE_DIR}/dep/FFmpeg/include)

set(ffmpeg_libs_dir ${PROJECT_SOURCE_DIR}/dep/FFmpeg/libs)
link_directories(${ffmpeg_libs_dir})
#file(GLOB ffmpeg_libs ${ffmpeg_libs_dir}/*.a)

set(src_dir ${PROJECT_SOURCE_DIR}/src)
file(GLOB src_codes ${src_dir}/*.cpp)

set(demo_dir ${PROJECT_SOURCE_DIR}/demo)
file(GLOB demo_codes ${demo_dir}/*.cpp)

foreach(demo ${demo_codes})
    get_filename_component(demo_basename ${demo} NAME_WE)
    add_executable(${demo_basename} ${demo} ${src_codes})
    target_link_libraries(${demo_basename} ${ffmpeg_libs_dir}/libavformat.a ${ffmpeg_libs_dir}/libavdevice.a
            ${ffmpeg_libs_dir}/libavcodec.a ${ffmpeg_libs_dir}/libavutil.a ${ffmpeg_libs_dir}/libswresample.a
            ${ffmpeg_libs_dir}/libavfilter.a ${ffmpeg_libs_dir}/libswscale.a ${ffmpeg_libs_dir}/libx264.a
            ${ffmpeg_libs_dir}/libpostproc.a pthread z dl)
endforeach()
