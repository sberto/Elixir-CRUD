defmodule Crud.Post do
  use Ecto.Schema
  import Ecto.Changeset

  schema "posts" do
    field(:text, :string)
    belongs_to(:user, Crud.User, type: :binary_id)  # Corrected the reference and specified type
    timestamps()
  end

  def changeset(post, params \\ %{}) do
    IO.puts("post: #{inspect(post)}")

    post
    |> cast(params, [:text, :user_id])  # Include :user_id in the cast to ensure it's passed
    |> validate_required([:text, :user_id])  # Ensure both text and user_id are present
  end
end
