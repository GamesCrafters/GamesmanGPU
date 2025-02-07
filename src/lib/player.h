#pragma once

#include "utils.h"
#include <string>

class Player {
public:
  enum PlayerType {
    O = 0,
    X = 1,
    Error = -1,
  };

private:
  PlayerType player_type;

public:
  CUDA_CALLABLE Player(unsigned int num_empty_spaces);
  CUDA_CALLABLE Player(PlayerType player_type) : player_type(player_type) {}

  CUDA_CALLABLE PlayerType get_player_type() const { return player_type; }
  CUDA_CALLABLE PlayerType next_player_type() const;

  std::string format() const;
};
