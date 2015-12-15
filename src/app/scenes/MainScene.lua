local battleLayer = require 'app.scenes.BattleLayer'
local MainScene = class("MainScene", function()
    return display.newScene("MainScene")
end)

function MainScene:ctor()
	self:addChild(battleLayer.new())
end

function MainScene:onEnter()
end

function MainScene:onExit()
end



return MainScene
