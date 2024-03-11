local g = {}
local mt = {__index = g}


local function createGrid(rows, columns)
    local grid = {}
    for i=1, rows do
        grid[i] = {}
        for j=1, columns do
        grid[i][j] = {}
        end
    end

    return grid
end

local function verifyPixel(self, row, column)
    local g = self.grid
    if #g[row][column] == 0 then return end

    if #g[row+1][column] == 0 then
        g[row+1][column] = g[row][column]
        g[row][column] = {}
        return
    end

    local dirs = {}

    if column > 1 then table.insert(dirs, -1) end
    if column < self.columns then table.insert(dirs, 1) end

    if #dirs > 1 and love.math.random()> 0.5 then dirs = {dirs[2], dirs[1]} end

    for _, dir in ipairs(dirs) do
        if #g[row+1][column+dir] == 0 then
            g[row+1][column+dir] = g[row][column]
            g[row][column] = {}
            return
        end
    end
end

function g.new(rows, columns)
    local self = {
        grid = createGrid(rows, columns),
        rows = rows,
        columns =  columns
    }
    setmetatable(self, mt)
    return self
end


function g:update()
    for rowi=self.rows -1 ,1 ,-1 do
        for coli=self.columns,1,-1 do
            verifyPixel(self, rowi, coli)
        end
    end
end

function g:draw()
    local grid = self.grid
    for i=1, self.rows do
        for j=1, self.columns do
            local v = grid[i][j]
            if #v > 0 then
                love.graphics.setColor(v)
                love.graphics.rectangle('fill', (j-1), (i-1), 1, 1)
            end
        end
    end
end

function g:load()
end

return g