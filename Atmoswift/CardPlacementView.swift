//
//  CardPlacementView.swift
//  Atmoswift
//
//  Created by Yunis Farah on 24/08/2020.
//

import SwiftUI

struct CardPlacementView: View {
    @State var weatherData: Model?

    var body: some View {
        ZStack {
            RectangleBox()
            DataToPresentInCard()
                .padding()
        }

            .onAppear() {
                WeatherAPI().loadData() { (info) in
                    self.weatherData = info

                }
        }
    }

    struct CardPlacementView_Previews: PreviewProvider {
        static var previews: some View {
            CardPlacementView()
                .preferredColorScheme(.dark)
        }
    }


    struct RectangleBox: View {
        var body: some View {
            Rectangle()
                .frame(width: 400, height: 90)
                .foregroundColor(.gray)
                .opacity(0.1)
                .cornerRadius(20)
            Spacer()
        }
    }
}

struct DataToPresentInCard: View {
    @State var weatherData: Model?
    var body: some View {
        HStack {
            Image(systemName: "wind")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.blue)
            Text("\(self.weatherData?.wind.speed ?? 0, specifier: "%.1f") m/s")
            Spacer()
            Image(systemName: "sunrise.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.yellow)
            Text("\((Double(self.weatherData?.sys.sunrise ?? 0) as! Double).getDateStringFromUTC())")
            Spacer()
            Image(systemName: "sunset.fill")
                .resizable()
                .frame(width: 30, height: 30)
                .foregroundColor(.orange)
            Text("\((Double(self.weatherData?.sys.sunset ?? 0) as! Double).getDateStringFromUTC())")
            Spacer()
        }
            .onAppear() {
                WeatherAPI().loadData() { (info) in
                    self.weatherData = info

                }
        }
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
