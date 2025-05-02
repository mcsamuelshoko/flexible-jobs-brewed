defmodule FlexibleJobsBrewedWeb.PageController do
  use FlexibleJobsBrewedWeb, :controller

  def home(conn, _params) do
    # The home page is often custom made,
    # so skip the default app layout.
    render(conn, :home, layout: false)
  end

  def about(conn, _params) do
    render(conn, :about, layout: false)
  end

  def contact(conn, _params) do
    render(conn, :contact, layout: false)
  end

  def privacy(conn, _params) do
    render(conn, :privacy, layout: false)
  end

  def terms(conn, _params) do
    render(conn, :terms, layout: false)
  end

  def jobs(conn, _params) do
    render(conn, :jobs, layout: false)
  end
end
