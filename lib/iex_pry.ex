defmodule Greeter do
    @moduledoc """
    To run with iex and mix
        iex --werl -S mix
    """
    require IEx

    def ohai(who, adjective) do
        greeting = "Ohai!, #{adjective} #{who}"
        IEx.pry
    end

end 