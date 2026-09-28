cask "trois" do
  version "0.1"
  sha256 "eabe08a63b78eaf199604f2d73347239f216d06a5352fb62d4b3aad83461a523"

  url "https://github.com/trois-dev/trois/releases/download/v#{version}/Trois-#{version}.zip"
  name "Trois"
  desc "Classic window themes for the title bar buttons"
  homepage "https://github.com/trois-dev/trois"

  livecheck do
    url :url
    strategy :github_latest
  end

  depends_on arch: :arm64
  depends_on macos: :ventura

  app "Trois.app"

  uninstall quit: "com.trois.app"

  # The helper files are only there if injection mode was used, and removing
  # them needs admin rights, so plain uninstall leaves them.
  zap delete: [
        "/Library/PrivilegedHelperTools/com.trois.app.Injector",
        "/Library/PrivilegedHelperTools/TroisLoader.bundle",
      ],
      trash:  [
        "~/Library/Application Support/Trois",
        "~/Library/Caches/com.trois.app",
        "~/Library/HTTPStorages/com.trois.app",
        "~/Library/Preferences/com.trois.app.plist",
      ]
end
