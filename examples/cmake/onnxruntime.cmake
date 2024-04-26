# ##############################################################################
# Copyright (C) Intel Corporation
#
# SPDX-License-Identifier: MIT
# ##############################################################################

cmake_minimum_required(VERSION 3.5.1)

if(WIN32)
  # To use the WinPixEventRuntime library to export D3D12PIX functions.
  # NOTE: VS_PACKAGE_REFERENCES doesn't work for C++ projects.
  find_program(NUGET nuget)
  if (NOT NUGET)
    message(FATAL "Cannot find nuget command line tool.\nInstall it with admin privilege: choco install nuget.commandline")
  endif()

  list(APPEND CMAKE_PREFIX_PATH "${CMAKE_CURRENT_BINARY_DIR}/../packages")
  set(ONNXRUNTIME_ROOT ${CMAKE_CURRENT_BINARY_DIR}/../packages/)
  set(ONNXRUNTIME_NAME Microsoft.ML.OnnxRuntime.DirectML)
  set(ONNXRUNTIME_VERSION 1.17.1)
  set(ONNXRUNTIME_INCLUDE_DIR "${ONNXRUNTIME_ROOT}/${ONNXRUNTIME_NAME}.${ONNXRUNTIME_VERSION}/build/native/include")
  set(ONNXRUNTIME_LIB_DIR "${ONNXRUNTIME_ROOT}/${ONNXRUNTIME_NAME}.${ONNXRUNTIME_VERSION}/runtimes/win-${CMAKE_CXX_COMPILER_ARCHITECTURE_ID}/native")
  execute_process(COMMAND ${NUGET} install ${ONNXRUNTIME_NAME} -Version ${ONNXRUNTIME_VERSION} -Verbosity quiet -OutputDirectory ${CMAKE_CURRENT_BINARY_DIR}/../packages/)
else()
  list(APPEND CMAKE_PREFIX_PATH "~/packages/onnxruntime/")
  set(ONNXRUNTIME_NAME onnxruntime-linux-x64-gpu)
  set(ONNXRUNTIME_VERSION 1.17.1)
  set(ONNXRUNTIME_INCLUDE_DIR "${CMAKE_PREFIX_PATH}/${ONNXRUNTIME_NAME}-${ONNXRUNTIME_VERSION}/include")
  set(ONNXRUNTIME_LIB_DIR "${CMAKE_PREFIX_PATH}/${ONNXRUNTIME_NAME}-${ONNXRUNTIME_VERSION}/lib")
endif()

