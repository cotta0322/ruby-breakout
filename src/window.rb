# frozen_string_literal: true

require 'gosu'
require './src/player'
require './src/ball'
require './src/block'
require './src/block_hit'

class Window < Gosu::Window
  def initialize
    super 700, 480
    self.caption = 'Tutorial Game'
    @player = Player.new
    @ball = Ball.new
    @blocks = create_default_blocks
    @block_hit = BlockHit.new
    @font = Gosu::Font.new(20)
    @message = ''
  end

  def update
    @player.to_left if Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::GP_LEFT)
    @player.to_right if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::GP_RIGHT)

    ball_x, ball_y = @ball.move
    @ball.flip_horizontal if is_ball_hit_the_side_wall(ball_x)
    @ball.flip_vertical if is_ball_hit_the_top_wall(ball_y)
    if is_gameover(ball_y)
      @message = 'GAME OVER!!'
      return
    end

    if ball_y + Ball::RADIAN > Player::HEIGHT_POSITION &&
       ball_y + Ball::RADIAN < Player::HEIGHT_POSITION + Player::HEIGHT &&
       ball_x > @player.x &&
       ball_x < @player.x + Player::WIDTH
      @ball.flip_vertical
    end

    hit_block = @blocks.find { |block| @block_hit.is_hit(@ball, block) }
    @block_hit.hit(@ball, hit_block) if hit_block
  end

  def draw
    @player.draw
    @ball.draw
    @blocks.each(&:draw)
    @font.draw_text(@message, 10, 10, 3, 1.0, 1.0, Gosu::Color::YELLOW) if @message != ''
  end

  def is_ball_hit_the_side_wall(ball_x)
    ball_x + Ball::RADIAN > 700 || (ball_x - Ball::RADIAN).negative?
  end

  def is_ball_hit_the_top_wall(ball_y)
    (ball_y + Ball::RADIAN).negative?
  end

  def is_gameover(ball_y)
    (ball_y + Ball::RADIAN) >= 480
  end
end
