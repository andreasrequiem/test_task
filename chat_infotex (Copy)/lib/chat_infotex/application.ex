defmodule ChatInfotex.Application do
  use Application

  def start(_type, _args) do
    {:ok, _} = Application.ensure_all_started(:syn)

    dispatch = :cowboy_router.compile([
      {:_, [
        {"/static/[...]", :cowboy_static, {:priv_dir, :chat_infotex, "static"}},
        {"/ws", ChatInfotex.WebSocketHandler, []},
        {"/app/[...]", :cowboy_static, {:priv_dir, :chat_infotex, "templates"}},
        {"/[...]", :cowboy_static, {:priv_dir, :chat_infotex, "templates"}}
      ]}
    ])

    {:ok, _} = :cowboy.start_clear(:http, [{:port, 8001}], %{env: %{dispatch: dispatch}})

    children = []
    opts = [strategy: :one_for_one, name: ChatInfotex.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
