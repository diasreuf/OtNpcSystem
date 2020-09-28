--[[
* RL860 - Real Map Clone Project v8.60
* King Tibianus.lua: Database for the King of Tibia
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
		keywords = { "hail", "king$" },
		reply = "I greet thee, my loyal subject."
	}
)

npc:addAliasKeyword( { "hello", "king$" } )
npc:addAliasKeyword( { "salutations", "king$" } )

npc:addAction(
	ACTION_VANISH,
	{
		reply = "What a lack of manners!"
	}
)

npc:addAction(
	ACTION_FAREWELL,
	{
		keywords = { "bye" },
		reply = "Good bye, %N!"
	}
)

npc:addAliasKeyword( { "farewell" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "job" },
		reply = "I am your sovereign, King Tibianus III, and it's my duty to provide justice and guidance for my subjects."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "justice" },
		reply = "I try my best to be just and fair to our citizens. The army and the TBI are a great help for fulfilling this duty."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "name" },
		reply = "It's hard to believe that you don't know your own king!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "news" },
		reply = "The latest news are usually brought to our magnificent town by brave adventurers. They spread tales of their journeys at Frodo's tavern."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "tibia" },
		reply = "Soon the whole land will be ruled by me once again!"
	}
)

npc:addAliasKeyword( { "land" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "how", "are", "you" },
		reply = "Thank you, I'm fine."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "castle" },
		reply = "Rain Castle is my home."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "sell" },
		reply = "Sell? Sell what? My kingdom isn't for sale!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "god" },
		reply = "Honor the gods and pay your taxes."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "zathroth" },
		reply = "Please ask a priest about the gods."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "citizen" },
		reply = "The citizens of Tibia are my subjects. Ask the old monk Quentin to learn more about them."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "sam" },
		reply = "He is a skilled blacksmith and a loyal subject."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "frodo" },
		reply = "He is the owner of Frodo's Hut and a faithful tax-payer."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "gorn" },
		reply = "He was once one of Tibia's greatest fighters. Now he is selling equipment."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "benjamin" },
		reply = "He was once my greatest general. Now he is very old and senile but we entrusted him with work for the Royal Tibia Mail."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "harkath" },
		reply = "Harkath Bloodblade is the general of our glorious army."
	}
)

npc:addAliasKeyword( { "bloodblade" } )
npc:addAliasKeyword( { "general" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "noodles" },
		reply = "The royal poodle Noodles is my greatest treasure!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "ferumbras" },
		reply = "He is a follower of the evil god Zathroth and responsible for many attacks on us. Kill him on sight!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "bozo" },
		reply = "He is my royal jester and cheers me up now and then."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "treasure" },
		reply = "The royal poodle Noodles is my greatest treasure!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "monster" },
		reply = "Go and hunt them! For king and country!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "help" },
		reply = "Visit Quentin, the monk, for help."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "quest" },
		reply = "I will call for heroes as soon as the need arises again and then reward them appropriately."
	}
)

npc:addAliasKeyword( { "mission" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "gold" },
		reply = "To pay your taxes, visit the royal tax collector."
	}
)

npc:addAliasKeyword( { "money" } )
npc:addAliasKeyword( { "tax" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "sewer" },
		reply = "What a disgusting topic!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "dungeon" },
		reply = "Dungeons are no places for kings."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "equipment" },
		reply = "Feel free to buy it in our town's fine shops."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "food" },
		reply = "Ask the royal cook for some food."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "time" },
		reply = "It's a time for heroes, that's for sure!"
	}
)

npc:addAliasKeyword( { "heroes" } )
npc:addAliasKeyword( { "hero$" } )
npc:addAliasKeyword( { "adventurer" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "tax", "collector" },
		reply = "He has been lazy lately. I bet you have not payed any taxes at all."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "king" },
		reply = "I am the king, so mind your words!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "army" },
		reply = "Ask the soldiers about that topic."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "enemy" },
		reply = "Our enemies are numerous. The evil minotaurs, Ferumbras, and the renegade city of Carlin to the north are just some of them."
	}
)

npc:addAliasKeyword( { "enemies" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "city", "north" },
		reply = "They dare to reject my reign over the whole continent!"
	}
)

npc:addAliasKeyword( { "carlin" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "thais" },
		reply = "Our beloved city has some fine shops, guildhouses, and a modern system of sewers."
	}
)

npc:addAliasKeyword( { "city" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "shop" },
		reply = "Visit the shops of our merchants and craftsmen."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "merchant" },
		reply = "Ask around about them."
	}
)

npc:addAliasKeyword( { "craftsmen" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "guild" },
		reply = "The four major guilds are the knights, the paladins, the druids, and the sorcerers."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "minotaur" },
		reply = "Vile monsters, but I must admit they are strong and sometimes even cunning ... in their own bestial way."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "paladin" },
		reply = "The paladins are great protectors for Thais."
	}
)

npc:addAliasKeyword( { "elane" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "knight" },
		reply = "The brave knights are necessary for human survival in Thais."
	}
)

npc:addAliasKeyword( { "gregor" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "sorcerer" },
		reply = "The magic of the sorcerers is a powerful tool to smite our enemies."
	}
)

npc:addAliasKeyword( { "muriel" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "druid" },
		reply = "We need the druidic healing powers to fight evil."
	}
)

npc:addAliasKeyword( { "marvik" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "good" },
		reply = "The forces of good are hard pressed in these dark times."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "evil" },
		reply = "We need all strength we can muster to smite evil!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "order" },
		reply = "We need order to survive!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "chaos" },
		reply = "Chaos arises from selfishness, and that's its weakness."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "excalibug" },
		reply = "It's the sword of the kings. If you could return this weapon to me I would reward you beyond your dreams."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "reward" },
		reply = "Well, if you want a reward, go on a quest to bring me Excalibug!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "chester" },
		reply = "A very competent person. A little nervous but very competent."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "tbi$" },
		reply = "This organisation is important in holding our enemies in check. Its headquarter is located in the bastion in the northwall."
	}
)
npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "eremo" },
		reply = "It is said that he lives on a small island near Edron. Maybe the people there know more about him."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "promot" },
		reply = "Do you want to be promoted in your vocation for 20000 gold?",
		talkstate = 1
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You are already promoted."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1 and player:getStorageValue( Storages.Player.Promotion ) >= 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You need to be at least level 20 in order to be promoted."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1 and player:getLevel() < 20
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You do not have enough money."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1 and player:getMoney() < 20000
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You need a premium account in order to promote."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1 and not player:isPremium()
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Congratulations! You are now promoted. Visit the sage Eremo for new spells."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end,
	function( player, parameters, self )
		player:removeMoney( 20000 )
		player:setVocation( player:getVocation():getPromotion() )
		player:setStorageValue( Storages.Player.Promotion, 1 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "" },
		reply = "Ok, then not."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end
)
