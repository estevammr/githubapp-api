defmodule GithubappWeb.AppController do
  use GithubappWeb, :controller

  alias Githubapp.GitHub
  alias Githubapp.GitHub.App

  require Githubapp

  action_fallback GithubappWeb.FallbackController

  def index(conn, %{"language" => language}) do
    gits = Githubapp.search_repo(language)    
    teste = Enum.at(gits, 1)
    teste2 = Enum.each(teste, fn(x) -> IO.puts x end) |> IO.inspect
    render(conn, "index.json", gits: gits)
  end

  def create(conn, %{"app" => app_params}) do
    with {:ok, %App{} = app} <- GitHub.create_app(app_params) do
      conn
      |> put_status(:created)
      |> put_resp_header("location", app_path(conn, :show, app))
      |> render("show.json", app: app)
    end
  end

  def show(conn, %{"id" => id}) do
    app = GitHub.get_app!(id)
    render(conn, "show.json", app: app)
  end

  def update(conn, %{"id" => id, "app" => app_params}) do
    app = GitHub.get_app!(id)

    with {:ok, %App{} = app} <- GitHub.update_app(app, app_params) do
      render(conn, "show.json", app: app)
    end
  end

  def delete(conn, %{"id" => id}) do
    app = GitHub.get_app!(id)
    with {:ok, %App{}} <- GitHub.delete_app(app) do
      send_resp(conn, :no_content, "")
    end
  end
end
