class Maximus < Formula
  desc "A keyboard-first TUI for running Claude Code sessions across many projects"
  homepage "https://github.com/tdlm/maximus"
  version "0.7.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.7.0/maximus-aarch64-apple-darwin.tar.xz"
      sha256 "818a57037ae3eadc30e918338b87bb4652723fdb90e955a70a269906cea2ebb7"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.7.0/maximus-x86_64-apple-darwin.tar.xz"
      sha256 "0aa851ae32ddc7236aefa7b1e9823502126b69530d820dec6a3e081a10b58cab"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.7.0/maximus-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "49326ce0d2560fdbae72207fd66ddfc563e5cce35c410b2d8a6f9ec7a14e09ee"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.7.0/maximus-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "21ba1aad378eaadf9f8a2bf97e57573afef689b39329b284b6b6d1244214910f"
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
