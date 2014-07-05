require("lib.anal")
require("lib.camera")
require("lib.csv")
require("lib.loveframes")
require("gui")
require("keyboard")

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)
  dragging     = { active = false, x = 0, y = 0 }
  canvas       = { x = 0, y = 0 }
  animations   = {}

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
  local spriteWidth  = config[1][1]
  local spriteHeight = config[1][2]

  animations   = {}
  for i, sprite in ipairs(sprites) do
    local animation = newAnimationFromTable(sprite)
    animation.x = love.window.getWidth()/2 - spriteWidth/2
    animation.y = love.window.getHeight()/2 - (#sprites * spriteHeight)/2 + ((i-1)*animation.fh)
    table.insert(animations, animation)
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
  -- Adjust the main viewport when the mouse is held down
  -- the mouse position is adjusted by (2 * initial canvas coord)
  -- because it's in a different frame of reference.
  -- Without this the canvas would be mirrored with every click,
  -- it's dirty so if you know a better way please fix!
  if dragging.active then
    canvas.x = dragging.x - (love.mouse.getX() - dragging.sx)
    canvas.y = dragging.y - (love.mouse.getY() - dragging.sy)
    camera:setPosition(canvas.x, canvas.y)
  end

  for i, animation in ipairs(animations) do
    animation:draw(animation.x, animation.y)
  end

  camera:unset()
  loveframes.draw(dt)
end

function love.mousepressed(x, y, button)
  if button == "l" then
    dragging.active = true
    dragging.sx     = 2*canvas.x
    dragging.sy     = 2*canvas.y
    dragging.x      = x - canvas.x
    dragging.y      = y - canvas.y
  end

  loveframes.mousepressed(x, y, button)
end

function love.mousereleased(x, y, button)
  if button == "l" then
    dragging.active = false
  end

  loveframes.mousereleased(x, y, button)
end
