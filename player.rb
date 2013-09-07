require 'rubygems'
require 'gosu'

module Froggy
	class Player
		JUMP_HEIGHT = 20
		SUPER_JUMP_HEIGHT = 30

		attr_accessor :jump_height
		attr_accessor :level

		attr_accessor :x
		attr_accessor :y

		def initialize(level)
			@level = level

			@x = 0
			@y = 0
		end

		def jumping?
			@y > (@level.height - SUPER_JUMP_HEIGHT)
		end

		def update
			w = @level.window
			if w.button_down?(Gosu::KbLeft) && @x > 0
				x -= 1
			end

			if w.button_down?(Gosu::KbRight) && @x < @level.width
				x += 1
			end

			if w.button_down?(Gosu::KbUp) && !jumping?
				# Jump!
			end

			if w.button_down?(Gosu::KbSpace)
				# Fire
			end
		end

		def draw
		end
	end

	class Froggy < Player
		def initialize(level)
			super(level)
			@froggy_body_sprite = Gosu::Image.new(level.window,
				'./img/froggy_body.png',
				false,
				0,
				0,
				49,
				77
			)
			@froggy_body_sprite = Gosu::Image.new(level.window,
				'./img/froggy_legs.png',
				false,
				0,
				0,
				109,
				50
			)
		end
	end
end