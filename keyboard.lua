
local function keyModifier(key)
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

function love.keypressed(key)
  local zSlider = gui.zoom.slider

  if key == "=" and keyModifier("shift") then
    camera:scale(1.1)
    zSlider:SetValue(zSlider:GetValue()*1.1)
  elseif key == "-" then
    camera:scale(0.9)
    zSlider:SetValue(zSlider:GetValue()*0.9)
  elseif key == "r" then
    camera:setScale(1, 1)
    zSlider:SetValue(1)
  end

  loveframes.keypressed(key)
end

function love.keyreleased(key)
  loveframes.keyreleased(key)
end

function love.textinput(text)
  loveframes.textinput(text)
end
