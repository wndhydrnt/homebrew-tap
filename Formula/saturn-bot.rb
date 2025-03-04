class SaturnBot < Formula
  desc "Create, modify or delete files across many repositories in parallel."
  homepage "https://github.com/wndhydrnt/saturn-bot"
  url "https://github.com/wndhydrnt/saturn-bot/archive/refs/tags/v0.23.1.tar.gz"
  sha256 "c458016ea4e8b76bdc2e54356c34cdc00e4da0e18d1c546cccb88ba0250cf4dd"
  license "AGPL-3.0"
  head "https://github.com/wndhydrnt/saturn-bot.git", branch: "main"
  version "0.23.1"

  depends_on "go" => :build

  def install
    semver = build.head? ? "0.0.0-dev" : version
    date_time = time.strftime('%Y-%m-%dT%H:%M:%SZ')

    ENV["GOPATH"] = HOMEBREW_CACHE/"go_cache"
    system "make", "VERSION=v#{semver}", "VERSION_DATETIME=#{date_time}", "VERSION_HASH=", "build"
    bin.install "saturn-bot"
    bash_completion.install "completion/saturn-bot.bash" => "saturn-bot"
    zsh_completion.install "completion/saturn-bot.zsh" => "_saturn-bot"
  end

  test do
    system "#{bin}/saturn-bot", "version"
  end
end
