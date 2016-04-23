require 'app'

describe App do
  describe '#display_greeting_message' do
    let(:subject) { App.new }

    it 'outputs "Hello!!!"' do
      expect(STDOUT).to receive(:puts).with('Hello!!!')
      subject.display_greeting_message
    end
  end

  describe '#process_command' do
    describe 'MOVE command' do
      it 'calls "Robot#move"' do
        expect(subject.robot).to receive(:move)
        subject.process_command('MOVE')
      end
    end

    describe 'LEFT command' do
      it 'calls "Robot#rotate"' do
        expect(subject.robot).to receive(:rotate).with('LEFT')
        subject.process_command('LEFT')
      end
    end

    describe 'RIGHT command' do
      it 'calls "Robot#rotate"' do
        expect(subject.robot).to receive(:rotate).with('RIGHT')
        subject.process_command('RIGHT')
      end
    end

    describe 'REPORT command' do
      it 'calls "Robot#report"' do
        subject.robot.place(0, 0, 'NORTH')
        expect(subject).to receive(:output).with('0,0,NORTH')
        subject.process_command('REPORT')
      end
    end

    describe 'PLACE command' do
      it 'calls "Robot#place"' do
        expect(subject.robot).to receive(:place).with(1, 3, 'SOUTH')
        subject.process_command('PLACE 1,3,SOUTH')
      end

      it 'accepts spaces within the parameters "Robot#place"' do
        expect(subject.robot).to receive(:place).with(1, 3, 'SOUTH')
          .exactly(5).times
        subject.process_command('PLACE 1 ,3,SOUTH')
        subject.process_command('PLACE 1, 3,SOUTH')
        subject.process_command('PLACE 1,3 ,SOUTH')
        subject.process_command('PLACE 1,3, SOUTH')
        subject.process_command('PLACE 1,3,SOUTH ')
      end

      it 'ignores it when invalid params are given' do
        expect(subject.robot).not_to receive(:place)

        subject.process_command('PLACE x,3,SOUTH')

        subject.process_command('PLACE 1,x,SOUTH')

        subject.process_command('PLACE 1,x,SOUTHx')
      end
    end
  end
end
