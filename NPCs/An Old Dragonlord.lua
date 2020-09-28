--[[
* RL860 - Real Map Clone Project v8.60
* An Old Dragonlord.lua: Database for the ancient dragon lord
]]--

local npc = OtNpcSystem:Init()

function onCreatureAppear( cid )
	npc:onCreatureAppear( cid )
end

function onCreatureDisappear( cid )
	npc:onCreatureDisappear( cid )
end

function onCreatureSay( cid, type, msg )
	npc:onCreatureSay( cid, type, msg )
end

function onThink()
	npc:onThink()
end

npc:addAction(
	ACTION_NOTFOCUSED,
	{
		keywords = { "hi$" },
		reply = "LEAVE THE DRAGONS' CEMETERY AT ONCE!"
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.DragonCemetery ) >= 1
	end
)

npc:addAliasKeyword( { "hello$" } )

npc:addAction(
	ACTION_NOTFOCUSED,
	{
		keywords = { "hi$" },
		reply = "AHHH MUSHRRROOOMSSS! NOW MY PAIN WILL BE EASSSED FOR A WHILE! TAKE THISS AND LEAVE THE DRAGONSSS' CEMETERY AT ONCE!"
	},
	function( player, parameters, self )
		return player:getItemCount( 2787 ) >= 1
	end,
	function( player, parameters, self )
		player:removeItem( 2787, 1 )
		player:addItem( 2319, 1 )
		player:setStorageValue( Storages.Player.DragonCemetery, 1 )
		return true
	end
)

npc:addAliasKeyword( { "hello$" } )

npc:addAction(
	ACTION_NOTFOCUSED,
	{
		keywords = { "hi$" },
		reply = "AHHHH THE PAIN OF AGESSS! I NEED MUSSSSHRROOOMSSS TO EASSSE MY PAIN! BRRRING ME MUSHRRROOOMSSS!"
	}
)

npc:addAliasKeyword( { "hello$" } )
