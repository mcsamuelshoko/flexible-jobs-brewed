defmodule FlexibleJobsBrewedWeb.JobsController do
  use FlexibleJobsBrewedWeb, :controller

  def index(conn, _params) do
    # The index page is often custom made,
    # so skip the default app layout.
    render(conn, :index, layout: false)
  end

  def companies(conn, _params) do
    render(conn, :companies)
  end

  def reviews(conn, _params) do
    render(conn, :reviews)
  end

  def salaries(conn, _params) do
    render(conn, :salaries)
  end


end
