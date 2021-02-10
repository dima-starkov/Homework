//
//  RealmToDoList.swift
//  homework__14
//
//  Created by Дмитрий Старков on 06.02.2021.
//

import UIKit


class RealmToDoList: UIViewController {
  
    @IBOutlet weak var table: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Добавить", style: .plain, target: self, action: #selector(addItem))
        
    }
    
    @objc func addItem(){
        
        let alert = UIAlertController(title: "Новая Задача", message: "Пожалуйста, заполните поле", preferredStyle: .alert)
        
        var alertTF = UITextField()
        alert.addTextField { TF in
            alertTF = TF
            TF.placeholder = "Новая Задача"
        }
        
        
        let save = UIAlertAction(title: "Сохранить", style: .default) { action in
            guard let text = alertTF.text , !text.isEmpty else {return}
           
            Rlm.rlm.save(task: text, isDone: false)
            
            self.table.insertRows(at: [IndexPath.init(row: Rlm.rlm.data.count - 1, section: 0)], with: .automatic)
        }
        
        let cancel = UIAlertAction(title: "Отмена", style: .destructive, handler: nil)
        alert.addAction(save)
        alert.addAction(cancel)
        present(alert, animated: true, completion: nil)
        
    }
    


}

extension RealmToDoList: UITableViewDataSource,UITableViewDelegate {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if Rlm.rlm.data.count != 0 { return Rlm.rlm.data.count } else
        { return 0 }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        let item = Rlm.rlm.data[indexPath.row]
        cell.textLabel?.text = item.task
        if item.isDone{cell.accessoryType = .checkmark}
        return cell
        
    }
    
    func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let contextItem = UIContextualAction(style: .destructive, title:"Delete") {  (contextualAction, view, boolValue) in
            let edit = Rlm.rlm.data[indexPath.row]
            Rlm.rlm.delete(obj: edit)
            self.table.reloadData()
            }
            let swipeActions = UISwipeActionsConfiguration(actions: [contextItem])

            return swipeActions
    }
    
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let task = Rlm.rlm.data[indexPath.row]
        
        if task.isDone{
            table.cellForRow(at: indexPath)?.accessoryType = .none
            Rlm.rlm.edit(task: task, isDone: false)
        } else {
            table.cellForRow(at: indexPath)?.accessoryType = .checkmark
            Rlm.rlm.edit(task: task, isDone: true)
            }
        }
    
    }


