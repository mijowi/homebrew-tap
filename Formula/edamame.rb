class Edamame < Formula
  desc "A fast TUI Markdown editor and viewer"
  homepage "https://github.com/mijowi/edamame"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.0/edamame-aarch64-apple-darwin.tar.xz"
      sha256 "b342ba4e93df2ff0386df1710afb76e33a798f8a426562076ceba8376aaaeea8"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.0/edamame-x86_64-apple-darwin.tar.xz"
      sha256 "47d8da341af44f0e5c517bb9b364c4ead72c78595ac223f478fd1d7e431ba5c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.0/edamame-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "daebb89d101300ae619c14a2388e3ef1d85b26bbfd9357f892bc77e362ae28dd"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.0/edamame-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "5830c472ce264ceb2ef71fe5e66de7c15f31c3f804e50fd3f4e1de0ae8835b41"
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
