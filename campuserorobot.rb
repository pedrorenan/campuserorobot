require 'telegram/bot'

token = 'seu_token_aqui'

Telegram::Bot::Client.run(token) do |bot|
	bot.listen do |message|
	case message.text
  	when '/start'
  		bot.api.send_message(chat_id: message.chat.id, text: message.from.first_name+", como vai? Esse é um bot educativo, para fins da OpenChallenge.")
		else
			bot.api.send_message(chat_id: message.chat.id, text: message.from.first_name+", você digitou algo.")
  	end
  end
end
