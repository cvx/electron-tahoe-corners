#import <AppKit/AppKit.h>
#include "tahoe_corners.h"

napi_value tahoe_corners(napi_env env, napi_callback_info info) {
  napi_status status;

  size_t argc = 1;
  napi_value args[1];
  status = napi_get_cb_info(env, info, &argc, args, 0, 0);
  if (status != napi_ok) {
    napi_throw_error(env, NULL, "tahoe_corners: failed to get arguments");
    return NULL;
  } else if (argc < 1) {
    napi_throw_error(env, NULL, "tahoe_corners: wrong number of arguments");
    return NULL;
  }

  void *windowBuffer;
  size_t windowBufferLength;
  status =
      napi_get_buffer_info(env, args[0], &windowBuffer, &windowBufferLength);
  if (status != napi_ok) {
    napi_throw_error(env, NULL, "tahoe_corners: cannot read window handle");
    return NULL;
  } else if (windowBufferLength == 0) {
    napi_throw_error(env, NULL, "tahoe_corners: empty window handle");
    return NULL;
  }

  NSView *mainWindowView = *static_cast<NSView **>(windowBuffer);
  if (![mainWindowView respondsToSelector:@selector(window)] ||
      mainWindowView.window == nil) {
    napi_throw_error(env, NULL, "tahoe_corners: NSView doesn't contain window");
    return NULL;
  }

  NSWindow *window = mainWindowView.window;

  [window setTitlebarAppearsTransparent:YES];
  [window setToolbarStyle:NSWindowToolbarStyleUnified];
  window.styleMask |= NSWindowStyleMaskFullSizeContentView;
  [window setTitleVisibility:NSWindowTitleHidden];

  NSToolbar *toolbar = [[NSToolbar alloc] initWithIdentifier:@"toolbar"];
  [toolbar setDisplayMode:NSToolbarDisplayModeIconOnly];
  [toolbar setAllowsUserCustomization:NO];
  [toolbar setAutosavesConfiguration:NO];
  if (@available(macOS 15.0, *)) {
    [toolbar setAllowsDisplayModeCustomization:NO];
  }
  [window setToolbar: toolbar];

  [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillEnterFullScreenNotification object:window queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    toolbar.visible = false;
  }];

  [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowWillExitFullScreenNotification object:window queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    toolbar.visible = true;
  }];

  [[NSNotificationCenter defaultCenter] addObserverForName:NSWindowDidExitFullScreenNotification object:window queue:[NSOperationQueue mainQueue] usingBlock:^(NSNotification *note) {
    toolbar.visible = true;
  }];

  return NULL;
}
