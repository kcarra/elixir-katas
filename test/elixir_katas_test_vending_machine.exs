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
             msg: "INSERT COIN",
             stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
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
             msg: "",
             stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
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
               msg: "",
               stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
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
               msg: "THANK YOU",
               stock: %{"COLA" => 9, "CHIPS" => 10, "CANDY" => 10}
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
               msg: "INSERT COIN",
               stock: %{"COLA" => 9, "CHIPS" => 10, "CANDY" => 10}
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
               msg: "PRICE 1.0",
               stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
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
               msg: "PRICE 0.65",
               stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
             }
  end

  test "The user inserts more change then the cost of the product", context do
    assert context[:state]
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.select_product("CANDY") ==
             %{
               current_amount: 0.00,
               coin_return: 0.10,
               msg: "",
               stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 9}
             }
  end

  test "The user decides he would no longer like something and wants his coins returned", context do
    assert context[:state]
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.return_coins() ==
             %{
               current_amount: 0.00,
               coin_return: 0.75,
               msg: "INSERT COIN",
               stock: %{"COLA" => 10, "CHIPS" => 10, "CANDY" => 10}
             }
  end

  test "The user selects a product that is sold out after inserting coins", context do
    assert %{context[:state] | :stock => %{"COLA" => 10, "CHIPS" => 0, "CANDY" => 10}}
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.insert_coin("QUARTER")
           |> VendingMachine.select_product("CHIPS") ==
             %{
               current_amount: 0.50,
               coin_return: 0.00,
               msg: "SOLD OUT",
               stock: %{"COLA" => 10, "CHIPS" => 0, "CANDY" => 10}
             }
  end

  test "The vending machine displays 'EXACT CHANGE ONLY' when it isn't able to make change for any of the items it", context do
      assert true
  end
end
