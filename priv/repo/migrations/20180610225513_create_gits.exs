defmodule Githubapp.Repo.Migrations.CreateGits do
  use Ecto.Migration

  def change do
    create table(:gits) do
      add :clone_url, :string
      add :full_name, :string
      add :node_id,   :string
      add :name,      :string
      add :git_url,   :string
      add :score,     :float
      add :homepage,  :string
      add :forks,     :integer
      add :stargazers_count, :integer
      add :languages_url, :string
      timestamps()
    end

  end
end
