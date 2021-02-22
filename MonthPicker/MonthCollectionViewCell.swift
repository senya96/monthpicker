//
//  MonthCollectionViewCell.swift
//  FinAppStoryboard
//
//  Created by Сергій Насінник on 20.02.2021.
//

import UIKit

class MonthCollectionViewCell: UICollectionViewCell {
    
    static var reuseID = "MonthCollectionViewCell"
    
    static func cellSize(width: CGFloat) -> CGSize {
        return CGSize(width: width, height: 50)
    }
    
    private var month: DateComponents?
    
    func getMonth() -> DateComponents?{
        return self.month
    }
    
    let label: UILabel = {
        let label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Saira", size: 18)
        label.textAlignment = .center
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func initViews(month: DateComponents, isCellSelected: Bool) {
        self.month = month
        label.text = "\(Calendar.current.monthSymbols[month.month!-1])"
        
        self.contentView.backgroundColor = isCellSelected ? UIColor(red: 225 / 255, green: 0, blue: 194 / 255, alpha: 0.6) : .clear
        addSubview(self.label)
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        setupConstraints()
    }
    
    func setupConstraints() {
        self.addSubview(label)
        label.topAnchor.constraint(equalTo: self.topAnchor).isActive = true
        label.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
        label.widthAnchor.constraint(equalTo: self.widthAnchor).isActive = true
        label.bottomAnchor.constraint(equalTo: self.bottomAnchor).isActive = true
    }
}
