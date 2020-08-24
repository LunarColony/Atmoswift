//
//  WeatherView.swift
//  Atmoswift
//
//  Created by Yunis Farah on 24/08/2020.
//

import SwiftUI

struct WeatherView: View {
    @State var weatherData: Model?
    var body: some View {
        NavigationView {
            VStack {
                HStack {
                    VStack {
                        TempView()
                            .padding()
                    }
                    Spacer()
                    Image(systemName: "sun.min.fill")
                        .resizable()
                        .frame(width: 60, height: 60)
                        .foregroundColor(.yellow)
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
