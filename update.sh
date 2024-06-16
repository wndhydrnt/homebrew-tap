#!/user/bin/env bash

set -e

version="$1"

archive_url="https://github.com/wndhydrnt/saturn-bot/archive/refs/tags/v${version}.tar.gz"
sha256=$(curl -fsSL "${archive_url}" | sha256sum | cut -d ' ' -f 1)

cat <<EOF > ./Formula/saturn-bot.rb
class SaturnBot < Formula
  desc "Create, modify or delete files across many repositories in parallel."
  homepage "https://github.com/wndhydrnt/saturn-bot"
  url "${archive_url}"
  sha256 "${sha256}"
  license "AGPL-3.0"
  head "https://github.com/wndhydrnt/saturn-bot.git", branch: "main"
  version "${version}"

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
EOF
