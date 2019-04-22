# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class ObjcDiff < Formula
  desc "objc-diff generates an API diff report for an Objective-C library, similar to those provided by Apple for the system frameworks. It assists library developers with providing their own diff report and verifying that no unexpected API changes have been made."
  homepage "http://codeworkshop.net/objc-diff"
  url "https://github.com/dreampiggy/objc-diff/archive/v0.4.2.tar.gz"
  sha256 "f1a8b66c22ecd7faa4902aca801dd0a90e8f75994dd41f995b2470a9edd404ee"

  depends_on "llvm" => :build
  depends_on :xcode => "10.0"

  bottle do
    root_url "https://github.com/dreampiggy/objc-diff/releases/download/v0.4.2"
    sha256 "e86ae5dc480945e7675e50290d1ebe188ea17c11574db8801b71b8f394fb6b4c" => :mojave
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "xcodebuild", "-project", "OCDiff.xcodeproj", "-target", "OCDiff"
    bin.install "build/Release/objc-diff"
    bin.install "build/Release/ObjectDoc.framework"
    man.install "build/Release/objc-diff.1"
    # system "cmake", ".", *std_cmake_args
    # system "make", "install" # if this fails, try separate make/make install steps
  end

  test do
    # `test do` will create, run in and delete a temporary directory.
    #
    # This test will fail and we won't accept that! For Homebrew/homebrew-core
    # this will need to be a test that verifies the functionality of the
    # software. Run the test with `brew test objc`. Options passed
    # to `brew install` such as `--HEAD` also need to be provided to `brew test`.
    #
    # The installed folder is not in the path, so use the entire path to any
    # executables being tested: `system "#{bin}/program", "do", "something"`.
    system "objc-diff", "--help"
  end
end
