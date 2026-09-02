class Sprout < Formula
  desc "Fast, simple, opinionated build tool for ordinary Scala projects"
  homepage "https://github.com/mywyau/sprout"
  url "https://github.com/mywyau/sprout/releases/download/v0.2.26/sprout-0.2.26.tar.gz"
  sha256 "b549aec6cf4cc661b13a5f96757ed8ea222b2ab259e79816f0fdca6dd74b0dd5"
  license "MIT"

  depends_on "openjdk@21"

  def install
    libexec.install Dir["*"]
    java = Formula["openjdk@21"].opt_bin/"java"
    (bin/"sprout").write <<~SH
      #!/bin/sh
      exec "#{java}" "-Dsprout.launcher=#{bin}/sprout" -jar "#{libexec}/lib/sprout.jar" "$@"
    SH
  end

  test do
    assert_match "Sprout 0.2.26", shell_output("#{bin}/sprout --version")
    (testpath/"sprout.toml").write <<~TOML
      [project]
      name = "formula-test"
      scala = "3.3.6"
    TOML
    system bin/"sprout", "setup-ide"
    assert_match (bin/"sprout").to_s, (testpath/".bsp/sprout.json").read
  end
end
