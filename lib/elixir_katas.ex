defmodule ElixirKatas.FizzBuzz do
  @moduledoc """
  Implements the FizzBuzz kata
    - Takes an integer or a list of integers. If the Integer is divisible by 5 and 3 it returns
      "Fizz Buzz" if the integer is divisible by only 5 it returns "Buzz" if the integer is divisble
      by only 3 it returns "Fizz"
  """
  def start(int) when is_list(int) do
    Enum.map(int, &start/1)
  end

  def start(int) do
    cond do
      rem(int, 5) == 0 and rem(int, 3) == 0 ->
        "Fizz Buzz"

      rem(int, 5) == 0 ->
        "Buzz"

      rem(int, 3) == 0 ->
        "Fizz"

      true ->
        int
    end
  end
end

defmodule FizzBuzzPatternMatching do
  def go(min, max), do: Enum.each(min..max, &go/1)
  def go(num) do
    case {rem(num, 5), rem(num, 3)} do
      {0, 0} -> IO.puts "FizzBuzz"
      {0, _} -> IO.puts "Fizz"
      {_, 0} -> IO.puts "Buzz"
      _ -> num
    end
  end
end


defmodule ElixirKatas.RomanNumeral do
  @moduledoc """
  Implements the Roman numeral Kata
    - Takes an integer or a list of integers and converts it to a Roman Numeral
  """
  @decimal_value [1000, 900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4, 1]
  @numeral_value ["M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I"]

  def convert_int_to_roman_numeral(int) when is_list(int) do
    Enum.map(int, fn x ->
      convert_int_to_roman_numeral(x)
    end)
  end

  def convert_int_to_roman_numeral(int, roman_numeral \\ "")

  def convert_int_to_roman_numeral(int, roman_numeral) when int == 0 do
    roman_numeral
  end

  def convert_int_to_roman_numeral(int, roman_numeral) do
    {decimal, index} =
      @decimal_value
      |> Enum.with_index()
      |> Enum.find(fn {roman_decimal, _} -> div(int, roman_decimal) > 0 end)

    roman_numeral = roman_numeral <> "#{Enum.at(@numeral_value, index)}"
    convert_int_to_roman_numeral(int - decimal, roman_numeral)
  end
end
