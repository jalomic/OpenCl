cmake_minimum_required(VERSION 3.1)
set(OPENCL_MIN_VERSION 120)

set(OPENCL_ICD_LOADER_HEADERS_DIR
    "${CMAKE_CURRENT_LIST_DIR}/OpenCL-Headers" CACHE PATH "Path to OpenCL
    Headers")

set(OPENCL_SDK_INCLUDE_DIRS
    "${CMAKE_CURRENT_LIST_DIR}/OpenCL-Headers"
    "${CMAKE_CURRENT_LIST_DIR}/OpenCL-CLHPP/include")

add_subdirectory(${CMAKE_CURRENT_LIST_DIR}/OpenCL-ICD-Loader)

set_target_properties(OpenCL PROPERTIES LIBRARY_OUTPUT_DIRECTORY
    ${CMAKE_CURRENT_BINARY_DIR})

target_include_directories(${CMAKE_PROJECT_NAME} PUBLIC ${OPENCL_SDK_INCLUDE_DIRS})
if(APPLE)
    target_link_libraries(${CMAKE_PROJECT_NAME} "-framework OpenCL")
else()
    target_link_libraries(${CMAKE_PROJECT_NAME} OpenCL)
endif()

target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_HPP_ENABLE_EXCEPTIONS)
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_TARGET_OPENCL_VERSION=${OPENCL_MIN_VERSION})
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_HPP_TARGET_OPENCL_VERSION=${OPENCL_MIN_VERSION})
target_compile_definitions(${CMAKE_PROJECT_NAME} PRIVATE CL_HPP_MINIMUM_OPENCL_VERSION=${OPENCL_MIN_VERSION})
