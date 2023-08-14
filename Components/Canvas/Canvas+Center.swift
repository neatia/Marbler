import Granite
import SwiftUI

extension Canvas {
    struct Center: GraniteCenter {
        struct State: GraniteState {
            var additionalFunctionContentExample: String = ""
            var mainContentExample: String = ""
            
            
            //Main Render
            var additionalFunctionContent: String = ""
            var mainContent: String = ""
        }
        
        @Store public var state: State
    }
}
