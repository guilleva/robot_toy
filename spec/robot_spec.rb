require 'robot'

describe Robot do
  let(:table) { Table.new }
  let(:subject) { Robot.new(table) }

  describe '#initialize' do
    it 'assigns the table attribute' do
      robot = Robot.new(table)
      expect(robot.table).to eql table
    end

    it 'initializes the position with nil' do
      robot = Robot.new(table)
      expect(robot.x).to be_nil
      expect(robot.y).to be_nil
      expect(robot.face).to be_nil
    end
  end

  describe '#in_table?' do
    it 'returns true if the robot has been positioned in the table' do
      subject.place(0, 0, 'NORTH')
      expect(subject.in_table?).to be_truthy
    end

    it 'returns false if the robot has not been positioned in the table' do
      expect(subject.in_table?).to be_falsey
    end
  end

  describe '#place' do
    it 'assigns the values to the attributes' do
      subject.place(1, 2, 'NORTH')
      expect(subject.x).to eql 1
      expect(subject.y).to eql 2
      expect(subject.face).to eql 'NORTH'

      subject.place(0, 0, 'SOUTH')
      expect(subject.x).to eql 0
      expect(subject.y).to eql 0
      expect(subject.face).to eql 'SOUTH'
    end

    it 'ignores invalid values for X attribute' do
      subject.place('a', 2, 'NORTH')
      expect(subject.x).to be_nil
      expect(subject.y).to be_nil
      expect(subject.face).to be_nil

      subject.place(-1, 2, 'NORTH')
      expect(subject.x).to be_nil
      expect(subject.y).to be_nil
      expect(subject.face).to be_nil
    end
  end

  describe '#move' do
    let(:subject) { Robot.new(table) }

    it 'does nothing if the robot has not been positioned in the table' do
      expect do
        subject.move
      end.not_to change(subject, :position)
    end

    it 'does nothing if the move will make it fall off the table - NORTH' do
      subject.place(4, 4, 'NORTH')
      expect do
        subject.move
      end.not_to change(subject, :position).from([4, 4, 'NORTH'])
    end

    it 'does nothing if the move will make it fall off the table - SOUTH' do
      subject.place(1, 0, 'SOUTH')
      expect do
        subject.move
      end.not_to change(subject, :position).from([1, 0, 'SOUTH'])
    end

    it 'does nothing if the move will make it fall off the table - EAST' do
      subject.place(4, 0, 'EAST')
      expect do
        subject.move
      end.not_to change(subject, :position).from([4, 0, 'EAST'])
    end

    it 'does nothing if the move will make it fall off the table - WEST' do
      subject.place(0, 4, 'WEST')
      expect do
        subject.move
      end.not_to change(subject, :position).from([0, 4, 'WEST'])
    end

    it 'moves the robot one position to the NORTH' do
      subject.place(0, 0, 'NORTH')
      expect do
        subject.move
      end.to change(subject, :position).to([0, 1, 'NORTH'])
    end

    it 'moves the robot one position to the SOUTH' do
      subject.place(0, 1, 'SOUTH')
      expect do
        subject.move
      end.to change(subject, :position).to([0, 0, 'SOUTH'])
    end

    it 'moves the robot one position to the EAST' do
      subject.place(1, 1, 'EAST')
      expect do
        subject.move
      end.to change(subject, :position).to([2, 1, 'EAST'])
    end

    it 'moves the robot one position to the WEST' do
      subject.place(1, 1, 'WEST')
      expect do
        subject.move
      end.to change(subject, :position).to([0, 1, 'WEST'])
    end
  end

  describe '#rotate' do
    let(:subject) { Robot.new(table) }

    it 'does nothing if the robot has not been positioned in the table' do
      expect do
        subject.rotate('LEFT')
      end.not_to change(subject, :face).from(nil)
    end

    it 'correctly rotates to the left' do
      subject.place(0, 0, 'NORTH')

      subject.rotate('LEFT')
      expect(subject.face).to eql 'WEST'

      subject.rotate('LEFT')
      expect(subject.face).to eql 'SOUTH'

      subject.rotate('LEFT')
      expect(subject.face).to eql 'EAST'

      subject.rotate('LEFT')
      expect(subject.face).to eql 'NORTH'
    end

    it 'correctly rotates to the right' do
      subject.place(0, 0, 'NORTH')

      subject.rotate('RIGHT')
      expect(subject.face).to eql 'EAST'

      subject.rotate('RIGHT')
      expect(subject.face).to eql 'SOUTH'

      subject.rotate('RIGHT')
      expect(subject.face).to eql 'WEST'

      subject.rotate('RIGHT')
      expect(subject.face).to eql 'NORTH'
    end
  end

  describe '#to_s' do
    let(:subject) { Robot.new(table) }

    it 'returns a message if it has not been positioned yet' do
      expect(subject.to_s).to eql "I'm in the limbo!"
    end

    it 'returns the robot current position' do
      subject.place(1, 1, 'SOUTH')
      expect(subject.to_s).to eql '1,1,SOUTH'
    end
  end
end
