# frozen_string_literal: true

# プレイヤーのバーのクラス
class Player
  WIDTH = 100
  HEIGHT = 5
  HEIGHT_POSITION = 450

  def initialize(window_width)
    @x = 0
    @window_width = window_width
  end

  def to_right
    @x += 5
    @x = MAX_RIGHT if @x > @window_width
  end

  def to_left
    @x -= 5
    @x = 0 if @x.negative?
  end

  def draw
    Gosu.draw_rect(@x, 450, WIDTH, HEIGHT, Gosu::Color::GRAY)
  end

  def in_range(point_x, point_y)
    @x < point_x && @x + WIDTH > point_x && HEIGHT_POSITION < point_y && HEIGHT_POSITION + HEIGHT > point_y
  end
end
