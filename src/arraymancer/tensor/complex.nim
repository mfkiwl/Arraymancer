# Copyright (c) 2023 the Arraymancer contributors
# Distributed under the Apache v2 License (license terms are at http://www.apache.org/licenses/LICENSE-2.0).
# This file may not be copied, modified, or distributed except according to those terms.

import std/complex
import
  ./data_structure,
  ./accessors,
  ./higher_order_applymap

proc complex*[T: SomeFloat](re: Tensor[T], im: Tensor[T]): Tensor[Complex[T]] {.inline, noinit.} =
  ## Create a new, complex Tensor by combining two real Tensors
  ##
  ## The first input Tensor is copied into the real part of the output Tensor,
  ## while the second input Tensor is copied into the imaginary part
  map2_inline(re, im, complex(x, y))

proc real*[T: SomeFloat](t: Tensor[Complex[T]]): Tensor[T] {.inline, noinit.} =
  ## Get the real part of a complex Tensor (as a float Tensor)
  t.map_inline(x.re)

proc `real=`*[T: SomeFloat](t: var Tensor[Complex[T]], val: T) {.inline.} =
  ## Set the real part of all the items of a complex Tensor to a certain floating point value
  for it in t.mitems:
    it.re = val

proc `real=`*[T: SomeFloat](t: var Tensor[Complex[T]], val: Tensor[T]) {.inline.} =
  ## Copy a real Tensor into the real part of an existing complex Tensor
  ## The source and target Tensor sizes must match, but the shapes might differ
  for it, srcit in mzip(t, val):
    it.re = srcit

proc imag*[T: SomeFloat](t: Tensor[Complex[T]]): Tensor[T] {.inline, noinit.} =
  ## Get the imaginary part of a complex Tensor (as a float Tensor)
  t.map_inline(x.im)

proc `imag=`*[T: SomeFloat](t: var Tensor[Complex[T]], val: T) {.inline.} =
  ## Set the imaginary part of all the items of a complex Tensor to a certain floating point value
  for it in t.mitems:
    it.im = val

proc `imag=`*[T: SomeFloat](t: var Tensor[Complex[T]], val: Tensor[T]) {.inline.} =
  ## Copy a real Tensor into the imaginary part of an existing complex Tensor
  ## The source and target Tensor sizes must match, but the shapes might differ
  for it, srcit in mzip(t, val):
    it.im = srcit

proc conjugate*[T: Complex32 | Complex64](A: Tensor[T]): Tensor[T] =
  ## Return the element-wise complex conjugate of a tensor of complex numbers.
  ## The complex conjugate of a complex number is obtained by changing the sign of its imaginary part.
  A.map_inline(x.conjugate)
