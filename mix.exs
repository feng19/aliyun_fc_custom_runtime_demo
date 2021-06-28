defmodule ExAliyunFc.MixProject do
  use Mix.Project

  def project do
    [
      app: :ex_aliyun_fc,
      version: "0.1.0",
      elixir: "~> 1.12",
      start_permanent: Mix.env() == :prod,
      releases: releases(),
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger],
      mod: {ExAliyunFc.Application, []}
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [{:plug_cowboy, "~> 2.5"}]
  end

  defp releases do
    [
      ex_aliyun_fc: [
        version: {:from_app, :ex_aliyun_fc},
        applications: [ex_aliyun_fc: :permanent],
        strip_beams: [keep: ["Docs", "Dbgi"]],
        include_executables_for: [:unix],
        # include_erts: Mix.env() != :dev,
        include_erts: "./rel/erlang/erts-11.1.3",
        steps: [:assemble]
        # config_providers: [{Config.Reader, {:system, "RELEASE_ROOT", "/etc/config.exs"}}]
      ]
    ]
  end
end
