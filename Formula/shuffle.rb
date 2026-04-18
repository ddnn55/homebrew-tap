class Shuffle < Formula
  desc "Command-line MP3 player with shuffle playback and arrow-key controls"
  homepage "https://github.com/ddnn55/shuffle"
  url "https://github.com/ddnn55/shuffle/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "8fdd03b7f7fa4f4f15f51bceb39481a7d0c2f9a00f3327bf85defa0ef92a14a4"
  license "MIT"
  head "https://github.com/ddnn55/shuffle.git", branch: "main"

  bottle do
    root_url "https://github.com/ddnn55/homebrew-tap/releases/download/shuffle-0.1.1"
    sha256 cellar: :any_skip_relocation, arm64_tahoe: "8c937eb5397826d71bc59cac77c756f792089d2e7b6d726ab904606e1085cf09"
  end

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
    libexec.mkpath
    system "swiftc", "macos/MediaRemoteHelper.swift",
                    "-O",
                    "-framework", "Foundation",
                    "-framework", "MediaPlayer",
                    "-o", libexec/"media_remote_helper"
  end

  test do
    assert_match(
      "No mp3 files found.",
      shell_output("#{bin}/shuffle 2>&1", 1),
    )
  end
end
