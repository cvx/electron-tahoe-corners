const { app, BrowserWindow } = require("electron");
const tahoeCorners = require("../");

app.whenReady().then(() => {
  const mainWindow = new BrowserWindow({
    width: 400,
    height: 400,
    backgroundColor: "#80ffffff",
    vibrancy: "sidebar",
    titleBarStyle: "hidden",
    autoHideMenuBar: true,
    trafficLightPosition: { x: 19, y: 19 },
  });

  tahoeCorners(mainWindow);

  mainWindow.loadFile("index.html");
});

app.on("window-all-closed", () => app.quit());
