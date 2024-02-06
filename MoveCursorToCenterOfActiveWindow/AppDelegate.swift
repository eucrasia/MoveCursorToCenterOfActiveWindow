//
//  AppDelegate.swift
//  MoveCursorToCenterOfActiveWindow
//

import Cocoa
import CoreGraphics
import OSLog

class AppDelegate: NSObject, NSApplicationDelegate {
    
    func applicationDidFinishLaunching(_ aNotification: Notification) {
        
        //
        // Usage: /path/to/MoveCursorToCenterOfActiveWindow.app [--debug]
        //
        let debugMode = CommandLine.arguments.contains("--debug")
        
        let bundleID = Bundle.main.bundleIdentifier ?? ""
        let category = OSLog.Category.pointsOfInterest.rawValue
        let logger = Logger(subsystem: bundleID, category: category)
        
        // We don't use Logger log levels below the default one
        // (because logs having those levels don't persist after the app exits, and this app exits rather quickly)
        
        if debugMode {
            logger.notice("[DEBUG] Screens have separate spaces: \(NSScreen.screensHaveSeparateSpaces, privacy: .public)")
            logger.notice("[DEBUG] Screens: \(NSScreen.screens, privacy: .public)")
        }
        
        guard let windowList = CGWindowListCopyWindowInfo(.optionOnScreenOnly, kCGNullWindowID) as? [NSDictionary] else {
            debugMode ? logger.error("[DEBUG] Cannot retrieve the window list") : logger.error("Cannot retrieve the window list")
            exit(EX_UNAVAILABLE)
        }
        
        guard let activeWindowInfo = windowList.first(where: { $0[kCGWindowLayer] as? Int == 0 }) else {
            debugMode ? logger.notice("[DEBUG] No active window found") : logger.notice("No active window found")
            exit(EX_NOINPUT)
        }
        
        guard let activeWindowBounds = activeWindowInfo[kCGWindowBounds] as? NSDictionary,
              let rect = CGRect(dictionaryRepresentation: activeWindowBounds) else {
            if debugMode {
                logger.error("[DEBUG] Cannot retrieve the bounds of the active window: \(activeWindowInfo, privacy: .public)")
            } else { logger.error("Cannot retrieve the bounds of the active window") }
            exit(EX_UNAVAILABLE)
        }
        
        let centerOfActiveWindow = CGPoint(x: rect.midX, y: rect.midY)
        
        if debugMode {
            logger.notice("[DEBUG] Active window: \(activeWindowInfo, privacy: .public)")
            logger.notice("[DEBUG] Attempting to move the cursor to \(centerOfActiveWindow.debugDescription, privacy: .public)")
        }
        let cgError = CGWarpMouseCursorPosition(centerOfActiveWindow)
        
        if cgError == CGError.success {
            if debugMode { logger.notice("[DEBUG] Successfully moved the cursor") }
            exit(EX_OK)
        } else {
            if debugMode {
                logger.error("[DEBUG] Unable to move the cursor: \(String(describing: cgError), privacy: .public)")
            } else { logger.error("Unable to move the cursor") }
            exit(EX_UNAVAILABLE)
        }
    }
    
    func applicationWillTerminate(_ aNotification: Notification) {
        // Insert code here to tear down your application
    }
}
