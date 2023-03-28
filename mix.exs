defmodule GriffinBenchmarks.MixProject do
  use Mix.Project

  def project do
    [
      app: :griffin_benchmarks,
      version: "0.1.0",
      elixir: "~> 1.14",
      start_permanent: Mix.env() == :prod,
      deps: deps()
    ]
  end

  # Run "mix help compile.app" to learn about applications.
  def application do
    [
      extra_applications: [:logger]
    ]
  end

  # Run "mix help deps" to learn about dependencies.
  defp deps do
    [
      {:slugify, "~> 1.3"},
      {:griffin_ssg, "~> 0.3"}
    ]
  end
end
