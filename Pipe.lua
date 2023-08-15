-- Creating the Pipe class
Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')
local PIPE_SCOLL = -60

-- initializing pipe class
function Pipe:init()

    self.x = VIRTUAL_WIDTH + 5
    self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT -10)
    self.width = PIPE_IMAGE:getWidth()
    --self.height = PIPE_IMAGE:getHeight()

end

-- update function to move the pipe
function Pipe:update(dt)

    self.x = self.x + PIPE_SCOLL * dt

end

function Pipe:render()

    love.graphics.draw(PIPE_IMAGE, self.x, self.y)

end