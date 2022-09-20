require_relative "boot"

require "rails/all"

# Require the gems listed in Gemfile, including any gems
# you've limited to :test, :development, or :production.
Bundler.require(*Rails.groups)

if %w[development test].include? ENV['RAILS_ENV']
  Dotenv::Railtie.load
end

module Myapp
  class Application < Rails::Application
    # Initialize configuration defaults for originally generated Rails version.
    config.load_defaults 6.1

    # INFO: 以下のファイルがgeneratorコマンドで自動生成されないようにする。
    # - asset関連ファイル
    # - ルーティング
    # - view_helper関連ファイル
    # - test用のfixtureはつくられないようにする
    config.generators do |g|
      g.assets false
      g.skip_routes true
      g.helper false
      g.test_framework :test_unit, fixture: false
    end

    # TimeZoneを日本時間に修正
    config.time_zone = "Tokyo"

    config.action_view.field_error_proc = Proc.new { |html_tag, instance| html_tag }

    # config.eager_load_paths << Rails.root.join("extras")
  end
end
