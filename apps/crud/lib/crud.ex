defmodule Crud do
  alias Crud.{Repo, User, Post}

  ## CRUD API
  # Create
  def create_user(attrs) do
    %User{}
    |> User.changeset(attrs)
    |> Repo.insert()
  end

  def create_post(user_id, attrs) do
    %Post{}
    |> Post.changeset(attrs)
    |> Repo.insert()
  end

  # Read
  def read_all do
    Repo.all(Crud.User)
    |> Repo.preload(:posts)
  end

  def read_user_and_posts!(id) do
    Repo.get!(User, id)
    |> Repo.preload(:posts)
  end

  # Update
  def update_post(id, attrs) do
    %Post{id: id}
    |> Post.update_changeset(attrs)
    |> IO.inspect()
    |> Repo.update()
    |> IO.inspect()
  end

  def update_user_data(id, attrs) do
    %User{id: id}
    |> User.update_changeset(attrs)
    |> Repo.update()
  end

  # Delete
  def delete_user(id) do
    Repo.delete(Repo.get!(User, id))
  end

  def delete_post(id) do
    Repo.delete(Repo.get!(Post, id))
  end
end
