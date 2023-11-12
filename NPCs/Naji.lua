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
		reply = "Welcome to the Tibian bank, %N! What can I do for you?"
	}
)

npc:addAliasKeyword( { "hello$" } )

npc:addAction(
	ACTION_VANISH,
	{
		reply = "Good bye."
	}
)

npc:addAction(
	ACTION_FAREWELL,
	{
		keywords = { "bye" },
		reply = "Good bye."
	}
)

npc:addAliasKeyword( { "farewell" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "job" },
		reply = "I work in this bank. I can change money for you and help you with your bank account."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "name" },
		reply = "My name is Naji. My mother gave me that name because she knew a Paladin with that name. I'm a spare timer hunter by myself, you know! I want to join the Paw and Fur - hunting elite!"
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "paw" },
		reply = "The Paw and Fur – Hunting Elite is a newly founded hunting society in Port Hope. It is said that they send you on hunting mission. Sounds great if you ask me."
	}
)

npc:addAliasKeyword( { "hunting" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "time" },
		reply = "It is exactly 11:35 am."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "bored" },
		reply = "Okay okay, no need to be rude! It seems you already know everything."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "buy" },
		reply = "We can change money for you. You can also access your bank account or your guild account options."
	}
)

npc:addAliasKeyword( { "sell" } )
npc:addAliasKeyword( { "offer" } )
npc:addAliasKeyword( { "do", "you", "have" } )

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "money" },
		reply = "We can change money for you. You can also access your bank account or your guild account options."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "bank", "account$" },
		reply = {
			"Every citizen has one. The big advantage is that you can access your money in every branch of the Global Bank! ...",
			"Would you like to know more about the {basic} functions of your bank account, the {advanced} functions, or are you already bored, perhaps?"
		}
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "rent$" },
		reply = {
			"Renting a house has never been this easy. Simply make a bid for an auction. We will check immediately if you have enough money ...",
			"Please keep in mind that the sum you have used to bid will be unavailable unless somebody places a higher bid. Once you have acquired a house the rent will be charged automatically from your bank account every month."
		}
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "advanced$" },
		reply = "Your bank account will be used automatically when you want to {rent} a house. Let me know if you want to know about how either one works."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "bank$" },
		reply = "We can change money for you. You can also access your bank account or your guild account options."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "basic$" },
		reply = "You can check the balance of your {bank account}, {deposit} money or {withdraw} it. You can also {transfer} money to other characters, provided that they have a vocation and are not on Rookgaard."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "guild", "balance$" },
		reply = nil
	},
	function( player, parameters, self )
		return player:getGuild()
	end,
	function( player, parameters, self )
		self:processSay( player:getId(), string.format( "Your guild account balance is %d gold.", player:getGuild():getBankBalance() ) )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "guild", "balance$" },
		reply = "You are not a member of a guild."
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "balance$" },
		reply = nil
	},
	function( player, parameters, self )
		if player:getBankBalance() >= 10000000 then
			self:processSay( player:getId(), string.format( "I think you must be one of the richest inhabitants of Tibia! Your account balance is %d gold.", player:getBankBalance() ) )
		elseif player:getBankBalance() >= 1000000 then
			self:processSay( player:getId(), string.format( "Wow, you've reached the magic number of one million gp! Your account balance is %d gold.", player:getBankBalance() ) )
		elseif player:getBankBalance() >= 100000 then
			self:processSay( player:getId(), string.format( "You certainly have made a pretty penny. Your account balance is %d gold.", player:getBankBalance() ) )
		else
			self:processSay( player:getId(), string.format( "Your account balance is %d gold.", player:getBankBalance() ) )
		end
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "deposit$" },
		reply = "Please tell me how much gold it is you would like to deposit.",
		talkstate = 100716
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "deposit", "%d+" },
		reply = nil,
		talkstate = 100717
	},
	nil,
	function( player, parameters, self, message )
		
		local count = self:getCount( message )
		if count == 0 then
			self:processSay( player:getId(), "You are joking, aren't you?" )
			self:setTalkState( player:getId(), 0 )
			return true
		elseif count >= 500000000 then
			self:processSay( player:getId(), "Sorry, but you can't deposit that much." )
			self:setTalkState( player:getId(), 0 )
			return true
		end
		
		self:processSay( player:getId(), string.format( "Would you really like to deposit %d gold?", count ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, count )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "deposit", "all" },
		reply = nil,
		talkstate = 100717
	},
	nil,
	function( player, parameters, self, message )
		
		local count = player:getMoney()
		if count <= 0 then
			self:processSay( player:getId(), "You are joking, aren't you?" )
			self:setTalkState( player:getId(), 0 )
			return true
		elseif count >= 500000000 then
			self:processSay( player:getId(), "Sorry, but you can't deposit that much." )
			self:setTalkState( player:getId(), 0 )
			return true
		end
		
		self:processSay( player:getId(), string.format( "Would you really like to deposit %d gold?", count ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, count )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "" },
		reply = nil,
		talkstate = 100717
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100716
	end,
	function( player, parameters, self, message )
		
		local count = self:getCount( message )
		if count <= 0 then
			self:processSay( player:getId(), "You are joking, aren't you?" )
			return true
		elseif count >= 500000000 then
			self:processSay( player:getId(), "Sorry, but you can't deposit that much." )
			return true
		end

		self:processSay( player:getId(), string.format( "Would you really like to deposit %d gold?", count ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, count )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = nil
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100717
	end,
	function( player, parameters, self, message )

		local count = self:getCustomState( player:getId(), STATE_BANKMONEY )
		if player:getMoney() >= count then
			player:removeMoney( count )
			player:setBankBalance( player:getBankBalance() + count )
			player:save()
			self:processSay( player:getId(), string.format( "Alright, we have added the amount of %d gold to your {balance}. You can {withdraw} your money anytime you want to.", count ) )
		else
			self:processSay( player:getId(), "You do not have enough gold." )
		end

		self:setCustomState( player:getId(), STATE_BANKMONEY, 0 )
		self:setCustomState( player:getId(), STATE_BANKPLAYER, nil )
	
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "withdraw$" },
		reply = "Please tell me how much gold it is you would like to withdraw.",
		talkstate = 100718
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "withdraw", "%d+" },
		reply = nil,
		talkstate = 100719
	},
	nil,
	function( player, parameters, self, message )
		
		local count = self:getCount( message )
		if count <= 0 then
			self:processSay( player:getId(), "Sure, you want nothing you get nothing!" )
			self:setTalkState( player:getId(), 0 )
			return true
		elseif count >= 500000000 then
			self:processSay( player:getId(), "Sorry, but you can't withdraw that much." )
			self:setTalkState( player:getId(), 0 )
			return true
		elseif count > player:getBankBalance() then
			self:processSay( player:getId(), "There is not enough gold on your account." )
			self:setTalkState( player:getId(), 0 )
			return true
		end
		
		self:processSay( player:getId(), string.format( "Are you sure you wish to withdraw %d gold from your bank account?", count ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, count )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "" },
		reply = nil,
		talkstate = 100719
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100718
	end,
	function( player, parameters, self, message )
		
		local count = self:getCount( message )
		if count <= 0 then
			self:processSay( player:getId(), "Sure, you want nothing you get nothing!" )
			self:setTalkState( player:getId(), 0 )
			return true
		elseif count >= 500000000 then
			self:processSay( player:getId(), "Sorry, but you can't withdraw that much." )
			self:setTalkState( player:getId(), 0 )
			return true
		elseif count > player:getBankBalance() then
			self:processSay( player:getId(), "There is not enough gold on your account." )
			self:setTalkState( player:getId(), 0 )
			return true
		end

		self:processSay( player:getId(), string.format( "Are you sure you wish to withdraw %d gold from your bank account?", count ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, count )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = nil
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100719
	end,
	function( player, parameters, self, message )

		local count = self:getCustomState( player:getId(), STATE_BANKMONEY )
		if player:getBankBalance() >= count then
			if Game.getMoneyWeight( count ) > player:getFreeCapacity() then
				self:processSay( player:getId(), "Whoah, hold on, you have no room in your inventory to carry all those coins. I don't want you to drop it on the floor, maybe come back with a cart!" )
				self:setTalkState( player:getId(), 0 )
			else
				player:addMoney( count )
				player:setBankBalance( player:getBankBalance() - count )
				player:save()
				self:processSay( player:getId(), string.format( "Here you are, %d gold. Please let me know if there is something else I can do for you.", count ) )
				self:setTalkState( player:getId(), 0 )
			end
		else
			self:processSay( player:getId(), "There is not enough gold on your bank account." )
			self:setTalkState( player:getId(), 0 )
		end

		self:setCustomState( player:getId(), STATE_BANKMONEY, 0 )
		self:setCustomState( player:getId(), STATE_BANKPLAYER, nil )
	
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "no" },
		reply = "As you wish. Is there something else I can do for you?"
	},
	function( player, parameters, self )
		return isInArray( { 100717, 100719 }, self:getTalkState( player:getId() ) )
	end,
	function( player, parameters, self, message )
		self:setCustomState( player:getId(), STATE_BANKMONEY, 0 )
		self:setCustomState( player:getId(), STATE_BANKPLAYER, nil )
		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "transfer$" },
		reply = "Please tell me the amount of gold you would like to transfer.",
		talkstate = 100755
	}
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "%d+" },
		reply = nil,
		talkstate = 100756
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100755
	end,
	function( player, parameters, self, message )
		
		local count = self:getCount( message )
		if count <= 0 then
			self:processSay( player:getId(), "Please think about it. Okay?" )
			return true
		elseif count >= 500000000 then
			self:processSay( player:getId(), "Sorry, but you can't transfer that much." )
			return true
		elseif count > player:getBankBalance() then
			self:processSay( player:getId(), "There is not enough gold on your account." )
			return true
		end

		self:processSay( player:getId(), string.format( "Who would you like transfer %d gold to?", count ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, count )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "%s+" },
		reply = nil,
		talkstate = 100757
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100756
	end,
	function( player, parameters, self, message )
	
		local player_name = message
		local player_id = 0
		
		local target = Player( player_name )
		if target then
			player_name = target:getName()
			player_id = target:getGuid()
		else
			local resultId = db.storeQuery( string.format( "SELECT `id`, `name` FROM `players` WHERE `name` = %s;", db.escapeString( player_name ) ) )
			if resultId ~= false then
				player_name = result.getDataString( resultId, "name" )
				player_id = result.getDataInt( resultId, "id" )
				result.free( resultId )
			else
				self:processSay( player:getId(), "This player does not exist." )
				return true
			end
		end

		self:processSay( player:getId(), string.format( "So you would like to transfer %d gold to %s?", self:getCustomState( player:getId(), STATE_BANKMONEY ), player_name ) )
		self:setCustomState( player:getId(), STATE_BANKPLAYER, player_id )

		return true
	end
)

