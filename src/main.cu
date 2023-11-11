#include "lib/tier.h"
#include <cassert>
#include <chrono>
#include <iostream>

using std::chrono::duration_cast;
using std::chrono::high_resolution_clock;
using std::chrono::milliseconds;

Tier *solve(Tier::SolveBy solve_by) {
  Tier *next_tier = nullptr;

  for (int i = 0; i < TTT_N * TTT_N + 1; i++) {
    Tier *tier = new Tier(i, next_tier);

    auto solve_result = tier->solve(solve_by);
    if (solve_result != Tier::SolveResult::Success) {
      throw std::runtime_error("Failed to solve tier " + std::to_string(i));
    }

    if (next_tier != nullptr) {
      delete next_tier;
      tier->set_next_tier_null();
    }

    next_tier = tier;
  }

  return next_tier;
}

int main() {
  std::cout << "== Start!" << std::endl;

  auto t1 = high_resolution_clock::now();
  auto tier_solved_by_cpu = solve(Tier::SolveBy::CPU);
  auto t2 = high_resolution_clock::now();
  std::cout << "CPU: ";
  std::cout << duration_cast<milliseconds>(t2 - t1).count() << "ms"
            << std::endl;

  auto t3 = high_resolution_clock::now();
  auto tier_solved_by_gpu = solve(Tier::SolveBy::GPU);
  auto t4 = high_resolution_clock::now();
  std::cout << "GPU: ";
  std::cout << duration_cast<milliseconds>(t4 - t3).count() << "ms"
            << std::endl;

  std::cout << "== Validating..." << std::endl;
  std::cout << "CPU: " << tier_solved_by_cpu->format() << std::endl;
  std::cout << "GPU: " << tier_solved_by_gpu->format() << std::endl;
  assert(*tier_solved_by_cpu == *tier_solved_by_gpu);
  std::cout << "Results by CPU and GPU are the same!" << std::endl;

  return 0;
}
