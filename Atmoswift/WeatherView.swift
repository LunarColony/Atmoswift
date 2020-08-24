//
//  WeatherView.swift
//  Atmoswift
//
//  Created by Yunis Farah on 24/08/2020.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherData: Model?

    let weatherIcons = [
        "Clear": "sun.min.fill",
        "Few clouds": "cloud.sun.fill",
        "Scattered clouds": "cloud.fill",
        "Broken clouds": "smoke.fill",
        "Shower rain": "cloud.rain.fill",
        "Rain": "cloud.heavyrain.fill",
        "Thunderstorm": "cloud.bolt.rain.fill",
        "Snow": "snow",
        "Mist": "cloud.fog.fill"
    ]
    
    let weatherIconsColors = [
        "Clear": Color.yellow,
        "Few clouds": Color.yellow,
        "Scattered clouds": Color.black,
        "Broken clouds": Color.gray,
        "Shower rain": Color.blue,
        "Rain": Color.blue,
        "Thunderstorm": Color.blue,
        "Snow": Color.blue,
        "Mist": Color.gray
    ] as [String : Any]
 

    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        TempView()
                            .padding()
                    }
                    Spacer()
                    Image(systemName: weatherIcons[self.weatherData?.weather[0].main ?? ""] ?? "")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(weatherIconsColors[self.weatherData?.weather[0].main ?? ""] as? Color)
                        .padding()
                }
                CardPlacementView()
                Spacer()
            }
                .padding()

                .navigationTitle("\(self.weatherData?.name ?? "loading"), \(self.weatherData?.sys.country ?? "")")
        }
            .onAppear() {
                WeatherAPI().loadData() { (info) in
                    self.weatherData = info

                }
        }
    }
}

struct WeatherView_Previews: PreviewProvider {
    static var previews: some View {
        WeatherView()
    }
}

struct TempView: View {
    @State var weatherData: Model?
    var body: some View {
        VStack {
            Text("\(self.weatherData?.main.temp ?? 0, specifier: "%.0f")°C")
                .font(.custom("Arial", size: 50))
                .bold()
            Text("\(self.weatherData?.weather[0].description ?? "")")
                .font(.custom("Arial", size: 14))
                .bold()
        }
            .onAppear() {
                WeatherAPI().loadData() { (info) in
                    self.weatherData = info
                }
        }
    }
}
