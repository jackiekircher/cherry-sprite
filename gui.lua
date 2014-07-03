function loadGui(fps)

  -- create the gui
  --[[
  local mainFrame = loveframes.Create("frame")
  mainFrame:SetName("cherry sprite")
  mainFrame:SetSize(love.window.getWidth(), 75)
  mainFrame:SetDraggable(false)
  mainFrame:ShowCloseButton(false)
  mainFrame:SetResizable(false)
  mainFrame:SetAlwaysOnTop(true)
  ]]

  local fpsText = loveframes.Create("text")
  fpsText:SetPos(100,35)
  fpsText:SetText("FPS (" .. fps .. ")")

  local fpsSlider = loveframes.Create("slider")
  fpsSlider:SetPos(10,10)
  fpsSlider:SetButtonSize(10,20)
  fpsSlider:SetWidth(240)
  fpsSlider:SetHeight(20)
  fpsSlider:SetMinMax(0,120)
  fpsSlider:SetDecimals(0)
  fpsSlider:SetValue(fps)
  fpsSlider.OnValueChanged = function(object, dt)
    local fps = object:GetValue()
    fpsText:SetText("FPS (" .. fps .. ")")
    for _, animation in ipairs(animations) do
      animation:setSpeed(fps)
    end
  end

  local zoomText = loveframes.Create("text")
  zoomText:SetPos(love.window.getWidth() - 160,35)
  zoomText:SetText("zoom (100%)")

  local zoomSlider = loveframes.Create("slider")
  zoomSlider:SetPos(love.window.getWidth() - 250,10)
  zoomSlider:SetButtonSize(10,20)
  zoomSlider:SetWidth(240)
  zoomSlider:SetHeight(20)
  zoomSlider:SetMinMax(0,5)
  zoomSlider:SetDecimals(3)
  zoomSlider:SetValue(1)
  zoomSlider.OnValueChanged = function(object, dt)
    local zoom = object:GetValue()
    zoomText:SetText("zoom (" .. zoom*100 .. "%)")
    camera:setScale(zoom, zoom)
  end

end
