-- Creating the composite class PipePair
PipePair = Class{}

-- using local variables 
local GAP_HEIGHT = math.random(50, 120)

-- initialize the class
function PipePair:init(y)

    -- initializing the pipes past the screen
    self.x = VIRTUAL_WIDTH + 32
    -- y will be for the top most pipe then the gap is applied and a regular pipe is implemented.
    self.y = y

    -- get the two pipes in this pair
    self.pipes = {
        ['upper'] = Pipe('top', self.y),
        ['lower'] = Pipe('bottom', self.y + PIPE_HEIGHT + GAP_HEIGHT)
    }

    -- remove the pipes from memory
    self.remove = false

end

-- updating the pipe pairs
function PipePair:update(dt)

    if self.x > -PIPE_WIDTH then
        self.x = self.x - PIPE_SPEED * dt
        self.pipes['lower'].x = self.x
        self.pipes['upper'].x = self.x
    else
        self.remove = true
    end
 
end

-- rendering the pipe pairs
function PipePair:render()

    for k, pipe in pairs(self.pipes) do
        pipe:render()
    end

end