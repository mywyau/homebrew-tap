class Sprout < Formula
  desc "Fast, simple, opinionated build tool for ordinary Scala projects"
  homepage "https://github.com/mywyau/sprout"
  url "https://github.com/mywyau/sprout/releases/download/v0.2.18/sprout-0.2.18.tar.gz"
  sha256 "e53f795d9d01d652744b610899bb47cb6d173d0d14910f0856ee00361b3bfd15"
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
    assert_match "Sprout 0.2.18", shell_output("#{bin}/sprout --version")
    (testpath/"sprout.toml").write <<~TOML
      [project]
      name = "formula-test"
      scala = "3.3.6"
    TOML
    system bin/"sprout", "setup-ide"
    assert_match (bin/"sprout").to_s, (testpath/".bsp/sprout.json").read
  end
end
