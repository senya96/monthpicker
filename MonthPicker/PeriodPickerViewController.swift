//
//  PeriodPickerViewController.swift
//  MonthPicker
//
//  Created by Сергій Насінник on 21.02.2021.
//

import Foundation
import UIKit

class PeriodPickerViewController: BaseViewController {
    
    var data: [Int: [Int: DateComponents]] = [:]
    
    var onDisappearHangler: ((DateComponents?, DateComponents?) -> Void)?
    var month1: DateComponents?
    var month2: DateComponents?
    
    var currentDate: Date = {
        var dc = DateComponents()
        dc.month = 0
        let currentDate = Calendar.current.date(byAdding: dc, to: Date())!
        return currentDate
    }()
    
    var label: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Saira", size: 20)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "План на місяць" //Виберіть місяці для кожного з яких буде встановлено ваш план"
        return label
    }()
    
    var sublabel: UILabel = {
        var label = UILabel()
        label.textColor = .white
        label.font = UIFont(name: "Saira", size: 15)
        label.translatesAutoresizingMaskIntoConstraints = false
        label.text = "Підзаголовок"
        return label
    }()
    
    let scrollView: UIScrollView = {
        let scroll = UIScrollView()
        scroll.showsVerticalScrollIndicator = false
        scroll.translatesAutoresizingMaskIntoConstraints = false
        return scroll
    }()
    let contentView: UIView = {
        let view = UIView()
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.minimumLineSpacing = 15
        layout.minimumInteritemSpacing = 0
        
        
        layout.sectionInset = UIEdgeInsets(top: 0, left: 0, bottom: 15, right: 0)
        let view = UICollectionView(frame: .zero, collectionViewLayout: layout)
        view.backgroundColor = .clear
        
        return view
    }()
    
    func isSelected(month: DateComponents) -> Bool{
        if month1 != nil && month2 != nil{
            let date1 = Calendar.current.date(from: month1!)!
            let date2 = Calendar.current.date(from: month2!)!
            let cellDate = Calendar.current.date(from: month)!
            if date1 <= cellDate && cellDate <= date2{
                return true
            }
        }
        if month1 != nil{
            let date1 = Calendar.current.date(from: month1!)!
            let cellDate = Calendar.current.date(from: month)!
            if date1 == cellDate{
                return true
            }
        }
        if month2 != nil{
            let date2 = Calendar.current.date(from: month2!)!
            let cellDate = Calendar.current.date(from: month)!
            if date2 == cellDate{
                return true
            }
        }
        return false
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setupNavBar(isHidden: false)
        
        let monthStart = Calendar.current.dateComponents([.month, .year], from: Date())
        
        print(monthStart.month!)//2
        print(monthStart.year!)
        print(Calendar.current.monthSymbols[monthStart.month!-1]) // February
        
        var dateComponent = DateComponents()
        dateComponent.month = 11
        
        let futureDate = Calendar.current.date(byAdding: dateComponent, to: Date())!
        let monthEnd = Calendar.current.dateComponents([.month, .year], from: futureDate)
        
        print(monthEnd.month!) // 2
        print(monthEnd.year!)
        print(Calendar.current.monthSymbols[monthEnd.month!-1]) // February
        
        view.addSubview(label)
        view.addSubview(sublabel)
        
        collectionView.delegate = self
        collectionView.dataSource = self
        
        collectionView.register(MonthCollectionViewCell.self, forCellWithReuseIdentifier: MonthCollectionViewCell.reuseID)
        collectionView.register(SectionHeader.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID)
        
        
        createConstraints()
        
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        setupScrollViewConstraints()
        setupContentViewConstraints()
        setupCollectionViewConstraints()
    }
    
    func createConstraints(){
        label.topAnchor.constraint(equalTo: self.view.layoutMarginsGuide.topAnchor).isActive = true
        label.leadingAnchor.constraint(equalTo: self.view.leadingAnchor, constant: 20).isActive = true
        
        sublabel.topAnchor.constraint(equalTo: label.bottomAnchor).isActive = true
        sublabel.leadingAnchor.constraint(equalTo: label.leadingAnchor).isActive = true
        
    }
    
    func setupScrollViewConstraints(){
        scrollView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        scrollView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        scrollView.topAnchor.constraint(equalTo: sublabel.bottomAnchor).isActive = true
        scrollView.bottomAnchor.constraint(equalTo: self.view.bottomAnchor).isActive = true
    }
    
    func setupContentViewConstraints(){
        contentView.centerXAnchor.constraint(equalTo: scrollView.centerXAnchor).isActive = true
        contentView.widthAnchor.constraint(equalTo: scrollView.widthAnchor).isActive = true
        contentView.topAnchor.constraint(equalTo: scrollView.topAnchor).isActive = true
        contentView.bottomAnchor.constraint(equalTo: scrollView.bottomAnchor).isActive = true
    }
    
    func setupCollectionViewConstraints(){
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(collectionView)
        
        collectionView.topAnchor.constraint(equalTo: contentView.topAnchor).isActive = true
        collectionView.widthAnchor.constraint(equalTo: self.view.widthAnchor).isActive = true
        collectionView.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        collectionView.heightAnchor.constraint(greaterThanOrEqualToConstant: 10).isActive = true
        
        contentView.bottomAnchor.constraint(equalTo: collectionView.bottomAnchor, constant: 20).isActive = true
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        onDisappearHangler?(month1, month2)
        super.viewWillDisappear(animated)
    }
}


