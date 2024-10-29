defmodule ChatInfotex.MixProject do
  use Mix.Project

  def project do
    [
      app: :chat_infotex,
      version: "0.1.0",
      elixir: "~> 1.17",
      deps: deps()
    ]
  end

  def application do
    [
      mod: {ChatInfotex.Application, []},
      extra_applications: [:logger, :n2o, :nitro, :kvs, :syn]
    ]
  end

  defp deps do
    [
      {:n2o, "~> 11.9"},
      {:nitro, "~> 9.9"},
      {:kvs, "~> 11.9"},
      {:cowboy, "~> 2.9"},
      {:jason, "~> 1.4"},
      {:syn, "~> 2.1"},
      {:ex_doc, "~> 0.29", only: :dev, runtime: false}
    ]
  end
end
