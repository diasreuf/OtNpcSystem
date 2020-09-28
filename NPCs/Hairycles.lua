--[[
* RL860 - Real Map Clone Project v8.60
* Hairycles.lua: Database for the Monkey Hairycles
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
		reply = "Be greeted, friend of the ape people. If you want to trade, just ask for my {offers}. If you are injured, ask for {healing}."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) >= 12
	end
)

npc:addAliasKeyword( { "hello$" } )

npc:addAction(
	ACTION_GREET,
	{
		keywords = { "hi$" },
		reply = "Oh! Hello! Hello! Did not notice!"
	}
)

npc:addAliasKeyword( { "hello$" } )

npc:addAction(
	ACTION_VANISH,
	{
		reply = "Bye, bye."
	}
)

npc:addAction(
	ACTION_FAREWELL,
	{
		keywords = { "bye" },
		reply = "Bye, bye."
	}
)

npc:addAliasKeyword( { "farewell" } )

npc:addAction(
	ACTION_TRADE,
	{
		keywords = { "offer" },
		reply = "Me offer tasty bananas. Me also sell statues of holy apes of wisdom. Statue of no talking, statue of no hearing, statue of no seeing."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) >= 18
	end,
	function( player, parameters, self )
		self:addBuyableItem( player:getId(), 2676, 2 )
		self:addBuyableItem( player:getId(), 5086, 65 )
		self:addBuyableItem( player:getId(), 5087, 65 )
		self:addBuyableItem( player:getId(), 5088, 65 )
		return true
	end
)

npc:addAction(
	ACTION_TRADE,
	{
		keywords = { "offer" },
		reply = "Me offer tasty bananas."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) >= 12
	end,
	function( player, parameters, self )
		self:addBuyableItem( player:getId(), 2676, 2 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "offers" },
		reply = "Me nothing have to offer you now. Perhaps ask later, when we know better."
	}
)
npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "how", "are", "you" },
		reply = "Me fine, me fine."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "advice" },
		reply = "You stay away from other apes. We not like foreigners. Especially with so little hair."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "job" },
		reply = "Me great wizard. Me great doctor. Me know many plants. Me old and me have seen many things."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "name" },
		reply = "Me is Hairycles."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "time" },
		reply = "You look to suns or moon and time you know."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "help" },
		reply = "Me not help you can. Other apes would get mad at me."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "jungle" },
		reply = "Jungle is dangerous. Jungle also provides us food. Take care when in jungle and safe you be."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "city" },
		reply = "City now our is. Chasing away evil snakemen."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "snakemen" },
		reply = "Evil snakemen mean to apes and making them work and holding them captive since apes can think. But then Spartaky came."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "spartaky" },
		reply = "He great ape was. He fled to jungle, taught other apes of snakemen secrets. Came back with other apes and together we chased snake people away. Made city our home."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "port", "hope" },
		reply = "Strange hairless ape people there live. We go and get funny things from strange people."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "ape", "people" },
		reply = "We be kongra, sibang and merlkin. Strange hairless ape people live in city called Port Hope."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "kongra" },
		reply = "Kongra verry strong. Kongra verry angry verry fast. Take care when kongra comes. Better climb on highest tree."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "sibang" },
		reply = "Sibang verry fast and funny. Sibang good gather food. Sibang know jungle well."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "merlkin" },
		reply = "Merlkin we are. Merlkin verry wise, merlkin learn many things quick. Teach other apes things a lot. Making heal and making magic."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "magic" },
		reply = "We see many things and learning quick. Merlkin magic learn quick, quick. We just watch and learn. Sometimes we try and learn."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "weapon" },
		reply = "We weapons not need much. Take what is around we do. Tools we more need."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "tools" },
		reply = "Lot of tools snakemen left when run away. But tools go break. New tools we get where we find. Like taking banana."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "tibia" },
		reply = "Me know Tibia is all we see."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "banana" },
		reply = "Banana is good. Is magic fruit. Banana makes happy. Banana means life. Banana is everything."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "language" },
		reply = "Strange hairless ape in loincloth came here. Zantar his name was. Brought many banana. We him liked. He here lived. Taught Hairycles funny language."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "holy", "serpent" },
		reply = "Ugly beasts that are holy to lizard people. Only found in ancient temple under Banuta. But me can not allow you to go there."
	}
)

