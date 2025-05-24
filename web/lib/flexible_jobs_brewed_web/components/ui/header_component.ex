defmodule FlexibleJobsBrewedWeb.Components.Ui.Header do
  @moduledoc """
  UI components reused

  """

    use Phoenix.Component
    use Gettext, backend: FlexibleJobsBrewedWeb.Gettext

    # alias Phoenix.LiveView.JS

  def header(assigns) do

    ~H"""
      <header>
        <div class=" pb-2">
          <div class="px-4 mx-auto sm:max-w-xl md:max-w-full lg:max-w-screen-xl md:px-24 lg:px-8">
            <div class="relative flex flex-wrap items-center justify-between">
              <a href="/" aria-label="Company" title="Flexible Jobs" class="pt-4 inline-flex items-center hover:text-fjSecondary transition-all duration-150 ease-in-out dark:hover:text-fjPrimary">
                <img src={"/images/logo-mono.svg"} width="96" class="" alt="logo" />
                <span class="ml-2 text-xl font-bold tracking-wide uppercase">Flexible Jobs</span>
              </a>


              <ul class="pt-4 flex items-center space-x-8 lg:flex">
                <li class="font-semibold hover:text-fjSecondary hover:underline transition-all duration-150 ease-in-out dark:hover:text-fjPrimary "><a href="#">Salaries</a></li>
                <li class="font-semibold hover:text-fjSecondary hover:underline transition-all duration-150 ease-in-out dark:hover:text-fjPrimary"><a href="#">Reviews</a></li>
                <li class="font-semibold hover:text-fjSecondary hover:underline transition-all duration-150 ease-in-out dark:hover:text-fjPrimary"><a href="#">About</a></li>
                <li>
                  <a
                    href="/"
                    class=" inline-flex items-center justify-center  btn font-semibold tracking-wide  dark:text-textLight bg-bgDark text-textDark dark:bg-bgLight ease-in-out transition duration-200 rounded shadow-md bg-fjAccent-400 hover:bg-fjPrimary hover:text-textLight focus:shadow-outline focus:outline-none"
                    aria-label="Sign up"
                    title="Sign up"
                  >
                    Sign&nbsp;up
                  </a>
                </li>
                <li class="font-semibold hover:text-fjSecondary hover:underline transition-all duration-150 ease-in-out dark:hover:text-fjPrimary"><a href="#">Contact</a></li>
              </ul>
              <!-- Mobile menu
              <div class="lg:hidden">
                <button aria-label="Open Menu" title="Open Menu" class="p-2 -mr-1 transition duration-200 rounded focus:outline-none focus:shadow-outline">
                  <svg class="w-5 text-textLight" viewBox="0 0 24 24">
                    <path fill="currentColor" d="M23,13H1c-0.6,0-1-0.4-1-1s0.4-1,1-1h22c0.6,0,1,0.4,1,1S23.6,13,23,13z"></path>
                    <path fill="currentColor" d="M23,6H1C0.4,6,0,5.6,0,5s0.4-1,1-1h22c0.6,0,1,0.4,1,1S23.6,6,23,6z"></path>
                    <path fill="currentColor" d="M23,20H1c-0.6,0-1-0.4-1-1s0.4-1,1-1h22c0.6,0,1,0.4,1,1S23.6,20,23,20z"></path>
                  </svg>
                </button>
              </div> -->
            </div>
          </div>
        </div>
      </header>
    """

  end

end
