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

# The directory structure is fairly simple:
#
# * Source/header files which are in the "private" directory are local to the
#   emulator core and are not exposed to users of the emulator core.
#
# * Header files which are in the "public" directory are meant to be used by
#   users of the emulator core to interface with it.

set(SRCS_PRIVATE private/log.c)
set(HDRS_PUBLIC public/gbcore/log.h)

# We compile the emulator core as object files to allow for inter-procedural
# optimization with the user of the emulator core.
#
# XXX: I really doubt this giving us any significant performance benefit given
# all of the potential disadvantages. Benchmark later.
add_library(gbcore OBJECT ${SRCS_PRIVATE} ${HDRS_PUBLIC})

# Allow users of the library to get access to the public header files.
target_include_directories(gbcore PUBLIC public)

# Enforce our project compile options.
kaigb_target_configure(gbcore)
