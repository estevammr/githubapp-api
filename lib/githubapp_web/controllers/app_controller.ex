defmodule GithubappWeb.AppController do
  use GithubappWeb, :controller
  alias Githubapp.GitHub.Repo
  alias Githubapp.GitHub
  alias Githubapp.GitHub.App

  require Githubapp

  action_fallback GithubappWeb.FallbackController

  def index(conn, %{"language" => language}) do
    gits = Githubapp.search_repo(language) 
    
    items = gits["items"]  
    result = Enum.map(items, fn item -> %{
      clone_url: item["clone_url"],
      full_name: item["full_name"],
      node_id: item["node_id"],
      name: item["name"],
      git_url: item["git_url"],
      score: item["score"],
      homepage: item["homepage"],
      forks: item["forks"],
      stargazers_count: item["stargazers_count"],
      languages_url: item["languages_url"]
    } end) 
    
    repo = result 
      |> Enum.chunk(2) 
      |> Enum.map(fn [a, b] -> {a, b} end) 
      |> Map.new
      |> IO.inspect
    GitHub.create_app(repo)
    render(conn, "index.json", result: result)
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
