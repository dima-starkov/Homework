//
//  Persistance.swift
//  homework 14
//
//  Created by Дмитрий Старков on 20.01.2021.
//

import Foundation
import RealmSwift

class Persistance {
    static let shared = Persistance()
    private let userNameKey = "Persistance.userNameKey"
    private let userSurNameKey = "Persistance.userSurNameKey"
    
    var userName: String? {
        set {UserDefaults.standard.set(newValue, forKey: userNameKey)}
        get {UserDefaults.standard.string(forKey:userNameKey)}
    }
    
    var surName: String? {
        set {UserDefaults.standard.set(newValue, forKey: userSurNameKey)}
        get {UserDefaults.standard.string(forKey:userSurNameKey)}
    }
    
}


class TaskList: Object {
    @objc dynamic var task = ""
    @objc dynamic var isDone = false
}

class Rlm {
    static let rlm = Rlm()
    let realm = try! Realm()
    var data: Results<TaskList>!
    data = realm.objects(TaskList.self)
    
    func save(task:String, isDone: Bool) {
        
        let obj = TaskList()
        obj.task = task
        obj.isDone = isDone
        realm.beginWrite()
        realm.add(obj)
        try! realm.commitWrite()
    }
    
    func delete(obj: TaskList) {
        let realm = try! Realm()
        data = realm.objects(TaskList.self)
        realm.beginWrite()
        realm.delete(obj)
        try! realm.commitWrite()
    }
    
}


class PersistanceWeather {
    static let shared = PersistanceWeather()
    private let tempKey = "Persistance.tempKey"
    private let feltKey = "Persistance.feltKey"
    
    var temp: String? {
        set {UserDefaults.standard.set(newValue, forKey: tempKey)}
        get {UserDefaults.standard.string(forKey:tempKey)}
    }
    
    var felt: String? {
        set {UserDefaults.standard.set(newValue, forKey: feltKey)}
        get {UserDefaults.standard.string(forKey:feltKey)}
    }
    
}
