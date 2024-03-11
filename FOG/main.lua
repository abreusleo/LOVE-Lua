local Grid = require'grid'
local Fog = require'fog'
local ROWS = 100  
local COLUMNS = 100
local WINDOW_W = 800
local WINDOW_H = 800
local cwidth = WINDOW_W/COLUMNS
local cheight = WINDOW_H/COLUMNS

local grid = Grid.new(ROWS, COLUMNS)
local fog

local fall_time = 0.1
local run_rate = ROWS/fall_time
local timer = 1

local moveTimer = 0
local moveInterval = 0.1 

function love.load()
    love.window.setMode(WINDOW_W, WINDOW_H)
    grid:load()
    fog = Fog.new(grid.player, 5)

end

function love.update(dt)
    timer = timer-dt

    while timer < 0 do
        timer = timer + 1
    end

    moveTimer = moveTimer + dt
    if moveTimer >= moveInterval then
        fog:update(grid.rows, grid.columns)
        
        moveTimer = 0

        local moveX, moveY = 0, 0
        if love.keyboard.isDown('w') and grid.player.Y > 1 then
            moveY = -1
        end
        if love.keyboard.isDown('s') and grid.player.Y < grid.rows then
            moveY = 1
        end
        if love.keyboard.isDown('a') and grid.player.X > 1 then
            moveX = -1
        end
        if love.keyboard.isDown('d') and grid.player.X < grid.columns then
            moveX = 1
        end

        if moveX ~= 0 or moveY ~= 0 then
            local newX, newY = grid.player.X + moveX, grid.player.Y + moveY
            if grid.grid[newY][newX] ~= 1 then
                grid.grid[grid.player.Y][grid.player.X] = 0
                grid.grid[newY][newX] = 2
                grid.player.X, grid.player.Y = newX, newY
            end
        end
    end
end

function love.draw()
    love.graphics.scale(cwidth, cheight)
    grid:draw(fog, cwidth, cheight)
end