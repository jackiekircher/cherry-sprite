require("lib.anal")
require("lib.camera")
require("lib.csv")
require("lib.loveframes")
require("keyboard")

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  zoom = 1

  -- read sprites by config file
  local sprites, framesPerSecond = loadSpriteFile("assets/spin_drive_96x96.png",
                                                  "assets/spin_drive_96x96_config.csv")
  animations = {}
  for i = 1, #sprites do
    table.insert(animations, newAnimationFromTable(sprites[i]))
  end
  for _, animation in ipairs(animations) do
    animation:setSpeed(framesPerSecond)
  end

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
  fpsText:SetText("FPS (" .. framesPerSecond .. ")")

  local fpsSlider = loveframes.Create("slider")
  fpsSlider:SetPos(5,10)
  fpsSlider:SetButtonSize(10,20)
  fpsSlider:SetWidth(240)
  fpsSlider:SetHeight(20)
  fpsSlider:SetMinMax(0,120)
  fpsSlider:SetDecimals(0)
  fpsSlider:SetValue(framesPerSecond)
  fpsSlider.OnValueChanged = function(object, dt)
    local fps = object:GetValue()
    fpsText:SetText("FPS (" .. fps .. ")")
    for _, animation in ipairs(animations) do
      animation:setSpeed(fps)
    end
  end

end

function loadSpriteFile(spriteFile, configFile)
  local img     = love.graphics.newImage(spriteFile)
  local config  = readCSV(configFile, ',')
  local sprites = {}
  local framesPerSecond = config[1][3]

  for i = 2, #config do
    table.insert(sprites, { name        = config[i][1],
                            image       = img,
                            frameWidth  = config[1][1],
                            frameHeight = config[1][2],
                            delay       = 1,
                            startRow    = config[i][2],
                            startCol    = config[i][3],
                            endRow      = config[i][4],
                            endCol      = config[i][5] })
  end

  -- set global values for sprite information
  -- right now the format of the sprite file depends on each sprite
  -- having the same dimensions
  spriteWidth  = config[1][1]
  spriteHeight = config[1][2]

  return sprites, framesPerSecond
end

function love.update(dt)
  for _, animation in ipairs(animations) do
    animation:update(dt)
  end

  loveframes.update(dt)
end

function love.draw()
  camera:set()

  local centerY = love.window.getHeight()/2 - (#animations * spriteHeight)/2
  local centerX = love.window.getWidth()/2 - spriteWidth/2
  for i, animation in ipairs(animations) do
    local yPos = centerY + ((i-1)*animation.fh)
    animation:draw(centerX, yPos)
  end

  camera:unset()

  loveframes.draw(dt)
end

function love.mousepressed(x, y, button)
  loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  loveframes.mousereleased(x, y, button)
end
