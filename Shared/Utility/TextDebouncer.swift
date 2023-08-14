//
//  TextDebouncer.swift
//  Marbler
//
//  Created by PEXAVC on 8/14/23.
//

import Foundation
import SwiftUI
import Combine

class TextDebouncer : ObservableObject {
    @Published var query = ""
    @Published var text = ""
    
    private var cancellables = Set<AnyCancellable>()
    
    init(_ startingText: String) {
        self.text = startingText
        #if os(macOS)
        $text
            .debounce(for: .seconds(0.75), scheduler: DispatchQueue.main)
            .sink(receiveValue: { [weak self] value in
                let trimmedValue = value.trimmingCharacters(in: .whitespacesAndNewlines)
                guard trimmedValue.isEmpty == false else { return }
                self?.query = trimmedValue
            } )
            .store(in: &cancellables)
        #endif
    }
}
