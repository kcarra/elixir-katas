defmodule ElixirKatas.VendingMachine.State do
  defstruct current_amount: 0.00,
            coin_return: 0.00,
            msg: "",
            stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
end

defmodule ElixirKatas.VendingMachine do
  @moduledoc """
    - Implements the Vending machine Kata [https://github.com/guyroyse/vending-machine-kata]
  """
  @insert_coin_msg "INSERT COIN"
  @thank_you "THANK YOU"
  @sold_out "SOLD OUT"
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

  def insert_coin(state, coin) when coin != "PENNY",
    do: update_state(state, coin, :current_amount)

  def insert_coin(state, coin), do: update_state(state, coin, :coin_return)

  def select_product(state, product) do
    cond do
      state[:stock][product] == 0 ->
        %{state | :msg => @sold_out}

      state[:current_amount] == @vending_machine_products[product] ->
        %{
          state
          | :msg => @thank_you,
            :current_amount => 0.00,
            :stock => %{state[:stock] | product => state[:stock][product] - 1}
        }

      state[:current_amount] == 0 ->
        %{state | :msg => @insert_coin_msg, :current_amount => 0.00}

      state[:current_amount] < @vending_machine_products[product] ->
        %{state | :msg => "PRICE #{@vending_machine_products[product]}"}

      state[:current_amount] > @vending_machine_products[product] ->
        %{
          state
          | :msg => "",
            :current_amount => 0.00,
            :coin_return =>
              Float.round(state[:current_amount] - @vending_machine_products[product], 2),
            :stock => %{state[:stock] | product => state[:stock][product] - 1}
        }

      true ->
        state
    end
  end

  def return_coins(state) do
    %{
      state
      | :coin_return => state[:current_amount],
        :current_amount => 0.00,
        :msg => @insert_coin_msg
    }
  end

  def update_state(state, coin, key_to_update) do
    Map.update!(state, key_to_update, fn key ->
      Float.round(key + @vending_machine_coin_mapping[coin], 2)
    end)
  end
end
