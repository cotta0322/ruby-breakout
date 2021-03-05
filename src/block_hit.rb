class BlockHit
  def is_hit(ball, block)
    block.x < ball.x && block.x + Block::WIDTH > ball.x && block.y < ball.y && block.y + Block::HEIGHT > ball.y
  end

  def hit(ball, block)
    return unless is_hit(ball, block)

    if block.y >= ball.previous_y
      ball.flip_horizontal if block.x > ball.previous_x || block.x + Block::WIDTH < ball.previous_x
      ball.flip_vertical
    end

    ball.flip_horizontal if block.y < ball.previous_y && block.y + Block::HEIGHT > ball.previous_y

    if block.y + Block::HEIGHT <= ball.previous_y
      ball.flip_horizontal if block.x > ball.previous_x || block.x + Block::WIDTH < ball.previous_x
      ball.flip_vertical
    end

    block.clear
  end
end
