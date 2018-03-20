defmodule Party do
  def host(table_size) do
    chopsticks = (1..table_size)
	         |> Enum.map(fn (n) -> spawn(Chopstick, :is_free, [n]) end)
  end
end
