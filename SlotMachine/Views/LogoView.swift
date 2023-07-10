//
//  LogoView.swift
//  SlotMachine
//
//  Created by Lori Rothermel on 7/3/23.
//

import SwiftUI

struct LogoView: View {
    var body: some View {
        
        Image("gfx-slot-machine")
            .resizable()
            .scaledToFit()
            .frame(minWidth: 256, idealWidth: 300, maxWidth: 320, minHeight: 112, idealHeight: 130, maxHeight: 140, alignment: .center)
            .padding(.horizontal)
            .layoutPriority(1)
            .modifier(ShadowModifier())
        
    }  // some View
}  // LogoView


struct LogoView_Previews: PreviewProvider {
    static var previews: some View {
        LogoView()
    }
}
