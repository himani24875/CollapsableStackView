//
//  ViewController.swift
//  CollapsableStackView
//
//  Created by Himani Goyal on 20/12/22.
//

import UIKit

class ViewController: UIViewController {
    private lazy var stackView: CustomStackView = {
        var stackView = CustomStackView(
            frame: .zero,
            cards: self.getCardsDataModel()
        )
        stackView.translatesAutoresizingMaskIntoConstraints = false
        return stackView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setUpUI()
    }
    
    private func setUpUI() {
        self.view.backgroundColor = .white
        self.view.addSubview(stackView)
        self.addConstraints()
    }
    
    private func addConstraints() {
        NSLayoutConstraint.activate([
            stackView.topAnchor.constraint(equalTo: self.view.topAnchor),
            stackView.leftAnchor.constraint(equalTo: self.view.leftAnchor),
            stackView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            stackView.rightAnchor.constraint(equalTo: self.view.rightAnchor)
        ])
    }
    
    func getCardsDataModel() -> [CollapsedCardViewModel] {
        var cards: [CollapsedCardViewModel] = []
        let cardColors: [UIColor] = [.red, .blue, .green, .yellow]
        
        for i in 0 ..< 4 {
            var viewModel = CollapsedCardViewModel(identifier: "CC\(i)")
            viewModel.topCollapsedTitle = "I am collapsed at Top \(i)"
            viewModel.bottomCollapsedTitle = "I am collapsed at Bottom \(i)"
            viewModel.expandedStateTitle = "I am expanded \(i)"
            viewModel.backgroundColor = cardColors[i]
            cards.append(viewModel)
        }
        return cards
    }
}

