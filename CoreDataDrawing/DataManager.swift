//
//  DataManager.swift
//  CoreDataDrawing
//
//  Created by Anant Patni on 1/23/23.
//

import Foundation
import UIKit

class DataManager {
    
    static var shared = DataManager()
    
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveData(drawingData: Data, imageData: Data) {
        let drawing = Drawing(context: context)
        
        // Save data here
        drawing.drawingData = drawingData
        drawing.imageData = imageData
    
        do {
            try context.save()
        } catch {
            print("Data could not be saved")
        }
    }
    
    func fetchData() -> [Drawing] {
        var fetchedData = [Drawing]()
        do {
            fetchedData = try context.fetch(Drawing.fetchRequest())
        } catch {
            print("Fetching failed")
        }
        return fetchedData
    }
}
