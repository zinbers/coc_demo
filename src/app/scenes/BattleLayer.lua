--
-- @File:BattleLayer.lua
-- @Description:
-- @Date:2015-12-12 20:16:10
-- @Author:zhangbing
--

local BattleLayer = class("BattleLayer",function()
	return display.newNode()
	end)

function BattleLayer:ctor()
	local bg = display.newSprite('bg.jpg')
	self:addChild(bg)
	bg:setScale(1.0)
	bg:setPosition(cc.p(display.cx,display.cy))
	local bgSize = bg:getContentSize()

	self:createLeftListView()
	self:createRightListView()

	self.leftSoliders=setmetatable({}, {__index=table})
	self.rightSoliders=setmetatable({}, {__index=table})
end

function BattleLayer:createLeftListView()
	self.leftListView = cc.ui.UIListView.new {
        bgColor = cc.c4b(200, 200, 200, 120),
        viewRect = cc.rect(40, 80, 60, 480),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,}
        :onTouch(handler(self, self.leftListListener))
        :addTo(self)

   	for i = 1,3 do
   		local item = self.leftListView:newItem()
   		local content = display.newSprite('s_'..i..'.jpg')
   		item:addContent(content)
   		item:setItemSize(60, 65)
   		local addBtn = cc.ui.UIPushButton.new()
   		addBtn:setButtonSize(30, 15)
   		addBtn:setButtonLabel("normal", cc.ui.UILabel.new({
            UILabelType = 2,
            text = "add",
            size = 15,
            color = cc.c3b(255, 64, 64)
        }))
        addBtn:onButtonClicked(function(event)
        	local btn = event.target
        	btn:setVisible(false)
        	local sp = display.newSprite('s_'..i..'.jpg')
        	sp:pos(display.cx,display.cy)
        	sp:addTo(self)
        	cc(sp):addComponent("components.ui.DraggableProtocol")
        		:exportMethods()
        		:setDraggableEnable(true)
        	self.leftSoliders:insert(sp)	
        	end)

        addBtn:setVisible(false)
        addBtn:setPosition(20,10)
        content:addChild(addBtn)
        item.addBtn = addBtn
   		self.leftListView:addItem(item)
   	end
   	self.leftListView:reload()
end

function BattleLayer:leftListListener(event)
	dump(event)
	local listView = event.listView
	if "clicked" == event.name then
		if event.item and event.item.addBtn then
			event.item.addBtn:setVisible(true)
		end
	elseif "moved" == event.name then
		self.bLeftListViewMove = true
	elseif "ended" == event.name then
		self.bLeftListViewMove = true
	else
        print("event name:" .. event.name)
	end
end

function BattleLayer:createRightListView()
	self.rightListView = cc.ui.UIListView.new {
        bgColor = cc.c4b(200, 200, 200, 120),
        viewRect = cc.rect(display.width-40-60, 80, 60, 480),
        direction = cc.ui.UIScrollView.DIRECTION_VERTICAL,}
        :onTouch(handler(self, self.rightListListener))
        :addTo(self)

   	for i = 1,3 do
   		local item = self.rightListView:newItem()
   		local content = display.newSprite('s_'..(i+3)..'.jpg')
   		item:addContent(content)
   		local addBtn = cc.ui.UIPushButton.new()
   		addBtn:setButtonSize(30, 15)
   		addBtn:setButtonLabel("normal", cc.ui.UILabel.new({
            UILabelType = 2,
            text = "add",
            size = 15,
            color = cc.c3b(255, 64, 64)
        }))
        addBtn:onButtonClicked(function(event)
        	local btn = event.target
        	btn:setVisible(false)
        	local sp = display.newSprite('s_'..(i+3)..'.jpg')
        	sp:pos(display.cx,display.cy)
        	sp:addTo(self)
        	cc(sp):addComponent("components.ui.DraggableProtocol")
        		:exportMethods()
        		:setDraggableEnable(true)
        	self.rightSoliders:insert(sp)
        	end)
        addBtn:setVisible(false)
        addBtn:setPosition(20,10)
        content:addChild(addBtn)
        item.addBtn = addBtn
   		item:setItemSize(60, 65)
   		self.rightListView:addItem(item)
   	end
   	self.rightListView:reload()
end

function BattleLayer:rightListListener(event)
	local listView = event.listView
	if "clicked" == event.name then
		if event.item and event.item.addBtn then
			event.item.addBtn:setVisible(true)
		end
	elseif "moved" == event.name then
		self.bRightListViewMove = true
	elseif "ended" == event.name then
		self.bRightListViewMove = true
	else
        print("event name:" .. event.name)
	end
end

return BattleLayer