-- The Ape City
-- Mission 01: Whisper Moss

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "These are dire times for our people. Problems plenty are in this times. But me people not grant trust easy. Are you willing to prove you friend of ape people?",
		talkstate = 1
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "To become friend of ape people a long and difficult way is. We do not trust easy but help is needed. Will you listen to story of Hairycles?",
		talkstate = 2
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Hairycles sad is now. But perhaps you will change mind one day."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = {
			"So listen, little ape was struck by plague. Hairycles not does know what plague it is. That is strange. Hairycles should know. But Hairycles learnt lots and lots ...",
			"Me sure to make cure so strong to drive away all plague. But to create great cure me need powerful components ...",
			"Me need whisper moss. Whisper moss growing south of human settlement is. Problem is, evil little dworcs harvest all whisper moss immediately ...",
			"Me know they hoard some in their underground lair. My people raided dworcs often before humans came. So we know the moss is hidden in east of upper level of dworc lair ...",
			"You go there and take good moss from evil dworcs. Talk with me about mission when having moss."
		}
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 1 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Hairycles thought better of you."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "" },
		reply = "Uh?"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 2
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Please hurry. Bring me whisper moss from dworc lair. Make sure it is from dworc lair! Take it yourself only! If you need to hear background of all again, ask Hairycles for {background}."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 1 and player:getStorageValue( Storages.Player.WhisperMoss ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "background" },
		reply = {
			"So listen, little ape was struck by plague. Hairycles not does know what plague it is. That is strange. Hairycles should know. But Hairycles learnt lots and lots ...",
			"Me sure to make cure so strong to drive away all plague. But to create great cure me need powerful components ...",
			"Me need whisper moss. Whisper moss growing south of human settlement is. Problem is, evil little dworcs harvest all whisper moss immediately ...",
			"Me know they hoard some in their underground lair. My people raided dworcs often before humans came. So we know the moss is hidden in east of upper level of dworc lair ...",
			"You go there and take good moss from evil dworcs. Talk with me about mission when having moss."
		}
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Oh, you brought me whisper moss? Good hairless ape you are! Can me take it?",
		talkstate = 3
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 1 and player:getStorageValue( Storages.Player.WhisperMoss ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Ah yes! That's it. Thank you for bringing mighty whisper moss to Hairycles. It will help but still much is to be done. Just ask for other mission if you ready."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 3 and player:getItemCount( 4838 ) >= 1
	end,
	function( player, parameters, self )
		player:removeItem( 4838, 1 )
		player:setStorageValue( Storages.Player.TheApeCity, 2 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Stupid, you no have the moss me need. Go get it. It's somewhere in dworc lair. If you lost it, they might restocked it meanwhile. If you need to hear background of all again, ask Hairycles for {background}."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 3
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.WhisperMoss, 0 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Strange being you are! Our people need help!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 3
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)

-- The Ape City
-- Mission 02: The Cure

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"Whisper moss strong is, but me need liquid that humans have to make it work ...",
			"Our raiders brought it from human settlement, it's called cough syrup. Go ask healer there for it."
		}
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 2
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 3 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You brought me that cough syrup from human healer me asked for?",
		talkstate = 4
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 3
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You so good! Brought syrup to me! Thank you, will prepare cure now. Just ask for mission if you want help again."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 4 and player:getItemCount( 4839 ) >= 1
	end,
	function( player, parameters, self )
		player:removeItem( 4839, 1 )
		player:setStorageValue( Storages.Player.TheApeCity, 4 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "No no, not right syrup you have. Go get other, get right health syrup."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 4
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Please hurry, urgent it is!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 4
	end
)

