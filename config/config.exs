# This file is responsible for configuring your application
# and its dependencies with the aid of the Mix.Config module.
#
# This configuration file is loaded before any dependency and
# is restricted to this project.
use Mix.Config

# General application configuration
config :mbta_schedule,
  ecto_repos: [MbtaSchedule.Repo]

# Configures the endpoint
config :mbta_schedule, MbtaSchedule.Endpoint,
  url: [host: "localhost"],
  secret_key_base: "sdrsEROO8K2hOGX2KXR6jbLAXt+AMMcpDkWu7fFKI7kvGlSLhDbPRyh01Lg+Rlwt",
  render_errors: [view: MbtaSchedule.ErrorView, accepts: ~w(html json)],
  pubsub: [name: MbtaSchedule.PubSub,
           adapter: Phoenix.PubSub.PG2]

# Configures Elixir's Logger
config :logger, :console,
  format: "$time $metadata[$level] $message\n",
  metadata: [:request_id]

# Import environment specific config. This must remain at the bottom
# of this file so it overrides the configuration defined above.
import_config "#{Mix.env}.exs"
