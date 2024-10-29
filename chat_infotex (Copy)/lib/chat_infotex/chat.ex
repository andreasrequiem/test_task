defmodule ChatInfotex.Chat do
  use N2O
  require :nitro

  def event(:init) do
    room = :proplists.get_value("room", :nitro.qc([]), "Кімната 1")

    :nitro.clear(:body)

    :nitro.insert_top(:body, [
      {:h1, [], ["Чат в #{room}"]},
      {:div, [
        {:id, :history},
        {:style, "border: 1px solid #ccc; height: 300px; overflow: auto;"}
      ], []},
      {:textbox, [
        {:id, :message},
        {:placeholder, "Введіть ваше повідомлення..."}
      ], []},
      {:input, [
        {:type, :hidden},
        {:id, :room},
        {:value, room}
      ], []},
      {:button, [
        {:id, :send},
        {:body, "Надіслати"},
        {:postback, :send_message},
        {:source, [:message, :room]}
      ], []},
      {:button, [
        {:id, :back},
        {:body, "Назад до кімнат"},
        {:postback, :back_to_rooms}
      ], []}
    ])
  end

  def event(:send_message) do
    message = :nitro.q(:message) |> to_string()
    room = :nitro.q(:room) |> to_string()
    user = :n2o.user() || "Користувач"

    msg = %{"type" => "message", "user" => user, "message" => message}

    :syn.publish({:chat_room, room}, {:chat_message, msg})

    :nitro.update(:message, {:textbox, [
      {:id, :message},
      {:placeholder, "Введіть ваше повідомлення..."}
    ], []})
  end

  def event(:back_to_rooms) do
    :nitro.redirect("/app/rooms.htm")
  end

  def event(_), do: []
end
