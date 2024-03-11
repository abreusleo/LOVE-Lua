local Player = require'player'
local g = {}
local mt = {__index = g}

local function createGrid()
    local grid = {}
    for line in love.filesystem.lines("map.txt") do
        local row = {}
        for digit in line:gmatch('.') do
            table.insert(row, tonumber(digit))
        end
        table.insert(grid, row)
    end
    return grid, #grid, #grid[1]
end

local function findPlayer(grid, rows, columns)
    for i=1, rows do
        for j=1, columns do
            if grid[i][j] == 2 then
                return i,j
            end
        end
    end
end

function g.new()
    local grid, rows, columns = createGrid();
    local i, j = findPlayer(grid, rows, columns)
    local self = {
        grid = grid,
        rows = rows,
        columns = columns,
        player = Player.new(j, i)
    }
    setmetatable(self, mt)
    return self
end

function g:draw(fog, cwidth, cheight)
    local grid = self.grid
    for i=1, self.rows do
        for j=1, self.columns do
            if fog.gridVisibility[i] and fog.gridVisibility[i][j] then
                if grid[i][j] == 1 then
                    love.graphics.setColor(0, 0, 0)
                else
                    love.graphics.setColor(255, 255, 255)
                end
            else
                love.graphics.setColor(0, 0, 0)
            end
            love.graphics.rectangle('fill', (j-1) * 1, (i-1) * 1, 1, 1)
        end
    end
    self.player:draw()
end

function g:load()
end

return g