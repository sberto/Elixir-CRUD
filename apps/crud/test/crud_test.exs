defmodule CrudTest do
  use Crud.RepoCase

  # Create
  test "create a user with valid attributes" do
    attrs = %{name: "Test User", id: Ecto.UUID.generate()}
    assert {:ok, %User{}} = Crud.create_user(attrs)
  end

  test "create a post with valid attributes" do
    id = Ecto.UUID.generate()
    user = %User{ id: id, name: "Robot" } |> Repo.insert!
    attrs = %{user_id: id, text: "Hello, world!"}
    assert {:ok, %Post{}} = Crud.create_post(id, attrs)
  end

  # Read
  test "read all users and their posts" do
    assert [%User{} | _] = Crud.read_all()
  end

  test "read a user and their posts" do
    id = Ecto.UUID.generate()
    user = %User{ id: id, name: "Robot", posts: [ %Post{ text: "one" }, %Post{ text: "two" } ] }
           |> Repo.insert!
    assert %User{id: id, name: "Robot", posts: [%Post{ text: "one" }, %Post{ text: "two" } ]} = Crud.read_user_and_posts!(id)
  end

  # Update
  test "update a post" do
    id = Ecto.UUID.generate()
    post = %Post{ user_id: id, text: "Hello, world!" }
    user =
      %User{ id: id, name: "Robot", posts: [post] }
           |> Repo.insert!
    %User{posts: [%Post{ id: post_id } = post]} = Crud.read_user_and_posts!(id)
    IO.inspect(post_id)

    assert post_id != nil

    assert {:ok, %Post{}} = Crud.update_post(post_id, %{text: "Hello, Mars!"})

    assert %Post{ text: "Hello, Mars!" } = Repo.get!(Post, post_id)
    end

  test "update a user name" do
    id = Ecto.UUID.generate()
    user = %User{ id: id, name: "Robot" } |> Repo.insert!
    assert {:ok, %User{}} = Crud.update_user_data(id, %{name: "Bender" })

    assert %User{ name: "Bender" } = Repo.get!(User, id)
  end

  # Delete
  test "delete a user and automatically delete posts" do
    id = Ecto.UUID.generate()
    user =
      %User{ id: id, name: "Robot", posts: [ %Post{ text: "one" }, %Post{ text: "two" } ] }
      |> Repo.insert!
    %User{ posts: [ %Post{ id: post1_id }, %Post{ id: post2_id } ] } = user

    assert Repo.get(User, id) != nil
    assert Repo.get(Post, post1_id) != nil
    assert Repo.get(Post, post2_id) != nil

    assert {:ok, %User{}} = Crud.delete_user(id)

    assert Repo.get(User, id) == nil
    assert Repo.get(Post, post1_id) == nil
    assert Repo.get(Post, post2_id) == nil
  end

  test "deleting a post does not delete the user" do
    id = Ecto.UUID.generate()
    user =
      %User{ id: id, name: "Robot", posts: [ %Post{ text: "one" }, %Post{ text: "two" } ] }
      |> Repo.insert!
    %User{ posts: [ %Post{ id: post1_id }, %Post{ id: post2_id } ] } = user

    assert Repo.get(User, id) != nil
    assert Repo.get(Post, post1_id) != nil
    assert Repo.get(Post, post2_id) != nil

    assert {:ok, %Post{}} = Crud.delete_post(post1_id)

    assert Repo.get(User, id) != nil
    assert Repo.get(Post, post1_id) == nil
    assert Repo.get(Post, post2_id) != nil

    assert {:ok, %Post{}} = Crud.delete_post(post2_id)

    assert Repo.get(User, id) != nil
    assert Repo.get(Post, post1_id) == nil
    assert Repo.get(Post, post2_id) == nil
  end
end
