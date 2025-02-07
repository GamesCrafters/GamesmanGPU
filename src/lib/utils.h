#pragma once

// ! For suppressing warnings
#ifndef __CUDACC__
#define __global__
#define cudaMemcpy(dst, src, size, kind)
#define cudaMalloc(ptr, size)
#define cudaFree(ptr)
#endif

#ifdef __CUDACC__
#define CUDA_CALLABLE __host__ __device__
#else
#define CUDA_CALLABLE
#endif

CUDA_CALLABLE unsigned long long factorial(unsigned int n);
CUDA_CALLABLE unsigned long long combination(unsigned int n, unsigned int k);
