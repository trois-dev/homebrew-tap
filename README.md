# Trois Homebrew Tap

Installs [Trois](https://github.com/trois-dev/trois) with Homebrew.

```sh
brew install --cask trois-dev/tap/trois
```

`brew uninstall --cask trois` removes the app. `brew uninstall --zap --cask trois` also removes installed themes, settings and the injection mode helper, which asks for your password.

## Updating the cask

After a release, set `version` and `sha256` in `Casks/trois.rb` (`shasum -a 256 Trois-<version>.zip`), then run `./test.sh`.
