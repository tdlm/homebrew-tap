class Maximus < Formula
  desc "A keyboard-first TUI for running Claude Code sessions across many projects"
  homepage "https://github.com/tdlm/maximus"
  version "0.13.0"
  if OS.mac?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.13.0/maximus-aarch64-apple-darwin.tar.xz"
      sha256 "a4ed8527819e825e6546de68e642d6f0bef005296264b2351e771fcc43714ac3"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.13.0/maximus-x86_64-apple-darwin.tar.xz"
      sha256 "62da701e91c4ff61289eebe43b7a1d02a261748bb2cb812307b19bd920448ccb"
    end
  end
  if OS.linux?
    if Hardware::CPU.arm?
      url "https://github.com/tdlm/maximus/releases/download/v0.13.0/maximus-aarch64-unknown-linux-gnu.tar.xz"
      sha256 "02400f92d68c8ca7afa56449c7069ce70fb4c87639832912306f174666d09fc5"
    end
    if Hardware::CPU.intel?
      url "https://github.com/tdlm/maximus/releases/download/v0.13.0/maximus-x86_64-unknown-linux-gnu.tar.xz"
      sha256 "ba047feb3aca3251c6b3229f85b9d7b3338003230d664ec4fefcddcdc4be92c0"
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
