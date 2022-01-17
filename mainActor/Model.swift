//
//  Model.swift
//  MainActorExample
//
//  Created by Rob Jonson on 17/01/2022.
//

import Foundation

class Model {
    var date:String {
        print("main: \(Thread.isMainThread)")
        return "\(Date())"
    }
    
    @MainActor var mainDate:String {
        print("@MainActor var - main: \(Thread.isMainThread)")
        return "\(Date())"
    }
    
    @MainActor func printDate(_ label:String) {
        print("@MainActor func - \(label) - main: \(Thread.isMainThread)")
    }
    
    var storedDate:String?
 
    @IBAction func doWorkInAsyncFunction(_ sender: Any) {

        Task { @MainActor in
            await doWork()
        }
    }
    
    func doWork() async  {
        let _ = await Background().go()

        print("returned from Background - now running off main thread")

        print("calling mainDate in doWork")
        self.storedDate = self.mainDate //sometimes not main thread
        printDate("in doWork") //sometimes not main thread
    }
    
    @IBAction func doWorkInAsyncFunctionWithPrint(_ sender: Any) {

        Task { @MainActor in
            //Adding this print statement, magically makes everything in doWork run on the main thread!!!
            print("Srsly?")
            await doWork()
        }
    }
    
    
    @IBAction func doInTask(_ sender: Any) {
        Task {
            let _ = await Background().go()

            print("returned from Background - now running off main thread")

            print("calling mainDate doInTask")
            self.storedDate = self.mainDate //main thread
            printDate("in doInTask") // main thread
        }
    }
}
