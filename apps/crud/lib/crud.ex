defmodule Crud do
  alias Crud.{Repo, User, Post}

  def all do
    Repo.all(Crud.User)
    |> Repo.preload(:posts)
    |> format
  end

  def format(users) do
    Enum.map(users, &format_user/1)
  end

  defp format_user(%User{} = user) do
    %{
      id: user.id,
      name: user.name,
      posts: format_posts(user.posts)
    }
  end

  defp format_posts(posts) do
    Enum.map(posts, &format_post/1)
  end

  defp format_post(%Post{} = post) do
    %{
      id: post.id,
      text: post.text
    }
  end
end
