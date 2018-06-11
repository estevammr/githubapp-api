defmodule Githubapp do
  use HTTPoison.Base

  @moduledoc """
  Githubapp keeps the contexts that define your domain
  and business logic.

  Contexts are also responsible for managing your data, regardless
  if it comes from the database, an external API or others.
  """

  def search_repo(language) do
    HTTPoison.start
    HTTPoison.get!("https://api.github.com/search/repositories?q=" <> language <> "&sort=stars").body
    |> Poison.decode!
  end
end
