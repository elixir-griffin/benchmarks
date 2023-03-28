defmodule Mix.Tasks.Grf.Gen.Files do
  use Mix.Task

  @moduledoc """
  mix grf.gen.files --count 100 --output src
  """

  @switches [
    count: :integer,
    output: :string
  ]

  @impl Mix.Task
  def run(args) do
    {opts, _parsed} = OptionParser.parse!(args, strict: @switches)

    opts = Enum.into(opts, %{})

    output_dir = opts.output
    files_count = opts.count

    # this text file can generate 367 markdown files,
    # but we can duplicate its contents to generate more
    chunk_list =
      "priv/lusiadas.txt"
      |> File.read!()
      |> String.duplicate(ceil(files_count/367))
      |> String.split("\n\n")
      |> Enum.chunk_every(3, 3, :discard)
      |> Enum.take(files_count)

    File.mkdir_p!(output_dir)

    for chunk <- chunk_list do
      filename = random_string(24)
      [p1, p2, p3] = chunk
      file = """
      ---
      title: #{random_title()}
      ---
      #{p1}

      #{p2}

      #{p3}
      """

      File.write!(output_dir <> "/#{filename}.md", file)
    end
  end

  defp random_string(length) do
    :crypto.strong_rand_bytes(length) |> Base.url_encode64 |> binary_part(0, length)
  end

  defp random_title() do
    1..Enum.random(5..10)
    |> Enum.map(fn _ ->
        random_string(Enum.random(6..20))
      end)
    |> Enum.join(" ")
  end

end
