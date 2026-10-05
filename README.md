# scaleninja/homebrew-tap

Homebrew formulae and casks for [scaleninja](https://scaleninja.com) command-line tools and Mac apps.

## Usage

Add and trust the tap once, then install tools and apps by name:

```bash
brew tap scaleninja/tap
brew trust --tap scaleninja/tap
brew install drivesync
brew install --cask deltasnap
brew install --cask macvisor
```

Or in one step (this also adds the tap): `brew install scaleninja/tap/drivesync`.

Once the tap is added, `brew update` picks up new tools and new versions, and any
formula added to this repository in the future installs with plain `brew install <name>`.

Trusting the tap stops Homebrew from warning about, or refusing to load, a non-official tap.

## Formulae

| Formula     | Installs | Project                                                      |
|-------------|----------|--------------------------------------------------------------|
| `drivesync` | `dsync`  | [scaleninja/drivesync](https://github.com/scaleninja/drivesync) |

## Casks

| Cask        | Installs        | Product                                          |
|-------------|-----------------|--------------------------------------------------|
| `deltasnap` | `DeltaSnap.app` | [DeltaSnap](https://scaleninja.com/deltasnap/)   |
| `macvisor`  | `MacVisor.app`  | [MacVisor](https://scaleninja.com/macvisor/)     |

The apps update themselves through Sparkle (`auto_updates true`), so `brew upgrade` skips
them unless you pass `--greedy`. To publish a new release, bump `version` and `sha256` in
`Casks/<name>.rb` (`shasum -a 256 <zip>`); `brew livecheck --cask <name>` reads the
Sparkle appcast to confirm the cask matches the latest release.

## Adding a tool

Each formula lives at `Formula/<name>.rb` and is owned by its upstream project, which
renders and pushes it from its release workflow rather than editing it here by hand.
To add a new CLI:

1. Publish prebuilt binaries and a `SHA256SUMS` file on the project's GitHub releases.
2. Add a generator script in the project (see `scripts/homebrew-formula.sh` in
   [scaleninja/drivesync](https://github.com/scaleninja/drivesync)) that renders the
   formula from a version and `SHA256SUMS`.
3. Add a release-workflow job that renders `Formula/<name>.rb` and pushes it to this
   repository using the `HOMEBREW_TAP_TOKEN` secret (a fine-grained PAT with
   *Contents: read and write* on this repository; an org-level secret can be shared by
   every project).
4. Add a row to the table above.

