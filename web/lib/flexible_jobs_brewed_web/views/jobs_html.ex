defmodule FlexibleJobsBrewedWeb.JobsHTML do
  @moduledoc """
  This module contains pages rendered by PageController.

  See the `page_html` directory for all templates available.
  """
  use FlexibleJobsBrewedWeb, :html

  embed_templates "jobs_html/*"
end
