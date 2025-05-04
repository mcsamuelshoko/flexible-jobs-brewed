defmodule FlexibleJobsBrewedWeb.ContactController do
  use FlexibleJobsBrewedWeb, :controller

  def index(conn, _params) do
    # The index page is often custom made,
    # so skip the default app layout.
    render(conn, :index, layout: false)
  end

  def show(conn, %{"messenger" => messenger} = _params) do
    render(conn, :show, messenger: messenger)
  end
end
