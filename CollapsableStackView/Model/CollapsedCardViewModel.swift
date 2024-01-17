//
//  CollapsedCardViewModel.swift
//  CollapsableStackView
//
//  Created by Himani Goyal on 20/12/22.
//

import UIKit

struct CollapsedCardViewModel {
    let identifier: String
    var state: CardState
    var topCollapsedTitle: String
    var bottomCollapsedTitle: String
    var expandedStateTitle: String
    var backgroundColor: UIColor
    
    init(identifier: String) {
        self.identifier = identifier
        self.state = .hidden
        self.topCollapsedTitle = String()
        self.bottomCollapsedTitle = String()
        self.expandedStateTitle = String()
        self.backgroundColor = .clear
    }
    
    init() {
        self.init(identifier: String())
    }
}
