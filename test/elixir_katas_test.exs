defmodule ElixirKatasTest do
  use ExUnit.Case

  test "Fizz" do
    assert ElixirKatas.FizzBuzz.start(6) == "Fizz"
  end

  test "Buzz" do
    assert ElixirKatas.FizzBuzz.start(20) == "Buzz"
  end

  test "Fizz Buzz" do
    assert ElixirKatas.FizzBuzz.start(15) == "Fizz Buzz"
  end

  test "List Fizz Buzz" do
    assert ElixirKatas.FizzBuzz.start([9, 15, 20, 25, 30, 12, 10]) == ["Fizz", "Fizz Buzz", "Buzz", "Buzz", "Fizz Buzz", "Fizz", "Buzz"]
  end

  test "Convert integers to Roman Numerals" do
    assert ElixirKatas.RomanNumeral.convert_int_to_roman_numeral([20, 10, 35, 333, 666, 1205, 550, 633, 734, 30]) ==
    ["XX", "X", "XXXV", "CCCXXXIII", "DCLXVI", "MCCV", "DL", "DCXXXIII", "DCCXXXIV", "XXX"]
  end


end
