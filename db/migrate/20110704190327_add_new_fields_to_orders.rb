class AddNewFieldsToOrders < ActiveRecord::Migration
  def self.up
    change_table :orders do |t|
      t.text   :address
      t.string :employee, :order_number
    end
  end

  def self.down
    change_table :orders do |t|
      t.remove :address, :employee, :order_number
    end
  end
end