extension PeriodPickerViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return Calendar.current.dateComponents([.month], from: currentDate).month == 1 ? 1 : 2
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let monthNumber = Calendar.current.dateComponents([.month], from: currentDate).month!  //1...12
        if section == 0 {
            return 12 - monthNumber + 1
        } else {
            return monthNumber - 1
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: MonthCollectionViewCell.reuseID, for: indexPath)
        
        if let cell = cell as? MonthCollectionViewCell {
            var dateComponent = DateComponents()
            if indexPath.section == 0{
                dateComponent.month = indexPath.row
            }
            else {
                dateComponent.month = self.collectionView(collectionView, numberOfItemsInSection: 0) + indexPath.row
            }
            
            let month = Calendar.current.dateComponents([.month, .year], from: Calendar.current.date(byAdding: dateComponent, to: currentDate)!)  //1...12
            if !data.keys.contains(indexPath.section){
                data[indexPath.section] = [:]
            }
            data[indexPath.section]![indexPath.row] = month
            cell.initViews(month: month, isCellSelected: self.isSelected(month: month))
        }
        return cell
    }
    
    
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: SectionHeader.reuseID, for: indexPath) as! SectionHeader
        
        header.configure(title: "\(Calendar.current.dateComponents([.year], from: currentDate).year! + indexPath.section)")
        self.collectionView.heightAnchor.constraint(equalToConstant: self.collectionView.collectionViewLayout.collectionViewContentSize.height).isActive = true
        return header
    }
    
    
}

extension PeriodPickerViewController: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let month = data[indexPath.section]![indexPath.row]
        if month1 != nil && month2 != nil{
            month1 = month
            month2 = nil
        } else if month1 == nil {
            month1 = month
        } else {
            month2 = month
        }
        
        if let m1 = month1, let m2 = month2{
            if m1.year! > m2.year! || (m1.year! == m2.year! && m1.month! > m2.month!){  //m1.month! > m2.month! && m1.year! >= m2.year!{
                month1 = m2
                month2 = m1
            }
        }
        collectionView.reloadData()
    }
    func collectionView(_ collectionView: UICollectionView,
                        willDisplay cell: UICollectionViewCell,
                        forItemAt indexPath: IndexPath){
        if let c = cell as? MonthCollectionViewCell {
            c.layoutSubviews()
        }
        self.collectionView.heightAnchor.constraint(equalToConstant: self.collectionView.collectionViewLayout.collectionViewContentSize.height).isActive = true
    }
    
}



// MARK: - UICollectionViewDelegateFlowLayout
extension PeriodPickerViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let width = (collectionView.frame.width / 3)
        return MonthCollectionViewCell.cellSize(width: width)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: view.frame.size.width, height: 70)
    }
    
}
