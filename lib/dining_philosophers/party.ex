defmodule Party do
  def host(table_size) do
    chopsticks = (1..table_size)
                 |> Enum.map(fn (n) -> spawn(Chopstick, :is_free, [n]) end)
    philosophers = (1..table_size)
                   |> Enum.map(fn (n) -> spawn(Philosopher, :thinking, [n, leftChopstick(n, chopsticks), rightChopstick(n, chopsticks, table_size)]) end)
    {chopsticks, philosophers}
  end

  defp leftChopstick(n, chopsticks) do
    Enum.at(chopsticks, n)
  end

  defp rightChopstick(n, chopsticks, table_size) do
    Enum.at(chopsticks, rem(n+1, table_size))
  end
end
