defmodule GithubappWeb.AppView do
  use GithubappWeb, :view
  alias GithubappWeb.AppView

  def render("index.json", %{gits: gits}) do
    %{data: render_many(gits["items"], AppView, "app.json")}
  end

  def render("show.json", %{app: app}) do
    %{data: render_one(app, AppView, "app.json")}
  end

  def render("app.json", %{app: app}) do
    %{clone_url: app["clone_url"],
      full_name: app["full_name"],
      node_id: app["node_id"],
      name: app["name"],
      git_url: app["git_url"],
      score: app["score"],
      homepage: app["homepage"],
      forks: app["forks"],
      stargazers_count: app["stargazers_count"],
      languages_url: app["languages_url"]}
  end
end
