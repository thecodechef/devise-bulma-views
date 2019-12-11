require 'rails'
require 'devise_bulma_views_helper'

module DeviseBulmaViews
    class Engine < ::Rails::Engine
    end

    class Railtie < ::Rails::Railtie #:nodoc:
        initializer 'rails-devise-bulma-views' do |app|
            DeviseBulmaViews::Railtie.instance_eval do
                pattern = pattern_from app.config.i18n.available_locales
                files = Dir[File.join(File.dirname(__FILE__), '../locales', "#{pattern}.yml")]
                I18n.load_path.concat(files)

                ActionView::Base.send :include, DeviseBulmaViewsHelper
            end
        end

        def self.pattern_from(args)
            array = Array(args || [])
            array.blank? ? '*' : "{#{array.join ','}}"
        end
    end
end