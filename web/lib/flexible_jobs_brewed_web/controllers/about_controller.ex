defmodule FlexibleJobsBrewedWeb.AboutController do
  use FlexibleJobsBrewedWeb, :controller

  def index(conn, _params) do
    # The index page is often custom made,
    # so skip the default app layout.
    render(conn, :index, layout: false)
  end

  def privacy(conn, _params) do
    render(conn, :privacy)
  end

  def terms(conn, _params) do
    render(conn, :terms)
  end

end
