local triviaUI = script:GetCustomProperty("TriviaUI"):WaitForObject()
local buttonPanel = script:GetCustomProperty("ButtonPanel"):WaitForObject()
local questionPanel = script:GetCustomProperty("QuestionPanel"):WaitForObject()
local questionButton = script:GetCustomProperty("QuestionButton"):WaitForObject()
local coinSFX = script:GetCustomProperty("CoinSFX"):WaitForObject()
local errorSFX = script:GetCustomProperty("ErrorSFX"):WaitForObject()


local trivia = {
	{Q='What was the first country to make gay marriage legal?',
		PA={'Denmark','United States','Finland','Sweden'},
		CA='Denmark'
	},
	{Q='Where did the Stonewall Riots occur?',
		PA={'New York City', 'Pallet Town', 'San Francisco','Florida'},
		CA='New York City'
	},
	{Q='Which color is a part of the asexuality flag?',
		PA={'Red','Pink','Yellow','Black'},
		CA='Black',
	},
	{Q='What was the first state to outlaw discrimination based on sexual orientation?',
		PA={'Cailfornia','Texas','Wisconsin','New York'},
		CA='Wisconsin'
	},
	{Q='What is a genderless term that can refer LGBT people? ',
		PA={'Queer','Gay','Asexual','Pan'},
		CA='Queer'
	},
	{Q='What Greek letter symbolizes gay and lesbian activism?',
		PA={'Lambda','Alpha','Delta', 'Theta'},
		CA='Lambda'
	}
}
	
function startTrivia() 
	print('client starting trivia')
	triviaUI.visibility = Visibility.FORCE_ON
	UI.SetCanCursorInteractWithUI(true)
	UI.SetCursorVisible(true) 
	nextTrivia()
end

function nextTrivia()
	rand = math.random(1, #trivia)
	question = trivia[rand]['Q']
	correctAnswer = trivia[rand]['CA']
	
	shuffle(trivia[rand]['PA'])
	
	for k,button in ipairs(buttonPanel:GetChildren()) do 
		button.text = trivia[rand]['PA'][k]
	end
	
	questionButton.text = '     Q: ' .. trivia[rand]['Q']
end 

function checkAnswer(ans)
	local player = Game.GetLocalPlayer()
	if ans == correctAnswer then 
		UI.ShowFlyUpText('Correct!', player:GetWorldPosition(), {color=Color.GREEN, isBig=true, duration=1})
		Events.Broadcast('GoldChange', 1)
		coinSFX:Play()
	else 
		UI.ShowFlyUpText('Wrong...', player:GetWorldPosition(), {color=Color.RED, isBig=true, duration=1})
		errorSFX:Play()
	end 
	Task.Wait(0.2)
	nextTrivia()
end 

function shuffle(tbl)
	for i = #tbl, 2, -1 do
		local j = math.random(i)
    	tbl[i], tbl[j] = tbl[j], tbl[i]
	end
	return tbl
end


function endTrivia()
	print('ending trivia')
	triviaUI.visibility = Visibility.FORCE_OFF
	UI.SetCanCursorInteractWithUI(false)
	UI.SetCursorVisible(false) 
end

Events.Connect("TriviaOn", startTrivia)
Events.Connect("TriviaOff", endTrivia)
Events.Connect("AnswerChosen", checkAnswer)