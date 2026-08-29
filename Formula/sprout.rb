class Sprout < Formula
  desc "Fast, simple, opinionated build tool for ordinary Scala projects"
  homepage "https://github.com/mywyau/sprout"
  url "https://github.com/mywyau/sprout/releases/download/v0.2.0/sprout-0.2.0.tar.gz"
  sha256 "acb83fc7297f4440e18b81b865c671a727e520bf79febd5e72430608a2405241"
  license "MIT"

  depends_on "openjdk@21"

  def install
    libexec.install Dir["*"]
    java = Formula["openjdk@21"].opt_bin/"java"
    (bin/"sprout").write <<~SH
      #!/bin/sh
      exec "#{java}" -jar "#{libexec}/lib/sprout.jar" "$@"
    SH
  end

  test do
    assert_match "Sprout 0.2.0", shell_output("#{bin}/sprout --version")
  end
end
