import Config

config :crud, Crud.Repo,
  database: "crud_repo",
  username: "postgres",
  password: "1234",
  hostname: "localhost",
  pool: Ecto.Adapters.SQL.Sandbox
