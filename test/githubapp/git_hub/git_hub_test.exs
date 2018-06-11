defmodule Githubapp.GitHubTest do
  use Githubapp.DataCase

  alias Githubapp.GitHub

  describe "gits" do
    alias Githubapp.GitHub.App

    @valid_attrs %{clone_url: "some clone_url"}
    @update_attrs %{clone_url: "some updated clone_url"}
    @invalid_attrs %{clone_url: nil}

    def app_fixture(attrs \\ %{}) do
      {:ok, app} =
        attrs
        |> Enum.into(@valid_attrs)
        |> GitHub.create_app()

      app
    end

    test "list_gits/0 returns all gits" do
      app = app_fixture()
      assert GitHub.list_gits() == [app]
    end

    test "get_app!/1 returns the app with given id" do
      app = app_fixture()
      assert GitHub.get_app!(app.id) == app
    end

    test "create_app/1 with valid data creates a app" do
      assert {:ok, %App{} = app} = GitHub.create_app(@valid_attrs)
      assert app.clone_url == "some clone_url"
    end

    test "create_app/1 with invalid data returns error changeset" do
      assert {:error, %Ecto.Changeset{}} = GitHub.create_app(@invalid_attrs)
    end

    test "update_app/2 with valid data updates the app" do
      app = app_fixture()
      assert {:ok, app} = GitHub.update_app(app, @update_attrs)
      assert %App{} = app
      assert app.clone_url == "some updated clone_url"
    end

    test "update_app/2 with invalid data returns error changeset" do
      app = app_fixture()
      assert {:error, %Ecto.Changeset{}} = GitHub.update_app(app, @invalid_attrs)
      assert app == GitHub.get_app!(app.id)
    end

    test "delete_app/1 deletes the app" do
      app = app_fixture()
      assert {:ok, %App{}} = GitHub.delete_app(app)
      assert_raise Ecto.NoResultsError, fn -> GitHub.get_app!(app.id) end
    end

    test "change_app/1 returns a app changeset" do
      app = app_fixture()
      assert %Ecto.Changeset{} = GitHub.change_app(app)
    end
  end
end
