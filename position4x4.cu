#include <iostream>
#include <bitset>

#include "position4x4.h"

#define FOUR_OOOO 0b10101010
#define FOUR_XXXX 0b11111111

bool char_has_4_in_a_row(char c)
{
    if (c == FOUR_OOOO)
    {
        return true;
    }
    if (c == FOUR_XXXX)
    {
        return true;
    }

    return false;
}

// Position4x4

bool Position4x4::has_4_in_a_row()
{
    for (int i = 0; i < 4; i++)
    {
        if (char_has_4_in_a_row(this->rows[i]))
        {
            return true;
        }
        if (char_has_4_in_a_row(this->cols[i]))
        {
            return true;
        }
    }

    if (char_has_4_in_a_row(this->pos_diag))
    {
        return true;
    }
    if (char_has_4_in_a_row(this->neg_diag))
    {
        return true;
    }

    return false;
}

// Printing

void Position4x4::print()
{
    std::cout << format_player(this->player);
    std::cout << '\n';

    for (int i = 0; i < 4; i++)
    {
        std::cout << std::bitset<8>(this->rows[i]) << '\n';
    }
}

void Position4x4::print_pretty()
{
    std::cout << format_player(this->player);
    std::cout << '\n';

    for (int i = 0; i < 4; i++)
    {
        // TODO
    }
}
