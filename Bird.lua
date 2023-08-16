-- Creating the bird class
Bird = Class{}

-- creating gravity
local GRAVITY = 17
local ANTI_GRAVITY = -5

-- initializing the bird class
function Bird:init()

    self.image = love.graphics.newImage('images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

    self.dy = 0

end

--[[
    AABB collision function to measure the x and y plane of the bird with respect to the pipe.
]]
function Bird:collides(pipe)

    if (self.x + 2) + (self.width - 4) >= pipe.x and self.x + 2 <= pipe.x + PIPE_WIDTH then
        if (self.y + 2) + (self.height - 4) >= pipe.y and self.y + 2 <= pipe.y + PIPE_HEIGHT then
            return true
        end
    end

    return false

end


-- update function to implement gravity
function Bird:update(dt)

    self.dy = self.dy + GRAVITY * dt

    if love.keyboard.wasPressed('space') then
        self.dy = ANTI_GRAVITY
    end

    self.y = self.y + self.dy

end

-- rendering the bird image on the background
function Bird:render()

    love.graphics.draw(self.image, self.x, self.y)

end