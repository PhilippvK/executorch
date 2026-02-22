#
# Copyright (c) 2020-2022 Arm Limited. All rights reserved.
#
# SPDX-License-Identifier: Apache-2.0
#
# Licensed under the Apache License, Version 2.0 (the License); you may
# not use this file except in compliance with the License.
# You may obtain a copy of the License at
#
# www.apache.org/licenses/LICENSE-2.0
#
# Unless required by applicable law or agreed to in writing, software
# distributed under the License is distributed on an AS IS BASIS, WITHOUT
# WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
# See the License for the specific language governing permissions and
# limitations under the License.
#

# Copied this file from core_platform/cmake/toolchain/arm-non-eabi-gcc.cmake And
# modified to align better with cs300 platform

set(RISCV_ARCH
    "rv32gc"
    CACHE STRING "Arch"
)
set(RISCV_ABI
    "ilp32d"
    CACHE STRING "Abi"
)
set(TARGET_CPU
    "generic-riscv32"
    CACHE STRING "Target CPU"
)
string(TOLOWER ${TARGET_CPU} CMAKE_SYSTEM_PROCESSOR)

set(CMAKE_SYSTEM_NAME Generic)
set(CMAKE_C_COMPILER "riscv32-unknown-elf-gcc")
set(CMAKE_CXX_COMPILER "riscv32-unknown-elf-g++")
set(CMAKE_ASM_COMPILER "riscv32-unknown-elf-gcc")
set(CMAKE_LINKER "riscv32-unknown-elf-ld")

set(CMAKE_EXECUTABLE_SUFFIX ".elf")
set(CMAKE_TRY_COMPILE_TARGET_TYPE STATIC_LIBRARY)
set(CMAKE_FIND_ROOT_PATH_MODE_PROGRAM NEVER)
set(CMAKE_FIND_ROOT_PATH_MODE_LIBRARY ONLY)
set(CMAKE_FIND_ROOT_PATH_MODE_INCLUDE ONLY)

# Select C/C++ version
set(CMAKE_C_STANDARD 11)
set(CMAKE_CXX_STANDARD 17)

# Compile options
add_compile_options(
  # -mcpu=${GCC_CPU} -mthumb "$<$<CONFIG:DEBUG>:-gdwarf-3>"
  "$<$<COMPILE_LANGUAGE:CXX>:-fno-unwind-tables;-fno-rtti;-fno-exceptions>"
  -fdata-sections -ffunction-sections
)

# Compile defines
add_compile_definitions("$<$<NOT:$<CONFIG:DEBUG>>:NDEBUG>")

# Link options
# add_link_options(-mcpu=${GCC_CPU} -mthumb)

# if(SEMIHOSTING)
#   add_link_options(--specs=semihost.specs)
# else()
#   add_link_options(--specs=nosys.specs)
# endif()

add_compile_options(-march=${RISCV_ARCH} -mabi=${RISCV_ABI})
add_link_options(-march=${RISCV_ARCH} -mabi=${RISCV_ABI})

add_link_options(LINKER:--gc-sections)

# Compilation warnings
add_compile_options(
  # -Wall -Wextra -Wcast-align -Wdouble-promotion -Wformat
  # -Wmissing-field-initializers -Wnull-dereference -Wredundant-decls -Wshadow
  # -Wswitch -Wswitch-default -Wunused -Wno-redundant-decls
  -Wno-error=deprecated-declarations -Wno-error=shift-count-overflow -Wno-psabi
)
