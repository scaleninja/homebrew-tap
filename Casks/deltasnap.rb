cask "deltasnap" do
  version "1.0.2"
  sha256 "1149e91d9fd14e8e23c7d5342976e6ea6b2be9f1f2fda5a9e1746fb9551fa8b8"

  url "https://scaleninja.com/download/deltasnap/releases/DeltaSnap-#{version}.zip"
  name "DeltaSnap"
  desc "APFS snapshot manager"
  homepage "https://scaleninja.com/deltasnap/"

  livecheck do
    url "https://scaleninja.com/download/deltasnap/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on macos: :sequoia

  app "DeltaSnap.app"

  zap trash: [
    "~/Library/Application Support/DeltaSnap",
    "~/Library/Caches/com.scaleninja.deltasnap",
    "~/Library/HTTPStorages/com.scaleninja.deltasnap",
    "~/Library/Preferences/com.scaleninja.deltasnap.plist",
    "~/Library/Saved Application State/com.scaleninja.deltasnap.savedState",
  ]

  caveats <<~EOS
    Open DeltaSnap once and approve its helper to link the dsnap and deltasnap
    commands into /usr/local/bin.

    Before `brew uninstall`, run Assistant > Uninstall and Disable DeltaSnap in
    the app to unregister its background services and command links.
  EOS
end
