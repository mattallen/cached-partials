require 'net/http'
require 'uri'

helper_path = File.join(RAILS_ROOT, 'vendor', 'plugins','cached_partials','helpers','cached_partials_helper')
require helper_path

ActiveRecord::Base.send :include, CachedPartials
ActionView::Base.send :include, CachedPartialsHelper

controller_path = File.join(RAILS_ROOT, 'vendor', 'plugins','cached_partials','controllers')
$LOAD_PATH << controller_path
ActiveSupport::Dependencies.load_paths << controller_path
config.controller_paths << controller_path

