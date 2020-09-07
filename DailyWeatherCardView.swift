//
//  DailyWeatherCardView.swift
//  Atmoswift
//
//  Created by Yunis Farah on 25/08/2020.
//

import SwiftUI
import SwiftUICharts

struct DailyWeatherCardView: View {
    @State var dailyWeatherData: DailyWeatherModel?
    var body: some View {
        MainRectangleCard()
            .padding()
            .onAppear() {
                DailyWeatherAPI().loadDailyData() { (dailyInfo) in
                    self.dailyWeatherData = dailyInfo
                }
        }
    }
}

struct DailyWeatherCardView_Previews: PreviewProvider {
    static var previews: some View {
        DailyWeatherCardView()
    }
}


struct MainRectangleCard: View {
    @State var dailyWeatherData: DailyWeatherModel?
    @State var graphInfo: graphData?
    var body: some View {
        VStack {
            LineView(data: graphInfo?.hourlytemps() ?? [0.0], title: "Hourly Weather Forecast", legend: "Full screen")
                .padding()
                .onAppear() {
                    DailyWeatherAPI().loadDailyData() { (dailyInfo) in
                        self.dailyWeatherData = dailyInfo
                    }
            }
        }
    }
}

class graphData {
    var hourlytemps = { () -> [Double] in
        var tempValue = [0.0]
        var dailyWeatherData: DailyWeatherModel?
        for i in 0..<(dailyWeatherData?.list.count ?? 1) {
            tempValue += [(dailyWeatherData?.list[i].main.temp ?? 0.0)]
        }
        print(tempValue)
        return tempValue
    }
}
