# MoveCursorToCenterOfActiveWindow
Move the mouse cursor to the center of the active window on macOS.

## Usage
1. Download the latest .zip file from [Releases](https://github.com/eucrasia/MoveCursorToCenterOfActiveWindow/releases).
2. Unzip the file (this may happen automatically) and open the folder starting with `MoveCursorToCenterOfActiveWindow`.
3. Place the `.app` file somewhere on the system. (Suppose you have placed it in `/Applications`)
4. Execute the following shell command: `open -g '/Applications/MoveCursorToCenterOfActiveWindow.app'`

* For practical purposes, you'll want to combine the app with your favorite app launcher or key-remapping utility. 
  * Sample rules for [Karabiner-Elements](https://github.com/pqrs-org/Karabiner-Elements) are included.

## Debug Mode
* Executing the app with the `--debug` argument (like below) enables the debug mode, which generates logs that can be visible in the macOS Console.app.
  * `open -g '/Applications/MoveCursorToCenterOfActiveWindow.app' --args --debug`

![image](https://github.com/eucrasia/MoveCursorToCenterOfActiveWindow/assets/6802832/c6d66afa-2b36-48dd-98e0-9fab6c358156)

## License
MIT
