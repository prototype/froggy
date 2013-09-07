require './zorder'

module Froggy
	class Target
		attr_accessor :level
		attr_accessor :sprite_sheet
		attr_accessor :sprite_tile_width
		attr_accessor :sprite_tile_height
		attr_accessor :current_sprite_idx

		attr_accessor :x
		attr_accessor :y

		attr_accessor :x_velocity
		attr_accessor :y_velocity

		def initialize(level, sprite_sheet_image_path, sprite_tile_width, sprite_tile_height)
			@level = level
			@sprite_sheet = Gosu::Image.load_tiles(level.window,
				sprite_sheet_image_path,
				sprite_tile_width,
				sprite_tile_height,
				true
			)

			@current_sprite_idx = 0
			@x = 0
			@y = 0

			@sprite_tile_width  = sprite_tile_width
			@sprite_tile_height = sprite_tile_height
		end

		def randomize_position_and_velocity
			@x = Random.rand(@level.width  - @sprite_tile_width)
			@y = Random.rand(@level.height - @sprite_tile_height)

			@x_velocity *= [-1, 1].sample
			@y_velocity *= [-1, 1].sample
			self
		end

		def update_velocity
			if @x <= 0 || @x >= @level.width - @sprite_tile_width
				@x_velocity *= -1;
			end

			if @y <= 0 || @y >= @level.height - @sprite_tile_height
				@y_velocity *= -1;
			end
		end

		# Default linear x progression
		def update_x
			@x += @x_velocity
		end

		# Default linear y progression
		def update_y
			@y += @y_velocity
		end

		def update_current_sprite_idx
			@current_sprite_idx = (@current_sprite_idx + 1) % sprite_sheet.length
		end

		def update
			update_current_sprite_idx
			update_x
			update_y
			update_velocity
		end

		def draw
			current_sprite_tile = @sprite_sheet[@current_sprite_idx]
			current_sprite_tile.draw(@x, @y, ZOrder::Targets)
		end
	end

	class BeeTarget < Target
		def initialize(level)
			super(level, './img/bee_sprites.png', 58, 47)
			@x_velocity = 4
			@y_velocity = 7
		end
	end
end