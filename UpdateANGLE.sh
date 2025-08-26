
set -e

# Hardcoded version/tag
ANGLE_VERSION="WebKit-7621.2.5.14.9"
ANGLE_TAR_URL="https://chromium.googlesource.com/external/github.com/WebKit/webkit/+archive/refs/tags/$ANGLE_VERSION/Source/ThirdParty/ANGLE.tar.gz"

# Clean up everything except .git, this script, and webkit_patches folder
find . -mindepth 1 ! -regex '^./.git\(/.*\)*' -a ! -regex '^./UpdateANGLE.sh' -a ! -regex '^./webkit_patches\(/.*\)*' -delete

# Download and extract ANGLE
curl -L "$ANGLE_TAR_URL" -o ANGLE.tar.gz
tar -xzf ANGLE.tar.gz
rm ANGLE.tar.gz

# Apply standalone patch if present
git apply webkit_patches/patches/angle-standalone.patch

# Remove files with potentially incompatible licenses
rm ./scripts/generate_android_bp.py
rm ./scripts/roll_chromium_deps.py
rm -rf ./tools/android_system_sdk/
rm -rf ./third_party/proguard/
rm -rf ./tools/flex-bison/
rm -rf ./third_party/android_system_sdk/
rm -rf ./util/windows/third_party/StackWalker
rm -rf ./third_party/glmark2/
rm -rf ./third_party/jdk/

# ADD README
echo "# Fork of ANGLE

This is a fork of [WebKit's version of ANGLE](https://github.com/WebKit/WebKit) for use in the iOS Version of [RAMSES](https://github.com/bmwcarit/ramses).
Makes the repository smaller and therefore faster to checkout.

To update this repository to the most recent commit run \`./UpdateANGLE.sh\`.
" > ./README.md

git add --all --renormalize
git add --renormalize -f third_party/zlib
git commit -m "Updated ANGLE to WebKit version $ANGLE_VERSION"