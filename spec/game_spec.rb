require 'game'

RSpec.describe Game do
  subject { described_class.new }

  it 'works' do
    expect(subject).to be_a(Game)
  end
end
