local f = {}
local mt = {__index = f}

function f.new(player, visibilityRadius)
    local self = {
        player = player,
        visibilityRadius = visibilityRadius,
        gridVisibility = {}
    }
    setmetatable(self, mt)
    return self
end

function f:update(rows, columns)
    for i = 1, rows do
        if not self.gridVisibility[i] then
            self.gridVisibility[i] = {}
        end
        for j = 1, columns do
            self.gridVisibility[i][j] = false
        end
    end

    for i = math.max(1, self.player.Y - self.visibilityRadius), math.min(rows, self.player.Y + self.visibilityRadius) do
        for j = math.max(1, self.player.X - self.visibilityRadius), math.min(columns, self.player.X + self.visibilityRadius) do
            if (i - self.player.Y)^2 + (j - self.player.X)^2 <= self.visibilityRadius^2 then
                self.gridVisibility[i][j] = true
            end
        end
    end
end

return f
