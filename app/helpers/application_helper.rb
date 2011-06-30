module ApplicationHelper
  
  # Return a title on a per-page basis.
  def global_title
    base_title = "Mole Valley Farmers Uniforms"
    @title ? base_title + " | " + @title : base_title
  end
  
  # Return a body id on a per-page basis.
  def body_id
    @title ? @title.downcase : nil
  end
  
  # Helper to format prices (stored in pence), as £pounds.pence in views.
  def format_price(amount)
    amount = amount.round
    pounds, pence = amount.divmod(100)
    raw sprintf("&pound;%d.%02d", pounds, pence)
  end
  
  # Helper to format prices (stored in pence), as pounds.pence (no £ symbol) for passing to forms
  def format_price_simple(amount)
  	amount = amount.round
    pounds, pence = amount.divmod(100)
    raw sprintf("%d.%02d", pounds, pence)
  end
  
end
