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
