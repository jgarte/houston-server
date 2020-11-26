defmodule Elementary.HoustonServerWeb do
  @moduledoc """
  The entrypoint for defining your web interface, such
  as controllers, views, channels and so on.

  This can be used in your application as:

      use Elementary.HoustonServerWeb, :controller
      use Elementary.HoustonServerWeb, :view

  The definitions below will be executed for every view,
  controller, etc, so keep them short and clean, focused
  on imports, uses and aliases.

  Do NOT define functions inside the quoted expressions
  below. Instead, define any helper function in modules
  and import those modules here.
  """

  def controller do
    quote do
      use Phoenix.Controller, namespace: Elementary.HoustonServerWeb

      import Plug.Conn
      import Phoenix.LiveView.Controller
      import Elementary.HoustonServerWeb.Gettext

      alias Elementary.HoustonServerWeb.Gettext, as: Gtext
      alias Elementary.HoustonServerWeb.Router.Helpers, as: Routes

      action_fallback Elementary.HoustonServerWeb.FallbackController
    end
  end

  def view do
    quote do
      use Phoenix.View,
        root: "lib/houston_server_web/templates",
        namespace: Elementary.HoustonServerWeb

      # Import convenience functions from controllers
      import Phoenix.Controller,
        only: [get_flash: 1, get_flash: 2, view_module: 1, view_template: 1]

      # Include shared imports and aliases for views
      unquote(view_helpers())
    end
  end

  def live_view do
    quote do
      use Phoenix.LiveView,
        layout: {Elementary.HoustonServerWeb.LayoutView, "live.html"}

      unquote(view_helpers())
    end
  end

  def live_component do
    quote do
      use Phoenix.LiveComponent

      unquote(view_helpers())
    end
  end

  def router do
    quote do
      use Phoenix.Router

      import Plug.Conn
      import Phoenix.Controller
      import Phoenix.LiveView.Router
    end
  end

  defp view_helpers do
    quote do
      use Phoenix.HTML

      import Phoenix.LiveView.Helpers
      import Phoenix.View
      import Elementary.HoustonServerWeb.ErrorHelpers
      import Elementary.HoustonServerWeb.Gettext

      alias Elementary.HoustonServerWeb.Endpoint
      alias Elementary.HoustonServerWeb.Gettext, as: Gtext
      alias Elementary.HoustonServerWeb.Router.Helpers, as: Routes
    end
  end

  @doc """
  When used, dispatch to the appropriate controller/view/etc.
  """
  defmacro __using__(which) when is_atom(which) do
    apply(__MODULE__, which, [])
  end
end
