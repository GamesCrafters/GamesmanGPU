#include <iostream>
#include <cassert>

#include "position4x4.h"
#include "position4x4_cuda.h"
#include "move.h"
#include "solver.h"

int main()
{
    std::cout << "GamesCrafters!\n"
              << std::endl;

    // CUDA test
    test_cuda_have_4_in_a_row();

    // GameResult
    std::cout << "sizeof(GameResult): " << sizeof(GameResult) << '\n';

    // Positions
    Position4x4 p = Position4x4();
    std::cout << p.format();
    std::cout << p.format_pretty();
    assert(p.primitive_value() == PrimitiveValue::NotPrimitive);

    char all_4[4] = {
        (char)0b10101010,
        (char)0b00000000,
        (char)0b00000000,
        (char)0b00000000};
    char empty[4] = {
        (char)0b00000000,
        (char)0b00000000,
        (char)0b00000000,
        (char)0b00000000};
    char pos_diag = 0b10101010;
    char neg_diag = 0b11111111;

    p = Position4x4(Player::Order, all_4, empty, 0, 0, 12);
    std::cout << p.format();
    std::cout << p.format_pretty();
    assert(p.primitive_value() == PrimitiveValue::Win);

    p = Position4x4(Player::Chaos, empty, all_4, 0, 0, 12);
    assert(p.primitive_value() == PrimitiveValue::Lose);

    p = Position4x4(Player::Order, empty, empty, pos_diag, 0, 12);
    assert(p.primitive_value() == PrimitiveValue::Win);

    p = Position4x4(Player::Chaos, empty, empty, 0, neg_diag, 12);
    assert(p.primitive_value() == PrimitiveValue::Lose);

    p = Position4x4(Player::Order, empty, empty, 0, 0, 0);
    assert(p.primitive_value() == PrimitiveValue::Lose);

    p = Position4x4();

    // Moves
    Move m = Move(Move::Piece::X, 0, 0);
    std::cout << m.format() << '\n';

    // Generate moves
    auto moves = p.generate_moves();
    auto moves_size = moves.size();

    assert(moves_size == 32);
    std::cout << "num_moves: " << moves_size << "\n\n==================\n\n";

    // for (const Move &m : moves)
    // {
    //     std::cout << m.format() << '\n';

    //     Position4x4 after = p.do_move(m);

    //     std::cout << after.format() << '\n';
    //     std::cout << after.format_pretty() << '\n';
    // }

    // Solve
    Solver solver = Solver();
    GameResult gr = solver.solve(p);

    std::cout << format_game_result(gr) << '\n';
}
