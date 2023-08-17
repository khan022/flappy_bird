-- import push and class library
push = require 'push'
Class = require 'class'

-- import the Bird class, Pipe class and PipePair composite class
require 'Bird'
require 'Pipe'
require 'PipePair'

-- import classes for different states
require 'StateMachine'
require 'states/BaseState'
require 'states/PlayState'
require 'states/TitleScreenState'
require 'states/ScoreState'
require 'states/CountdownState'

WINDOW_WIDTH = 1280
WINDOW_HEIGHT = 720

VIRTUAL_WIDTH = 512
VIRTUAL_HEIGHT = 288

-- loading background image
-- only accessible through this main file
local background = love.graphics.newImage('images/bg_og.png')
local backgroundScroll = 0 -- keeping the scrolling values

local ground = love.graphics.newImage('images/ground.png')
local groundScroll = 0

local BACKGROUND_SCROLL_SPEED = 25
local GROUND_SCROLL_SPEED = 70

local BACKGROUND_LOOPING_POINT = 413

-- creating local variable called bird and pipe
local bird = Bird()
local pipePairs = {}
local spawnTimer = 0
local lastY = -PIPE_HEIGHT + math.random(80) + 20
local scrolling = true -- local variable for scrolling

function love.load()

    -- getting the un pixelated filter on the elements
    love.graphics.setDefaultFilter('nearest', 'nearest')

    -- applying the name
    love.window.setTitle('Flat Bird!')

    -- initializing retro font and flappy bird font
    smallFont = love.graphics.newFont('fonts/font.ttf', 8)
    mediumFont = love.graphics.newFont('fonts/flappy.ttf', 14)
    flappyFont = love.graphics.newFont('fonts/flappy.ttf', 28)
    hugeFont = love.graphics.newFont('fonts/flappy.ttf', 56)
    love.graphics.setFont(flappyFont)

    -- initialize our table of sounds
    sounds = {
        ['jump'] = love.audio.newSource('sounds/jump.wav', 'static'),
        ['explosion'] = love.audio.newSource('sounds/explosion.wav', 'static'),
        ['hurt'] = love.audio.newSource('sounds/hurt.wav', 'static'),
        ['score'] = love.audio.newSource('sounds/score.wav', 'static'),

        -- https://freesound.org/people/xsgianni/sounds/388079/
        ['music'] = love.audio.newSource('sounds/marios_way.mp3', 'static')
    }

    -- kick off music
    sounds['music']:setLooping(true)
    sounds['music']:play()

    -- creating seed for random number generation
    math.randomseed(os.time())

    push:setupScreen(VIRTUAL_WIDTH, VIRTUAL_HEIGHT, WINDOW_WIDTH, WINDOW_HEIGHT, {
        vsync = true,
        fullscreen = false,
        resizable = true
    })

    -- initializing the states from the statemachine
    gStateMachine = StateMachine{
        ['title'] = function() return TitleScreenState() end,
        ['play'] = function() return PlayState() end,
        ['score'] = function() return ScoreState() end,
        ['countdown'] = function() return CountdownState() end
    }
    gStateMachine:change('title')

    -- initializing the input table
    love.keyboard.keysPressed = {}

    -- initialize mouse input table
    love.mouse.buttonsPressed = {}

end


-- using the resize function of the push
function love.resize(w, h)
    push:resize(w, h)
end

-- function for getting the user input
function love.keypressed(key)

    love.keyboard.keysPressed[key] = true

    if key == 'escape' then
        love.event.quit()
    end

end


--[[
    LÖVE2D callback fired each time a mouse button is pressed; gives us the
    X and Y of the mouse, as well as the button in question.
]]
function love.mousepressed(x, y, button)
    love.mouse.buttonsPressed[button] = true
end


function love.keyboard.wasPressed(key)

    if love.keyboard.keysPressed[key] then
        return true
    else
        return false
    end

end

--[[
    Equivalent to our keyboard function from before, but for the mouse buttons.
]]
function love.mouse.wasPressed(button)
    return love.mouse.buttonsPressed[button]
end


-- function for updating the background image
function love.update(dt)
    
    -- to check if collision is happening
    -- if scrolling then

    -- background and ground scrolling added
    backgroundScroll = (backgroundScroll + BACKGROUND_SCROLL_SPEED * dt) % BACKGROUND_LOOPING_POINT
    groundScroll = (groundScroll + GROUND_SCROLL_SPEED * dt) % VIRTUAL_WIDTH

    -- just update the state machine
    gStateMachine:update(dt)

        -- spawning pipes as elements of table
        -- spawnTimer = spawnTimer + dt

        -- if spawnTimer > 2.5 then

        --     local y = math.max(-PIPE_HEIGHT + 10, 
        --         math.min(lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        --     lastY = y
        
        --     table.insert(pipePairs, PipePair(y))
        --     spawnTimer = 0

        -- end

        -- applying gravity on the bird
        -- bird:update(dt)

        -- for k, pair in pairs(pipePairs) do
        --     pair:update(dt)
            
        --     -- check if the bird is colliding with the pipes
        --     for l, pipe in pairs(pair.pipes) do
        --         if bird:collides(pipe) then
        --             -- pause the game to show collision
        --             scrolling = false
        --         end
        --     end
            -- if pipe.x < -pipe.width then
            --     table.remove(pipes, k)
            -- end
    --     end

    --     for k, pair in pairs(pipePairs) do
    --         if pair.remove then
    --             table.remove(pipePairs, k)
    --         end
    --     end
    -- end

    -- reset the input table
    love.keyboard.keysPressed = {}
    love.mouse.buttonsPressed = {}

end



-- render the image elements
function love.draw()
    
    -- starting the game
    push:start()

    -- drawing the background, pip, ground, and the bird
    love.graphics.draw(background, -backgroundScroll, 0)

    -- for k, pair in pairs(pipePairs) do
    --     pair:render()
    -- end

    -- rendering the state machine
    gStateMachine:render()

    love.graphics.draw(ground, -groundScroll, VIRTUAL_HEIGHT - 16)

    -- rendering the bird
    -- bird:render()

    -- ending the game
    push:finish()

end