defmodule Crud.Repo.Migrations.AddOnDelete do
  use Ecto.Migration

  def change do
    alter table(:posts) do
      modify :user_id, references(:users, on_delete: :delete_all, type: :binary_id),
             from: references(:users, on_delete: :nothing, type: :binary_id)
    end
  end
end
