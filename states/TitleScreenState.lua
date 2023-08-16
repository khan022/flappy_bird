-- created using the BaseState

TitleScreenState = Class{__includes = BaseState}

function TitleScreenState:update(dt)

    if love.keyboard.wasPressed('enter') or love.keyboard.wasPressed('return') or love.keyboard.wasPressed('s') then
        gStateMachine:change('play')
    end

end

function TitleScreenState:render()

    love.graphics.setFont(flappyFont)
    love.graphics.printf('Flat Bird!', 0, 64, VIRTUAL_WIDTH, 'center')

    love.graphics.setFont(mediumFont)
    love.graphics.printf('Please press enter!', 0, 100, VIRTUAL_WIDTH, 'center')

end