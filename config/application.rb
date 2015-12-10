require File.expand_path('../boot', __FILE__)

require 'rails/all'

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

module Rareform
  class Application < Rails::Application
    config.encoding = "utf-8"
    config.filter_parameters += [:password]
    # Settings in config/environments/* take precedence over those specified here.
    # Application configuration should go into files in config/initializers
    # -- all .rb files in that directory are automatically loaded.

    # Set Time.zone default to the specified zone and make Active Record auto-convert to this zone.
    # Run "rake -D time" for a list of tasks for finding time zone names. Default is UTC.
    # config.time_zone = 'Central Time (US & Canada)'

    # The default locale is :en and all translations from config/locales/*.rb,yml are auto loaded.
    # config.i18n.load_path += Dir[Rails.root.join('my', 'locales', '*.{rb,yml}').to_s]
    # config.i18n.default_locale = :de

    # Do not swallow errors in after_commit/after_rollback callbacks.
    config.active_record.raise_in_transactional_callbacks = true

    # Adding s3 validation
    AWS::S3::Base.establish_connection!(
        :access_key_id     => 'AKIAICSA2PKJNAGFUABQ',
        :secret_access_key => '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'
    )

    ENV['BUCKET'] ='rareform'
    ENV['SOUNDCLOUD_CLIENT_ID'] = '3ee351e7ff8a40cc7558c785b58b91e1'
  end
end
