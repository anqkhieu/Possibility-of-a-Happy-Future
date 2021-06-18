local ResponsesButton = script:GetCustomProperty("ResponsesButton")
local NPC = script:GetCustomProperty("NPC"):WaitForObject()

local dgBox = script.parent
local player = Game.GetLocalPlayer()
local dgIndex = 1
local dgBackward = false


dialogue = {
	{text = "Here we are! Welcome to Prideland.", 
		reply={'Beautiful!'}, 
		animation='unarmed_talk_listen_casual'},
	{text = "Meet my friend, Min! \nHe doesn't talk much, but he does all the paperwork for this place. (Min grunts.)", 
		reply={'<Next>'},
		animation='unarmed_talk_casual'},
	{text = "In Prideland, there's lots of people to meet... and minigames to play!", 
		reply={'Why are you out here?'},
		animation='unarmed_talk_casual'},
	{text = "One of my old partners really loves trivia. \nThey're inside sitting by the table if you want to give it a go!", 
		reply={'<Next>'},
		animation='unarmed_talk_casual'},		
	{text = "It's 100% worth it to come talk with people. \nIf you impress them, they might give you coins.", 
		reply={'Coins?', 'Yesss, money!'},
		animation='unarmed_talk_listen_casual'},
	{text = "Coins are used to upgrade your fashion and more! \nMin, for example, is willing to trade 10 coins for wingsss!", 
		reply={'For what?!'},
		animation='unarmed_wave'},
	{text = "Yes, FLIGHT! Min will use his magical powers to grant you the ability to fly.", 
		reply={'Sounds dangerous!', 'Holy smokes...'},
		animation='unarmed_thumbs_up',
		confirm=true},
	{text = "So watcha waiting for, " .. player.name .. "! Start exploring Prideland.", 
		reply ={'Thanks Mace!', 'Nice to meet you, Min.'},
		animation='unarmed_talk_listen_casual'}
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
		
	dgIndex = dgIndex + 1	
	if dgBackward == true then 
		dgIndex = dgIndex - 1 
		dgBackward = false
	end 
	
	if dgIndex <= #dialogue then 
		ConverseNPC(dgIndex) 
	else 
		Events.Broadcast("EndScene")
	end
	
end

function Init()
	UI.SetCanCursorInteractWithUI(true)
	UI.SetCursorVisible(true) 
	Events.Connect("PlayerReply", NextDialogue) 
	ConverseNPC(1)
end 


Events.Connect("ActivateScene", Init)



