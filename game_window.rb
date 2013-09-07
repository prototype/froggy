require 'rubygems'
require 'gosu'
require './game_level'
require './zorder'
require './player'

module Froggy
	class GameWindow < Gosu::Window
		attr_accessor :level
		attr_accessor :player

		def initialize
			super(1024, 768, false)
			@level = Level1.new(self)
			@player = FroggyPlayer.new(@level)
		end

		def update
			@player.update
			@level.update
		end

		def draw
			@level.background_image.draw(0, 0, ZOrder::Background)
			@level.draw
			@player.draw
		end
	end
end