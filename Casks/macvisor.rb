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

  # zap leaves what MacVisor's own uninstaller keeps, because the VMs it never
  # removes still need it: the SSH key VMs made without the user's key trust
  # (~/.macvisor/ssh), the custom networks VMs are on, the storage locations,
  # the record of VMs made on this Mac, and the licensing state, which only
  # the app's uninstaller hands back. The support folder isn't trashed whole:
  # a storage location can be inside it.
  zap trash: [
    "~/.macvisor/run",
    "~/.macvisor/setup-warned",
    "~/.macvisor/ssh-answered",
    "~/Library/Application Support/MacVisor/.autostart-session",
    "~/Library/Application Support/MacVisor/.hooks.json.lock",
    "~/Library/Application Support/MacVisor/.install-failures-checked",
    "~/Library/Application Support/MacVisor/.macvisor-import-staging",
    "~/Library/Application Support/MacVisor/.nvram-unsupported",
    "~/Library/Application Support/MacVisor/_GuestImage",
    "~/Library/Application Support/MacVisor/ai",
    "~/Library/Application Support/MacVisor/backups.json",
    "~/Library/Application Support/MacVisor/high-availability.json",
    "~/Library/Application Support/MacVisor/hooks.json",
    "~/Library/Application Support/MacVisor/installs",
    "~/Library/Application Support/MacVisor/layer-pins.json",
    "~/Library/Application Support/MacVisor/layer-pins.json.lock",
    "~/Library/Application Support/MacVisor/local-network-runner.json",
    "~/Library/Application Support/MacVisor/logs",
    "~/Library/Application Support/MacVisor/networks.json.lock",
    "~/Library/Application Support/MacVisor/operations",
    "~/Library/Application Support/MacVisor/privacy-runner.json",
    "~/Library/Application Support/MacVisor/privacy-service.json",
    "~/Library/Application Support/MacVisor/run",
    "~/Library/Application Support/MacVisor/runners",
    "~/Library/Application Support/MacVisor/RuntimeCache",
    "~/Library/Application Support/MacVisor/setup-times.json",
    "~/Library/Application Support/MacVisor/watchdog-restarts.json",
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

    Before `brew uninstall`, choose Assistant > Uninstall MacVisor... in the
    app. It hands this Mac's license back, so the key can be used on another
    Mac, and removes the background service, the Network Helper and its
    firewall rules, the command links and the .mvz resolvers. `brew uninstall`
    on its own does none of that. Your VMs are never removed, and neither
    `brew uninstall --zap` nor the app's uninstaller removes the SSH key, the
    networks and the storage locations those VMs need.
  EOS
end