npc:addAction(
	ACTION_KEYWORD,
	{
		keywords = { "yes" },
		reply = nil
	},
	function( player, parameters, self )
		return self:getTalkState( player:getId() ) == 100757
	end,
	function( player, parameters, self, message )

		local money_count = self:getCustomState( player:getId(), STATE_BANKMONEY )	
		if money_count > player:getBankBalance() then
			self:processSay( player:getId(), "There is not enough gold on your account." )
			return true
		end
	
		local player_name = message
		local player_id = self:getCustomState( player:getId(), STATE_BANKPLAYER )

		local target = Player( player_id )
		if target then

			player_name = target:getName()
			player_id = target:getGuid()

			player:setBankBalance( player:getBankBalance() - money_count )
			player:save()
			
			target:setBankBalance( target:getBankBalance() + money_count )
			target:save()
			
		else

			local resultId = db.storeQuery( string.format( "SELECT `id`, `name` FROM `players` WHERE `id` = %s;", db.escapeString( player_id ) ) )
			if resultId ~= false then
				player_name = result.getDataString( resultId, "name" )
				player_id = result.getDataInt( resultId, "id" )
				result.free( resultId )
			else
				self:processSay( player:getId(), "This player does not exist." )
				return true
			end
			
			player:setBankBalance( player:getBankBalance() - money_count )
			player:save()

			db.query( string.format( "UPDATE `players` SET `balance` = ( `balance` + %d ) WHERE `id` = %s;", money_count, player_id ) )

		end

		self:processSay( player:getId(), string.format( "You have transferred %d gold to %s.", money_count, player_name ) )
		self:setCustomState( player:getId(), STATE_BANKMONEY, 0 )
		self:setCustomState( player:getId(), STATE_BANKPLAYER, nil )
	
		return true
	end
)
