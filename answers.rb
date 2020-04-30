# Back in the good old days, you used to be able to write a darn near
# uncrackable code by simply taking each letter of a message and incrementing it
# by a fixed number, so "abc" by 2 would look like "cde", wrapping around back
# to "a" when you pass "z".  Write a function, `caesar_cipher(str, shift)` which
# will take a message and an increment amount and outputs the encoded message.
# Assume lowercase and no punctuation. Preserve spaces.
#
# To get an array of letters "a" to "z", you may use `("a".."z").to_a`. To find
# the position of a letter in the array, you may use `Array#find_index`.

def caesar_cipher(str, shift)
  ciphed = []
  str.chars.each do |char|
    if char.match(/[a-z]/i) == nil
      ciphed << char
    else
      ciphed << ciphe(char, shift)
    end
  end
  ciphed.join('')
end

def ciphe(letter, shift)
  alphabet = ('a'..'z').to_a
  letter_idx = alphabet.find_index(letter)

  new_idx = letter_idx + shift
  new_idx -= 26 if new_idx > 25

  alphabet[new_idx]
end

# Write a method, `digital_root(num)`. It should Sum the digits of a positive
# integer. If it is greater than 10, sum the digits of the resulting number.
# Keep repeating until there is only one digit in the result, called the
# "digital root". **Do not use string conversion within your method.**
#
# You may wish to use a helper function, `digital_root_step(num)` which performs
# one step of the process.

def digital_root(num)
  if num >= 10
    num_split = digital_root_step(num)
    digital_root(num_split.reduce(:+))
  else
    return num
  end
end

def digital_root_step(num)
  "#{num}".chars.map { |n| n.to_i }
end

# Jumble sort takes a string and an alphabet. It returns a copy of the string
# with the letters re-ordered according to their positions in the alphabet. If
# no alphabet is passed in, it defaults to normal alphabetical order (a-z).

# Example:
# jumble_sort("hello") => "ehllo"
# jumble_sort("hello", ['o', 'l', 'h', 'e']) => 'ollhe'

def jumble_sort(str, alphabet = nil)
  alphabet ||= ('a'..'z').to_a
  sorted = []

  # traverse str, finding the letters that come out in the alphabet first
  alphabet.each do |alpha|
    sorted << str.scan(/#{alpha}/i).join('')
  end

  sorted.join('')
end

class Array
  # Write a method, `Array#two_sum`, that finds all pairs of positions where the
  # elements at those positions sum to zero.

  # NB: ordering matters. I want each of the pairs to be sorted smaller index
  # before bigger index. I want the array of pairs to be sorted
  # "dictionary-wise":
  #   [0, 2] before [1, 2] (smaller first elements come first)
  #   [0, 1] before [0, 2] (then smaller second elements come first)

  def two_sum
    zero_pair_idxs = []

    0.upto(self.length-2).each do |idx1|
      idx1.upto(self.length-1).each do |idx2|
        next if idx1 == idx2
        n1, n2 = self[idx1], self[idx2]
        zero_pair_idxs << [idx1, idx2] if n1 + n2 == 0
      end
    end

    zero_pair_idxs
  end
end

class String
  # Returns an array of all the subwords of the string that appear in the
  # dictionary argument. The method does NOT return any duplicates.

  def real_words_in_string(dictionary)
    dictionary.select do |real_word|
      self.match(/#{real_word}/i)
    end
  end
end

# Write a method that returns the factors of a number in ascending order.

def factors(num)
  facs = []
  (1..num).each do |n|
    facs << n if num % n == 0
  end
  facs
end
