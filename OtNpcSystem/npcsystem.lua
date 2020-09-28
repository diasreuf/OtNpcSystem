--[[
* OtNpcSystem v0.5
* by Robson Dias (diasreuf@gmail.com)
* Based in "Advanced NPC System by Jiddo"
]]--

if OtNpcSystem then
	return
end

--[[
* @constants: Default Action Types
* @desc: Constant indexes for defining npc actions
]]--

ACTION_GREET = 1
ACTION_FAREWELL = 2
ACTION_VANISH = 3
ACTION_NOTFOCUSED = 4
ACTION_KEYWORD = 5
ACTION_TRADE = 6

--[[
* @constants: Default Messages for all NPCs
* @desc: Constant indexes for defining default messages
]]--

DEFAULT_REPLY_GREET = "Hello, %N!"
DEFAULT_REPLY_FAREWELL = "Good bye, %N!"
DEFAULT_REPLY_VANISH = "How rude!"

--[[
* @func: OtNpcSystem
* @desc: Define OtNpcSystem main class with default parameters
]]--

OtNpcSystem = {
	Actions = nil,
	Focuses = nil,
	TalkStates = nil,
	TalkLasts = nil,
	TradeWindows = nil,
	CustomShop = nil,
	Voices = nil,
	VoicesLast = 0,
	Fluids = nil,
	IdleTime = 30,
	TalkRadius = 3,
}

--[[
* @func: Init()
* @desc: Creates a new NPC handler with an empty callbackFunction stack
]]--

function OtNpcSystem:Init()

	local npcsystem = {}

	npcsystem.Actions = {}
	npcsystem.TalkStates = {}
	npcsystem.Focuses = {}
	npcsystem.TalkLasts = {}
	npcsystem.TradeWindows = {}
	npcsystem.CustomShop = {}
	npcsystem.Voices = {}
	npcsystem.Fluids = {
		[1] = "Water",
		[2] = "Blood",
		[3] = "Beer",
		[4] = "Slime",
		[5] = "Lemonade",
		[6] = "Milk",
		[7] = "Manafluid",
		[10] = "Lifefluid",
		[11] = "Oil",
		[13] = "Urine",
		[14] = "Coconut Milk",
		[15] = "Wine",
		[19] = "Mud",
		[21] = "Fruid Juice",
		[26] = "Lava",
		[27] = "Rum",
		[28] = "Swamp",
		[35] = "Tea",
		[43] = "Mead"
	}

	setmetatable( npcsystem, self )
	self.__index = self
	
	return npcsystem
end

--[[
* @func: onThink()
* @desc: Execute NPC main loop
]]--

