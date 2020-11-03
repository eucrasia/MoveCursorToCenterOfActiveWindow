//
//  AppDelegate.swift
//  MoveCursorToCenterOfActiveWindow
//

import Cocoa
import CoreGraphics

// @NSApplicationMain
class AppDelegate: NSObject, NSApplicationDelegate {
    
    var window: NSWindow!
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        if
            let windowList = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [NSDictionary],
            let activeWindowInfo = windowList.first(where: { $0[kCGWindowLayer] as? Int == 0
            }),
            let activeWindowBounds = activeWindowInfo[kCGWindowBounds] as? NSDictionary,
            let rect = CGRect(dictionaryRepresentation: activeWindowBounds)
        {
            // debugPrint(rect)
            let centerOfActiveWindow = CGPoint(x: rect.midX, y: rect.midY)
            
            let error = CGWarpMouseCursorPosition(centerOfActiveWindow)
            if error == CGError.success {
                exit(EX_OK)
            } else {
                debugPrint(error)
                exit(EX_UNAVAILABLE)
            }
        } else {
            exit(EX_UNAVAILABLE)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}

