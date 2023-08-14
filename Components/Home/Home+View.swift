import Granite
import GraniteUI

import SwiftUI
import Foundation

extension Home: View {
    var safeAreaTop: CGFloat {
        #if os(iOS)
        if #available(iOS 11.0, *),
           let keyWindow = UIApplication.shared.keyWindow {
            return keyWindow.safeAreaInsets.top
        }
        return .layer1
        #endif
        return 0
    }
    
    @MainActor
    public var view: some View {
        VStack {
            Canvas()
        }
        .edgesIgnoringSafeArea([.top, .bottom])
        .padding(.top, safeAreaTop)
        .graniteNavigation(backgroundColor: Color.background, disable: Device.isMacOS) {
            Image(systemName: "chevron.backward")
                .renderingMode(.template)
                .font(.title2)
                .frame(width: 24, height: 24)
                .contentShape(Rectangle())
                .offset(x: -2)
        }
    }
}

struct GraniteTabIcon: View {
    @Environment(\.graniteTabSelected) var isTabSelected
    
    var name: String
    var larger: Bool = false
    
    var body: some View {
        Image(systemName: "\(name)\(isTabSelected == true ? ".fill" : "")")
            .renderingMode(.template)
            .font(larger ? Font.title : Font.title2.bold())
            .frame(width: 20,
                   height: 20,
                   alignment: .center)
            .padding(.top, larger ? 2 : 0)
            .contentShape(Rectangle())
    }
}
