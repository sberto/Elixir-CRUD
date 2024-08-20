alias Crud.{Repo, User, Post}

IO.puts "Seeding database..."

id = Ecto.UUID.generate()
Repo.insert! %User{ id: id, name: "Human1", posts: [ %Post{ text: "HELLO HUMAN" }, %Post{ text: "HELLO FELLOW HUMANS" } ] }

id = Ecto.UUID.generate()
Repo.insert! %User{ id: id, name: "Human2", posts: [ %Post{ text: "DESTROY" }, %Post{ text: "DESTROY" } ] }
Repo.insert! %Post{ text: "JUST KIDDING", user_id: id }

IO.puts "Done!"