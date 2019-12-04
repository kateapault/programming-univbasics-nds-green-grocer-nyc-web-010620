def find_item_by_name_in_collection(name, collection)
  # Implement me first!
  #
  # Consult README for inputs and outputs
  
  for item in collection do
    if item[:item] == name
      return item  
    end
  end
  nil
end

def consolidate_cart(cart)
  # INPUTS: AoH
  # OUTPUTS: Array where every unique item is present
  # every item should have a :count attribute
  # every item's :count should be >= 1
  
  unique_cart = []
  items_in_cart_so_far = []
  for item in cart do
    item_name = item[:item]
    if items_in_cart_so_far.include?(item_name)
      ind = items_in_cart_so_far.index(item_name)
      unique_cart[ind][:count] += 1
    else
      item[:count] = 1
      unique_cart << item
      items_in_cart_so_far << item_name
    end
  end  
  
  unique_cart
end


def apply_coupons(cart, coupons)
  # INPUTS: Array of item hashes
  #         Array of coupon hashes
  # OUTPUTS: array of item hashes (some with ITEM W/ COUPON)
  # REMEMBER: This method **should** update cart
  # if coupon is for 2 of an item and there are 3 of that item in the cart,
  # returned cart should have both "item x count: 1" and "item w/ coupon count: 2" hashes
  
  coupon_updates = []
  
  for item in cart do
    coupon = find_item_by_name_in_collection(item[:item], coupons)
    if coupon
      num_not_in_coupon = item[:count] % coupon[:num]
      
      items_with_coupon = {}
      items_with_coupon[:item] = item[:item] + " W/COUPON"
      items_with_coupon[:price] = (coupon[:cost] / coupon[:num])
      items_with_coupon[:clearance] = item[:clearance]
      items_with_coupon[:count] = (item[:count] - num_not_in_coupon)
      
      item[:count] = num_not_in_coupon  
        
      coupon_updates.push(items_with_coupon)
    end
  end
  cart += coupon_updates
  cart
end


def apply_clearance(cart)
  # Consult README for inputs and outputs
  #
  # REMEMBER: This method **should** update cart
  cart = consolidate_cart(cart)
  for item in cart do
    if item[:clearance]
      item[:price] = (item[:price] * 0.8).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # INPUTS: 
  
  consolidated_cart = consolidate_cart(cart)
  applied_coupons = apply_coupons(consolidated_cart)
  final_cart = apply_clearance(applied_coupons)
  
  
  
end

test1cart = [{:item=>"AVOCADO", :price=>3.0, :clearance=>true, :count=>2}]
test1coupons = [{:item=>"AVOCADO", :num=>2, :cost=>5.0}]

p apply_coupons(test1cart,test1coupons)
