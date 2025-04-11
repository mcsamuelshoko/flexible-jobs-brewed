defmodule FlexibleJobsBrewed.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      FlexibleJobsBrewedWeb.Telemetry,
      FlexibleJobsBrewed.Repo,
      {DNSCluster, query: Application.get_env(:flexible_jobs_brewed, :dns_cluster_query) || :ignore},
      {Phoenix.PubSub, name: FlexibleJobsBrewed.PubSub},
      # Start the Finch HTTP client for sending emails
      {Finch, name: FlexibleJobsBrewed.Finch},
      # Start a worker by calling: FlexibleJobsBrewed.Worker.start_link(arg)
      # {FlexibleJobsBrewed.Worker, arg},
      # Start to serve requests, typically the last entry
      FlexibleJobsBrewedWeb.Endpoint
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: FlexibleJobsBrewed.Supervisor]
    Supervisor.start_link(children, opts)
  end

  # Tell Phoenix to update the endpoint configuration
  # whenever the application is updated.
  @impl true
  def config_change(changed, _new, removed) do
    FlexibleJobsBrewedWeb.Endpoint.config_change(changed, removed)
    :ok
  end
end
