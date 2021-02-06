//
//  ViewController.swift
//  homework__14
//
//  Created by Дмитрий Старков on 03.02.2021.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var helloLabel: UILabel!
    
    @IBOutlet weak var nameTF: UITextField!
    @IBOutlet weak var surNameTF: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        helloLabel.text = "Hello \(Persistance.shared.userName ?? "") \(Persistance.shared.surName ?? "")"
        
    }


    @IBAction func saveButton(_ sender: Any) {
        
        guard let name = nameTF.text,
              let surName = surNameTF.text else {return}
        Persistance.shared.userName = name
        Persistance.shared.surName = surName
    }
    
}


