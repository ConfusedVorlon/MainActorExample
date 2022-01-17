//
//  NSAlert+async.swift
//  async3
//
//  Created by Rob Jonson on 14/01/2022.
//


import Foundation
import AppKit


extension NSAlert {

    enum Fail: String, Error {
        case alertCancelled
    }
    
    /// Async confirmation
    /// - Parameters:
    ///   - window: window
    ///   - message: message
    ///   - informativeText: info
    ///   - ok: ok -> returns true
    ///   - cancel: cancel -> returns false
    /// - Returns: true if 'ok' clicked
    static func confirm(from window: NSWindow,
                      message: String,
                      informativeText: String? = nil,
                      ok: String = "Ok",
                      cancel: String? = nil) async throws -> Void {

        return try await withCheckedThrowingContinuation {
            continuation in

            let alert = NSAlert()

            alert.messageText = message
            if let informativeText = informativeText {
                alert.informativeText = informativeText
            }

            alert.addButton(withTitle: ok)
            if let cancel = cancel {
                alert.addButton(withTitle: cancel)
            }

            alert.beginSheetModal(for: window, completionHandler: { returnCode in
                DispatchQueue.global(qos: .background).async {
                    print("beginSheetModal: main: \(Thread.isMainThread)")
                    if returnCode == .alertFirstButtonReturn {
                        continuation.resume()
                    } else {
                        continuation.resume(throwing: Fail.alertCancelled)
                    }
                }

            })
        }
    }
}
