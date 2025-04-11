defmodule FlexibleJobsBrewed.Repo do
  use Ecto.Repo,
    otp_app: :flexible_jobs_brewed,
    adapter: Ecto.Adapters.Postgres
end
