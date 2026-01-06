# electron-tahoe-corners

## Usage

1. Add this package to the dependencies of your electron app
2. Import it in your main js file
   ```js
   import tahoeCorners from "electron-tahoe-corners";
   ```
3. Apply it on your window:
   ```js
   tahoeCorners(mainWindow);
   ```

## Credit

The technique is based on [a comment](https://github.com/electron/electron/issues/47514#issuecomment-3508053035) by [hopejr](https://github.com/hopejr) and the extension structure is based on [electron-window-rotator](https://github.com/antonfisher/electron-window-rotator) by [antonfisher](https://github.com/antonfisher).
