defmodule ElixirKatas.VendingMachine.State do
  defstruct current_amount: 0.00, coin_return: 0.00, msg: ""
end

defmodule ElixirKatas.VendingMachine do
  @moduledoc """
    - Implements the Vending machine Kata [https://github.com/guyroyse/vending-machine-kata]
  """
  @insert_coin_msg "INSERT COIN"
  @vending_machine_coin_mapping %{
    "QUARTER" => 0.25,
    "DIME" => 0.10,
    "NICKEL" => 0.05,
    "PENNY" => 0.01
  }
  @vending_machine_products %{
    "COLA" => 1.00,
    "CHIPS" => 0.50,
    "CANDY" => 0.65
  }

  def new do
    %ElixirKatas.VendingMachine.State{}
  end

  def insert_coin(state), do: %{state | :msg => @insert_coin_msg}

  def insert_coin(state, coin) when coin != "PENNY", do: update_state(state, coin, :current_amount)

  def insert_coin(state, coin), do: update_state(state, coin, :coin_return)

  def select_product(state, product) do
    cond do
      state[:current_amount] == @vending_machine_products[product] ->
        %{state | :msg => "THANK YOU", :current_amount => 0.00}
      state[:current_amount] == 0 -> 
        %{state | :msg => "INSERT COIN", :current_amount => 0.00}
      state[:current_amount] < @vending_machine_products[product] ->
        %{state | :msg => "PRICE #{@vending_machine_products[product]}"}
    end
  end

  def update_state(state, coin, key_to_update) do
    Map.update!(state, key_to_update, fn key ->
      Float.round(key + @vending_machine_coin_mapping[coin], 2)
    end)
  end
end
