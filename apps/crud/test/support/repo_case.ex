defmodule Crud.RepoCase do
  use ExUnit.CaseTemplate

  using do
    quote do
      use ExUnit.Case

      alias Crud.{Repo, User, Post}

      import Ecto
      import Ecto.Query
      import Crud.RepoCase
    end
  end

  setup tags do
    pid = Ecto.Adapters.SQL.Sandbox.start_owner!(Crud.Repo, shared: not tags[:async])
    on_exit(fn -> Ecto.Adapters.SQL.Sandbox.stop_owner(pid) end)
    :ok
  end
end