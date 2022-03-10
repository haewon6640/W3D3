1...5
def range(start,endV)
    
    return [] if endV <= start
    
    arr = []
    arr << start 
    arr.concat( range(start+1,endV) )
    
end

# this is math, not Ruby methods.
# p range(1,5)

def exp(b , n)
    #takes in n 
    return 1 if n == 0 
    
    return b * exp(b,n-1) 

end

def exp2(b,n)

    return 1 if n == 0 
    return b if n == 1

    if n.even?
        exp2(b,n/2) ** 2
    else
        b * (exp2(b,(n-1)/2) ** 2)
    end

end
# recursion 1
# exp(b, 0) = 1
# exp(b, n) = b * exp(b, n - 1)

# recursion 2
# p exp(b, 0) = 1
# p exp(4, 2)
# p exp2(5, 3)
# p exp(b, n) = exp(b, n / 2) ** 2             [for even n]
# p exp(b, n) = b * (exp(b, (n - 1) / 2) ** 2) [for odd n]
# arr = [1,2,3,4,5]
# duplicate_arr = arr
# duplicate_arr[1] = 5
# duplicate_arr = [1,5,3,4,5]
# arr = [1,5,3,4,5]

# arr = [[1,2,3][4,5,6]]
# dup_arr = arr.dup
# dup_arr[1] = [6,7,8]
# dup_arr[[1,2,3][6,7,8]]
# arr = [[1,2,3][4,5,6]]

# dup_arr[0] << 4
# dup_arr[[1,2,3,4],[6,7,8]]
# arr[[1,2,3,4],[6,7,8]]
class Array

    def deep_dup
        arr = Array.new(0)
        self.each do |ele|
            if ele.is_a?(Array)
                arr += ele.deep_dup
            else
                arr << ele
            end
        end
        arr
    end

end

# arr = [1, [2], [3, 4,[5]]]

# robot_parts = [
#   ["nuts", "bolts", "washers"],
#   ["capacitors", "resistors", "inductors"]
# ]

# robot_parts_copy = robot_parts.deep_dup

# # shouldn't modify robot_parts
# robot_parts_copy[1] << "LEDs"
# # but it does
# p robot_parts[1] # => ["capacitors", "resistors", "inductors", "LEDs"]

def rec_fib(n)

    return 1 if n == 1
    return 1 if n == 2


    rec_fib(n-1) + rec_fib(n-2)

end

# p rec_fib(3)

def itr_fib(n)
    
    sum = 1 
    first = 1
    second = 1
    
    while n > 2

        sum = first + second
        first = second
        second = sum 

        n -= 1
    end
    sum
end

def bsearch(arr,target)
    return nil if arr.length == 0
    mid = arr.length/2
    if arr[mid] == target
        return mid
    elsif arr[mid] > target
        return bsearch(arr[0...mid],target) 
    else
        val = bsearch(arr[mid+1..-1], target)
        return val.nil? ? nil : mid + 1 + val
    end
end

# p bsearch([1, 2, 3], 1) # => 0
# p bsearch([2, 3, 4, 5], 3) # => 1
# p bsearch([2, 4, 6, 8, 10], 6) # => 2
# p bsearch([1, 3, 4, 5, 9], 5) # => 3
# p bsearch([1, 2, 3, 4, 5, 6,7,9,20,25,30,40], 25) # => 5
# p bsearch([1, 2, 3, 4, 5, 6], 0) # => nil
# p bsearch([1, 2, 3, 4, 5, 7], 6) # => nil
    #binary search of an array 
    #b_search(arr,target) 
    #basecase


    #case 1
        #arr[arr.length/2] == target return arr.length/2+1
    #case 2
        #arr[arr.length/2] > target b_search(arr[0...arr.length/2], target) 
    #case 3
        #arr[arr.length/2] < target b_search(arr[arr.length/2 + 1..-1], target)  + arr.length/2
# p itr_fib(7)

def merge_sort(arr)
    return arr if arr.length <= 1
    
    mid = arr.length / 2 
    print arr[0...mid].to_s + "   " 
    print arr[mid..-1]
    puts
    merge(merge_sort(arr[0...mid]),merge_sort(arr[mid..-1]))
end

# merge(first[1,3,6],second[0,4,7])
def merge(arr1,arr2)
    merged_arr = Array.new(0)
    #pointer logic
    pointer1 = 0
    pointer2 = 0

    while pointer1 < arr1.length && pointer2 < arr2.length
        if arr1[pointer1] > arr2[pointer2]
            merged_arr << arr2[pointer2]
            pointer2 += 1
        else 
            merged_arr << arr1[pointer1]
            pointer1 += 1
        end  
    end

    if pointer1 == arr1.length
        merged_arr.concat(arr2[pointer2..-1])
    else
        merged_arr.concat(arr1[pointer1..-1])
    end
    p "Merged #{arr1} and #{arr2} got #{merged_arr}"
    merged_arr
end

# p merge_sort([7,2,5,0,-2,3])
# we take out 1 from the arr somemethod(1) subsets([2,3])
# subsets([2,3]) take somemethod(2) then run subsets([3])
# store subsetThree = subsets([3])
# moreSubsets = subsetThree.map {|subset| subset << 2}
# store subsetTwo = subsets([2,3])
# moreSubse

def subsets(arr)
    return [[]] if arr.length == 0
    aset = subsets(arr[0...-1])
    bset = aset.map { |el| el + [arr[-1]]}
    aset.concat(bset)
end

# p subsets([]) # => [[]]
# p subsets([1]) # => [[], [1]]
# p subsets([1, 2]) # => [[], [1], [2], [1, 2]]
# p subsets([1, 2, 3])
# => [[], [1], [2], [1, 2], [3], [1, 3], [2, 3], [1, 2, 3]]

def permutations(arr)
    result = []
    return [[]] if arr.length == 0 

    spa = permutations(arr[0...-1])
   
    spa.each do |subarray|
        (0..arr.length-1).each do |i|
            result << subarray[0...i] + [arr[-1]] + subarray[i..-1]
        end
    end
    result
end

p permutations([1, 2, 3]) # => [[1, 2, 3], [1, 3, 2],
                        #     [2, 1, 3], [2, 3, 1],
                        #     [3, 1, 2], [3, 2, 1]]