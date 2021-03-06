defmodule Brainfook do
  @moduledoc """
  Documentation for Brainfook.
  """

  @doc """
  Hello world.

  ## Examples

      iex> Brainfook.hello
      :world

  """
  def hello do
    :world
  end
end

defmodule Memory do
  defstruct prev: [], cur: [0]
end

defmodule Head do
  import Memory

  @doc ~S"""
    iex> Head.next(%Memory{prev: [1, 2, 3], cur: [4, 5, 6]})
    %Memory{prev: [1, 2, 3, 4], cur: [5, 6]}

    iex> Head.next(%Memory{cur: [1, 2, 3]})
    %Memory{prev: [1], cur: [2, 3]}

    iex> Head.next(%Memory{prev: [1, 2, 3], cur: [4]})
    %Memory{prev: [1, 2, 3, 4], cur: [0]}
  """
  def next(mem) do
    case mem.cur do
      [head] ->
        %{mem | prev: mem.prev ++ [head], cur: [0]}

      [head | tail] ->
        %{mem | prev: mem.prev ++ [head], cur: tail}
    end
  end

  @doc ~S"""
    iex> Head.prev(%Memory{prev: [1, 2, 3], cur: [4, 5, 6]})
    %Memory{prev: [1, 2], cur: [3, 4, 5, 6]}

    iex> Head.prev(%Memory{prev: [2, 3, 4], cur: [1]})
    %Memory{prev: [2, 3], cur: [4, 1]}

    iex> Head.prev(%Memory{prev: [], cur: [2, 3]})
    %Memory{prev: [], cur: [0, 2, 3]}
  """
  def prev(mem) do
    case Enum.reverse(mem.prev) do
      [] ->
        %{mem | cur: [0] ++ mem.cur}

      [head | tail] ->
        %{mem | prev: Enum.reverse(tail), cur: [head] ++ mem.cur}
    end
  end

  @doc ~S"""
    iex> Head.inc(%Memory{cur: [4, 5, 6]})
    %Memory{cur: [5, 5, 6]}

    iex> Head.inc(%Memory{cur: [1, 2, 3]})
    %Memory{cur: [2, 2, 3]}
  """
  def inc(mem) do
    case mem.cur do
      [head | tail] ->
        %{mem | cur: [head + 1] ++ tail}
    end
  end

  @doc ~S"""
    iex> Head.dec(%Memory{cur: [4, 5, 6]})
    %Memory{cur: [3, 5, 6]}

    iex> Head.dec(%Memory{cur: [1, 2, 3]})
    %Memory{cur: [0, 2, 3]}
  """
  def dec(mem) do
    case mem.cur do
      [head | tail] ->
        %{mem | cur: [head - 1] ++ tail}
    end
  end
end
