class SaturnBot < Formula
  desc "Create, modify or delete files across many repositories in parallel."
  homepage "https://github.com/wndhydrnt/saturn-bot"
  url "https://github.com/wndhydrnt/saturn-bot/archive/refs/tags/v0.5.0.tar.gz"
  sha256 "e893a94a874aa82d0f2dcaf2eec394bd1530cfb751cb8e9d661ba8abbb89fb0d"
  license "AGPL-3.0"
  head "https://github.com/wndhydrnt/saturn-bot.git", branch: "main"
  version "0.5.0"

  depends_on "go" => :build

  def install
    semver = build.head? ? "0.0.0-dev" : version
    date_time = time.strftime('%Y-%m-%dT%H:%M:%SZ')

    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    system "make", "VERSION=v#{semver}", "VERSION_DATETIME=#{date_time}", "VERSION_HASH=", "build"
    bin.install "saturn-bot"
  end

  test do
    system "#{bin}/saturn-bot", "version"
  end
end
