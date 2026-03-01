/*
 * Copyright (c) Meta Platforms, Inc. and affiliates.
 * All rights reserved.
 *
 * This source code is licensed under the BSD-style license found in the
 * LICENSE file in the root directory of this source tree.
 */

#include <executorch/kernels/portable/cpu/pattern/pattern.h>
#include <executorch/runtime/kernel/kernel_includes.h>
#include <cmath>

// static inline float acoshf_wrapper(float x) {
//     return (float)::acosh((double)x);
// }
static inline float acosh_compat(float x) {
    return (float)::acosh((double)x);
}

static inline double acosh_compat(double x) {
    return ::acosh(x);
}


namespace torch {
namespace executor {
namespace native {

// DEFINE_UNARY_UFUNC_REALHBBF16_TO_FLOATHBF16(acosh_out, std::acosh)
// DEFINE_UNARY_UFUNC_REALHBBF16_TO_FLOATHBF16(acosh_out, acoshf_wrapper)
DEFINE_UNARY_UFUNC_REALHBBF16_TO_FLOATHBF16(acosh_out, acosh_compat)
// internal::unary_ufunc_realhbbf16_to_floathbf16(
//     acoshf_wrapper,
//     acosh_wrapper,
//     ctx,
//     in,
//     out);

} // namespace native
} // namespace executor
} // namespace torch
