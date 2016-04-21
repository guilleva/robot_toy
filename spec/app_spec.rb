require 'app'

describe App do
  describe '#display_greeting_message' do
    let(:subject) { App.new }

    it 'outputs "Hello!!!"' do
      expect(STDOUT).to receive(:puts).with('Hello!!!')
      subject.display_greeting_message
    end
  end
end
