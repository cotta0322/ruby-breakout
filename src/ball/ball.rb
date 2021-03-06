# frozen_string_literal: true

require './src/ball/circle'

# ボールクラス
class Ball
  attr_reader :x, :y, :previous_x, :previous_y

  SPEED = 5
  RADIAN = 5
  def initialize
    @x = @y = RADIAN
    @previous_x = @previous_y = 0
    @dx = 0.5
    @dy = 0.5
  end

  def move
    @previous_x = @x
    @previous_y = @y
    @x += @dx * SPEED
    @y += @dy * SPEED
    [@x, @y]
  end

  def draw
    draw_circle(@x, @y, RADIAN, Gosu::Color::GRAY)
  end

  def flip_horizontal
    @dx = -@dx
  end

  def flip_vertical
    @dy = -@dy
  end
end
