-- example of button click and hover events.
-- Should be in client context, as buttons would generally be per-player
local button = script.parent

function OnClicked(whichButton)
	Events.Broadcast("PlayerReply", whichButton.text)
end

function OnHovered(whichButton)
	--print("button hovered: " .. whichButton.name)
end

function OnUnhovered(whichButton)
	--print("button unhovered: " .. whichButton.name)
end

button.clickedEvent:Connect(OnClicked)
button.hoveredEvent:Connect(OnHovered)
button.unhoveredEvent:Connect(OnUnhovered)
