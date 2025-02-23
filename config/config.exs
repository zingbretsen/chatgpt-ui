# This file is responsible for configuring your application
# and its dependencies with the aid of the Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.

# General application configuration
import Config

config :chatgpt,
  title: "Elixir ChatGPT",
  # or gpt-3.5-turbo
  model: "gpt-3.5-turbo",
  enabled_models: ["gpt-3.5-turbo", "davinci"],
  default_model: :"gpt-4",
  models: [
    %{
      id: :"gpt-4",
      truncate_tokens: 8000
    },
    %{
      id: :"gpt-3.5-turbo",
      truncate_tokens: 4000
    },
    %{
      id: :davinci,
      truncate_tokens: 2200
    },
    %{
      id: :"gpt-3.5-turbo-16k",
      truncate_tokens: 15000
    }
  ],
  enable_google_oauth: true,
  restrict_email_domains: true,
  allowed_email_domains: ["google.com"]

# Configures the endpoint
config :chatgpt, ChatgptWeb.Endpoint,
  url: [host: "localhost"],
  render_errors: [
    formats: [html: ChatgptWeb.ErrorHTML, json: ChatgptWeb.ErrorJSON],
    layout: false
  ],
  pubsub_server: Chatgpt.PubSub,
  live_view: [signing_salt: "U3AoOojJ"]

# Configure esbuild (the version is required)
config :esbuild,
  version: "0.14.41",
  default: [
    args:
      ~w(js/app.js --bundle --target=es2017 --outdir=../priv/static/assets --external:/fonts/* --external:/images/*),
    cd: Path.expand("../assets", __DIR__),
    env: %{"NODE_PATH" => Path.expand("../deps", __DIR__)}
  ]

# Configure tailwind (the version is required)
config :tailwind,
  version: "3.2.4",
  default: [
    args: ~w(
      --config=tailwind.config.js
      --input=css/app.css
      --output=../priv/static/assets/app.css
    ),
    cd: Path.expand("../assets", __DIR__)
  ]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Use Jason for JSON parsing in Phoenix
config :phoenix, :json_library, Jason

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{config_env()}.exs"
