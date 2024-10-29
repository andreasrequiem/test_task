defmodule ChatInfotex.RoomSelector do
  use N2O
  require :nitro

  def event(:init) do
    buttons = Enum.map(1..3, fn i ->
      room = "Кімната #{i}"
      {:button, [
        {:id, String.to_atom("room_#{i}")},
        {:body, room},
        {:postback, {:select_room, room}}
      ], []}
    end)

    :nitro.clear(:body)

    :nitro.insert_top(:body, [
      {:h1, [], ["Виберіть кімнату"]},
      {:div, [], buttons}
    ])
  end



  def event(_), do: []
end
