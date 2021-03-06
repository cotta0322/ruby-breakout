# frozen_string_literal: true

# 基本となるブロックのクラス
class BasicBlock
  attr_reader :x, :y, :height, :width, :is_clear

  BASE_POINT_X = 50
  BASE_POINT_Y = 50

  def initialize(x_coordinate, y_coordinate)
    @height = 20
    @width = 100
    @is_clear = false
    @x = BASE_POINT_X + (x_coordinate * @width)
    @y = BASE_POINT_Y + (y_coordinate * @height)
    @color = (x_coordinate + y_coordinate).even? ? Gosu::Color::RED : Gosu::Color::BLUE
  end

  def draw
    Gosu.draw_rect(@x, @y, @width, @height, @color)
  end

  def clear
    @is_clear = true
    @x = -1000
    @y = -1000
  end
end

def create_default_blocks
  rel = []
  8.times do |row|
    6.times do |column|
      rel.push(BasicBlock.new(column, row))
    end
  end
  rel
end
