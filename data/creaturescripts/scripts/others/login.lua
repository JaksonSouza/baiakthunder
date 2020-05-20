function onLogin(player)
	local loginStr = "Bem-vindo ao " .. configManager.getString(configKeys.SERVER_NAME) .. "!"
	if player:getLastLoginSaved() <= 0 then
		loginStr = loginStr .. " Por favor escolha sua roupa."
		player:sendOutfitWindow()
	else
		if loginStr ~= "" then
			player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)
		end

		loginStr = string.format("Sua �ltima visita foi em %s.", os.date("%a %b %d %X %Y", player:getLastLoginSaved()))
	end
	player:sendTextMessage(MESSAGE_STATUS_DEFAULT, loginStr)

	-- Stamina
	nextUseStaminaTime[player.uid] = 0

	-- Dodge/Critical System
	if player:getDodgeLevel() == -1 then
		player:setDodgeLevel(0) 
	end
	if player:getCriticalLevel() == -1 then
		player:setCriticalLevel(0) 
	end
	
	player:loadSpecialStorage()
	
	-- Promotion
	local vocation = player:getVocation()
	local promotion = vocation:getPromotion()
	if player:isPremium() then
		local value = player:getStorageValue(STORAGEVALUE_PROMOTION)
		if not promotion and value ~= 1 then
			player:setStorageValue(STORAGEVALUE_PROMOTION, 1)
		elseif value == 1 then
			player:setVocation(promotion)
		end
	elseif not promotion then
		player:setVocation(vocation:getDemotion())
	end

	-- Events
	player:registerEvent("PlayerDeath")
	player:registerEvent("AnimationUp")
	player:registerEvent("DropLoot")
	player:registerEvent("HungerGames")
	player:registerEvent("DodgeSystem")
	player:registerEvent("CriticalSystem")
	player:registerEvent("AutoLoot")
	return true
end
