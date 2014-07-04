require("lib.anal")
require("lib.camera")
require("lib.csv")
require("lib.loveframes")
require("gui")
require("keyboard")

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)
  animations   = {}
  spriteHeight = 0
  spriteWidth  = 0

  loadGui()
end

-- function loadSpriteFile()
-- spriteFile (string): the path to the sprite file to be loaded
--
-- This function loads the sprite file into the animations table which means
-- it updates global state. spriteWidth and spriteHeight are also globally
-- updated. The corresponding config file is determined based on path name
-- (sprite_file.png -> sprite_file_config.csv)
function loadSpriteFile(spriteFile)
  local configFile = spriteFile:gsub(".png", "_config.csv")

  local img     = love.graphics.newImage(spriteFile)
  local config  = readCSV(configFile, ',')
  local sprites = {}

  for i = 2, #config do
    table.insert(sprites, { name        = config[i][1],
                            image       = img,
                            frameWidth  = config[1][1],
                            frameHeight = config[1][2],
                            speed       = config[1][3],
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
  animations   = {}
  for _, sprite in ipairs(sprites) do
    table.insert(animations, newAnimationFromTable(sprite))
  end

  return { fps = config[1][3] }
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
