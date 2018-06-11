defmodule GithubappWeb.AppControllerTest do
  use GithubappWeb.ConnCase

  alias Githubapp.GitHub
  alias Githubapp.GitHub.App

  @create_attrs %{clone_url: "some clone_url"}
  @update_attrs %{clone_url: "some updated clone_url"}
  @invalid_attrs %{clone_url: nil}

  def fixture(:app) do
    {:ok, app} = GitHub.create_app(@create_attrs)
    app
  end

  setup %{conn: conn} do
    {:ok, conn: put_req_header(conn, "accept", "application/json")}
  end

  describe "index" do
    test "lists all gits", %{conn: conn} do
      conn = get conn, app_path(conn, :index)
      assert json_response(conn, 200)["data"] == []
    end
  end

  describe "create app" do
    test "renders app when data is valid", %{conn: conn} do
      conn = post conn, app_path(conn, :create), app: @create_attrs
      assert %{"id" => id} = json_response(conn, 201)["data"]

      conn = get conn, app_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "clone_url" => "some clone_url"}
    end

    test "renders errors when data is invalid", %{conn: conn} do
      conn = post conn, app_path(conn, :create), app: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "update app" do
    setup [:create_app]

    test "renders app when data is valid", %{conn: conn, app: %App{id: id} = app} do
      conn = put conn, app_path(conn, :update, app), app: @update_attrs
      assert %{"id" => ^id} = json_response(conn, 200)["data"]

      conn = get conn, app_path(conn, :show, id)
      assert json_response(conn, 200)["data"] == %{
        "id" => id,
        "clone_url" => "some updated clone_url"}
    end

    test "renders errors when data is invalid", %{conn: conn, app: app} do
      conn = put conn, app_path(conn, :update, app), app: @invalid_attrs
      assert json_response(conn, 422)["errors"] != %{}
    end
  end

  describe "delete app" do
    setup [:create_app]

    test "deletes chosen app", %{conn: conn, app: app} do
      conn = delete conn, app_path(conn, :delete, app)
      assert response(conn, 204)
      assert_error_sent 404, fn ->
        get conn, app_path(conn, :show, app)
      end
    end
  end

  defp create_app(_) do
    app = fixture(:app)
    {:ok, app: app}
  end
end
