import Config

config :crud,
  ecto_repos: [Crud.Repo]

import_config "#{config_env()}.exs"
