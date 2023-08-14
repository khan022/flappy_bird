-- import push library

push = require 'push'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEGHT = 288

-- loading background image
-- only accessible through this main file
local background = love.graphics.newImage('images/bg_og.png')
local backgroundScroll = 0 -- keeping the scrolling values

local ground = love.graphics.newImage('images/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 25
local GROUND_SCROLL_SPEED = 70

local BACKGROUND_LOOPING_POINT = 413

function love.load()

    -- getting the un pixelated filter on the elements
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- applying the name
    love.window.setTitle('Flat Bird!')

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

end


-- using the resize function of the push
function love.resize(w, h)
    push:resize(w, h)
end

-- function for getting the user input
function love.keypressed(key)

    if key == 'escape' then
        love.event.quit()
    end

end


-- function for updating the background image
function love.update(dt)
    
    -- background and ground scrolling added
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

end



-- render the image elements

function love.draw()
    
    -- starting the game
    push:start()

    -- drawing the background and ground
    love.graphics.draw(background, -backgroundScroll, 0)

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEGHT - 16)

    -- ending the game
    push:finish()

end