require './target'
require './zorder'

module Froggy
	class GameLevel
		attr_accessor :number
		attr_accessor :window
		attr_accessor :background_image
		attr_accessor :enemies
		attr_accessor :targets

		attr_accessor :width
		attr_accessor :height

		def initialize(number, window, bg_image_path)
			@number = number || 0
			@window = window
			@window.caption = "Froggy the Frog - Level #{@number}"

			@background_image = Gosu::Image.new(window, bg_image_path, true)

			@enemies = []
			@targets = []

			@width  = window.width
			@height = window.height

			@targets << BeeTarget.new(self).randomize_position_and_velocity
			@targets << BeeTarget.new(self).randomize_position_and_velocity
			@targets << BeeTarget.new(self).randomize_position_and_velocity
			@targets << BeeTarget.new(self).randomize_position_and_velocity
		end

		# Helper method in generating random targets for us.
		# Will simplify level creation for us if we don't care
		# for positioning of initial targets.
		def generate_random_targets(n)
			targets = []
			n.times {
				#targets << 
			}
			targets
		end

		def update
			@targets.each { |t| t.update }
			@enemies.each { |e| e.update }
		end

		def draw
			@targets.each { |t| t.draw }
		end

	end
end