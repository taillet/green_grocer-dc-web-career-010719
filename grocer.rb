def consolidate_cart(cart)
cart_hash = {}
  cart.uniq.each do |item|
    cart_hash.store(item.keys[0], item.values[0])
    cart_hash[item.keys[0]].merge!({:count=>cart.count(item)})
  end
 cart_hash
end

def apply_coupons(cart, coupons)
  string = []
  if coupons.any?
    coupons.each do |coupon|
      if coupons.count(coupon) > 1
        old_num = 0
        old_num = coupon[:num]
        coupon[:num] = old_num*coupons.count
        coupon[:count] = coupons.count
        coupons = coupons.uniq
      end
    end
  coupons.each do |coupon|
    count_array = []
    if cart.keys.include?(coupon[:item]) and cart[coupon[:item]][:count]>=coupon[:num]
       string = coupon[:item]+" W/COUPON"
       count_array = coupon_count(cart, coupon[:item], coupon)
       cart[coupon[:item]][:count] = count_array[0]
       cart[string] = {:price => coupon[:cost],
       :clearance => cart[coupon[:item]][:clearance],
       :count => !coupon[:count].nil? ? coupon[:count] : count_array[1]}
    else
      cart
    end
   end
  end
  cart
end

def coupon_count(cart, item, coupon)
 count_array = []
 count = cart[item][:count]
 num = coupon[:num].to_i
 div = count / num
 rem = count % num
 diff = count - num
 if div == 1
   if rem == 0
  # 0 = old item, 1 = coupon item
      count_array[0] = rem
      count_array[1] = div
    elsif rem > 0
      count_array[0] = diff
      count_array[1] = div
    end
  elsif div == 0
    count_array[0] = 0
    count_array[1] = count
  elsif div > 1
    count_array[0] = diff
    count_array[1] = div
  end
  return count_array
end

def apply_clearance(cart)
  # code here
  cart.each do |label, info|
    if info[:clearance] == true
      info[:price] = (info[:price].to_f*".8".to_f).round(2)
    end
  end
  cart
end

def checkout(cart, coupons)
  # code here
  total = 0.0
   cart = consolidate_cart(cart)
   cart = apply_coupons(cart, coupons)
   cart = apply_clearance(cart)
   cart.each do |item|
     if item[1][:count] != 0
       if item[0].split.length != 2
         total += item[1][:price]*item[1][:count]
       else
         total += item[1][:price]
       end
      end
   end
total
end