-- countdown for the start of the game

CountdownState = Class{__includes = BaseState}

-- time for countdown
COUNTDOWN_TIMER = 0.75

function CountdownState:init()

    self.count = 3
    self.timer = 0

end

-- keeping track of time to countdown from 3
function CountdownState:update(dt)

    self.timer = self.timer + dt

    if self.timer > COUNTDOWN_TIMER then
        self.timer = self.timer % COUNTDOWN_TIMER
        self.count = self.count -1 

        if self.count == 0 then
            gStateMachine:change('play')
        end
    end

end

-- rendering the countdown values
function CountdownState:render()
    love.graphics.setFont(hugeFont)
    love.graphics.printf(tostring(self.count), 0, 120, VIRTUAL_WIDTH, 'center')
end