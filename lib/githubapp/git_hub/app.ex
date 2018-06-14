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

  @required_fields ~w(clone_url full_name node_id)
  @optional_fields ~w()

  def changeset(app, params \\ :empty) do
    app
    #|> cast(params, @required_fields, @optional_fields)
  end
end
