class Shuffle < Formula
  desc "Command-line MP3 player with shuffle playback and arrow-key controls"
  homepage "https://github.com/ddnn55/shuffle"
  url "https://github.com/ddnn55/shuffle/archive/refs/tags/v0.1.0.tar.gz"
  sha256 "52e9f75bf4ed4935b14130e5f69971dafd00dc28bc4867fe18d3879c12b1b76e"
  license "MIT"
  head "https://github.com/ddnn55/shuffle.git", branch: "main"

  depends_on "rust" => :build
  depends_on :macos

  def install
    system "cargo", "build", "--release", "--bin", "shuffle"
    bin.install "target/release/shuffle"
  end

  test do
    assert_match(
      "No mp3 files found.",
      shell_output("#{bin}/shuffle 2>&1", 1)
    )
  end
end
