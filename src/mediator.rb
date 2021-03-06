# frozen_string_literal: true

require './src/player/player'
require './src/ball/ball'
require './src/block/basic_block'

# 各要素（ボール、プレイヤー、ブロック）に跨る処理をまとめるクラス
class Mediator
  def initialize(window_width, window_height)
    @ball = Ball.new
    @player = Player.new(window_width)
    @blocks = create_default_blocks
    @font = Gosu::Font.new(20)

    @window_width = window_width
    @window_height = window_height
  end

  def draw
    @ball.draw
    @player.draw
    @blocks.each(&:draw)
    game_over if is_hit_bottom_wall
    game_clear if is_all_blocks_clear
  end

  def next
    @ball.move

    @ball.flip_horizontal if is_hit_side_wall

    @ball.flip_vertical if is_hit_top_wall

    @ball.flip_vertical if is_hit_player

    hit_block = @blocks.find { |block| is_hit_block(block) }
    hit_block(hit_block) if hit_block
  end

  def player_to_right
    @player.to_right
  end

  def player_to_left
    @player.to_left
  end

  private

  def is_all_blocks_clear
    !@blocks.find { |block| !block.is_clear }
  end

  def is_hit_side_wall
    @ball.x + Ball::RADIAN > @window_width || (@ball.x - Ball::RADIAN).negative?
  end

  def is_hit_top_wall
    (@ball.y + Ball::RADIAN).negative?
  end

  def is_hit_bottom_wall
    @ball.y + Ball::RADIAN >= @window_height
  end

  def game_over
    @font.draw_text('GAME OVER!!', 10, 10, 3, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def game_clear
    @font.draw_text('GAME CLEAR!!', 10, 10, 3, 1.0, 1.0, Gosu::Color::YELLOW)
  end

  def is_hit_player
    @player.in_range(@ball.x, @ball.y)
  end

  def is_hit_block(block)
    block.x < @ball.x && block.x + block.width > @ball.x && block.y < @ball.y && block.y + block.height > @ball.y
  end

  def hit_block(block)
    return unless is_hit_block(block)

    if block.y >= @ball.previous_y
      @ball.flip_horizontal if block.x > @ball.previous_x || block.x + block.width < @ball.previous_x
      @ball.flip_vertical
    end

    @ball.flip_horizontal if block.y < @ball.previous_y && block.y + block.height > @ball.previous_y

    if block.y + block.height <= @ball.previous_y
      @ball.flip_horizontal if block.x > @ball.previous_x || block.x + block.width < @ball.previous_x
      @ball.flip_vertical
    end

    block.clear
  end
end
