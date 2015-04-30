defmodule HelloPhoenix.Case do
  use ExUnit.CaseTemplate
  alias Ecto.Adapters.SQL
  alias HelloPhoenix.Repo

  setup do
    SQL.begin_test_transaction(Repo)

    on_exit fn ->
      SQL.rollback_test_transaction(Repo)
    end
  end

  using do
    quote do
      alias HelloPhoenix.Repo
      alias HelloPhoenix.Contact
      use Plug.Test

      def send_request(conn) do
        conn
        |> put_private(:plug_skip_csrf_protection, true)
        |> HelloPhoenix.Endpoint.call([])
      end
    end
  end
end

ExUnit.start

# Create the database, run migrations, and start the test transaction.
Mix.Task.run "ecto.create", ["--quiet"]
Mix.Task.run "ecto.migrate", ["--quiet"]
Ecto.Adapters.SQL.begin_test_transaction(HelloPhoenix.Repo)
