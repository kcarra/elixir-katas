defmodule Stack do
    use GenServer

    def start_link(state) do
        GenServer.start_link(__MODULE__, state, name: __MODULE__)
    end

    @impl true
    def init(stack) do
        {:ok, stack}
    end

    @impl true
    def handle_call(:pop, _from, [head | tail]) do
        {:reply, head, tail}
    end

    @impl true
    def handle_cast({:push, head}, tail) do
        {:noreply, [head | tail]}
    end
end