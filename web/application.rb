require 'sinatra'
require 'compass'
require 'haml'
require 'zurb-foundation'

module Web
  class Application < Sinatra::Base
    configure do
      set :root, Web.root
      set :views, File.join(root, 'views')
      set :public_folder, File.join(root, 'public')
      set :haml, { :format => :html5, :escape_html => true }
      set :scss, { :style => :compact, :debug_info => false }
      Compass.add_project_configuration(File.join(Sinatra::Application.root, "config", "compass.rb"))
    end

    get '/stylesheets/:name.css' do
      content_type 'text/css', :charset => 'utf-8'
      scss(:"stylesheets/#{params[:name]}" )
    end

    get '/' do
      haml :index
    end
  end
end
