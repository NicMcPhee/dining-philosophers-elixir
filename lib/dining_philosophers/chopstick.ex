defmodule Chopstick do
  def is_free(chopstick_number) do
    receive do
      {:request, from} ->
        IO.puts("Chopstick #{chopstick_number} received request")
        send(from, {:ok, chopstick_number})
        is_held(chopstick_number)
      {:release, from} ->
        IO.puts("Chopstick #{chopstick_number} was incorrectly released")
        is_free(chopstick_number)
      {:finish} ->
        exit(:normal)
    end
  end

  def is_held(chopstick_number) do
    receive do
      {:release, from} ->
        IO.puts("Chopstick #{chopstick_number} was released")
        is_free(chopstick_number)
      {:finish} ->
        IO.puts("Chopstick #{chopstick_number} was told to finish while still in use")
        exit(:still_in_use)
    end
  end
end
