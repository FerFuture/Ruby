require_relative "boot"
require "rails/all"

Bundler.require(*Rails.groups)

module Backend
  class Application < Rails::Application
    config.load_defaults 7.1

    config.autoload_lib(ignore: %w(assets tasks))

    # Configuración de CORS
    config.middleware.insert_before 0, Rack::Cors do
      allow do
        origins '*'  # Esto permite todas las solicitudes, reemplaza '*' con tu dominio si es necesario
        resource '*', headers: :any, methods: [:get, :post, :put, :delete, :options]
      end
    end
  end
end
