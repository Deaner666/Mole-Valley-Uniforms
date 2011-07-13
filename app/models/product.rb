# == Schema Information
# Schema version: 20110713205238
#
# Table name: products
#
#  id                 :integer         not null, primary key
#  name               :string(255)
#  stock_code         :string(255)
#  price              :integer
#  created_at         :datetime
#  updated_at         :datetime
#  image_file_name    :string(255)
#  image_content_type :string(255)
#  image_file_size    :integer
#  image_updated_at   :datetime
#

class Product < ActiveRecord::Base
  
  has_many :line_items
  has_many :orders, :through => :line_items
  has_and_belongs_to_many :sizes
  
  has_attached_file :image, :styles => { :thumbnail => "75>x75", :large => "300>x300" },
                            :storage => :s3,
                            :bucket => 'molevalleyfarmers',
                            :s3_credentials => "#{Rails.root}/config/s3.yml"
  
  validates :name,       :presence => true
  validates :stock_code, :presence => true
  validates :price,      :presence => true,
                         :numericality => {
                          :only_integer => true,
                          :greater_than_or_equal_to => 0
                         }
  
   # Get this product's line_item for a given order
   def line_item(order)
     result = nil
     for line_item in self.line_items
       if line_item.order_id == order.id
         result = line_item
       end
     end
     if result == nil
       raise NoLineItemError
     end
   end
                         
end
