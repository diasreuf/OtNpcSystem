--[[
* OtNpcSystem v0.1
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

	setmetatable( npcsystem, self )
	self.__index = self
	
	return npcsystem
end

--[[
* @func: onThink()
* @desc: Execute NPC main loop
]]--

function OtNpcSystem:onThink()

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
		self:internalGreetAction( cid, action )
	elseif action.type == ACTION_FAREWELL then
		self:internalFarewellAction( cid, action )
	elseif action.type == ACTION_KEYWORD or action.type == ACTION_NOTFOCUSED then
		self:internalKeywordAction( cid, action )
	elseif action.type == ACTION_TRADE then
		
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
* @desc: Process NPC keyword/notfocused action
* @cid: creatureId
* @action: keyword/notfocused action
]]--

function OtNpcSystem:internalKeywordAction( cid, action )
	
	if not self:isFocused( cid ) and action.type ~= ACTION_NOTFOCUSED then
		return false
	end

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
	
	table.insert( self.Actions, {
		type = type,
		parameters = parameters,
		condition = condition,
		action = action
	} )

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

	if type( action.parameters.keywords ) ~= "table" then
		return false
	end

	for _, keyword in pairs( action.parameters.keywords ) do
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
