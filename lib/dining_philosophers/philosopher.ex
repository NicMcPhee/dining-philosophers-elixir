defmodule Philosopher do
  def thinking(philosopher_number, leftChopstick, rightChopstick) do
    receive do
      {:eat, from} ->
        IO.puts("Philosopher #{philosopher_number} is now eating")
        eating(philosopher_number, leftChopstick, rightChopstick)
      {:finish} ->
        exit(:normal)
    end
  end

  def eating(philosopher_number, leftChopstick, rightChopstick) do
    receive do
      {:think, from} ->
        IO.puts("Philosopher #{philosopher_number} is now thinking")
	      send(leftChopstick, {:release, self()})
	      send(rightChopstick, {:release, self()})
        thinking(philosopher_number, leftChopstick, rightChopstick)
      # A philosopher can be asked to "think" by computing fib(n)
      # for the specified value of n.
      {:think, n, from} ->
        IO.puts("Philosopher #{philosopher_number} is computing fib(#{n})")
	      send(leftChopstick, {:release, self()})
	      send(rightChopstick, {:release, self()})
        result = fib(n)
        IO.puts("Philosopher #{philosopher_number} found fib(#{n}) = #{result}")
        send(from, {:ok, result})
        thinking(philosopher_number, leftChopstick, rightChopstick)
      {:finish} ->
        exit(:normal)
    end
  end

  defp fib(0), do: 0
  defp fib(1), do: 1
  defp fib(n), do: fib(n-2) + fib(n-1) 
end
