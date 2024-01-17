//
//  CustomStackView.swift
//  CollapsableStackView
//
//  Created by Himani Goyal on 20/12/22.
//

import UIKit

class CustomStackView: UIStackView {
    private var cards: [CollapsedCardViewModel] = []
    private var cardViews: [CollapsableCardView] = []
    
    init(frame: CGRect, cards: [CollapsedCardViewModel]) {
        super.init(frame: frame)
        self.cards = cards
        setUpView()
    }
    
    required init(coder: NSCoder) {
        super.init(coder: coder)
        setUpView()
    }
    
    func setUpView() {
        self.axis = .vertical

        for card in cards {
            let cardView = CollapsableCardView.view(dataModel: card)
            cardView.delegate = self
            cardViews.append(cardView)
            self.addArrangedSubview(cardView)
        }
        
        updateUIForSelectedCard(withIndex: 0)
    }
    
    func updateUIForSelectedCard(withIndex index: Int) {
        for i in 0 ..< cards.count {
            if i < index {
                cards[i].state = .collapsedAtTop
                cardViews[i].setState(state: .collapsedAtTop)
            } else if i == index {
                cards[i].state = .expanded
                cardViews[i].setState(state: .expanded)
            } else if i == index + 1 {
                cards[i].state = .collapsedAtBottom
                cardViews[i].setState(state: .collapsedAtBottom)
            } else {
                cards[i].state = .hidden
                cardViews[i].setState(state: .hidden)
            }
        }
    }
}

extension CustomStackView: CollapsableCardViewDelegate {
    func didTapCard(dataModel: CollapsedCardViewModel) {
        if let tappedCardIndex = cards.firstIndex(where: { $0.identifier == dataModel.identifier }) {
            self.updateUIForSelectedCard(withIndex: tappedCardIndex)
        }
    }
}
