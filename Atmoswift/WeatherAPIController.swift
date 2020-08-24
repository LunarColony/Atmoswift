//
//  WeatherAPIController.swift
//  Atmoswift
//
//  Created by Yunis Farah on 24/08/2020.
//

import SwiftUI


class WeatherAPI {
    func loadData(completion: @escaping (Model) -> ()) {
        guard let url = URL(string: "https://api.openweathermap.org/data/2.5/weather?q=oslo&units=metric&APPID=c256e12a788194c4496bd8406b26efd3") else { return }
        
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

extension Double {
    func getDateStringFromUTC() -> String {
        let date = Date(timeIntervalSince1970: self)

        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale(identifier: "en_GB")
        dateFormatter.dateStyle = .medium
        dateFormatter.dateFormat = "hh:MM"

        return dateFormatter.string(from: date)
    }
}
