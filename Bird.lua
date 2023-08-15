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