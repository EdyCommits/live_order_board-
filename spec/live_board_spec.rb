require 'live_board'

describe 'LiveBoard' do

  it 'starts empty' do
    board = LiveBoard.new

    expect(board.all_orders.length).to eq 0
  end

  it 'stores registered orders' do
    board = LiveBoard.new

    order1 = Order.new(user_id: "user", quantity: 10, price_per_kg: 50, type: :sell)
    order2 = Order.new(user_id: "user1", quantity: 1, price_per_kg: 10, type: :buy)

    board.register(order1)
    board.register(order2)

    expect(board.all_orders.length).to eq 2
    expect(board.all_orders[0]).to eq order1
    expect(board.all_orders[1]).to eq order2
  end

  it 'generates empty summary when no orders registered' do
    board = LiveBoard.new

    expect(board.summary).to eq "There are no orders registered."
  end

  it 'generates summary of one sell order' do
    board = LiveBoard.new

    board.register(Order.new(user_id: "user1", quantity: 7.5, price_per_kg: 80, type: :sell))

    expect(board.summary).to eq "- 7.5kg for £80"
  end

  it 'generates summary of sell orders in ascending order by price' do
    board = LiveBoard.new

    board.register(Order.new(user_id: "user1", quantity: 5.5, price_per_kg: 100, type: :sell))
    board.register(Order.new(user_id: "user2", quantity: 10, price_per_kg: 50.78, type: :sell))
    board.register(Order.new(user_id: "user3", quantity: 3.2, price_per_kg: 75, type: :sell))

    expect(board.summary).to eq(
      "- 10kg for £50.78\n" +
      "- 3.2kg for £75\n" +
      "- 5.5kg for £100"
    )
  end

end
