-- example of button click and hover events.
-- Should be in client context, as buttons would generally be per-player
local button = script.parent

function OnClicked(whichButton)
	print("button clicked: " .. whichButton.name)
	Events.Broadcast('AnswerChosen', whichButton.text)
end

button.clickedEvent:Connect(OnClicked)