-- The Ape City
-- Mission 03: Lizard Parchment

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Little ape should be healthy soon. Me so happy is. Thank you again! But me suspect we in more trouble than we thought. Will you help us again?",
		talkstate = 5
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 4
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = {
			"So listen, please. Plague was not ordinary plague. That's why Hairycles could not heal at first. It is new curse of evil lizard people ...",
			"I think curse on little one was only a try. We have to be prepared for big strike ...",
			"Me need papers of lizard magician! For sure you find it in his hut in their dwelling. It's south east of jungle. Go look there please! Are you willing to go?"
		},
		talkstate = 6
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 5
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Good thing that is! Report about your mission when have scroll."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 6
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 5 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Good thing that is! Report about your mission when have scroll."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 6
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You got scroll from lizard village in south east?",
		talkstate = 7
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 5
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "No! That not scroll me looking for. Silly hairless ape you are. Go to village of lizards and get it there on your own!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 7 and player:getItemCount( 5956 ) < 1 and player:getStorageValue( Storages.Player.LizardParchment ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Oh, you seem to have lost scroll? That's bad news. If you lost it, only way to get other is to kill holy serpents. But you can't go there so you must ask adventurers who can."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 7 and player:getItemCount( 5956 ) < 1 and player:getStorageValue( Storages.Player.LizardParchment ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You brought scroll with lizard text? Good! I will see what text tells me! Come back when ready for other mission."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 7 and player:getItemCount( 5956 ) >= 1 and player:getStorageValue( Storages.Player.LizardParchment ) == 1
	end,
	function( player, parameters, self )
		player:removeItem( 5956, 1 )
		player:setStorageValue( Storages.Player.TheApeCity, 6 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "That's bad news. If you lost it, only way to get other is to kill holy serpents. But you can't go there so you must ask adventurers who can."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 7
	end
)

-- The Ape City
-- Mission 04: Decyphering

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"Ah yes that scroll. Sadly me not could read it yet. But the holy banana me insight gave! In dreams Hairycles saw where to find solution ...",
			"Me saw a stone with lizard signs and other signs at once. If you read signs and tell Hairycles, me will know how to read signs ...",
			"You go east to big desert. In desert there city. East of city under sand hidden tomb is. You will have to dig until you find it, so take shovel ...",
			"Go down in tomb until come to big level and then go down another. There you find a stone with signs between two huge red stones ...",
			"Read it and return to me. Are you up to that challenge?"
		},
		talkstate = 8
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 6
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Good thing that is! Report about mission when you have read those signs."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 8
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 7 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You still don't know signs on stone, go and look for it in tomb east in desert."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 7 and player:getStorageValue( Storages.Player.Decyphering ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Ah yes, you read the signs in tomb? Good! May me look into your mind to see what you saw?",
		talkstate = 9
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 7 and player:getStorageValue( Storages.Player.Decyphering ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Oh, so clear is all now! Easy it will be to read the signs now! Soon we will know what to do! Thank you again! Ask for mission if you feel ready."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 9
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 8 )
		player:getPosition():sendMagicEffect( CONST_ME_MAGIC_BLUE )
		return true
	end
)

-- The Ape City
-- Mission 05: Hydra Egg

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"So much there is to do for Hairycles to prepare charm that will protect all ape people ...",
			"You can help more. To create charm of life me need mighty token of life! Best is egg of a regenerating beast as a hydra is ...",
			"Bring me egg of hydra please. You may fight it in lair of Hydra at little lake south east of our lovely city Banuta! You think you can do?"
		},
		talkstate = 10
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 8
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You brave hairless ape! Get me hydra egg. If you lose egg, you probably have to fight many, many hydras to get another."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 10
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 9 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You bring Hairycles egg of hydra?",
		talkstate = 11
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 9
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Ah, the egg! Mighty warrior you be! Thank you. Hairycles will put it at safe place immediately."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 11 and player:getItemCount( 4850 ) >= 1
	end,
	function( player, parameters, self )
		player:removeItem( 4850, 1 )
		player:setStorageValue( Storages.Player.TheApeCity, 10 )
		self:setIdle( player:getId() )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You not have egg of hydra. Please get one!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 11
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Please hurry. Hairycles not knows when evil lizards strike again."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 11
	end
)

-- The Ape City
-- Mission 06: Witches Cap Mushroom

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"Last ingredient for charm of life is thing to lure magic. Only thing me know like that is mushroom called witches' cap. Me was told it be found in isle called Fibula, where humans live ...",
			"Hidden under Fibula is a secret dungeon. There you will find witches' cap. Are you willing to go there for good ape people?"
		},
		talkstate = 12
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 10
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Long journey it will take, good luck to you."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 12
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 11 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You brought Hairycles witches' cap from Fibula?",
		talkstate = 18
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 11
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Incredible, you brought a witches' cap! Now me can prepare mighty charm of life. Yet still other missions will await you, friend."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 18 and player:getItemCount( 4840 ) >= 1
	end,
	function( player, parameters, self )
		player:removeItem( 4840, 1 )
		player:setStorageValue( Storages.Player.TheApeCity, 12 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Not right mushroom you have. Find me a witches' cap on Fibula!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 18
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Please try to find me a witches' cap on Fibula."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 18
	end
)

-- The Ape City
-- Mission 07: Destroying Casks

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"Mighty life charm is protecting us now! But my people are still in danger. Danger from within ...",
			"Some of my people try to mimic lizards to become strong. Like lizards did before, this cult drinks strange fluid that lizards left when fled ...",
			"Under the city still the underground temple of lizards is. There you find casks with red fluid. Take crowbar and destroy three of them to stop this madness. Are you willing to do that?"
		},
		talkstate = 13
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 12
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Hairycles sure you will make it. Good luck, friend."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 13
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 13 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You do please Hairycles again, friend. Me hope madness will not spread further now. Perhaps you are ready for other mission."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 13 and player:getStorageValue( Storages.Player.CasksDestroyed ) >= 3
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 14 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Please destroy three casks in the complex beneath Banuta, so my people will come to senses again."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 13
	end
)

