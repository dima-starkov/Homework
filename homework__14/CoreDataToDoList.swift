//
//  CoreDataToDoList.swift
//  homework__14
//
//  Created by Дмитрий Старков on 06.02.2021.
//

import UIKit


class CoreDataToDoList: UIViewController {
    
    
    
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addItem))
       
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
    
        
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
            
            self.toDoArray.remove(at: indexPath.row)
            self.table.reloadData()
        }
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])
        
            return swipeActions
    }
    
}
