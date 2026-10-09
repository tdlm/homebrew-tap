class Maximus < Formula
  desc "A keyboard-first TUI for running Claude Code sessions across many projects"
  homepage "https://github.com/tdlm/maximus"
  version "0.5.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.5.0/maximus-aarch64-apple-darwin.tar.xz"
      sha256 "521329318e03fd3436fdeab3bd0caaaff7336db97915c89dfb6ca17f5cbf2ed4"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.5.0/maximus-x86_64-apple-darwin.tar.xz"
      sha256 "ce373f8aca2bcfb63911ac151c7f810ee21c81450cf1db6ff2f9f8e63e3bf4c5"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.5.0/maximus-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "ae366bea24dc04c945ab58b69a0697ae2f7f2fbb0ac88e056c3b442244b1e49d"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.5.0/maximus-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "c0581f5b995133471568629b3634c8cbf8db5409e58372e649ff6f93f358b2ee"
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
