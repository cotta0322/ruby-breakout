# frozen_string_literal: true

class Block
  attr_reader :x, :y

  WIDTH = 100
  HEIGHT = 20

  def initialize(x, y, color = 0)
    @x = x
    @y = y
    @color = color
  end

  def draw
    Gosu.draw_rect(@x, @y, WIDTH, HEIGHT, color)
  end

  def color
    case @color
    when 0
      Gosu::Color::RED
    when 1
      Gosu::Color::BLUE
    end
  end

  def clear
    @x = -1000
    @y = -1000
  end
end

def create_default_blocks
  rel = []
  8.times do |colum|
    6.times do |row|
      rel.push(Block.new(50 + 100 * row, 50 + 20 * colum, (row + colum).even? ? 0 : 1))
    end
  end
  rel
end
