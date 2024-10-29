defmodule Chat.Router do
  use N2O, with: [:n2o]

  def init(req, opts) do
    :n2o_cowboy.websocket_upgrade(req, opts)
  end

  def websocket_init(state) do
    {:ok, state}
  end

  def websocket_handle({:text, msg}, state) do
    # Обробка повідомлень від клієнта
    {:reply, {:text, "Echo: #{msg}"}, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end
end
