//
//  InfoView.swift
//  SlotMachine
//
//  Created by Lori Rothermel on 7/4/23.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) var dismiss
    
    
    var body: some View {
        VStack(alignment: .center, spacing: 10) {
            LogoView()
            
            Spacer()
            
            Form {
                Section(header: Text("About The Application")) {
                    FormRowView(firstItem: "Application", secondItem: "Slot Machine")
                    FormRowView(firstItem: "Platforms", secondItem: "iPhone, iPad, Mac")
                    FormRowView(firstItem: "Developer", secondItem: "Lori B. Rothermel")
                    FormRowView(firstItem: "Designer", secondItem: "Sir Winston Rothermel 7th")
                    FormRowView(firstItem: "Music", secondItem: "Dan Lebowitz")
                    FormRowView(firstItem: "Website", secondItem: "????")
                    FormRowView(firstItem: "Copyright", secondItem: "© 2023 All Rights Reserved")
                    FormRowView(firstItem: "Version", secondItem: "1.0.0")
                }  // Section
            }  // Form
            .font(.system(.body, design: .rounded))
            
        }  // VStack
        .padding(.top, 40)
        .overlay(
            Button(action: {
                dismiss()
            }, label: {
                Image(systemName: "xmark.circle")
                    .font(.title)
            })  // Button
                .padding(.top, 30)
                .padding(.trailing, 20)
                .accentColor(.secondary)
            , alignment: .topTrailing
        )  // .overlay
        
    }  // some View
}  // InfoView



struct FormRowView: View {
    var firstItem: String
    var secondItem: String
    
    
    var body: some View {
        HStack {
            Text(firstItem)
                .foregroundColor(.gray)
            Spacer()
            Text(secondItem)
        }  // HStack
    }
}



struct InfoView_Previews: PreviewProvider {
    static var previews: some View {
        InfoView()
    }
}

