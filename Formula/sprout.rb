class Sprout < Formula
  desc "Fast, simple, opinionated build tool for ordinary Scala projects"
  homepage "https://github.com/mywyau/sprout"
  url "https://github.com/mywyau/sprout/releases/download/v0.2.2/sprout-0.2.2.tar.gz"
  sha256 "e3ec1109a50f386ac784c39be48f5189ba86c3c615008f3b00a777fde2f186c8"
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
    assert_match "Sprout 0.2.2", shell_output("#{bin}/sprout --version")
    (testpath/"sprout.toml").write <<~TOML
      [project]
      name = "formula-test"
      scala = "3.3.6"
    TOML
    system bin/"sprout", "setup-ide"
    assert_match (bin/"sprout").to_s, (testpath/".bsp/sprout.json").read
  end
end
