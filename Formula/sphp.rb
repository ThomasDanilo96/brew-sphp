class Sphp < Formula
  desc "Simple PHP version switcher for macOS (Apache + CLI) using Homebrew"
  homepage "https://github.com/ThomasDanilo96/homebrew-sphp"
  url "https://raw.githubusercontent.com/ThomasDanilo96/brew-sphp/master/sphp.sh"
  version "1.0.0"
  sha256 "54b1e4368d05619c1a310e2277e442c0143d5a0186ab814307439af7800930d3"
  license "MIT"

  def install
    bin.install "sphp.sh" => "sphp"
  end
end

