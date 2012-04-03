require 'sinatra/base'
require 'sinatra/flash/storage'
require 'sinatra/flash/style'


module Sinatra
  module Flash
    
    def self.registered(app)
      app.helpers Flash::Storage
      app.helpers Flash::Style

      # This callback rotates any flash structure we referenced, placing the 'next' hash into the session
      # for the next request.
      app.after do
        @flash.each{|key, flash| session[key] = @flash[key].next} if @flash
        session.delete :flash if session[:flash] == {}
      end
    end
  end

  register Flash
end