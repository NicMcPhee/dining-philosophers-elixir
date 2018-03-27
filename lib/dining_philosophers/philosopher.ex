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
      {:finish} ->
        exit(:normal)
    end
  end
end
