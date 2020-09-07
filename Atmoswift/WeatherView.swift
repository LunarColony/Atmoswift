//
//  WeatherView.swift
//  Atmoswift
//
//  Created by Yunis Farah on 24/08/2020.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherData: Model?
    @State var dailyWeatherData: DailyWeatherModel?
    @State var searchButtonState = false

    let weatherIcons = [
        "Clear": "sun.min.fill",
        "Clouds": "cloud.sun.fill",
        "Rain": "cloud.rain.fill",
        "Thunderstorm": "cloud.bolt.rain.fill",
        "Snow": "snow",
        "Mist": "cloud.fog.fill"
    ]

    let weatherIconsColors = [
        "Clear": Color.yellow,
        "Clouds": Color.gray,
        "Rain": Color.blue,
        "Thunderstorm": Color.blue,
        "Snow": Color.blue,
        "Mist": Color.gray
    ] as [String: Any]

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
                        .frame(width: 90, height: 60)
                        .foregroundColor(weatherIconsColors[self.weatherData?.weather[0].main ?? ""] as? Color)
                        .padding()
                }
                CardPlacementView()
                DailyWeatherCardView()
                Spacer()
            }
                .padding()

                .navigationTitle("\(self.weatherData?.name ?? "loading"), \(self.weatherData?.sys.country ?? "")")
                .navigationBarItems(trailing:
                        Button(action: {
                            self.searchButtonState.toggle()
                        }) {
                            Image(systemName: "magnifyingglass.circle")
                                .resizable()
                                .frame(minWidth: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealWidth: 30, maxWidth: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, minHeight: /*@START_MENU_TOKEN@*/0/*@END_MENU_TOKEN@*/, idealHeight: 30, maxHeight: /*@START_MENU_TOKEN@*/.infinity/*@END_MENU_TOKEN@*/, alignment: /*@START_MENU_TOKEN@*/.center/*@END_MENU_TOKEN@*/)
                        }.sheet(isPresented: $searchButtonState) {
                            SearchBarView()
                        }
                )

        }
            .onAppear() {
                WeatherAPI().loadData() { (info) in
                    self.weatherData = info

                }
                
                DailyWeatherAPI().loadDailyData() { (dailyInfo) in
                    self.dailyWeatherData = dailyInfo
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
