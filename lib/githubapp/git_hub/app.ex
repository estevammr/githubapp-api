defmodule Githubapp.GitHub.App do
  use Ecto.Schema
  import Ecto.Changeset


  schema "gits" do
    field :clone_url, :string
    field :full_name, :string
    field :node_id,   :string
    field :name,      :string
    field :git_url,   :string
    field :score,     :float
    field :homepage,  :string
    field :forks,     :integer
    field :stargazers_count, :integer
    field :languages_url, :string
    timestamps()
  end

  @doc false
  def changeset(app, attrs) do
    app
    |> cast(attrs, [:clone_url])
    |> validate_required([:clone_url])
  end
end
