# SPDX-License-Identifier: ISC
#
# Copyright 2023 Michael Rodriguez
#
# Permission to use, copy, modify, and/or distribute this software for any
# purpose with or without fee is hereby granted, provided that the above
# copyright notice and this permission notice appear in all copies.
#
# THE SOFTWARE IS PROVIDED "AS IS" AND THE AUTHOR DISCLAIMS ALL WARRANTIES WITH
# REGARD TO THIS SOFTWARE INCLUDING ALL IMPLIED WARRANTIES OF MERCHANTABILITY
# AND FITNESS. IN NO EVENT SHALL THE AUTHOR BE LIABLE FOR ANY SPECIAL, DIRECT,
# INDIRECT, OR CONSEQUENTIAL DAMAGES OR ANY DAMAGES WHATSOEVER RESULTING FROM
# LOSS OF USE, DATA OR PROFITS, WHETHER IN AN ACTION OF CONTRACT, NEGLIGENCE OR
# OTHER TORTIOUS ACTION, ARISING OUT OF OR IN CONNECTION WITH THE USE OR
# PERFORMANCE OF THIS SOFTWARE.

# The build system structure is influenced by the principles and guidelines laid
# out in the following resources:
#
# * https://cliutils.gitlab.io/modern-cmake/
# * https://cmake.org/cmake/help/book/mastering-cmake/

# The FATAL_ERROR option is accepted but ignored by CMake 2.6 and higher. It
# should be specified so CMake versions 2.4 and lower fail with an error instead
# of just a warning.
cmake_minimum_required(VERSION 3.7...3.25 FATAL_ERROR)

if (${CMAKE_VERSION} VERSION_LESS 3.12)
  cmake_policy(VERSION ${CMAKE_MAJOR_VERSION}.${CMAKE_MINOR_VERSION})
endif()

# Allow the `project()` command to specify the project version.
cmake_policy(SET CMP0048 NEW)

project(kaigb VERSION 1.0.0.0
              DESCRIPTION "Game Boy emulator"
              HOMEPAGE_URL "https://github.com/kaichiuchi/kaigb"
              LANGUAGES C)

if (${CMAKE_CURRENT_SOURCE_DIR} STREQUAL ${CMAKE_CURRENT_BINARY_DIR})
  message(FATAL_ERROR "You cannot create a build inside of the source "
                      "directory. Try running this command: \"cmake -S "
                      "${CMAKE_SOURCE_DIR} -B .\"")
endif()

# Support folders in IDEs. This isn't really too necessary as most modern IDEs
# have native support for CMake, but it isn't wrong to support other workflows.
set_property(GLOBAL PROPERTY USE_FOLDERS ON)

# For development versions, this should be set to Debug. For all other versions,
# this should be set to Release.
#
# https://www.kitware.com//cmake-and-the-default-build-type/
set(BUILD_TYPE_DEFAULT "Debug")

if (NOT CMAKE_BUILD_TYPE AND NOT CMAKE_CONFIGURATION_TYPES)
  message(STATUS "Setting build type to '${BUILD_TYPE_DEFAULT}' as one wasn't "
                 "specified.")

  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY VALUE “${BUILD_TYPE_DEFAULT}”)

  # Set the possible values of build type for cmake-gui.
  set_property(CACHE CMAKE_BUILD_TYPE PROPERTY STRINGS
               "Debug" "Release" "MinSizeRel" "RelWithDebInfo")
endif()

# Define command line options.
option(KAIGB_TESTS_BUILD "Build the unit tests" ON)

# This looks horrible, I know. You can blame CMake for this.
option(KAIGB_EXTRA_COMPILE_CHECKS "Enables additional warning checks during \
compile-time, which requires compiler optimization to be enabled. This is only \
suitable to verify that the codebase is truly free of warnings. If you wish to \
debug the code, do not enable this option. This option has no effect when the \
Debug build type is not specified." ON)

# Add the `kaigb_target_configure()` command.
include(CMakeModules/TargetConfigure.cmake)

# Continue with the build process.
add_subdirectory(src)
