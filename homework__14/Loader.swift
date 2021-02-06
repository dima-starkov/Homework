//
//  Loader.swift
//  homework__14
//
//  Created by Дмитрий Старков on 06.02.2021.
//

import Foundation

class Loader{
    
    func loadData(completion: @escaping (WeatherData?,Error?) -> Void){
        let url = URL(string:"https://api.openweathermap.org/data/2.5/weather?q=Moscow&appid=71934bd60fcbe86c04ac7578b6db5800&lang=ru&units=metric")!
        let request = URLRequest(url: url)
        let task = URLSession.shared.dataTask(with: request) { (data, response, error) in
            DispatchQueue.main.async {
            guard let data = data else {return}
            do{
                let weather = try JSONDecoder().decode(WeatherData.self, from: data)
                completion(weather,nil)
            } catch let jsonError{
                print("Failed to decode Json\(jsonError)")
                completion(nil,jsonError)
            }
            }
        }
        task.resume()
        
    }
}
