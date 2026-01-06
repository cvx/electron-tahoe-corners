const NativeExtension = require("bindings")("NativeExtension");

module.exports = function round(electronWindow) {
  try {
    if (process.platform !== "darwin") {
      throw new Error("platform not supported");
    }

    NativeExtension.tahoe_corners(electronWindow.getNativeWindowHandle());
  } catch (e) {
    throw new Error(`electron-tahoe-corners: failed: ${e.stack || e}`);
  }
};
