require 'telegram/bot'
require 'pry'
require 'httparty_with_cookies'

class Httparty_With_Cookies
    include HTTParty_with_cookies
end

token = '455098435:AAFLPOGWe6Diw0QU27Vp7nyMk4sg5khKQlg'
api = Httparty_With_Cookies.new
Telegram::Bot::Client.run(token) do |bot|
	bot.listen do |message|
	case message.text
  	when '/start'
  		bot.api.send_message(chat_id: message.chat.id, text: message.from.first_name+", como vai? Esse é um bot educativo, para fins da OpenChallenge.")
		when '/campuserorobot'
			bot.api.send_message(chat_id: message.chat.id, text: "Consultando https://campuse.ro/api/v1/campuserorobot (É Pública, pode jogar no navegador)")
			response = api.get('https://campuse.ro/api/v1/campuserorobot')
			#binding.pry
			bot.api.send_message(chat_id: message.chat.id, text: response.parsed_response.to_s)
		when '/me'
			bot.api.send_message(chat_id: message.chat.id, text: "Consultando https://campuse.ro/api/v1/me (Essa precisa de permissão!)")
			response = api.get('https://campuse.ro/api/v1/me')
			binding.pry
			if response.code == 200
			     bot.api.send_message(chat_id: message.chat.id, text: response)
           api = Httparty_With_Cookies.new
      else
          bot.api.send_message(chat_id: message.chat.id, text: "Não estamos logados, digita /logar_como_o_CampuseroRobot")
      end
		when '/logar_como_o_CampuseroRobot'
			response = api.get('https://campuse.ro')
			bot.api.send_message(chat_id: message.chat.id, text: "Logando em https://campuse.ro/login ... (O pulo do gato...)")
			response = api.post('https://campuse.ro/login', :body => "------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"username\"\r\n\r\ncontato@prte.com.br\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"password\"\r\n\r\ncampuserorobot\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW\r\nContent-Disposition: form-data; name=\"csrfmiddlewaretoken\"\r\n\r\n"+api.cookies['csrftoken']+"\r\n------WebKitFormBoundary7MA4YWxkTrZu0gW--", :headers => {'Content-Type' => 'application/x-www-form-urlencoded', 'content-type' => 'multipart/form-data; boundary=----WebKitFormBoundary7MA4YWxkTrZu0gW'})

			#binding.pry
			if response.code == 200
				bot.api.send_message(chat_id: message.chat.id, text: "Pronto, logamos, tenta aí um /me")
			else
				bot.api.send_message(chat_id: message.chat.id, text: "Algo deu errado, paciência... é experimental...")
			end
		else
			bot.api.send_message(chat_id: message.chat.id, text: message.from.first_name+", você digitou algo.")
  	end
  end
end
