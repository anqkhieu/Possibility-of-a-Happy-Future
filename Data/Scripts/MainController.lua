local ResponsesButton = script:GetCustomProperty("ResponsesButton")
local NPC = script:GetCustomProperty("NPC"):WaitForObject()

local dgBox = script.parent
local player = Game.GetLocalPlayer()
local dgIndex = 1
local dgBackward = false


dialogue = {
	{text = "Oh, are you lost?", 
		reply={'I am never not!', 'Yes, I am lost in your eyes.'}, 
		animation='unarmed_talk_listen_casual'},
	{text = "Geez! Seems like the one thing you didn't lose was your humor!", 
		reply={'<Next>'},
		animation='unarmed_laugh'},
	{text = "No, but seriously buddy, I really don't stumble onto many people out here. \nI'm surprised to find you!", 
		reply={'Why are you out here?'},
		animation='unarmed_talk_casual'},
	{text = "I come out here for the stars and the quiet, but I was just about to head back to Prideland.", 
		reply={'<Next>'},
		animation='unarmed_talk_casual'},		
	{text = "You're welcome to come with! Especially you're feeling lost... \nA lot of people are still trying to figure out life, themselves, and Adulting.", 
		reply={'Alright, I will come with!', 'Yep, sounds relateable.'},
		animation='unarmed_talk_listen_casual'},
	{text = "My name's Mace by the way. How about you?", 
		reply={player.name},
		animation='unarmed_wave'},
	{text = "That's a beautiful name! May I ask you your pronouns?", 
		reply={'She/Her', 'He/Him', 'They/Them', 'No / Still figuring that out!'},
		animation='unarmed_thumbs_up',
		confirm=true},
	{text = "Anyway, nice to meet you, " .. player.name .. "! Hope you're ready for my driving.", 
		reply ={'Adventure time!', 'Thanks Mace.'},
		animation='unarmed_ready_to_rumble'}
}


function UpdateDialogue(arg)
	if type(arg) == 'number' then dgBox.text = dialogue[arg].text
	else dgBox.text = arg end
end

function UpdateReplies(i)
	for _,v in ipairs(script.parent:GetChildren()) do if v ~= script then v:Destroy() end end
	local choiceTable = nil
	if type(i) == 'number' then choiceTable = dialogue[i]['reply']
	else choiceTable = i end
	
	for j = 1, #choiceTable do 
		choiceButton = World.SpawnAsset(ResponsesButton, {parent = script.parent})
		choiceButton.y = (j * 85) - (#choiceTable * choiceButton.height) - 40 
		choiceButton.text = choiceTable[j]
	end
end

function ConverseNPC(index, text, reply, animation)
	if index == nil then 
		UpdateDialogue(text)
		UpdateReplies(reply)
		NPC:PlayAnimation(animation, {playbackRate = 0.75})
	else 
		UpdateDialogue(index)
		UpdateReplies(index)
		NPC:PlayAnimation(dialogue[index]['animation'], {playbackRate = 0.75})
	end
end 

function NextDialogue(reply)
	print(reply)
	
	if dialogue[dgIndex]['confirm'] == true then 
		if reply == 'She/Her' then 
			ConverseNPC(nil, 'Girls night out, it is! \nI go by she/they by the way. Both work!', {'<Next>'}, 'unarmed_talk_casual')
		elseif reply == 'He/Him' then 
			ConverseNPC(nil, 'Dude, get ready for the time of your life! \nI go by she/they by the way. Both work!', {'<Next>'}, 'unarmed_talk_listen_casual')		
		elseif reply == 'They/Them' then
			ConverseNPC(nil, 'Cool. Ready for the time of your life, my friend? \nI go by she/they by the way. Both work!', {'<Next>'}, 'unarmed_talk_casual')
		elseif reply == 'No / Still figuring that out!' then 
			ConverseNPC(nil, 'Respect! My pronouns are she/they by the way.', {'<Next>'}, 'unarmed_talk_casual')
		end
		dgIndex = dgIndex + 1
		dgBackward = true
		return 
	end 
	
	dgIndex = dgIndex + 1	
	if dgBackward == true then 
		dgIndex = dgIndex - 1 
		dgBackward = false
	end 
	
	if dgIndex <= #dialogue then 
		ConverseNPC(dgIndex) 
	else 
		player:TransferToGame('f5bde4/prideland-the-prologue')
	end
	
end

function Init()
	ConverseNPC(dgIndex)
	UI.SetCanCursorInteractWithUI(true)
	UI.SetCursorVisible(true) 
	
	Events.Connect("PlayerReply", NextDialogue) 
end 


Init()



