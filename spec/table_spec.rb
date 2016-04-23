require 'table'

describe Table do
  let(:subject) { Table.new }

  describe '#valid_position?' do
    it 'returns true when the (x,y) are inside the table limits' do
      expect(subject.valid_position?(1, 2)).to be_truthy
      expect(subject.valid_position?(1, 2)).to be_truthy
    end

    it 'returns false when the x or y are less than 0' do
      expect(subject.valid_position?(-1, 2)).to be_falsey
      expect(subject.valid_position?(1, -1)).to be_falsey
    end

    it 'returns false when the x or y are >= to the table limits' do
      expect(subject.valid_position?(Table::WIDTH, 2)).to be_falsey
      expect(subject.valid_position?(1, Table::HEIGHT)).to be_falsey

      expect(subject.valid_position?(Table::WIDTH + 1, 2)).to be_falsey
      expect(subject.valid_position?(1, Table::HEIGHT + 1)).to be_falsey
    end
  end

  describe '#value_point_value?' do
    it 'returns true if value is an integer greater or equal to 0' do
      expect(subject.valid_point_value?(0)).to be_truthy
      expect(subject.valid_point_value?(1)).to be_truthy
      expect(subject.valid_point_value?(10)).to be_truthy
    end

    it 'returns true if value is an integer lower than 0' do
      expect(subject.valid_point_value?(-1)).to be_falsey
      expect(subject.valid_point_value?(-10)).to be_falsey
    end
  end
end
