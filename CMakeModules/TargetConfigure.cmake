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

# Configures a target to conform to our project specifications.
function(kaigb_target_configure TARGET_NAME)
  # Extensions will not always be forbidden; we just don't care about them right
  # now.
  set_target_properties(${TARGET_NAME} PROPERTIES
                        C_STANDARD 90
                        C_STANDARD_REQUIRED YES
                        C_EXTENSIONS OFF)

  if (CMAKE_C_COMPILER_ID MATCHES "Clang" OR # MATCHES to account for AppleClang
      CMAKE_C_COMPILER_ID STREQUAL "GCC")
      target_compile_options(${TARGET_NAME} PRIVATE -pipe)

      if (CMAKE_BUILD_TYPE STREQUAL "Debug")
        target_compile_options(${TARGET_NAME} PRIVATE -ggdb3
                                                      -Wall
                                                      -Wduplicated-branches
                                                      -Wduplicated-cond
                                                      -Werror
                                                      -Wextra
                                                      -Wlogical-op
                                                      -Wpadded
                                                      -Wpedantic
                                                      -Wshadow)

        if (KAIGB_EXTRA_COMPILE_CHECKS)
          target_compile_options(${TARGET_NAME} PRIVATE -O1 -Wnull-dereference)
        endif()
      endif()
  endif()
endfunction()
