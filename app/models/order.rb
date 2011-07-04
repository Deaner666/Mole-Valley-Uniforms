# == Schema Information
# Schema version: 20110704190327
#
# Table name: orders
#
#  id           :integer         not null, primary key
#  branch       :string(255)
#  created_at   :datetime
#  updated_at   :datetime
#  contact      :string(255)
#  job_title    :string(255)
#  address      :text
#  employee     :string(255)
#  order_number :string(255)
#

class Order < ActiveRecord::Base
  
  has_many :line_items
  has_many :products, :through => :line_items
  
  accepts_nested_attributes_for :line_items,
    :reject_if => lambda { |a| a[:quantity].blank? }
  
  validates :branch, :presence => true
  validates :contact, :presence => true
  validates :job_title, :presence => true
  validates :address, :presence => true
  validates :employee, :presence => true
  validates :order_number, :presence => true
  
  # Find the total cost of an order by summing the cost of its line_items
  def total
    self.line_items.inject(0) {|x, li| x + li.total }
  end
  
  # If a combination of product and size already exists amongst an order's line_items, return true,
  # else return false
  def has_line_item?(product_id, size)
    bool = false
    for li in self.line_items
      if li.product_id == product_id && li.size == size
        bool = true
      end
    end
    return bool
  end
  
  # Return an array with similar line_items (same product and same size) merged
  def line_items_crunched
    # lis_crunched = []
    # for li in self.line_items
    #   lis_crunched.find(lis_crunched << li){ |lic| lic.product_id == li.product_id && lic.size == li.size }.quantity += li.quantity if li.quantity
    # end
    
    # new_array = array.map {|v,w| [v,w, array.select {|b,c|
    #    b == v && c == w }.inject(0){|m,b| m + b.last}]}.uniq
    
    self.line_items.group(["product_id", "size"])
    
  end
  
end
