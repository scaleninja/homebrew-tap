cask "macvisor" do
  version "27.0.0-beta3"
  sha256 "77d662c2ef1a60b8980869bffa44b571332b416247cdae40b4ee7ed04494790a"

  url "https://scaleninja.com/download/macvisor/releases/MacVisor-#{version}.zip"
  name "MacVisor"
  desc "Native virtual machine manager for Apple Silicon Macs"
  homepage "https://scaleninja.com/macvisor/"

  livecheck do
    url "https://scaleninja.com/download/macvisor/appcast.xml"
    strategy :sparkle, &:short_version
  end

  auto_updates true
  depends_on arch: :arm64
  depends_on macos: :golden_gate

  app "MacVisor.app"

  zap trash: [
    "~/Library/Application Support/MacVisor",
    "~/Library/Caches/com.scaleninja.macvisor",
    "~/Library/HTTPStorages/com.scaleninja.macvisor",
    "~/Library/Preferences/com.scaleninja.macvisor.plist",
    "~/Library/Saved Application State/com.scaleninja.macvisor.savedState",
  ]

  caveats <<~EOS
    Open MacVisor once and approve the Network Helper to link the mvz and
    macvisor commands into /usr/local/bin.

    Before `brew uninstall`, run Assistant > Uninstall MacVisor... in the app to
    remove its background service, helper, command links and
    /etc/resolver/macvisor. VM locations are left untouched.
  EOS
end
