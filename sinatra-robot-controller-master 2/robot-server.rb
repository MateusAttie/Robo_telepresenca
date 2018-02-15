require 'sinatra'
require 'socket'
require 'rack/mobile-detect'

use Rack::MobileDetect

set :bind, '0.0.0.0'
set :port, 4567

port = 8090

puts "digite o ip do robô ou deixe em branco para modo de teste"
hostname = gets.chomp

hostname = 'localhost' if hostname.empty?

s = TCPSocket.open(hostname, port)

helpers do
  def get_layout
    @layout_default = ( request.env['X_MOBILE_DEVICE'] ? :layout_mobile : true )
  end
end

before do
  get_layout()
end

get '/' do
  erb  :althome, :layout => @layout_default
end

get '/old' do
  erb  :home
end

post '/:com' do
  case params[:com]
  when "codehere40"
    s.print "back"
  when "codehere39"
    s.print "right"
  when "codehere38"
    s.print "front"
  when "codehere37"
    s.print "left"
  when "stahp"
    s.print "stop"
  end
end

error Sinatra::NotFound do
  @pname = request.path_info[1, request.path_info.length]
  erb  :fourofour
end
