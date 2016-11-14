class MessengerController < ApplicationController
	require 'json'
	require 'httparty'
	include MessengerHelper

	def receive_message
		checkFacebookToken()
 		$webhook = JSON.parse(request.raw_post)
 		@recipient = $webhook["entry"][0]["messaging"][0]["sender"]["id"]
 		@userText = $webhook["entry"][0]["messaging"][0]["message"]["text"].downcase
 		@positiveResponses = ["thats grrrreaat", "Thats Awesome!", "Yay! No Homework!", "Finally, a break from some homework", "Awesome. Just what i needed to hear.", "Yay. Some good news today.", "thats almost better than harry potter", "time to celebrate, come on!"]
		@negativeResponses = ["booooo.", "what a shame." "ugh. That stinks.", "your teacher needs to chill out on the homework", "That's so sad to hear", "that sucks, at least you look good today.", "that sucks more than a vacuum", "thats worse than when Dumbledore died."]
 		currentClasses = Grouparray.all

 		#@checkUserExists = Messagehuman.checkUserExists(@recipient)
 		#Messagehuman.sendButton(@recipient) if User.find_by(conversation_id: @recipient).nil? && @checkUserExists == false
 		#@checkUserExists = Messagehuman.checkUserExists(@recipient)
 		#Messagehuman.sendMessage(@recipient, @checkUserExists)

 		currentClasses.each do |group|
 			randomNum = rand(0..7)
 			if group.conversation_id == @recipient
 				if @userText == "yes"
 					Messagehuman.sendMessage(group.conversation_id, @negativeResponses[randomNum])
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name, group_day: group.group_day, end_time: group.end_time)
 					@group.update(homework_assigned: true)
 				elsif @userText == "no"
=begin
 					Messagehuman.sendMessage(group.conversation_id, @positiveResponses[randomNum])
 					@groupArrayGroup = Grouparray.find_by(id: group.id)
 					@groupArrayGroup.destroy
 					@group = Group.find_by(conversation_id: group.conversation_id, group_name: group.group_name)
 					@group.update(homework_assigned: false)
=end
 				else
 					
 				end
 			end
 		end
 	end

 	def check_token
 		checkFacebookToken()
 	end

 	def webhook_inspect
 		@user = User.find_by(conversation_id: '134381003642835')
 	end
 
end