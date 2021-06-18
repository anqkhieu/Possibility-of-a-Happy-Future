local trigger = script.parent

function OnInteracted(whichTrigger, other)
	if other:IsA("Player") then
		print('interacting')
		Events.BroadcastToPlayer(other, "TriviaOn")
	end
end

trigger.interactedEvent:Connect(OnInteracted)

function OnEndOverlap(whichTrigger, other)
	if other:IsA("Player") then
		print(whichTrigger.name .. ": End Trigger Overlap with " .. other.name)
		Events.BroadcastToPlayer(other, "TriviaOff")
	end
end


trigger.endOverlapEvent:Connect(OnEndOverlap)


