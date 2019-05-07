# Documentation: https://docs.brew.sh/Formula-Cookbook
#                https://rubydoc.brew.sh/Formula
# PLEASE REMOVE ALL GENERATED COMMENTS BEFORE SUBMITTING YOUR PULL REQUEST!
class ObjcDiff < Formula
  desc "objc-diff generates an API diff report for an Objective-C library, similar to those provided by Apple for the system frameworks. It assists library developers with providing their own diff report and verifying that no unexpected API changes have been made."
  homepage "http://codeworkshop.net/objc-diff"
  url "https://github.com/dreampiggy/objc-diff.git", :using => :git, :tag => 'v0.5.1'

  depends_on "llvm" => :build
  depends_on :xcode => "10.0"

  bottle do
    root_url "https://github.com/dreampiggy/objc-diff/releases/download/v0.5.1"
    sha256 "3362de400a9ee569e6030188ee54459d7a95b0061359273107172989a8393482" => :mojave
  end

  def install
    # ENV.deparallelize  # if your formula fails when building in parallel
    # Remove unrecognized options if warned by configure
    system "xcodebuild", "-project", "OCDiff.xcodeproj", "-scheme", "OCDiff", "-configuration", "Release", "-derivedDataPath", "DerivedData"
    bin.install "DerivedData/Build/Products/Release/objc-diff"
    bin.install "DerivedData/Build/Products/Release/ObjectDoc.framework"
    man.install "DerivedData/Build/Products/Release/objc-diff.1"
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
