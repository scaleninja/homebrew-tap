cask "macvisor" do
  version "27.2.0"
  sha256 "10a8822036f3ab2f038d5902e604d417065301ac895d584e309a208c58d28ad4"

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
  bash_completion "#{appdir}/MacVisor.app/Contents/Resources/completions/macvisor.bash"
  zsh_completion "#{appdir}/MacVisor.app/Contents/Resources/completions/_macvisor"
  fish_completion "#{appdir}/MacVisor.app/Contents/Resources/completions/macvisor.fish"
  fish_completion "#{appdir}/MacVisor.app/Contents/Resources/completions/macvisor.fish", target: "mvz.fish"

  uninstall launchctl: "com.scaleninja.macvisor.inference",
            quit:      "com.scaleninja.macvisor"

  zap trash: [
    "~/.macvisor",
    "~/Library/Application Support/MacVisor",
    "~/Library/Caches/com.scaleninja.macvisor",
    "~/Library/Caches/com.scaleninja.macvisor.service",
    "~/Library/HTTPStorages/com.scaleninja.macvisor",
    "~/Library/HTTPStorages/com.scaleninja.macvisor.service",
    "~/Library/LaunchAgents/com.scaleninja.macvisor.inference.plist",
    "~/Library/Preferences/com.scaleninja.macvisor.cli.plist",
    "~/Library/Preferences/com.scaleninja.macvisor.plist",
    "~/Library/Preferences/com.scaleninja.macvisor.runner.plist",
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
