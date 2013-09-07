#
# A fast implementation of a frog game to help folks from the UvA
# minor programming start getting interested in becoming game devs.
#
# Copyright (c) 2013 Ninh Bui
#

require 'rubygems'
require 'gosu'

require './game_window'
require './game_level'

window = Froggy::GameWindow.new
window.show