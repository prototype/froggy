require 'rubygems'
require 'gosu'

require './zorder'

module Froggy
	class Player
		JUMP_HEIGHT = 400
		SUPER_JUMP_HEIGHT = 30

		attr_accessor :jump_height
		attr_accessor :level

		attr_accessor :x
		attr_accessor :y

		attr_accessor :x_velocity
		attr_accessor :y_velocity

		attr_accessor :sprite_height
		attr_accessor :sprite_width

		def initialize(level)
			@level = level

			@x_velocity = 10
			@y_velocity = 20

			@sprite_width = 0
			@sprite_height = 0


			@jumping = false

			@x = (@level.width / 2).to_i
			@y = @level.height - 100
		end

		def jumping?
			@jumping
			#@y + @sprite_height < @level.height
		end

		def grounded?
			@y + @sprite_height >= @level.height
		end

		def can_jump?
			!jumping?
		end

		def want_to_move_left?
			@level.window.button_down?(Gosu::KbLeft) && can_move_left?
		end

		def want_to_move_right?
			@level.window.button_down?(Gosu::KbRight) && can_move_right?
		end

		def want_to_jump?
			@level.window.button_down?(Gosu::KbUp)
		end

		def can_move_left?
			@x > 0
		end

		def can_move_right?
			@x < (@level.width - @sprite_width)
		end

		def move_left!
			@x -= @x_velocity
			@x = 0 if @x < 0
		end

		def move_right!
			x_max = @level.width - @sprite_width
			@x += @x_velocity
			@x = x_max if @x > x_max
		end

		def jump!
			return if jumping?
			@jumping = true
		end

		def update
			w = @level.window

			if want_to_move_left?
				move_left!
			end

			if want_to_move_right?
				move_right!
			end

			if want_to_jump? && can_jump?
				jump!
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
		HOP_HEIGHT = 8

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

			@dy = 0
		end

		def animate_jump
			return if !jumping?

			@dy = 30

			if @y <= (@level.height - JUMP_HEIGHT)
				@y_velocity *= -1
			end


			@y -= @y_velocity

			if grounded?
				@y_velocity *= -1
				@y = @level.height - @sprite_height
				@jumping = false
			end			

		end

		def animate_move_hop
			return if jumping?
			if (want_to_move_left? && can_move_left?) ^ (want_to_move_right? && can_move_right?)
				@dy = -1 * (Math.sin(@x / 2.0) * HOP_HEIGHT).to_i.abs
			else
				@dy = 0
			end
		end

		def draw
			animate_move_hop
			animate_jump
			@legs_sprite.draw(@x,      @y + 50 + @dy, ZOrder::Player)
			@body_sprite.draw(@x + 30, @y + 10, ZOrder::Player)
		end
	end
end