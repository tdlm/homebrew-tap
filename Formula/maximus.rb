class Maximus < Formula
  desc "A keyboard-first TUI for running Claude Code sessions across many projects"
  homepage "https://github.com/tdlm/maximus"
  version "0.1.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.1.0/maximus-aarch64-apple-darwin.tar.xz"
      sha256 "5db9e084cece2386ab7390b367bfe9e89b6cb4f19d6a8ed5def0c0a06e979cc9"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.1.0/maximus-x86_64-apple-darwin.tar.xz"
      sha256 "cfdd911958959a6de53f1d70798dc604296d35512a481d609901e3e4e8e48370"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.1.0/maximus-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "7e5f01fa6a5e7677c1f888a9f880661b3ed644b6fcbf241126144162153bac84"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.1.0/maximus-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "279239027ee0c6f23c4251b979f2da2938469f2c4df31d229b1b165bef641a24"
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
