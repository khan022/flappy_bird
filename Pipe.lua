-- Creating the Pipe class
Pipe = Class{}

local PIPE_IMAGE = love.graphics.newImage('images/pipe.png')
-- local PIPE_SCOLL = -60

-- global variables for pipe speed, height, and width
PIPE_SPEED = 60
PIPE_HEIGHT = 288
PIPE_WIDTH = 70

-- initializing pipe class
function Pipe:init(orientation, y)

    self.x = VIRTUAL_WIDTH
    self.y = y 
    -- self.y = math.random(VIRTUAL_HEIGHT / 4, VIRTUAL_HEIGHT -10)

    self.width = PIPE_IMAGE:getWidth()
    self.height = PIPE_HEIGHT

    self.orientation = orientation

end

-- update function to move the pipe
function Pipe:update(dt)

    -- self.x = self.x + PIPE_SCOLL * dt

end

function Pipe:render()

    love.graphics.draw(PIPE_IMAGE, self.x, 
        (self.orientation == 'top' and self.y + PIPE_HEIGHT or self.y), 
        0, -- rotation, 0 means no rotation
        1, -- scale on X axis
        self.orientation == 'top' and -1 or 1) -- scale on Y axis

end