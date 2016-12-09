class AddStripeCustomerIdToUsers < ActiveRecord::Migration[5.0]
  def change
    add_column :users, :subid, :string
  end
end
