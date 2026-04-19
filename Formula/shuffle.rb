class Shuffle < Formula
  desc "Command-line MP3 player with shuffle playback and arrow-key controls"
  homepage "https://github.com/ddnn55/shuffle"
  url "https://github.com/ddnn55/shuffle/archive/refs/tags/v0.1.2.tar.gz"
  sha256 "d5fc6db23f9659a26ff2c2c641b8f0f5cf5290b23489762c4c24a62f966bd2a1"
  license "MIT"
  head "https://github.com/ddnn55/shuffle.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "install", *std_cargo_args(path: ".")
  end

  test do
    assert_match(
      "No mp3 files found.",
      shell_output("#{bin}/shuffle 2>&1", 1),
    )
  end
end
