class Edamame < Formula
  desc "A fast TUI Markdown editor and viewer"
  homepage "https://github.com/mijowi/edamame"
  version "0.1.3"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.3/edamame-aarch64-apple-darwin.tar.xz"
      sha256 "49d4f6d54ff2d9c47a055b815644b663b4b874eb655a4f9fdc3a39dcb3d04f82"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.3/edamame-x86_64-apple-darwin.tar.xz"
      sha256 "5c291798b16825410d0abdde24bf131784d88112f4f1709b9aefe060b3b0e8e7"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.3/edamame-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "9f8742de62ff4446312dde32dbe712c302a580bdc20cab7cbc59282a684792a5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.3/edamame-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "919d006ba57410ae0933e9e2726302e7d707be693a559f6404c69e48e848b0c1"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-unknown-linux-gnu":          {},
    "x86_64-unknown-linux-musl-dynamic": {},
    "x86_64-unknown-linux-musl-static":  {},
  }.freeze

  def target_triple
    cpu = Hardware::CPU.arm? ? "aarch64" : "x86_64"
    os = OS.mac? ? "apple-darwin" : "unknown-linux-gnu"

    "#{cpu}-#{os}"
  end

  def install_binary_aliases!
    BINARY_ALIASES[target_triple.to_sym].each do |source, dests|
      dests.each do |dest|
        bin.install_symlink bin/source.to_s => dest
      end
    end
  end

  def install
    if OS.mac? && Hardware::CPU.arm?
      bin.install "edamame"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "edamame"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "edamame"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "edamame"
    end

    install_binary_aliases!

    # Homebrew will automatically install these, so we don't need to do that
    doc_files = Dir["README.*", "readme.*", "LICENSE", "LICENSE.*", "CHANGELOG.*"]
    leftover_contents = Dir["*"] - doc_files

    # Install any leftover files in pkgshare; these are probably config or
    # sample files.
    pkgshare.install(*leftover_contents) unless leftover_contents.empty?
  end
end
