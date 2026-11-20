class Edamame < Formula
  desc "A Terminal Markdown editor that stays rendered while you edit"
  homepage "https://github.com/mijowi/edamame"
  version "0.1.8"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.8/edamame-aarch64-apple-darwin.tar.xz"
      sha256 "c157d6757f5a405cae5e82ba44f02b153c1e8b2f46eab0ab35f5ab0bd95719d0"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.8/edamame-x86_64-apple-darwin.tar.xz"
      sha256 "b4464d518da974b430d281819040f5ab7d6902b80eb5ebd64c51d0522ddc1e14"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.8/edamame-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "f48bf85fa848862c360e8f77039a8d0b58c69b27e45eab6baac13fda06c836d3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.8/edamame-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "1d8c0f64cd8b27e84a2ac97e520cf26cff130264c7de04f1b5665eaebe9f9d9e"
    end
  end
  license "Apache-2.0"

  BINARY_ALIASES = {
    "aarch64-apple-darwin":              {},
    "aarch64-unknown-linux-gnu":         {},
    "x86_64-apple-darwin":               {},
    "x86_64-pc-windows-gnu":             {},
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
