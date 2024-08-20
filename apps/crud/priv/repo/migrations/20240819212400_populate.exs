defmodule Crud.Repo.Migrations.Populate do
  use Ecto.Migration

  def change do
    create table(:users, primary_key: false) do
      add :id, :binary_id, primary_key: true
      add :name, :string
      add :inserted_at, :naive_datetime
      add :updated_at, :naive_datetime
    end

    create table(:posts) do
      add :text, :string
      add :user_id, references(:users, on_delete: :nothing, type: :binary_id)
      add :inserted_at, :naive_datetime
      add :updated_at, :naive_datetime
    end
  end
end
