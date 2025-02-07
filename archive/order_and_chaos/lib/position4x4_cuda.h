#pragma once

#include <map>

#include "position4x4.h"
#include "recursive_value.h"

// Threads per CTA (2048 threads per CTA)
const int DEFAULT_BLOCK_SIZE = 1 << 11;

// CTAs per Grid
inline int GRID_SIZE(int N, int BLOCK_SIZE) { return (N + BLOCK_SIZE - 1) / BLOCK_SIZE; }

// Functions
std::map<Position4x4, GameResult> cuda_solve_0_spaces_remain();

void test_cuda_have_4_in_a_row(const int N, const int BLOCK_SIZE);
