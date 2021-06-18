local player = Game.GetLocalPlayer()
local Cameras = script:GetCustomProperty("Cameras"):WaitForObject()
local DialogueUI = script:GetCustomProperty("DialogueUI"):WaitForObject()

function PlayScene(sceneNum)
	print('Play Scene')
	local newCamera = Cameras:GetChildren()[sceneNum]
	print(newCamera.name)
	player:SetOverrideCamera(newCamera, 2)
	DialogueUI.visibility = Visibility.FORCE_ON
end

function EndScene()
	player:ClearOverrideCamera(3)
	DialogueUI.visibility = Visibility.FORCE_OFF
	UI.SetCanCursorInteractWithUI(false)
	UI.SetCursorVisible(false) 
end

Events.Connect("ActivateScene", PlayScene)
Events.Connect("EndScene", EndScene)