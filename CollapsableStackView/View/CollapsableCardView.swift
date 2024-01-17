//
//  CollapsableCardView.swift
//  CollapsableStackView
//
//  Created by Himani Goyal on 20/12/22.
//

import UIKit

protocol CollapsableCardViewDelegate: AnyObject {
    func didTapCard(dataModel: CollapsedCardViewModel)
}

enum CardState {
    case expanded
    case collapsedAtTop
    case collapsedAtBottom
    case hidden
}

class CollapsableCardView: UIView {
    @IBOutlet weak var stackViewContainer: UIStackView!
    @IBOutlet weak var topCollapsedView: UIView!
    @IBOutlet weak var bottomCollapsedView: UIView!
    @IBOutlet weak var expandedView: UIView!
    
    @IBOutlet weak var topCollapsedLbl: UILabel!
    @IBOutlet weak var expandedLbl: UILabel!
    @IBOutlet weak var bottomCollapsedLbl: UILabel!
        
    weak var delegate: CollapsableCardViewDelegate?
    private var dataModel = CollapsedCardViewModel()
    
    init(frame: CGRect, dataModel: CollapsedCardViewModel) {
        super.init(frame: frame)
        self.dataModel = dataModel
        setUpView()
    }

    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    static func view(
        dataModel: CollapsedCardViewModel
    ) -> CollapsableCardView {
        let cardNib = UINib.init(nibName: "CollapsableCardView", bundle: .main)
        let cardView = cardNib.instantiate(withOwner: nil, options: nil)[0] as! CollapsableCardView
        cardView.dataModel = dataModel
        cardView.populateData()
        return cardView
    }
    
    func setState(state: CardState) {
        dataModel.state = state
        self.setUpView()
    }
    
    func populateData() {
        self.topCollapsedLbl.text = dataModel.topCollapsedTitle
        self.expandedLbl.text = dataModel.expandedStateTitle
        self.bottomCollapsedLbl.text = dataModel.bottomCollapsedTitle
        self.backgroundColor = dataModel.backgroundColor
        
        setUpView()
    }
    
    func setUpView() {
        self.isHidden = false
        
        switch dataModel.state {
        case .collapsedAtBottom:
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                if !self.topCollapsedView.isHidden {
                    self.topCollapsedView.isHidden = true
                }
                if !self.expandedView.isHidden {
                    self.expandedView.isHidden = true
                }
                self.bottomCollapsedView.isHidden = false
            }
        case .collapsedAtTop:
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                self.topCollapsedView.isHidden = false
                
                if !self.expandedView.isHidden {
                    self.expandedView.isHidden = true
                }
                
                if !self.bottomCollapsedView.isHidden {
                    self.bottomCollapsedView.isHidden = true
                }
            }
        case .expanded:
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                if !self.topCollapsedView.isHidden {
                    self.topCollapsedView.isHidden = true
                }
                
                self.expandedView.isHidden = false
                
                if !self.bottomCollapsedView.isHidden {
                    self.bottomCollapsedView.isHidden = true
                }
            }
        case .hidden:
            UIView.animate(withDuration: 1) { [weak self] in
                guard let self = self else { return }
                if !self.topCollapsedView.isHidden {
                    self.topCollapsedView.isHidden = true
                }
                
                if !self.expandedView.isHidden {
                    self.expandedView.isHidden = true
                }
                
                if !self.bottomCollapsedView.isHidden {
                    self.bottomCollapsedView.isHidden = true
                }
                
                self.isHidden = true
            }
        }
    }
    
    @IBAction func didTapTopCollapsedView(_ sender: UIButton) {
        self.delegate?.didTapCard(dataModel: self.dataModel)
    }

    @IBAction func didTapBottomCollpasedView(_ sender: UIButton) {
        self.delegate?.didTapCard(dataModel: self.dataModel)
    }
}
