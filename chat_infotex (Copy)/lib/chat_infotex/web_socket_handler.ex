defmodule ChatInfotex.WebSocketHandler do
  @behaviour :cowboy_websocket

  require Logger

  def init(req, _state) do
    {:cowboy_websocket, req, %{room: nil, user: nil}}
  end

  def websocket_init(state) do
    {:ok, state}
  end

  def websocket_handle({:text, msg}, state) do
    case Jason.decode(msg) do
      {:ok, %{"type" => "join", "room" => room}} ->
        
        :syn.join({:chat_room, room}, self())
        {:ok, Map.put(state, :room, room)}

      {:ok, %{"type" => "message", "message" => message}} ->
        room = Map.get(state, :room, "Кімната 1")
        user = Map.get(state, :user, "Користувач")

        msg_record = %{"type" => "message", "user" => user, "message" => message}

        :syn.publish({:chat_room, room}, {:chat_message, msg_record})

        {:ok, state}

      _ ->
        {:ok, state}
    end
  end

  def websocket_info({:chat_message, msg}, state) do
    {:reply, {:text, Jason.encode!(msg)}, state}
  end

  def websocket_info(_info, state) do
    {:ok, state}
  end

  def terminate(_reason, _req, _state) do
    :ok
  end
end
