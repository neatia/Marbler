import Granite
import GraniteUI
import SwiftUI

extension Canvas: View {
    public var view: some View {
        VStack(spacing: 0) {
            HStack(spacing: .layer3) {
                Button {
                    GraniteHaptic.light.invoke()
                    
                    guard let url = URL(string: "https://github.com") else {
                        return
                    }
                    
                    let example: ExampleShader = .init()
                    
                    _state.additionalFunctionContentExample.wrappedValue = example.additionalFunctionContent
                    _state.mainContentExample.wrappedValue = example.mainContent
                    
                    action = .loadHTML(Generate
                        .shader(header: Generate.header,
                                additionalFunctions: example.additionalFunctionContent,
                                mainContent: example.mainContent), url)
                } label: {
                    Text("Example")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.75))
                        .cornerRadius(8)
                        .font(.headline)
                }
                .buttonStyle(PlainButtonStyle())
                
                Spacer()
                
                Button {
                    GraniteHaptic.light.invoke()
                    //Dummy url
                    guard let url = URL(string: "https://github.com") else {
                        return
                    }
                    
                    action = .loadHTML(Generate
                        .shader(header: Generate.header,
                                additionalFunctions: state.additionalFunctionContent,
                                mainContent: state.mainContent), url)
                    
                } label: {
                    Text("Run")
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.green.opacity(0.75))
                        .cornerRadius(8)
                        .font(.headline)
                }
                .buttonStyle(PlainButtonStyle())
            }
            .frame(height: 24)
            .padding(.leading, .layer4)
            .padding(.trailing, .layer4)
            .padding(.vertical, .layer4)
            
            Divider()
            
            HStack(spacing: 0) {
                VStack(spacing: 8) {
                    HStack {
                        Text("Fixed Globals")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding(.top, .layer2)
                    
                    HStack {
                        Text(Generate.header+"\n"+Generate.additionalHeaderTooltip)
                            .multilineTextAlignment(.leading)
                            .font(.headline.bold())
                            .foregroundColor(.foreground.opacity(0.5))
                        Spacer()
                    }
                    
                    HStack {
                        Text("Additional functions")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding(.top, .layer2)
                    
                    UniversalEditorView(state.additionalFunctionContentExample)
                        .attach({ content in
                            _state.additionalFunctionContent.wrappedValue = content
                        }, at: \.setContent)
                        .id(state.additionalFunctionContentExample.count)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.foreground.opacity(0.5), lineWidth: 2.0))
                    
                    HStack {
                        Text("main()")
                            .font(.title2.bold())
                        Spacer()
                    }
                    .padding(.top, .layer2)
                    
                    UniversalEditorView(state.mainContentExample)
                        .attach({ content in
                            _state.mainContent.wrappedValue = content
                        }, at: \.setContent)
                        .id(state.mainContentExample.count)
                        .background(RoundedRectangle(cornerRadius: 8).stroke(Color.foreground.opacity(0.5), lineWidth: 2.0))
                }
                .padding(.horizontal, .layer4)
                .padding(.bottom, .layer4)
                
                Divider()
                
                GraniteWebView(action: $action, state: $webviewState)
            }
        }
        .padding(.top, .layer4)
        .onAppear {
            #if os(iOS)
            UITextView.appearance().backgroundColor = .clear
            #endif
        }
    }
}

#if canImport(UIKit)
extension View {
    func hideKeyboard() {
        UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
#endif
