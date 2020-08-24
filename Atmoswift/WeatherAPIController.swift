//
//  WeatherAPIController.swift
//  Atmoswift
//
//  Created by Yunis Farah on 24/08/2020.
//

import SwiftUI


class WeatherAPI {
    func loadData(completion: @escaping (Model) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=London&units=metric&APPID=c256e12a788194c4496bd8406b26efd3") else { return }
        
        URLSession.shared.dataTask(with: url) { (data, _, _) in
            do {
                let apiData = try JSONDecoder().decode(Model.self, from: data!)
                
                DispatchQueue.main.async {
                    completion(apiData)
                }
                
            } catch  {
                print(error.localizedDescription)
            }
        }.resume()
    }
}


class UnixTimestampConverter {
    
}
