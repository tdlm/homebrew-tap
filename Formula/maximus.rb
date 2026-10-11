class Maximus < Formula
  desc "A keyboard-first TUI for running Claude Code sessions across many projects"
  homepage "https://github.com/tdlm/maximus"
  version "0.8.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.8.0/maximus-aarch64-apple-darwin.tar.xz"
      sha256 "24ed9839af17d85d9590f3d3960a6e2969babb737a0f6471a9ffc346ab0be0e2"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.8.0/maximus-x86_64-apple-darwin.tar.xz"
      sha256 "b9ee30c6fc62613eb6b6bf9c4954ebd2018f3ca6fc5101424f742f5858536282"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.8.0/maximus-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "eff2fa6910a5e2be9b553f1ffb053f8e73ad2f90f33fd00ffb259b400ecb5cef"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.8.0/maximus-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ac35a8f6c36085c248e7338b57a47f35e7bf6dbd7ab51f16f92044bb63cf6765"
    end
  end

  BINARY_ALIASES = {
    "aarch64-apple-darwin":      {},
    "aarch64-unknown-linux-gnu": {},
    "x86_64-apple-darwin":       {},
    "x86_64-unknown-linux-gnu":  {},
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
      bin.install "maximus"
    end
    if OS.mac? && Hardware::CPU.intel?
      bin.install "maximus"
    end
    if OS.linux? && Hardware::CPU.arm?
      bin.install "maximus"
    end
    if OS.linux? && Hardware::CPU.intel?
      bin.install "maximus"
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
