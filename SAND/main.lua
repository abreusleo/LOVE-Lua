local Grid = require'grid'
local ROWS = 64    
local COLUMNS = 64
local WINDOW_W = 800
local WINDOW_H = 450
local cwidth = WINDOW_W/COLUMNS
local cheight = WINDOW_H/COLUMNS

local grid = Grid.new(ROWS, COLUMNS)

local fall_time = 1
local run_rate = ROWS/fall_time
local timer = 0.1

local rand = love.math.random

function love.load()
    love.window.setMode(WINDOW_W, WINDOW_H)
end

function love.update(dt)
    timer = timer-dt
    while timer < 0 do
        timer = timer + 1/run_rate
        grid:update()
    end
    if love.mouse.isDown(1) then
        local x,y = love.mouse.getPosition()
        grid.grid[math.ceil(y/cheight)][math.ceil(x/cwidth)] = {rand(), rand(), rand()}
    end
end

function love.draw()
    love.graphics.scale(cwidth, cheight)
    grid:draw()
end