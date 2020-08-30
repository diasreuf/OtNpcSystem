--[[
* RL860 - Real Map Clone Project v8.60
* Boozer.lua: Database for the host Boozer
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
	ACTION_GREET,
	{
		keywords = { "hi$" },
		reply = "Welcome to the Hard Rock Racing Track, %N."
	}
)

npc:addAliasKeyword( { "hello$" } )

npc:addAction(
	ACTION_VANISH,
	{
		reply = "You'll be back."
	}
)

npc:addAction(
	ACTION_FAREWELL,
	{
		keywords = { "bye" },
		reply = "You'll be back."
	}
)

npc:addAliasKeyword( { "farewell" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "job" },
		reply = "I am the bartender here at the racing track."
	}
)

npc:addAliasKeyword( { "tavern" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "frodo" },
		reply = "I heard about his tiny tavern in Thais."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "name" },
		reply = "Just call me Boozer. Everyone does that."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "time" },
		reply = "No clue, boy."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "time" },
		reply = "No clue, girl."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "king" },
		reply = "The king is far away, so who cares?"
	}
)

npc:addAliasKeyword( { "tibianus" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "army" },
		reply = "Good customers."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "ferumbras" },
		reply = "Guess he'd be bad news for business."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "excalibug" },
		reply = "Heard about it now and then. Then again I also hear there a bogeyman somewhere in the swamps."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "bogeyman" },
		reply = "Just a tale to scare the kids."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "thais" },
		reply = "If you like that Thais that much just go there."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "tibia" },
		reply = "People from all over Tibia come here to buy, sell, gamble, and get drunk until they puke."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "carlin" },
		reply = "Heard about that women there. Must visit that wenches someday."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "amazon" },
		reply = "I guess they just have not met the right man yet."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "news" },
		reply = "The swampelves, down at Shadowthorn, are up to some trouble again."
	}
)

npc:addAliasKeyword( { "rumors" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "swampelves" },
		reply = "Some elves gone evil so to say. They now live in a small village to the south called Shadowthorn. No big deal. Who cares about some carrot-eating musicians at all?"
	}
)

npc:addAction(
	ACTION_TRADE,
	{
		keywords = { "trade" },
		reply = "See my wares."
	},
	function( player, parameters, self )
	
		self:addBuyableItem( player:getId(), 2689, 4 ) -- Bread
		self:addBuyableItem( player:getId(), 2012, 2, 3 ) -- Mug of Beer
		self:addBuyableItem( player:getId(), 2696, 6 ) -- Cheese
		self:addBuyableItem( player:getId(), 2687, 5 ) -- Cookie
		self:addBuyableItem( player:getId(), 2671, 8 ) -- Ham
		self:addBuyableItem( player:getId(), 8208, 10 ) -- Ice Cream Cone (Venorean Dream)
		self:addBuyableItem( player:getId(), 2012, 2, 5 ) -- Mug of Lemonade
		self:addBuyableItem( player:getId(), 2666, 5 ) -- Meat
		self:addBuyableItem( player:getId(), 2012, 1, 1 ) -- Mug of Water
		self:addBuyableItem( player:getId(), 2012, 3, 15 ) -- Mug of Wine
		
		return true
	end
)
