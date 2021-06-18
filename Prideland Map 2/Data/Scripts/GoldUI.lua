function OnResourceChanged(player, resourceId, newValue)
	print('resource changed')
	if resourceId == 'Gold' then 
		script.parent.text = 'Gold: ' .. tostring(newValue)
	end
end

local player = Game.GetLocalPlayer()
player.resourceChangedEvent:Connect(OnResourceChanged)

function ChangeGold(val)
	oldValue = tonumber(string.sub(tostring(script.parent.text),7,-1))
	script.parent.text = 'Gold: ' .. tostring(oldValue + val)
	
	if oldValue + val >= 10 then 
		Events.BroadcastToServer(player, "Fly")
	end
end

Events.Connect("GoldChange", ChangeGold)