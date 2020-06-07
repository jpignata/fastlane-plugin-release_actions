describe Fastlane::Actions::ReleaseActionsAction do
  describe '#run' do
    it 'prints a message' do
      expect(Fastlane::UI).to receive(:message).with("The release_actions plugin is working!")

      Fastlane::Actions::ReleaseActionsAction.run(nil)
    end
  end
end
