cask "deltasync" do
  version "0.1"
  sha256 :no_check

  url "https://scaleninja.com/download/DeltaSync.dmg"
  name "DeltaSync"
  desc "Rsync GUI to compare directories and sync files"
  homepage "https://scaleninja.com/deltasync/"

  livecheck do
    skip "No version information available"
  end

  depends_on macos: :sonoma

  app "DeltaSync.app"

  zap trash: [
    "~/Library/Caches/com.scaleninja.DeltaSync",
    "~/Library/HTTPStorages/com.scaleninja.DeltaSync",
    "~/Library/Preferences/com.scaleninja.DeltaSync.plist",
    "~/Library/Saved Application State/com.scaleninja.DeltaSync.savedState",
  ]
end
