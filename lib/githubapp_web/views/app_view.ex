defmodule GithubappWeb.AppView do
  use GithubappWeb, :view
  alias GithubappWeb.AppView

  def render("index.json", %{result: result}) do
    %{data: result}
  end

  def render("show.json", %{app: app}) do
    %{data: render_one(app, AppView, "app.json")}
  end

end
