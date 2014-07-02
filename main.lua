require("AnAL")
require("keyboard")
require("camera")

function love.load()
  love.graphics.setBackgroundColor(255, 255, 255)

  local sprite     = love.graphics.newImage("spin_drive_96x96.png")
  local spriteSize = 96
  framesPerSecond  = 10
  speed = 1
  zoom  = 1

  animations = {}
  for i = 1, sprite:getHeight() / spriteSize do
    table.insert(animations, newAnimationFromRow(sprite, spriteSize, spriteSize, frameRate(), i))
  end
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
    local yPos = (i - 1) * 96
    animation:draw(0, yPos)
  end

  camera:unset()
end
