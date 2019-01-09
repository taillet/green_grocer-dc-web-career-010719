require 'pry'

def consolidate_cart(cart)
<<<<<<< HEAD
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
=======
  # code here
  $cart_hash = {}
  coupon_hash = {}
  $new_hash = {}
  food =0
  $list = []
  diff = 0
  for food in 0...cart.length
    $list << cart[food].keys[0]
  end
  cart.each do |item|
    array = []
    array << item.values[0]
    array << {:count=>$list.count(item.keys[0])}
    $cart_hash.store(item.keys[0], array.reduce({}, :merge))
  end
   $cart_hash
end

def apply_coupons(cart, coupons)
  # code here
array = []
iarray = []
narray = []
carray = []
$coupi = []
$coupn = []
$coupc = []
food = 0
for food in 0...coupons.length
  $coupi << coupons[food][:item]
end
for food in 0...coupons.length
  $coupn << coupons[food][:num]
end
for food in 0...coupons.length
  $coupc << coupons[food][:cost]
end
if coupons.any? == false
  array << cart
elsif coupons.any? == true
  num = coupons.length-1
  w = 0
  for w in 0..num
    coupons[w].each do |label, info|
      if label == :item
        if cart.keys.include?(info) == false
          array << cart
        else
                  if $coupi.uniq.length != $coupi.length
                    iarray = $coupi.select{ |food| $coupi.count(food) > 1 }.uniq
                    narray = $coupn.select{ |food| $coupn.count(food) > 1 }.uniq
                    carray = $coupc.select{ |food| $coupc.count(food) > 1 }.uniq
                    howmany = iarray.length
                    for j in 0...howmany
                      amount = $coupi.count(iarray[j])
                      num = (narray[j])*amount
                      cost = carray[j]
                      newcoupons = []
                      newcoupons[j] = {:item=> iarray[j], :num=>num, :cost=>cost}
                      coupons.clear
                      coupons = newcoupons
                    end
                end
mun = coupons.length
k=0
          for k in 0...mun
            coupons[k].each do |label, info|
              string = ""
              if label == :item
                string = info+" W/COUPON"
                $new_hash = {string => cart[info].clone}
                $new_hash.values[0][:price] = coupons[k][:cost]
              elsif label == :num
                div = cart.values[0][:count] / info
                rem = cart.values[0][:count] % info
                diff = info - cart.values[0][:count]
                if div == 1
                  if rem == 0
                    $new_hash.values[0][:count] = 1
                    cart.values[0][:count] = 0
                    array << cart
                  elsif rem > 0
                    cart.values[0][:count] = rem
                    array << $cart_hash
                    $new_hash.values[0][:count] = div
                  end
                elsif div == 0
                  $new_hash.values[0][:count] = cart.values[0][:count]
                  cart.values[0][:count] = 0
                  array << cart
                elsif div > 1
                  cart[0][:count] = rem
                  array << cart
                end
              end
            end
          end
        end
      end
    end
  end
end
array << $new_hash
coupon_hash = array.reduce({}, :merge)

coupon_hash
>>>>>>> 993cd6632db601daf21787501609b244b840dc22
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

def checkout(cart:[], coupons:[])
  # code here
<<<<<<< HEAD
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
=======
  cart = consolidate_cart(cart: cart)
  cart = apply_coupons(cart: cart, coupons: coupons)
  cart = apply_clearance(cart: cart)

>>>>>>> 993cd6632db601daf21787501609b244b840dc22
end
