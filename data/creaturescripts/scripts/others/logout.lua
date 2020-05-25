function onLogout(player)
	if player:getStorageValue(STORAGEVALUE_EVENTS) >= 1 then
		player:sendTextMessage(MESSAGE_INFO_DESCR, "Voc� n�o pode deslogar enquanto estiver dentro de um evento.")
		return false
	end
	player:say("Nois que v�a brux�um!", TALKTYPE_MONSTER_SAY)
	player:saveSpecialStorage()
	local playerId = player:getId()
	if nextUseStaminaTime[playerId] then
		nextUseStaminaTime[playerId] = nil
	end
	return true
end
