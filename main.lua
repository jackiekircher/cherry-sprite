require("lib/AnAL")
require("lib/camera")
require("lib/csv")
require("keyboard")

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  framesPerSecond = 10
  speed = 1
  zoom  = 1

  -- read sprites by row
  --[[
  local sprite     = love.graphics.newImage("spin_drive_96x96.png")
  local spriteSize = 96
  animations       = {}
  for i = 1, sprite:getHeight() / spriteSize do
    table.insert(animations, newAnimationFromRow(sprite, spriteSize, spriteSize, frameRate(), i))
  end
  ]]

  -- read sprites by config file
  local sprites = loadSpriteFile("assets/spin_drive_96x96.png", "assets/spin_drive_96x96_config.csv")
  animations    = {}
  for i = 1, #sprites do
    table.insert(animations, newAnimationFromTable(sprites[i]))
  end
end

function loadSpriteFile(spriteFile, configFile)
  local img     = love.graphics.newImage(spriteFile)
  local config  = readCSV(configFile, ',')
  local sprites = {}

  for i = 2, #config do
    table.insert(sprites, { name        = config[i][1],
                            image       = img,
                            frameWidth  = config[1][1],
                            frameHeight = config[1][2],
                            delay       = config[1][3],
                            startRow    = config[i][2],
                            startCol    = config[i][3],
                            endRow      = config[i][4],
                            endCol      = config[i][5] })
  end

  return sprites
end

function frameRate()
  if framesPerSecond == 0 then
    return 0
  else
    return 1/framesPerSecond
  end
end

function love.update(dt)
  for _, animation in ipairs(animations) do
    animation:setSpeed(speed)
    animation:update(dt)
  end
end

function love.draw()
  camera:set()

  for i, animation in ipairs(animations) do
    local yPos = (i - 1) * animation.fh
    animation:draw(0, yPos)
  end

  camera:unset()
end
