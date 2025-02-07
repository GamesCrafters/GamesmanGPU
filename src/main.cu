#include "lib/tier.h"
#include <cassert>
#include <chrono>
#include <iostream>

using std::chrono::duration_cast;
using std::chrono::high_resolution_clock;
using std::chrono::milliseconds;

Tier *solve(Tier::SolveBy solve_by, bool destroy_tiers) {
  Tier *next_tier = nullptr;

  for (int i = 0; i < TTT_N * TTT_N + 1; i++) {
    Tier *tier = new Tier(i, next_tier);

    std::cout << "Solving tier " << tier->format() << "/" << TTT_N * TTT_N
              << "..." << std::endl;
    std::cout << "\tusing " << Tier::format(solve_by) << std::endl;

    auto t1 = high_resolution_clock::now();
    auto solve_result = tier->solve(solve_by);
    auto t2 = high_resolution_clock::now();
    std::cout << "\tSolved using: ";
    std::cout << duration_cast<milliseconds>(t2 - t1).count() << "ms"
              << " from time " << t1.time_since_epoch().count() << " to "
              << t2.time_since_epoch().count() << std::endl;

    if (solve_result != Tier::SolveResult::Success) {
      throw std::runtime_error("Failed to solve tier " + std::to_string(i));
    }

    if (destroy_tiers && (next_tier != nullptr)) {
      delete next_tier;
      tier->set_next_tier_null();
    }

    next_tier = tier;
  }

  return next_tier;
}

void play_game(Tier *top_tier) {
  Position position = Position();
  Tier *tier = top_tier;

  unsigned int row;
  unsigned int col;

  while (true) {
    Position *children;
    auto num_children = position.children(children);
    for (int i = 0; i < num_children; i++) {
      std::cout << "---------------- Child " << std::to_string(i + 1)
                << " ----------------" << std::endl;
      auto id = children[i].id();
      auto rv = tier->get_next_tier()->rv(id);
      std::cout << "Opponent will: " << rv.format() << std::endl;
      std::cout << children[i].format() << std::endl;
    }
    delete[] children;

    std::cout << "===================="
              << "====================" << std::endl;
    auto id = position.id();
    auto rv = tier->rv(id);
    std::cout << rv.format() << std::endl;
    std::cout << position.format() << std::endl;

    if (num_children == 0) {
      std::cout << "[*] Game over!" << std::endl;
      break;
    }

    std::cout << "Enter i: ";
    std::cin >> row;
    if (row >= TTT_N) {
      std::cerr << "[!] Invalid i" << std::endl;
      continue;
    }
    std::cout << "Enter j: ";
    std::cin >> col;
    if (col >= TTT_N) {
      std::cerr << "[!] Invalid j" << std::endl;
      continue;
    }

    if (position.is_occupied(row, col)) {
      std::cerr << "[!] Position is occupied" << std::endl;
      continue;
    }

    position = position.next_position(row, col);
    tier = tier->get_next_tier();
  }
}

bool validate(Tier *tier_solved_by_cpu, Tier *tier_solved_by_gpu) {
  while ((tier_solved_by_cpu != nullptr) && (tier_solved_by_gpu != nullptr)) {
    std::cout << "Validating tier " << tier_solved_by_cpu->format() << "/"
              << TTT_N * TTT_N << "..." << std::endl;

    if (*tier_solved_by_cpu != *tier_solved_by_gpu) {
      std::cerr << "[*] Results by CPU and GPU are different!" << std::endl;
      return false;
    }
    tier_solved_by_cpu = tier_solved_by_cpu->get_next_tier();
    tier_solved_by_gpu = tier_solved_by_gpu->get_next_tier();
  }

  if ((tier_solved_by_cpu != nullptr) || (tier_solved_by_gpu != nullptr)) {
    std::cerr << "[*] Results by CPU and GPU are different!" << std::endl;
    return false;
  }

  return true;
}

int main() {
  std::cout << "== Start!" << std::endl;
  auto t0 = high_resolution_clock::now();
  std::cout << "Current time: " << t0.time_since_epoch().count() << "\n"
            << std::endl;

  auto t1 = high_resolution_clock::now();
  auto tier_solved_by_cpu = solve(Tier::SolveBy::CPU, false);
  auto t2 = high_resolution_clock::now();
  std::cout << "\n=== CPU: ";
  std::cout << duration_cast<milliseconds>(t2 - t1).count() << "ms"
            << " from time " << t1.time_since_epoch().count() << " to "
            << t2.time_since_epoch().count() << "\n"
            << std::endl;

  auto t3 = high_resolution_clock::now();
  auto tier_solved_by_gpu = solve(Tier::SolveBy::GPU, false);
  auto t4 = high_resolution_clock::now();
  std::cout << "\n=== GPU: ";
  std::cout << duration_cast<milliseconds>(t4 - t3).count() << "ms"
            << " from time " << t3.time_since_epoch().count() << " to "
            << t4.time_since_epoch().count() << "\n"
            << std::endl;

  std::cout << "== Validating..." << std::endl;
  if (validate(tier_solved_by_cpu, tier_solved_by_gpu)) {
    std::cout << "[*] Results by CPU and GPU are the same!" << std::endl;
  } else {
    throw std::runtime_error("[*] Results by CPU and GPU are different!");
  }

  std::cout << "\n== Playing..." << std::endl;
  play_game(tier_solved_by_cpu);

  return 0;
}
