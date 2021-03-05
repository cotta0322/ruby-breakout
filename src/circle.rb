# frozen_string_literal: true

CIRCLE_STEP = 10
def draw_circle(cx, cy, r, color)
  0.step(360, CIRCLE_STEP) do |a1|
    a2 = a1 + CIRCLE_STEP
    r.times do |i|
      Gosu.draw_line cx + Gosu.offset_x(a1, r - i), cy + Gosu.offset_y(a1, r - i), color, cx + Gosu.offset_x(a2, r - i),
                     cy + Gosu.offset_y(a2, r - i), color, 9999
    end
  end
end
