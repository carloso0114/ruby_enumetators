require './e_methods.rb'

describe Enumerable do
  let(:arr) { [1, 2, 3, 4] }
  let(:arr2) { ['hello', 'hey', 'hola'] }
  let(:ha) { { 'key1': 'green', 'key2': 'purple', 'key3': 'black' } }
  let(:ra) { (0..10) }
  let(:empty_arr) { [] }
  let(:other_val) { [false, true, nil] }

  describe "#my_each" do
    it "returns an enumerator if no block is given" do
      expect(arr.my_each.is_a?(Enumerator)).to eql(true)
    end

    it "iterates to each one of the elements of an array" do
      i = 0
      arr.my_each do |el| 
        expect(el).to eql(arr[i])
        i += 1
      end
    end

    it "iterates to each one of the elements of a hash" do
      ha.my_each do |key, val|
        expect(val).to eql(ha[key])
      end
    end
  end

  describe "#my_each_with_index" do
    it "returns an enumerator if no block is given" do
      expect(arr.my_each_with_index.is_a?(Enumerator)).to eql(true)
    end

    it "iterates to each one of the elements of an array and check the index" do
      i = 0
      arr.my_each_with_index do |el, ind| 
        expect(el).to eql(arr[i])
        expect(ind).to eql(i)
        i += 1
      end
    end
  end

  describe "#my_select" do
    it "returns an enumerator if no block is given" do
      expect(arr.my_select.is_a?(Enumerator)).to eql(true)
    end

    it "returns a new array according to the block's condition" do
      expect(arr.my_select(&:even?)).to eql([2, 4])
    end

    it "returns a new array" do
      expect(ra.my_select(&:odd?)).to eql([1, 3, 5, 7, 9])
    end

    it "returns a new hash matching keys and values" do
      expect(ha.my_select { |_k, v| v.length == 5 }).to eql({ 'key1': 'green', 'key3': 'black' })
    end
  end

  describe "#my_all?" do
    context "block is given and argum is not nil" do
      it "returns true if element is nil" do
        expect(arr.my_all?(Numeric) { |el| el > 0}).to eql(true)
      end
    end

    context "block is given and argum is nil" do
      it "returns false if not all elements are true according to condition" do
        expect(ra.my_all? { |el| el > 1}).to eql(false)
      end
    end

    context "block not given and argum is nil" do
      it "returns false if element is equal to nil or false" do
        expect(other_val.my_all?).to eql(false)
      end
    end
  end

  describe "#my_any?" do
    context "block is given and argum is an instance of Regexp" do
      it "returns true if argument match element" do
        expect(arr2.my_any?(/y/) { |el| el.length > 5 }).to eql(true)
      end
    end

    context "block is given and argum is nil" do
      it "returns false according to block's condition" do
        expect(arr.my_any? { |el| el > 4 }).to eql(false)
      end
    end

    context "block not given and argum is nil" do
      it "returns true if element is not equal to nil or false" do
        expect(arr2.my_any?).to eql(true)
      end
    end
  end

  describe "#my_none?" do
    context "block not given and argum is nil" do
      it "returns true if none of the elements is true" do
        expect(empty_arr.my_none?).to eql(false)
      end
    end

    context "block is given and argum is nil" do
      it "returns true if the block doesn't return true" do
        expect(ra.my_none? { |n| n > 10 }).to eql(true)
      end
    end
  end

  describe "#my_count" do

  end

  describe "#my_map" do

  end

  describe "#my_inject" do

  end

  describe "#multiply_els" do

  end
end