defmodule Chat.Web.Socket do
  @moduledoc false

  require N2O

  @random_messages [
    "Вітаємо на нашому чаті!",
    "Раді бачити вас тут!",
    "Спілкуйтесь та насолоджуйтесь!",
    "Приємного користування!",
    "Ваше перебування тут важливе для нас!",
    "Як ваш день?",
    "Що нового?",
    "Розкажіть щось цікаве!",
    "Чи є у вас питання?",
    "Дякуємо, що ви з нами!"
  ]

  # Функція для вибору випадкового повідомлення
  defp get_random_message do
    Enum.random(@random_messages)
  end

  def init(args) do
    {:ok, N2O.cx(module: Keyword.get(args, :module))}
  end

  def handle_in({message, _}, state) when is_binary(message) do
    random_msg = get_random_message()
    {:reply, :ok, {:text, random_msg}, state}
  end

  def handle_info(message, state) do
    random_msg = get_random_message()

    case :n2o_proto.info(message, [], state) do
      {:reply, {:binary, _}, _, state} ->
        {:reply, :ok, {:binary, random_msg}, state}

      _ ->
        {:noreply, state}
    end
  end

  def terminate(_reason, _state) do
    :ok
  end
end
