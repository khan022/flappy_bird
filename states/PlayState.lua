-- moving all the play code into here.

PlayState = Class{__includes = BaseState}

PIPE_SPEED = 60
PIPE_WIDTH = 70
PIPE_HEIGHT = 288

BIRD_WIDTH = 38
BIRD_HEIGHT = 24

-- initializing play state
function PlayState:init()

    self.bird = Bird()
    self.pipePairs = {}
    self.timer = 0

    -- using the last recorded y to calculate the next gap
    self.lastY = -PIPE_HEIGHT + math.random(80) + 20

end

-- all the work in main update have shifted here.

function PlayState:update(dt)

    -- update timer for pipe spawning
    self.timer = self.timer + dt

    -- spawn new pipe after 2.5 seconds
    if self.timer > 2.5 then
        
        local y = math.max(-PIPE_HEIGHT + 10, 
                 math.min(self.lastY + math.random(-20, 20), VIRTUAL_HEIGHT - 90 - PIPE_HEIGHT))
        self.lastY = y

        
        table.insert(self.pipePairs, PipePair(y)) -- adding new pipes
        self.timer = 0 -- reseting the timer
    
    end

    -- moving the pipes and generating them in random location
    for k, pair in pairs(self.pipePairs) do
        -- update position of pair
        pair:update(dt)
    end

    -- removing the pipes
    for k, pair in pairs(self.pipePairs) do
        if pair.remove then
            table.remove(self.pipePairs, k)
        end
    end

    -- update bird based on gravity and input
    self.bird:update(dt)

    -- check collisions between bird and pipes
    for k, pair in pairs(self.pipePairs) do
        for l, pipe in pairs(pair.pipes) do
            if self.bird:collides(pipe) then
                gStateMachine:change('title')
            end
        end
    end

    -- check collisions with the ground
    if self.bird.y > VIRTUAL_HEIGHT - 15 then
        gStateMachine:change('title')
    end

end


-- rendering the movements

function PlayState:render()
    for k, pair in pairs(self.pipePairs) do
        pair:render()
    end

    self.bird:render()
end