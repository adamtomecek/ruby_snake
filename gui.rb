require 'rubygems'
require 'bundler/setup'

Bundler.require(:default)

require_relative 'lib/snake'
require_relative 'lib/game'
require_relative 'lib/terminal_renderer'
require_relative 'lib/gui_renderer'

GuiRenderer.new(Game.new)
