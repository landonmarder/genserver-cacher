# Cacher

Caching store using GenServer.

## Installation

If [available in Hex](https://hex.pm/docs/publish), the package can be installed as:

  1. Add `cacher` to your list of dependencies in `mix.exs`:

    ```elixir
    def deps do
      [{:cacher, "~> 0.1.0"}]
    end
    ```

  2. Ensure `cacher` is started before your application:

    ```elixir
    def application do
      [applications: [:cacher]]
    end
    ```
