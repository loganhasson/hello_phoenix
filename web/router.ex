defmodule HelloPhoenix.Router do
  use Phoenix.Router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", HelloPhoenix do
    pipe_through :api

    resources "/contacts", ContactController
  end
end
