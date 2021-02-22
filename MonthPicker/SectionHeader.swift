//
//  SectionHeader.swift
//  FinAppStoryboard
//
//  Created by Сергій Насінник on 21.02.2021.
//

import UIKit

class SectionHeader: UICollectionReusableView {
    
    static let reuseID = "SectionHeader"
    
    private let label: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.textColor = .white
        return label
    }()
    
    public func configure(title: String) {
        label.text = title
        addSubview(label)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        label.frame = bounds
    }
    
}
