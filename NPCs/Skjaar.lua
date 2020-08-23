--[[
* RL860 - Real Map Cloje Project v8.60
* Database for Skjaar, guardian of the crypt in the mount sternum and master mage
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
		keywords = {
			{ "hi$" },
			{ "hello$" }
		},
		reply = "I don't talk to little children!!"
	},
	function( player, parameters, self )
		return player:getLevel() < 15
	end
)

npc:addAction(
	ACTION_GREET,
	{
		keywords = {
			{ "hi$" },
			{ "hello$" }
		},
		reply = "Hail, friend of nature! How may I help you?"
	},
	function( player, parameters, self )
		return player:isDruid()
	end
)

npc:addAction(
	ACTION_GREET,
	{
		keywords = {
			{ "hi$" },
			{ "hello$" }
		},
		reply = "Another creature who believes thinks physical strength is more important than wisdom! Why are you disturbing me?"
	},
	function( player, parameters, self )
		return player:isKnight()
	end
)

npc:addAction(
	ACTION_GREET,
	{
		keywords = {
			{ "hi$" },
			{ "hello$" }
		},
		reply = "Neither strong enough to be a knight nor wise enough to be a real mage. You like it easy, don't you? Why are you disturbing me?"
	},
	function( player, parameters, self )
		return player:isPaladin()
	end
)

npc:addAction(
	ACTION_GREET,
	{
		keywords = {
			{ "hi$" },
			{ "hello$" }
		},
		reply = "It's good to see somebody who has chosen the path of wisdom. What do you want?"
	},
	function( player, parameters, self )
		return player:isSorcerer()
	end
)

npc:addAction(
	ACTION_VANISH,
	{
		reply = "Run away, unworthy %N!"
	}
)

npc:addAction(
	ACTION_FAREWELL,
	{
		keywords = {
			{ "bye" },
			{ "farewell" }
		},
		reply = "Farewell, %N!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "job" }
		},
		reply = "Once I was the master of all mages, but now I only protect this crypt."
	}
)




npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "name" }
		},
		reply = "I am Skjaar the Mage, master of all spells."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "door" }
		},
		reply = "This door seals a crypt."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "crypt" }
		},
		reply = "Here lies my master. Only his closest followers may enter."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "help" }
		},
		reply = "I'm not here to help anybody. I only protect my master's crypt."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "mountain" }
		},
		reply = "Hundreds of years my master's castle stood on the top of this mountain. Now there is a volcano."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "volcano" }
		},
		reply = "I can still feel the magical energy in the volcano."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "castle" }
		},
		reply = "The castle was destroyed when my master tried to summon a nameless creature. All that is left is this volcano."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "time" }
		},
		reply = "To those who have lived for a thousand years time holds no more terror."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "master" }
		},
		reply = "If you are one of his followers, you need not ask about him, for you will know. And if you aren't, you are not worthy anyway!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "idiot" },
			{ "fuck" },
			{ "asshole" }
		},
		reply = "Take this for your words!"
	},
	function( player, parameters, self )
		player:addHealth( -( player:getHealth() - 1 ) )
		player:getPosition():sendMagicEffect( CONST_ME_MAGIC_RED )
		self:setIdle( player:getId() )
		return true
	end
)








npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "key" }
		},
		reply = "I will give the key to the crypt only to the closest followers of my master. Would you like me to test you?",
		talkstate = 1
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "yes" }
		},
		reply = "Before we start I must ask you for a small donation of 1000 gold coins. Are you willing to pay 1000 gold coins for the test?",
		talkstate = 2
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "no" }
		},
		reply = "Then leave, unworthy worm!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "" }
		},
		reply = "You're not worthy if you cannot make up your mind. Leave!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "yes" }
		},
		reply = "All right then. Here comes the first question. What was the name of Dago's favourite pet?",
		talkstate = 3
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2 and player:getMoney() >= 1000
	end,
	function( player, parameters, self )
		player:removeMoney( 1000 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "yes" }
		},
		reply = "You don't even have the money to make a donation? Then go!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "no" }
		},
		reply = "You're not worthy then. Now leave!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "" }
		},
		reply = "You're not worthy if you cannot make up your mind. Leave!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "redips" }
		},
		reply = "Perhaps you knew him after all. Tell me - how many fingers did he have when he died?",
		talkstate = 4
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 3
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "" }
		},
		reply = "You are wrong. Get lost!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 3
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "7" },
			{ "seven" }
		},
		reply = "Also true. But can you also tell me the colour of the deamons in which master specialized?",
		talkstate = 5
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 4
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "" }
		},
		reply = "You are wrong. Get lost!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 4
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "black" }
		},
		reply = "It seems you are worthy after all. Do you want the key to the crypt?",
		talkstate = 6
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 5
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "" }
		},
		reply = "You are wrong. Get lost!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 5
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "yes" }
		},
		reply = "Here you are."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 6
	end,
	function( player, parameters, self )
		player:addItem( 2089, 1 ):setActionId( 3142 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = {
			{ "" }
		},
		reply = "It is always a wise decision to leave the dead alone."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 6
	end
)
