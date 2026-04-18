class Shuffle < Formula
  desc "Command-line MP3 player with shuffle playback and arrow-key controls"
  homepage "https://github.com/ddnn55/shuffle"
  url "https://github.com/ddnn55/shuffle/archive/refs/tags/v0.1.1.tar.gz"
  sha256 "8fdd03b7f7fa4f4f15f51bceb39481a7d0c2f9a00f3327bf85defa0ef92a14a4"
  license "MIT"
  head "https://github.com/ddnn55/shuffle.git", branch: "main"

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
