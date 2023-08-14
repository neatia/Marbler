import Granite
import SwiftUI

struct Canvas: GraniteComponent {
    @Command var center: Center
    
    @State var action: WebViewAction = .idle
    @State var webviewState: WebViewState = .empty
    
}
