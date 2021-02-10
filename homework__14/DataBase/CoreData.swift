//
//  CoreData.swift
//  homework__14
//
//  Created by Дмитрий Старков on 10.02.2021.
//

import Foundation
import CoreData


class Database {
    
    let appDelegate = UIApplication.shared.delegate as! AppDelegate
    let context = appDelegate.persistentContainer.viewContext
    
    var toDoArray:[ToDoList] {
        let fetchRequest: NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
        do {
            return toDoArray = try context.fetch(fetchRequest)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
    
    }
    
    func saveTask(title:String){
    
        guard let entity = NSEntityDescription.entity(forEntityName: "ToDoList", in: context) else {return}
        let taskObject = ToDoList(entity: entity, insertInto: context)
        taskObject.task = title
        
        do{
            try context.save()
            toDoArray.append(taskObject)
            
        } catch let error as NSError {
            print(error.localizedDescription)
        }
        
        
    }
    
    func deleteTask(edit:ToDoList) {
        context.delete(edit)
        do{
        try context.save()
            
        } catch let error as NSError {
            
        print(error.localizedDescription)
        }
    }
    
    
}
