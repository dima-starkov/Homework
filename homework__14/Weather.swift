//
//  Weather.swift
//  homework__14
//
//  Created by Дмитрий Старков on 06.02.2021.
//

import UIKit

class Weather: UIViewController {

    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var feltLabel: UILabel!
    
    let loader = Loader()
    var weatherData: WeatherData? = nil
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.tempLabel.text = PersistanceWeather.shared.temp
        self.feltLabel.text = PersistanceWeather.shared.felt
        
        
        loader.loadData { (data, error) in
            self.weatherData = data
            let temperature = String( (self.weatherData?.main["temp"])!)
            let felt = String( (self.weatherData?.main["feels_like"])!)
            
            self.tempLabel.text = "\(temperature)°C"
            self.feltLabel.text = "ощущается как \(felt)°C"
            
            PersistanceWeather.shared.temp = self.tempLabel.text
            PersistanceWeather.shared.felt = self.feltLabel.text
            
        }
    }
    

}
