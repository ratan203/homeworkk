class MessengerController < Messenger::MessengerController
	require 'json'
  def webhook
  	$webhook = JSON.parse(request.raw_post)

    #logic here
  	if fb_params.first_entry.callback.message?
  		Messenger::Client.send(
    		Messenger::Request.new(
      		Messenger::Elements::Text.new(text: 'some text'),
      		fb_params.first_entry.sender_id
    		)
  		)
		end

    render nothing: true, status: 200
  end

  def webhook_inspect
  end
end