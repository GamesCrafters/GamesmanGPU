#pragma once

#include <array>

#include "move.h"

#define A4_OOOO (char)0b10101010
#define A4_XXXX (char)0b11111111

#define TAKEN_0 (char)0b00000010
#define TAKEN_1 (char)0b00001000
#define TAKEN_2 (char)0b00100000
#define TAKEN_3 (char)0b10000000

#define CLEAR_0 (char)0b11111100
#define CLEAR_1 (char)0b11110011
#define CLEAR_2 (char)0b11001111
#define CLEAR_3 (char)0b00111111

#define SET_O_0 (char)0b00000010
#define SET_O_1 (char)0b00001000
#define SET_O_2 (char)0b00100000
#define SET_O_3 (char)0b10000000

#define SET_X_0 (char)0b00000011
#define SET_X_1 (char)0b00001100
#define SET_X_2 (char)0b00110000
#define SET_X_3 (char)0b11000000

#define FL_OX_0 (char)0b00000001
#define FL_OX_1 (char)0b00000100
#define FL_OX_2 (char)0b00010000
#define FL_OX_3 (char)0b01000000

const char TAKEN_MASKS[4] = {
    (char)TAKEN_0,
    (char)TAKEN_1,
    (char)TAKEN_2,
    (char)TAKEN_3};

const char CLEAR_MASKS[4] = {
    (char)CLEAR_0,
    (char)CLEAR_1,
    (char)CLEAR_2,
    (char)CLEAR_3};

const char SET_O_MASKS[4] = {
    (char)SET_O_0,
    (char)SET_O_1,
    (char)SET_O_2,
    (char)SET_O_3};

const char SET_X_MASKS[4] = {
    (char)SET_X_0,
    (char)SET_X_1,
    (char)SET_X_2,
    (char)SET_X_3};

const char FL_OX_MASKS[4] = {
    (char)FL_OX_0,
    (char)FL_OX_1,
    (char)FL_OX_2,
    (char)FL_OX_3};

bool char_has_4_in_a_row(const char &c);

void char_set_piece(char &c, size_t i, Move::Piece piece);

char char_flip_ox(char c);
unsigned char char_flip_vertical(unsigned char c);

std::array<char, 4> flip_ox(const char (&chars)[4]);
std::array<char, 4> flip_horizontal(const char (&chars)[4]);
std::array<unsigned char, 4> flip_vertical(const unsigned char (&chars)[4]);

// 32-bit

#define FIR_ROW_OOOO (uint32_t)0b00000000000000000000000010101010
#define SEC_ROW_OOOO (uint32_t)0b00000000000000001010101000000000
#define THR_ROW_OOOO (uint32_t)0b00000000101010100000000000000000
#define FOU_ROW_OOOO (uint32_t)0b10101010000000000000000000000000

#define FIR_ROW_XXXX (uint32_t)0b00000000000000000000000011111111
#define SEC_ROW_XXXX (uint32_t)0b00000000000000001111111100000000
#define THR_ROW_XXXX (uint32_t)0b00000000111111110000000000000000
#define FOU_ROW_XXXX (uint32_t)0b11111111000000000000000000000000

#define FIR_ROW_MASK (uint32_t)0b00000000000000000000000011111111
#define SEC_ROW_MASK (uint32_t)0b00000000000000001111111100000000
#define THR_ROW_MASK (uint32_t)0b00000000111111110000000000000000
#define FOU_ROW_MASK (uint32_t)0b11111111000000000000000000000000

#define FIR_COL_OOOO (uint32_t)0b00000010000000100000001000000010
#define SEC_COL_OOOO (uint32_t)0b00001000000010000000100000001000
#define THR_COL_OOOO (uint32_t)0b00100000001000000010000000100000
#define FOU_COL_OOOO (uint32_t)0b10000000100000001000000010000000

#define FIR_COL_XXXX (uint32_t)0b00000011000000110000001100000011
#define SEC_COL_XXXX (uint32_t)0b00001100000011000000110000001100
#define THR_COL_XXXX (uint32_t)0b00110000001100000011000000110000
#define FOU_COL_XXXX (uint32_t)0b11000000110000001100000011000000

#define FIR_COL_MASK (uint32_t)0b00000011000000110000001100000011
#define SEC_COL_MASK (uint32_t)0b00001100000011000000110000001100
#define THR_COL_MASK (uint32_t)0b00110000001100000011000000110000
#define FOU_COL_MASK (uint32_t)0b11000000110000001100000011000000

#define POS_DIA_OOOO (uint32_t)0b10000000001000000000100000000010
#define POS_DIA_XXXX (uint32_t)0b11000000001100000000110000000011
#define POS_DIA_MASK (uint32_t)0b11000000001100000000110000000011

#define NEG_DIA_OOOO (uint32_t)0b00000010000010000010000010000000
#define NEG_DIA_XXXX (uint32_t)0b00000011000011000011000011000000
#define NEG_DIA_MASK (uint32_t)0b00000011000011000011000011000000

bool int_has_4_in_a_row(const uint32_t &chars);
