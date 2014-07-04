function loadGui(fps)
  local fps = fps or 10

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

  -- slider to set the frames per second
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

  -- slider to set the zoom level
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

  -- dropdown list of sprite files
  local spriteDir   = "assets/sprites"
  local spriteFiles = detectSpriteFiles(spriteDir)

  local fileList = loveframes.Create("multichoice")
  fileList:SetPos(10,60)
  fileList:SetText("choose sprite file")
  for _, fileName in ipairs(spriteFiles) do
    fileList:AddChoice(fileName)
  end
  fileList.OnChoiceSelected = function(object, choice)
    local config = loadSpriteFile(spriteDir .. "/" .. choice)
    fpsSlider:SetValue(config.fps)
  end
end

function detectSpriteFiles(dir)
  local files = love.filesystem.getDirectoryItems(dir)
  local spriteFiles = {}

  for _, file in ipairs(files) do
    if string.find(file, ".png", #file-4) then
      -- only support .png files for now, sprites are supposed to
      -- have transparecy after all...
      table.insert(spriteFiles, file)
    end
  end

  return spriteFiles
end
