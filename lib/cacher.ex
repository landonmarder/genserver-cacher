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

  def read(key) do
    GenServer.call(@name, {:read_from_store, key})
  end

  def delete(key) do
    GenServer.call(@name, {:delete_from_store, key})
  end

  def clear do
    GenServer.cast(@name, :clear_store)
  end

  ## Server API

  def handle_call({:write_to_store, key, value}, _from, store) do
    new_store = insert_or_update_key(store, key, value)
    {:reply, new_store[key], new_store}
  end

  def handle_call({:read_from_store, key}, _from, store) do
    {:reply, store[key], store}
  end

  def handle_call({:delete_from_store, key}, _from, store) do
    {:reply, nil, Map.delete(store, key)}
  end

  ## Server Callbacks

  def init(:ok) do
    {:ok, %{}}
  end

  def handle_cast(:clear_store, _store) do
    {:noreply, %{}}
  end

  ## Helper Functions

  defp insert_or_update_key(store, key, value) do
    case Map.has_key?(store, key) do
      true ->
        Map.put(store, key, value)
      false ->
        Map.put_new(store, key, value)
    end
  end
end
