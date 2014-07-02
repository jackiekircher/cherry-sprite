
function love.keypressed(key)
  if key == "up" then
    speed = speed + 0.5
  elseif key == "down" then
    speed = math.max(0, speed - 0.5)

  elseif key == "=" and keyModifier("shift") then
    camera:scale(1.1)
  elseif key == "-" then
    camera:scale(0.9)
  elseif key == "r" then
    camera:setScale(1, 1)
  end
end

function keyModifier(key)
  if key == "shift" then
    return love.keyboard.isDown('lshift') or love.keyboard.isDown('rshift')
  elseif key == "alt" then
    return love.keyboard.isDown('lalt')   or love.keyboard.isDown('ralt')
  elseif key == "control" then
    return love.keyboard.isDown('lctrl')  or love.keyboard.isDown('rctrl')
  elseif key == "meta" then
    return love.keyboard.isDown('lgui')   or love.keyboard.isDown('rgui')
  end
end
