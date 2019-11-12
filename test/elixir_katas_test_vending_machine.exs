defmodule ElixirKatasVendingMachine do
  use ExUnit.Case
  alias ElixirKatas.VendingMachine, as: VendingMachine

  # Before each test create an intial vending machine state
  setup do
    vending_machine_state = VendingMachine.new()
    %{:state => Map.from_struct(vending_machine_state)}
  end

  test "No coins have been inserted in the vending machine", context do
    assert context[:state] |> VendingMachine.insert_coin() == %{
             current_amount: 0.00,
             coin_return: 0.00,
             msg: "INSERT COIN"
           }
  end

  test "The vending machine accepts valid coins", context do
    assert context[:state]
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("DIME")
           |> VendingMachine.insert_coin("DIME")
           |> VendingMachine.insert_coin("NICKEL") == %{
             current_amount: 1.25,
             coin_return: 0.00,
             msg: ""
           }
  end

  test "The vending machine accepts valid coins and rejects invalid ones", context do
    assert context[:state]
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("PENNY")
           |> VendingMachine.insert_coin("PENNY") ==
             %{
               current_amount: 0.50,
               coin_return: 0.02,
               msg: ""
             }
  end

  test "The user inserts enough change for a cola and selects the product", context do
    assert context[:state]
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.select_product("COLA") ==
             %{
               current_amount: 0.00,
               coin_return: 0.00,
               msg: "THANK YOU"
             }
  end

  test "The user inserts enough change for a cola and selects the product then selects the product again after the cola has been dispensed",
       context do
    assert context[:state]
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.select_product("COLA")
           |> VendingMachine.select_product("COLA") ==
             %{
               current_amount: 0.00,
               coin_return: 0.00,
               msg: "INSERT COIN"
             }
  end

  test "The user doesn't insert enough change and selects a cola", context do
    assert context[:state]
    |> VendingMachine.insert_coin("QUARTER")
    |> VendingMachine.insert_coin("QUARTER")
    |> VendingMachine.select_product("COLA") ==
      %{
        current_amount: 0.50,
        coin_return: 0.00,
        msg: "PRICE 1.0"
      }
  end

  test "The user doesn't insert enough change and selects a candy", context do
    assert context[:state]
    |> VendingMachine.insert_coin("QUARTER")
    |> VendingMachine.insert_coin("QUARTER")
    |> VendingMachine.select_product("CANDY") ==
      %{
        current_amount: 0.50,
        coin_return: 0.00,
        msg: "PRICE 0.65"
      }
  end

end
