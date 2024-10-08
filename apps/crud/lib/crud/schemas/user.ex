defmodule Crud.User do
  use Ecto.Schema
  import Ecto.Changeset

  @primary_key {:id, :binary_id, autogenerate: false}
  schema "users" do
    field(:name, :string)
    has_many(:posts, Crud.Post)
    timestamps()
  end

  def changeset(user, params \\ %{}) do
    user
    |> cast(params, [:id, :name])
    |> validate_required([:id, :name])
    |> unique_constraint(:name)
  end

  def update_changeset(post, params) do
    post
    |> cast(params, [:id, :name])
    |> unique_constraint(:name)
    |> validate_required([:id])
    |> validate_required([:name])
  end
end
