require 'rubygems'
require 'gosu'
require './zorder'

module Froggy
	class GameWindow < Gosu::Window
		attr_accessor :level
		attr_accessor :score

		def initialize
			super(1024, 768, false)
			self.caption = "Froggy the Frog"
			@score = 0
		end

		def update
			@level.update
		end

		def draw
			@level.background_image.draw(0, 0, ZOrder::Background)
			@level.draw
		end

	end
end