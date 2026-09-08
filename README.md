# scaleninja/homebrew-tap

Homebrew formulae for [scaleninja](https://scaleninja.com) command-line tools.

## Usage

Add the tap once, then install tools by name:

```bash
brew tap scaleninja/tap
brew install drivesync
```

Or in one step (this also adds the tap): `brew install scaleninja/tap/drivesync`.

Once the tap is added, `brew update` picks up new tools and new versions, and any
formula added to this repository in the future installs with plain `brew install <name>`.

If Homebrew refuses with an "untrusted tap" error, run `brew trust scaleninja/tap` first.

## Formulae

| Formula     | Installs | Project                                                      |
|-------------|----------|--------------------------------------------------------------|
| `drivesync` | `dsync`  | [scaleninja/drivesync](https://github.com/scaleninja/drivesync) |

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

