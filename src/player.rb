# frozen_string_literal: true

class Player
  attr_reader :x

  WIDTH = 100
  HEIGHT = 5
  MAX_RIGHT = 640 - WIDTH
  HEIGHT_POSITION = 450

  def initialize
    @x = 0
  end

  def to_right
    @x += 5
    @x = MAX_RIGHT if @x > MAX_RIGHT
  end

  def to_left
    @x -= 5
    @x = 0 if @x.negative?
  end

  def draw
    Gosu.draw_rect(@x, 450, WIDTH, HEIGHT, Gosu::Color::GRAY)
  end
end
