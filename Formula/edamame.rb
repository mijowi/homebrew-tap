class Edamame < Formula
  desc "A Terminal Markdown editor that stays rendered while you edit"
  homepage "https://github.com/mijowi/edamame"
  version "0.1.6"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.6/edamame-aarch64-apple-darwin.tar.xz"
      sha256 "ce209cc33c6d6ed8bbf3cc1b21dfddb4b3e88bd7f0e5aaebfbd8b4f1641d07f7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.6/edamame-x86_64-apple-darwin.tar.xz"
      sha256 "bc0cf6dae508fceba6e736b251cd90636c7c155c67f27f20a302f1880c0d6556"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.6/edamame-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "425fa2d71740ebab319340b888fdb87f58f0ed16079b80bbf10a327c554e2835"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.6/edamame-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "81db5aa77387e2c9c9e7a3e7f8648ca42b12ca02463e18b732863fef16a4a105"
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
