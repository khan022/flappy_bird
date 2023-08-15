-- Creating the bird class

Bird = Class{}


-- initializing the bird class
function Bird:init()

    self.image = love.graphics.newImage('images/bird.png')
    self.width = self.image:getWidth()
    self.height = self.image:getHeight()

    self.x = VIRTUAL_WIDTH / 2 - (self.width / 2)
    self.y = VIRTUAL_HEIGHT / 2 - (self.height / 2)

end

-- rendering the bird image on the background
function Bird:render()

    love.graphics.draw(self.image, self.x, self.y)

end