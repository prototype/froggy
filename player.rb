require 'rubygems'
require 'gosu'

require './zorder'

module Froggy
	class Player
		JUMP_HEIGHT = 20
		SUPER_JUMP_HEIGHT = 30

		attr_accessor :jump_height
		attr_accessor :level

		attr_accessor :x
		attr_accessor :y

		attr_accessor :x_velocity

		attr_accessor :sprite_height
		attr_accessor :sprite_width

		def initialize(level)
			@level = level

			@x_velocity = 10
			@sprite_width = 0
			@sprite_height = 0


			@x = 0
			@y = @level.height - 100
		end

		def jumping?
			@y > (@level.height - SUPER_JUMP_HEIGHT)
		end

		def update
			w = @level.window

			if w.button_down?(Gosu::KbLeft) && @x > 0
				@x -= @x_velocity
			end

			if w.button_down?(Gosu::KbRight) && @x <= (@level.width - @sprite_width)
				@x += @x_velocity
			end

			if w.button_down?(Gosu::KbUp) && !jumping?
				# Jump!
			end

			if w.button_down?(Gosu::KbSpace)
				# Fire
			end
		end

		def draw
			raise "Must be overridden in subclass!"
		end
	end

	class FroggyPlayer < Player
		def initialize(level)
			super(level)

			@sprite_width = 109
			@sprite_height = 100

			@body_sprite = Gosu::Image.new(level.window,
				'./img/froggy_body.png',
				false,
				0,
				0,
				49,
				77
			)
			@legs_sprite = Gosu::Image.new(level.window,
				'./img/froggy_legs.png',
				false,
				0,
				0,
				109,
				50
			)

			@y = @level.height - @sprite_height
		end

		def draw
			@body_sprite.draw(@x, @y, ZOrder::Player)
		end
	end
end