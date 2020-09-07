//
//  SearchBarView.swift
//  Atmoswift
//
//  Created by Yunis Farah on 25/08/2020.
//

import SwiftUI

struct SearchBarView: View {
    @Environment(\.presentationMode) var presentationMode
    
    @State var userInput: String = ""
    var body: some View {
        NavigationView {
            List {
                VStack {
                    TextField("Search", text: $userInput)
                }
            }
                .listStyle(InsetGroupedListStyle())
            .navigationTitle("Add new city")
                .navigationBarItems(trailing:
                        Button(action: {
                            self.presentationMode.wrappedValue.dismiss()
                        }, label: {
                                Text("Done")
                            }))
        }
    }
}
