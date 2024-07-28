class SaturnBot < Formula
  desc "Create, modify or delete files across many repositories in parallel."
  homepage "https://github.com/wndhydrnt/saturn-bot"
  url "https://github.com/wndhydrnt/saturn-bot/archive/refs/tags/v0.7.0.tar.gz"
  sha256 "1166abdcbe8c2ac4a81efa560c0fd6e653ca0f58738803577bda8f874198281d"
  license "AGPL-3.0"
  head "https://github.com/wndhydrnt/saturn-bot.git", branch: "main"
  version "0.7.0"

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
