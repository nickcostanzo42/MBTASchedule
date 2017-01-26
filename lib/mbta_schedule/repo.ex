defmodule MbtaSchedule.Repo do
  use Ecto.Repo, otp_app: :mbta_schedule

  adapter: Ecto.Adapters.Postgres,
  username: "postgres",
  password: "postgres",
  database: "my_app_dev",
  pool_size: 10

end

