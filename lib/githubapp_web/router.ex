defmodule GithubappWeb.Router do
  use GithubappWeb, :router

  pipeline :api do
    plug :accepts, ["json"]
  end

  scope "/api", GithubappWeb do
    pipe_through :api
    resources "/gits", AppController, except: [:new, :edit]
  end
end
