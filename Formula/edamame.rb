class Edamame < Formula
  desc "A fast TUI Markdown editor and viewer"
  homepage "https://github.com/mijowi/edamame"
  version "0.1.5"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.5/edamame-aarch64-apple-darwin.tar.xz"
      sha256 "e12809edbaf90de379d033c345e4338ba53d9d1bc7fd8ac656a307a25b6a9998"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.5/edamame-x86_64-apple-darwin.tar.xz"
      sha256 "00222653ee4d2be7492e72b590504c83e35d9af4841624a7adad1eb2bba50773"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.5/edamame-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "0ca0411268767ba75fd1b07440aa9681e6ca7a77c7b3a172d27d2cb9ed86116d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/mijowi/edamame/releases/download/v0.1.5/edamame-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "559c80bc128384e90a99a3a0cf92f37e4e50b613be4be4a435da15c20c65bd7d"
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
