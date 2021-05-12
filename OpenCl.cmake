# Copyright (c) 2020 The Khronos Group Inc.
#
# Licensed under the Apache License, Version 2.0 (the "License");
# you may not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
#     http://www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an "AS IS" BASIS,
# WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.

cmake_minimum_required(VERSION 3.0)

set(CMAKE_CXX_STANDARD 11)

if (NOT CMAKE_BUILD_TYPE)
    message(STATUS "No build type selected, default to Release")
    set(CMAKE_BUILD_TYPE "Release" CACHE PATH "Build Type" FORCE)
endif()

set(OPENCL_ICD_LOADER_HEADERS_DIR
    "${CMAKE_CURRENT_LIST_DIR}/OpenCL-Headers" CACHE PATH "Path to OpenCL
    Headers")

if(CMAKE_INSTALL_PREFIX_INITIALIZED_TO_DEFAULT)
    set(CMAKE_INSTALL_PREFIX "${PROJECT_SOURCE_DIR}/install" CACHE PATH "Install Path" FORCE)
endif()

set(OPENCL_SDK_INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/OpenCL-Headers"
    "${CMAKE_CURRENT_LIST_DIR}/OpenCL-CLHPP/include")

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/OpenCL-ICD-Loader)

set_target_properties(OpenCL PROPERTIES LIBRARY_OUTPUT_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${OPENCL_SDK_INCLUDE_DIRS})
target_link_libraries(${CMAKE_PROJECT_NAME} OpenCL)

set(OPENCL_MIN_VERSION 120)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_HPP_ENABLE_EXCEPTIONS)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_TARGET_OPENCL_VERSION=${OPENCL_MIN_VERSION})
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_HPP_TARGET_OPENCL_VERSION=${OPENCL_MIN_VERSION})
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_HPP_MINIMUM_OPENCL_VERSION=${OPENCL_MIN_VERSION})
