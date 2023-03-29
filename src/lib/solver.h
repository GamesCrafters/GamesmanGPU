#pragma once

#include <map>

#include "primitive_value.h"
#include "position4x4.h"
#include "recursive_value.h"

class Solver
{
    // Keep small as map value
    enum MemoizedGameResult : char
    {
        OrderLoses,
        OrderWins,
    };

private:
    std::map<Position4x4, MemoizedGameResult> memoized;

    GameResult memoized_to_game_result(
        const Position4x4 &cur_position, const MemoizedGameResult &mgr);

    MemoizedGameResult game_result_to_memoized(
        const Position4x4 &cur_position, const GameResult &gr);

private:
    std::vector<GameResult> solve_children(
        const Position4x4 &position);

    GameResult solve_one_child(
        const Position4x4 &position, const Move &move);

public:
    Solver() : memoized(std::map<Position4x4, MemoizedGameResult>()) {}

    GameResult solve_not_memoized(const Position4x4 &position);
    GameResult solve(const Position4x4 &position);
};
