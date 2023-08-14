//
//  GlobalTextEditorView.swift
//  Marbler
//
//  Created by PEXAVC on 8/14/23.
//

import Foundation
import Granite
import SwiftUI

struct UniversalEditorView: View {
    @GraniteAction<String> var setContent
    @StateObject var textDebouncer: TextDebouncer
    
    init(_ startingText: String) {
        _textDebouncer = .init(wrappedValue: .init(startingText))
    }
    
    var body: some View {
        Group {
            if #available(macOS 13.0, iOS 16.0, *) {
                TextEditor(text: $textDebouncer.text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.foreground)
                    .background(.clear)
                    .font(.headline)
                    .scrollContentBackground(Visibility.hidden)
                    .padding(.layer3)
            } else {
                TextEditor(text: $textDebouncer.text)
                    .textFieldStyle(PlainTextFieldStyle())
                    .foregroundColor(.foreground)
                    .background(.clear)
                    .font(.headline)
                    .padding(.layer3)
            }
        }
        .onChange(of: textDebouncer.query) { newQuery in
            setContent.perform(newQuery)
        }
    }
}
