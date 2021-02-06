//
//  CoreDataToDoList.swift
//  homework__14
//
//  Created by Дмитрий Старков on 06.02.2021.
//

import UIKit
import CoreData

class CoreDataToDoList: UIViewController {
    
    var toDoArray:[ToDoList] = []
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addItem))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest: NSFetchRequest<ToDoList> = ToDoList.fetchRequest()
        do {
            toDoArray = try context.fetch(fetchRequest)
        } catch let error as NSError{
            print(error.localizedDescription)
        }
        
        
    }
    
    @objc func addItem(){
        
        let alert = UIAlertController(title: "Новая Задача", message: "Пожалуйста, заполните поле", preferredStyle: .alert)
        
        var alertTF = UITextField()
        alert.addTextField { TF in
            alertTF = TF
            TF.placeholder = "Новая Задача"
        }
        
        
        let save = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let text = alertTF.text,!text.isEmpty else {return}
           
            self.saveTask(title: text)
        
            self.table.reloadData()
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    
    func saveTask(title:String){
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
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
    
}

extension CoreDataToDoList: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if toDoArray.count != 0 { return toDoArray.count } else
        { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = toDoArray[indexPath.row]
        cell.textLabel?.text = item.task
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title:"Delete") {  (contextualAction, view, boolValue) in
            let edit = self.toDoArray[indexPath.row]
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            context.delete(edit)
            
            do{
                try context.save()
                
            } catch let error as NSError {
                print(error.localizedDescription)
            }
            
            self.table.reloadData()
           
        }
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

            return swipeActions
    }
    
}
