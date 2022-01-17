//
//  ViewController.swift
//  async3
//
//  Created by Rob Jonson on 14/01/2022.
//

import Cocoa

//Actor that isn't main - it does not run on the main thread
actor Background {
    func go() -> String {
        print("Background go - main: \(Thread.isMainThread)")
        return "\(Date())"
    }
}


class ViewController: NSViewController {
    
    let model = Model()
 
    @IBAction func doWorkInAsyncFunction(_ sender: Any) {

        model.doWorkInAsyncFunction(self)
    }
    
    @IBAction func doWorkInAsyncFunctionWithPrint(_ sender: Any) {

        model.doWorkInAsyncFunctionWithPrint(self)
    }
    
    
    @IBAction func doInTask(_ sender: Any) {
        model.doInTask(self)
    }
    

    

    
}