-- The Ape City
-- Mission 08: Evidence of Holy Ape

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"Now that the false cult was stopped, we need to strengthen the spirit of my people. We need a symbol of our faith that ape people can see and touch ...",
			"Since you have proven a friend of the ape people I will grant you permission to enter the forbidden land ...",
			"To enter the forbidden land in the north-east of the jungle, look for a cave in the mountains east of it. There you will find the blind prophet ...",
			"Tell him Hairycles you sent and he will grant you entrance ...",
			"Forbidden land is home of Bong. Holy giant ape big as mountain. Don't annoy him in any way but look for a hair of holy ape ...",
			"You might find at places he has been, should be easy to see them since Bong is big ...",
			"Return a hair of the holy ape to me. Will you do this for Hairycles?"
		},
		talkstate = 14
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 14
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Hairycles proud of you. Go and find holy hair. Good luck, friend."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 14
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 15 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "You brought hair of holy ape?",
		talkstate = 15
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 15 and player:getStorageValue( Storages.Player.HolyApeHair ) == 1
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Get a hair of holy ape from forbidden land in east. Speak with blind prophet in cave."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 15
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Incredible! You got a hair of holy Bong! This will raise the spirit of my people. You are truly a friend. But one last mission awaits you."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 15 and player:getItemCount( 4843 ) >= 1
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.TheApeCity, 16 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "You no have hair. You lost it? Go and look again."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 15
	end,
	function( player, parameters, self )
		player:setStorageValue( Storages.Player.HolyApeHair, 0 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Go to forbidden land in east to find hair."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 15
	end
)

-- The Ape City
-- Mission 09: The Deeper Catacombs

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"You have proven yourself a friend, me will grant you permission to enter the deepest catacombs under Banuta which we have sealed in the past ...",
			"Me still can sense the evil presence there. We did not dare to go deeper and fight creatures of evil there ...",
			"You may go there, fight the evil and find the monument of the serpent god and destroy it with hammer me give to you ...",
			"Only then my people will be safe. Please tell Hairycles, will you go there?"
		},
		talkstate = 16
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 16
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Hairycles sure you will make it. Just use hammer on all that looks like snake or lizard. Tell Hairycles if you succeed with mission."
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 16
	end,
	function( player, parameters, self )
		player:addItem( 4846, 1 )
		player:setStorageValue( Storages.Player.TheApeCity, 17 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "Me know its much me asked for but go into the deepest catacombs under Banuta and destroy the monument of the serpent god."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 17 and player:getStorageValue( Storages.Player.SnakeHeadDestroyed ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = {
			"Finally my people are safe! You have done incredible good for ape people and one day even me brethren will recognise that ...",
			"I wish I could speak for all when me call you true friend but my people need time to get accustomed to change ...",
			"Let us hope one day whole Banuta will greet you as a friend. Perhaps you want to check me offers for special friends."
		}
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 17 and player:getStorageValue( Storages.Player.SnakeHeadDestroyed ) == 1
	end,
	function( player, parameters, self )
		player:updateAchievement( 49 ) -- Friend of the Apes
		player:setStorageValue( Storages.Player.TheApeCity, 18 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "No more missions await you right now, friend. Perhaps you want to check me {offers} for special friends... or {shamanic powers}."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 18 and player:getStorageValue( Storages.Player.ShamanicPower ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "mission" },
		reply = "No more missions await you right now, friend. Perhaps you want to check me {offers} for special friends."
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 18
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "shamanic", "powers" },
		reply = "Me truly proud of you, friend. You learn many about plants, charms and ape people. Me want grant you shamanic power now. You ready?",
		talkstate = 17
	},
	function( player, parameters, self )
		return player:getStorageValue( Storages.Player.TheApeCity ) == 18 and player:getStorageValue( Storages.Player.ShamanicPower ) == 0
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = "Friend of the ape people! Take my gift and become me apprentice! Here is shaman clothing for you!"
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 17
	end,
	function( player, parameters, self )
		player:addOutfit( 158, 0 )
		player:addOutfit( 154, 0 )
		player:getPosition():sendMagicEffect( CONST_ME_MAGIC_BLUE )
		player:setStorageValue( Storages.Player.ShamanicPower, 1 )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Me sad. Please reconsider."
	},
	function( player, parameters, self )
		return isInArray( { 13, 14, 16, 17 }, self:getTalkState( player:getId() ) )
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "Me sad. Me expected better from you!"
	},
	function( player, parameters, self )
		return isInArray( { 5, 6, 8, 10, 12 }, self:getTalkState( player:getId() ) )
	end,
	function( player, parameters, self )
		self:setIdle( player:getId() )
		return true
	end
)
