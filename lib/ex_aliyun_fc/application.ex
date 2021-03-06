defmodule ExAliyunFc.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      {Plug.Cowboy,
       scheme: :http,
       plug: ExAliyunFc.Endpoint,
       options: [
         port: 9000,
         protocol_options: [idle_timeout: :infinity, max_keepalive: :infinity]
       ]}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ExAliyunFc.Supervisor]
    Supervisor.start_link(children, opts)
  end
end
