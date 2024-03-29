camera = {
         x = 0,
         y = 0,
    scaleX = 1,
    scaleY = 1,
  rotation = 0
}

function camera:set()
  love.graphics.push()
  love.graphics.rotate(-self.rotation)
  love.graphics.translate(-self.x, -self.y)
  love.graphics.scale(self.scaleX, self.scaleY)
end

function camera:unset()
  love.graphics.pop()
end

function camera:move(dx, dy)
  self.x = self.x + (dx or 0)
  self.y = self.y + (dy or 0)
end

function camera:rotate(dr)
  self.rotation = self.rotation + dr
end

function camera:scale(sx, sy)
  sx = sx or 1
  self.scaleX = self.scaleX * sx
  self.scaleY = self.scaleY * (sy or sx)
end

function camera:setPosition(x, y)
  self.x = x or self.x
  self.y = y or self.y
end

function camera:setScale(sx, sy)
  self.scaleX = sx or self.scaleX
  self.scaleY = sy or self.scaleY
end
