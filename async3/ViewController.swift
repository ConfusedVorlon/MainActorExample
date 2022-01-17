//
//  ViewController.swift
//  async3
//
//  Created by Rob Jonson on 14/01/2022.
//

import Cocoa

//Actor that isn't main - so it runs off the main thread
actor Background {
    func go() -> Date {
        // complex work to load a user from the database
        // happens here; we'll just send back an example
        print("Background go - main: \(Thread.isMainThread)")
        return Date()
    }
}


class ViewController: NSViewController {
    

    var date:Date {
        print("main: \(Thread.isMainThread)")
        return Date()
    }
    
    @MainActor var mainDate:Date {
        print("@MainActor var - main: \(Thread.isMainThread)")
        return Date()
    }
    
    @MainActor func printDate(_ label:String) {
        print("@MainActor func - \(label) - main: \(Thread.isMainThread)")
    }

    
    var storedDate:Date?
 
    @IBAction func doWorkInAsyncFunction(_ sender: Any) {

        Task { @MainActor in
            await doWork()
        }
    }
    
    @IBAction func doWorkInAsyncFunctionWithPrint(_ sender: Any) {

        Task { @MainActor in
            print("Srsly?")
            await doWork()
        }
    }
    
    
    @IBAction func doInTask(_ sender: Any) {
        Task {
            let _ = await Background().go()

            print("returned from oldStyle - now running off main thread")

            print("calling mainDate doInTask")
            self.storedDate = self.mainDate //not main thread
            printDate("in leaveMain") //not main thread
        }
    }
    
    func doWork() async  {
        let _ = await Background().go()

        print("returned from oldStyle - now running off main thread")

        print("calling mainDate in doWork")
        self.storedDate = self.mainDate //not main thread
        printDate("in leaveMain") //not main thread
    }
    

    
}