function OtNpcSystem:onThink()
	
	if ( self.VoicesLast + 20 ) < os.time() then
		local voice = self.Voices[ math.random( #self.Voices ) ]
		if voice and math.random( 100 ) < 25 then
			selfSay( voice )
		end
		self.VoicesLast = os.time()
	end

	if #self.Focuses == 0 then
		self:updateFocus()
		return true
	end

	for pos, cid in pairs( self.Focuses ) do
		if not self:isInTalkRadius( cid ) then
			self:internalVanishAction( cid )
		elseif self.TalkLasts[ cid ] ~= 0 and ( os.time() - self.TalkLasts[ cid ] ) > self.IdleTime then
			self:internalFarewellAction( cid )
		end
	end
	
	self:updateFocus()
	
	return true
end

--[[
* @func: onCreatureAppear( cid )
* @desc: Run when player/creature get close to NPC window
* @cid: creatureId
]]--

function OtNpcSystem:onCreatureAppear( cid )
	
end

--[[
* @func: onCreatureDisappear( cid )
* @desc: Run when player/creature move away from NPC window
* @cid: creatureId
]]--

function OtNpcSystem:onCreatureDisappear( cid )

	local creature = Creature( cid )
	if not creature:isPlayer() then
		return false
	end
	
	local player = creature:getPlayer()
	if not self:isFocused( player:getId() ) then
		return false
	end
	
	self:internalFarewellAction( player:getId() )
	
	return true
end

--[[
* @func: onCreatureSay( cid, type, message )
* @desc: Parse all npc "talk" interactions
* @cid: creatureId
* @type: message type
* @message: player message to npc
]]--

function OtNpcSystem:onCreatureSay( cid, type, message )

	local creature = Creature( cid )
	if not creature or not creature:isPlayer() then
		return false
	end

	local player = creature:getPlayer()
	if not player then
		return false
	end
	
	if not self:isInTalkRadius( player:getId() ) then
		return false
	end

	local action = self:findAction( player:getId(), message )
	if not action then
		return false
	end

	if action.type == ACTION_GREET then
		self:internalGreetAction( player:getId(), action )
	elseif action.type == ACTION_FAREWELL then
		self:internalFarewellAction( player:getId(), action )
	elseif action.type == ACTION_KEYWORD then
		self:internalKeywordAction( player:getId(), action )
	elseif action.type == ACTION_NOTFOCUSED then
		self:internalNotFocusedAction( player:getId(), action )
	elseif action.type == ACTION_TRADE then
		self:internalTradeAction( player:getId(), action )
	end
	
	self:setTalkState( player:getId(), ( action.parameters.talkstate ~= 0 and action.parameters.talkstate or 0 ) )
	self.TalkLasts[ player:getId() ] = os.time()
	
	return true
end

--[[
* @func: internalGreetAction( cid, action )
* @desc: Process NPC greet action
* @cid: creatureId
* @action: greet action
]]--

function OtNpcSystem:internalGreetAction( cid, action )
	
	if self:isFocused( cid ) then
		return false
	end

	if action.parameters.reply then
		self:processSay( cid, action.parameters.reply )
		self:addFocus( cid )
		return true
	end
	
	local action = self:findAction( cid, ACTION_GREET )
	if not action or action.parameters.reply == nil then
		self:processSay( cid, DEFAULT_REPLY_GREET )
	else
		self:processSay( cid, action.parameters.reply )
	end
	
	self:addFocus( cid )

	return true
end

--[[
* @func: internalFarewellAction( cid, action )
* @desc: Process NPC farewell action
* @cid: creatureId
* @action: farewell action
]]--

function OtNpcSystem:internalFarewellAction( cid, action )
	
	if not self:isFocused( cid ) then
		return false
	end

	if action ~= nil and action.parameters.reply ~= nil then
		self:processSay( cid, action.parameters.reply )
		self:releaseFocus( cid )
		return true
	end
	
	local action = self:findAction( cid, ACTION_FAREWELL )
	if not action or action.parameters.reply == nil then
		self:processSay( cid, DEFAULT_REPLY_FAREWELL )
	else
		self:processSay( cid, action.parameters.reply )
	end
	
	self:releaseFocus( cid )

	return true
end

--[[
* @func: internalVanishAction( cid, action )
* @desc: Process NPC vanish/walkaway action
* @cid: creatureId
]]--

function OtNpcSystem:internalVanishAction( cid )
	
	if not self:isFocused( cid ) then
		return false
	end
	
	local action = self:findAction( cid, ACTION_VANISH )
	if not action or action.parameters.reply == nil then
		self:processSay( cid, DEFAULT_REPLY_VANISH )
	else
		self:processSay( cid, action.parameters.reply )
	end
	
	self:releaseFocus( cid )

	return true
end

--[[
* @func: internalKeywordAction( cid, action )
* @desc: Process NPC keyword action
* @cid: creatureId
* @action: keyword action
]]--

function OtNpcSystem:internalKeywordAction( cid, action )
	
	if not self:isFocused( cid ) then
		return false
	end

	if not action.parameters.reply then
		return false
	end

	if action.parameters.customshop ~= nil then
		self.CustomShop[ cid ] = nil
		self.CustomShop[ cid ] = action.parameters.customshop
	end

	self:processSay( cid, action.parameters.reply )

	return true
end

--[[
* @func: internalNotFocusedAction( cid, action )
* @desc: Process NPC notfocused action
* @cid: creatureId
* @action: notfocused action
]]--

function OtNpcSystem:internalNotFocusedAction( cid, action )
	
	if self:isFocused( cid ) then
		return false
	end

	if not action.parameters.reply then
		return false
	end
	
	self:processSay( cid, action.parameters.reply )

	return true
end

--[[
* @func: internalTradeAction( cid, action )
* @desc: Process NPC trade window
* @cid: creatureId
* @action: notfocused action
]]--

function OtNpcSystem:internalTradeAction( cid, action )
	
	if not self:isFocused( cid ) then
		return false
	end
	
	local tradeWindow = self.TradeWindows[ cid ]
	if not tradeWindow then
		return false
	end
	
	openShopWindow(
		cid,
		tradeWindow,
		function( cid, itemid, subType, amount, ignoreCap, inBackpacks )
			self:internalBuyCallback( cid, itemid, subType, amount, ignoreCap, inBackpacks )
		end,
		function( cid, itemid, subType, amount, ignoreCap, inBackpacks )
			self:internalSellCallback( cid, itemid, subType, amount, ignoreCap, inBackpacks )
		end
	)

	if not action.parameters.reply then
		return false
	end
	
	self:processSay( cid, action.parameters.reply )

	return true
end

--[[
* @func: addAction( type, parameters, condition, action )
* @desc: Process NPC action internal condition.
* @type: action type
* @parameters: keywords, reply, talkstate, etc.
* @condition: condition to execute action
* @action: internal action to execute on match
]]--

function OtNpcSystem:addAction( type, parameters, condition, action )

	if type == nil or parameters == nil then
		return false
	end
	
	local keywords = {}
	if parameters.keywords ~= nil then
		table.insert( keywords, parameters.keywords )
		parameters.keywords = nil
	end

	table.insert( self.Actions, {
		type = type,
		keywords = keywords,
		parameters = parameters,
		condition = condition,
		action = action
	} )

	return true
end

--[[
* @func: addAliasKeyword( keyword )
* @desc: Add alias keyword to last action
* @type: keyword to match
]]--

function OtNpcSystem:addAliasKeyword( keyword )

	if keyword == nil then
		return false
	end
	
	local action = self.Actions[ #self.Actions ]
	if action ~= nil then
		table.insert( action.keywords, keyword )
		return true
	end

	return false
end

--[[
* @func: findAction( cid, value )
* @desc: Process NPC action internal condition.
* @cid: creatureId
* @value: action type or action keywords
]]--

function OtNpcSystem:findAction( cid, value )

	if #self.Actions == 0 then
		return false
	end
	
	for _, action in pairs( self.Actions ) do
		if ( ( type( value ) == "number" and action.type == value ) or ( type( value ) == "string" and self:findActionKeyword( action, value ) ) ) and self:processInternalCondition( cid, action ) then
			self:processInternalAction( cid, action )
			return action
		end
	end
	
	return false
end

--[[
* @func: findActionKeyword( action, message )
* @desc: Check if action keywords matches player message
* @action: npc action
* @message: player message
]]--

function OtNpcSystem:findActionKeyword( action, message )

	if type( action.keywords ) ~= "table" then
		return false
	end

	for _, keyword in pairs( action.keywords ) do
		if self:processInternalKeyword( keyword, message ) then
			return true
		end
	end

	return false
end

--[[
* @func: processInternalKeyword( keywords, message )
* @desc: Process action keywords matches
* @keywords: action keywords
* @message: player message
]]--

function OtNpcSystem:processInternalKeyword( keywords, message )
	local ret = true
	for _, keyword in pairs( keywords ) do
		local a, b = string.find( message, keyword )
		if a == nil or b == nil then
			ret = false
			break
		end
	end
	return ret
end

--[[
* @func: processInternalCondition( cid, action )
* @desc: Process NPC action internal condition.
* @cid: creatureId
* @action: npc action
]]--

function OtNpcSystem:processInternalCondition( cid, action )
	
	local player = Player( cid )
	if not player then
		return false
	end

	if action.condition and not action.condition( player, action.parameters, self ) then
		return false
	end
	
	return true
end

--[[
* @func: processInternalAction( cid, action )
* @desc: Process NPC action internal action.
* @cid: creatureId
* @action: npc action
]]--

function OtNpcSystem:processInternalAction( cid, action )
	
	local player = Player( cid )
	if not player then
		return false
	end
	
	if not action.action then
		return false
	end
	
	if action.type == ACTION_KEYWORD and not self:isFocused( cid ) then
		return false
	end
	
	action.action( player, action.parameters, self )

	return true
end

--[[
* @func: processSay( cid, message )
* @desc: Send NPC reply to creature
* @cid: creatureId
* @message: npc message
]]--

function OtNpcSystem:processSay( cid, message )

	if type( message ) == "table" then
		for _, msg in pairs( message ) do
			selfSay( self:processSayReplace( cid, msg ), cid )
		end
	else
		selfSay( self:processSayReplace( cid, message ), cid )
	end

	return true
end

--[[
* @func: processSayReplace( message )
* @desc: Replace keywords from npc reply
* @cid: creatureId
* @message: npc reply
]]--

function OtNpcSystem:processSayReplace( cid, message )
	
	local player = Player( cid )
	if not player then
		return false
	end

	local parseInfo = {
		[ "%%N" ] = player:getName(),
		[ "%%T" ] = getFormattedWorldTime()
	}

	local shop = self:getCustomShop( cid )
	if shop then
		parseInfo[ "%%L" ] = shop.level
		parseInfo[ "%%P" ] = shop.price
		parseInfo[ "%%S" ] = shop.name
	end

	for search, replace in pairs( parseInfo ) do
		message = string.gsub( message, search, replace )
	end
	
	return message
end

--[[
* @func: addFocus( cid )
* @desc: Add creature to NPC focus
* @cid: creatureId
]]--

function OtNpcSystem:addFocus( cid )
	
	if self:isFocused( cid ) then
		return false
	end

	self.TalkLasts[ cid ] = os.time()
	self.TradeWindows[ cid ] = {}
	self.CustomShop[ cid ] = {}

	table.insert( self.Focuses, cid )

	self:setTalkState( cid, 0 )
	self:updateFocus()

	return true
end

--[[
* @func: releaseFocus( cid )
* @desc: Remove/release creature from NPC focus
* @cid: creatureId
]]--

function OtNpcSystem:releaseFocus( cid )
	
	if not self:isFocused( cid ) then
		return false
	end

	self.TalkStates[ cid ] = nil
	self.TalkLasts[ cid ] = nil
	self.TradeWindows[ cid ] = nil
	self.CustomShop[ cid ] = nil

	local cidPos = nil
	for k, v in pairs( self.Focuses ) do
		if v == cid then
			cidPos = k
		end
	end
		
	table.remove( self.Focuses, cidPos )

	closeShopWindow( cid )
	self:updateFocus()
	
	return true
end

--[[
* @func: updateFocus()
* @desc: Update NPC focus to the last creature in focus table
]]--

function OtNpcSystem:updateFocus()
	
	if #self.Focuses == 0 then
		doNpcSetCreatureFocus( 0 )
		return false
	end
	
	doNpcSetCreatureFocus( self.Focuses[ #self.Focuses ] )
	
	return true
end

--[[
* @func: isFocused( cid )
* @desc: Check if provided CreatureId exists in NPC focus table
* @cid: creatureId
]]--

function OtNpcSystem:isFocused( cid )

	if #self.Focuses == 0 then
		return false
	end

	for k, v in pairs( self.Focuses ) do
		if v == cid then
			return true
		end
	end

	return false
end

--[[
* @func: setIdleTime( time )
* @desc: Set NPC idle timeout
* @time: time in seconds
]]--

function OtNpcSystem:setIdleTime( time )
	
	self.IdleTime = time
	
	if self.IdleTime ~= time then
		return false
	end
	
	return true
end

--[[
* @func: setTalkRadius( radius )
* @desc: Set radius that player can talk to NPC
* @radius: square meters (SQM)
]]--

function OtNpcSystem:setTalkRadius( radius )
	
	self.TalkRadius = radius
	
	if self.TalkRadius ~= radius then
		return false
	end
	
	return true
end

--[[
* @func: getTalkRadius()
* @desc: Return current NPC talk radius
]]--

function OtNpcSystem:getTalkRadius()
	return self.TalkRadius
end

--[[
* @func: isInTalkRadius( cid )
* @desc: Check if creature provided is in talk radius with NPC
* @cid: creatureId
]]--

function OtNpcSystem:isInTalkRadius( cid )
	return ( self.TalkRadius >= getDistanceBetween( getCreaturePosition( getNpcCid() ), getPlayerPosition( cid ) ) )
end

--[[
* @func: setTalkState( cid, state )
* @desc: Set talk state to provided creature
* @cid: creature id
* @state: talk state
]]--

function OtNpcSystem:setTalkState( cid, state )
	
	self.TalkStates[ cid ] = state

	if self:getTalkState( cid ) ~= state then
		return false
	end
	
	return true
end

--[[
* @func: getTalkState( cid )
* @desc: Get current talk state from creature
* @cid: creatureId
]]--

function OtNpcSystem:getTalkState( cid )

	if self.TalkStates[ cid ] ~= nil and self.TalkStates[ cid ] ~= 0 then
		return self.TalkStates[ cid ]
	end

	return 0
end

--[[
* @func: isWeekDay( day )
* @desc: Verify if provided day matches current day from week
* @day: day from week (monday, tuesday, etc)
]]--

function OtNpcSystem:isWeekDay( day )
	
	if os.date( "%A" ):lower() == day:lower() then
		return true
	end
	
	return false
end

--[[
* @func: getCount( message )
* @desc: Get numbers from provided message
* @message: message with numbers
]]--

function OtNpcSystem:getCount( message )
	local b, e = string:find( "%d+" )
	return b and e and tonumber( string:sub( b, e ) ) or -1
end

--[[
* @func: setIdle( cid )
* @desc: Force release focus without any message
* @cid: creatureId
]]--

function OtNpcSystem:setIdle( cid )
	
	if not self:isFocused( cid ) then
		return false
	end
	
	addEvent( function( self, cid )
		self:releaseFocus( cid )
	end, 1000, self, cid )
	
	return true
end

--[[
* @func: internalBuyCallback( cid, itemid, subType, amount, ignoreCap, inBackpacks )
* @desc: Process trade window buy action
* @cid: creatureId
* @itemid: buyable item id
* @subtype: item subtype
* @amount: item amount
* @ignoreCap: ignore capacity on buy
* @inBackpacks: buy items in backpacks
]]--

function OtNpcSystem:internalBuyCallback( cid, itemid, subType, amount, ignoreCap, inBackpacks )

	local player = Player( cid )
	if not player then
		return false
	end
	
	local shopItem = self:internalGetTradeItem( player:getId(), itemid, subType, true )
	if shopItem == nil or shopItem.buy == -1 then
		return false
	end

	local backpackId = 1988
	local totalCost = amount * shopItem.buy
	
	if inBackpacks then
		totalCost = isItemStackable( itemid ) == true and totalCost + 20 or totalCost + ( math.max(1, math.floor( amount / getContainerCapById( backpackId ) ) ) * 20 )
	end
	
	local subType = shopItem.subType or 1
	local a, b = doNpcSellItem( cid, itemid, amount, subType, ignoreCap, inBackpacks, backpackId )
	
	if a < amount then

		doPlayerSendCancel( cid, ( a == 0 and "You do not have enough capacity." or "You do not have enough capacity for all items." ) )

		if a > 0 then
			player:removeMoney( ( ( a * shopItem.buy ) + ( b * 20 ) ) )
			return true
		end

		return false
	end
	
	doPlayerTakeMoney( player:getId(), totalCost )
	doPlayerSendTextMessage( cid, MESSAGE_INFO_DESCR, string.format( "Bought %dx %s for %d gold.", amount, ItemType( itemid ):getName(), totalCost ) )

	local action = self:findAction( cid, ACTION_TRADE_BUY_REPLY )
	if action ~= false and action.parameters.reply ~= nil then
		self:processSay( cid, string.gsub( action.parameters.reply, "%%P", totalCost ) )
	end
	
	self.TalkLasts[ player:getId() ] = os.time()

	return true
end

--[[
* @func: internalSellCallback( cid, itemid, subType, amount, ignoreCap, inBackpacks )
* @desc: Process trade window sell action
* @cid: creatureId
* @itemid: sellable item id
* @subtype: item subtype
* @amount: item amount
* @ignoreCap: ignore capacity on sell
* @inBackpacks: sell items in backpacks
]]--

function OtNpcSystem:internalSellCallback( cid, itemid, subType, amount, ignoreCap, inBackpacks )
	
	local player = Player( cid )
	if not player then
		return false
	end
	
	local shopItem = self:internalGetTradeItem( player:getId(), itemid, subType, false )
	if shopItem == nil or shopItem.sell == -1 then
		return false
	end

	if not isItemFluidContainer( itemid ) then
		subType = -1
	end
	
	local totalCost = ( amount * shopItem.sell )

	if not doPlayerRemoveItem( player:getId(), itemid, amount, subType, ignoreEquipped ) then
		doPlayerSendCancel( player:getId(), "You do not have this object." )
		return false
	end
	
	doPlayerAddMoney( player:getId(), totalCost )
	doPlayerSendTextMessage( player:getId(), MESSAGE_INFO_DESCR, string.format( "Sold %dx %s for %d gold.", amount, ItemType( itemid ):getName():lower(), totalCost ) )

	local action = self:findAction( player:getId(), ACTION_TRADE_SELL_REPLY )
	if action ~= false and action.parameters.reply ~= nil then
		self:processSay( player:getId(), string.gsub( action.parameters.reply, "%%P", totalCost ) )
	end
	
	self.TalkLasts[ player:getId() ] = os.time()

	return true
end

--[[
* @func: internalGetTradeItem( cid, itemId, subType, onBuy )
* @desc: Find requested item from Trade Window
* @cid: creatureId
* @itemid: item id
* @subtype: item subtype
* @onBuy: buying or selling?
]]--

function OtNpcSystem:internalGetTradeItem( cid, itemId, subType, onBuy )
	
	local tradeWindow = self.TradeWindows[ cid ]
	if not tradeWindow then
		return nil
	end
	
	for i = 1, #tradeWindow do
		local shopItem = self.TradeWindows[ cid ][ i ]
		if ( ( isItemFluidContainer( shopItem.id ) and shopItem.id == itemId and shopItem.subType == subType ) or shopItem.id == itemId ) and ( not onBuy and shopItem.sell > 0 or onBuy and shopItem.buy > 0 ) then
			return shopItem
		end
	end
	
	return nil
end

--[[
* @func: addBuyableItem( cid, itemId, itemPrice, subType, itemName )
* @desc: Adds an item to npc buyable table
* @cid: creatureId
* @itemid: item id
* @itemPrice: item price
* @subtype: item subtype
* @itemName: item name (if empty, item name will be loadded from items.xml)
]]--

function OtNpcSystem:addBuyableItem( cid, itemId, itemPrice, subType, itemName )
	
	if itemId == nil or type( itemId ) ~= "number" then
		return false
	end

	if itemName == nil then
		local itemtype = ItemType( itemId )
		if itemtype:isFluidContainer() then
			local fluidName = self.Fluids[ subType ]
			if fluidName ~= nil then
				itemName = string.format( "%s of %s", itemtype:getName(), fluidName:lower() )
			else
				itemName = string.format( "%s of unknown", itemtype:getName() )
			end
		else
			itemName = itemtype:getName()
		end
	end
	
	table.insert( self.TradeWindows[ cid ], {
		id = itemId,
		buy = itemPrice,
		sell = 0,
		subType = subType,
		name = itemName
	} )
	
	return true
end

--[[
* @func: addSellableItem( cid, itemId, itemPrice, subType, itemName )
* @desc: Adds an item to npc sellable table
* @cid: creatureId
* @itemid: item id
* @itemPrice: item price
* @subtype: item subtype
* @itemName: item name (if empty, item name will be loadded from items.xml)
]]--

function OtNpcSystem:addSellableItem( cid, itemId, itemPrice, subType, itemName )
	
	if itemId == nil or type( itemId ) ~= "number" then
		return false
	end
	
	if itemName == nil then
		local itemtype = ItemType( itemId )
		if itemtype:isFluidContainer() then
			local fluidName = self.Fluids[ subType ]
			if fluidName ~= nil then
				itemName = string.format( "%s of %s", itemtype:getName(), fluidName:lower() )
			else
				itemName = string.format( "%s of unknown", itemtype:getName() )
			end
		else
			itemName = itemtype:getName()
		end
	end
	
	table.insert( self.TradeWindows[ cid ], {
		id = itemId,
		buy = 0,
		sell = itemPrice,
		subType = subType,
		name = itemName
	} )
	
	return true
end

--[[
* @func: getCustomShop( cid )
* @desc: Get player custom shop/parameters
* @cid: creatureId
]]--

function OtNpcSystem:getCustomShop( cid )
	
	local shop = self.CustomShop[ cid ]
	if not shop then
		return nil
	end
	
	return shop
end

--[[
* @func: addVoice( text )
* @desc: Add message to random npc talk
* @text: message text
]]--

function OtNpcSystem:addVoice( text )
	
	if self.Voices == nil then
		return false
	end
	table.insert( self.Voices, text )
	
	return true
end

--[[
* @func: getPosition()
* @desc: Get current npc position (x,y,z)
]]--

function OtNpcSystem:getPosition()
	
	local npc = Npc( getNpcCid() )
	if not npc then
		return nil
	end
	
	return npc:getPosition()
end
