# frozen_string_literal: true

require 'gosu'
require './src/mediator'

# Windowのクラス
class Window < Gosu::Window
  WIDTH = 700
  HEIGHT = 480

  def initialize
    super WIDTH, HEIGHT
    @mediator = Mediator.new(WIDTH, HEIGHT)
  end

  def update
    @mediator.player_to_left if Gosu.button_down?(Gosu::KB_LEFT) || Gosu.button_down?(Gosu::GP_LEFT)
    @mediator.player_to_right if Gosu.button_down?(Gosu::KB_RIGHT) || Gosu.button_down?(Gosu::GP_RIGHT)

    @mediator.next
  end

  def draw
    @mediator.draw
  end
end
