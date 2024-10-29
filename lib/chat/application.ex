defmodule Chat.Application do
  use Application

  def start(_type, _args) do
    :n2o.start()

    # Запускаємо Cowboy сервер з N2O
    {:ok, _} = :cowboy.start_clear(:http,
      [{:port, 4000}],
      %{env: %{dispatch: :n2o_cowboy.points()}}
    )

    children = []
    opts = [strategy: :one_for_one, name: Chat.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
