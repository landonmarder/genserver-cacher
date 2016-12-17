defmodule Cacher do
  use GenServer
  @name CA

  ## Client API

  def start_link(opts \\ []) do
    GenServer.start_link(__MODULE__, :ok, opts ++ [name: CA])
  end

  def write(key, value) do
    GenServer.call(@name, {:write_to_store, key, value})
  end


  ## Server API

  def handle_call({:write_to_store, key, value}, _from, store) do
    new_store = update_store(store, key, value)
    {:reply, "#{key}: #{value}", new_store}
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  ## Helper Functions

  defp update_store(store, key, value) do
    case Map.has_key?(store, key) do
      true ->
        Map.update!(store, key, value)
      false ->
        Map.put_new(store, key, value)
    end
  end
end
