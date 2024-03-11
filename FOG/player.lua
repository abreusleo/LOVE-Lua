local p = {}
local mt = {__index = p}


function p.new(posX, posY)
    local self = {
        X = posX,
        Y = posY
    }
    setmetatable(self, mt)
    return self
end

function p:update(posX, posY)
    self.X, self.Y = posX, posY
end

function p:draw()    
    love.graphics.setColor(255, 0, 0)
    love.graphics.rectangle('fill', (self.X-1), (self.Y-1), 1, 1)
end

function p:load()
end

return p