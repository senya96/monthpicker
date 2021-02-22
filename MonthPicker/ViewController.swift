//
//  ViewController.swift
//  MonthPicker
//
//  Created by Сергій Насінник on 21.02.2021.
//

import UIKit

class ViewController: BaseViewController {
    
    @objc
    func buttonAction(_ sender: UIButton){
        let vc = PeriodPickerViewController()
        vc.onDisappearHangler = {
            dc1, dc2 in
            print("Start: \(dc1)")
            print("End: \(dc2)")
        }
        self.navigationController?.pushViewController(vc, animated: true)
    }
    
    let planButton: UIButton = {
        let button = UIButton()
        button.backgroundColor = UIColor(red: 225 / 255, green: 0, blue: 194 / 255, alpha: 0.6)
        button.setTitle("Запланувати", for: .normal)
        button.addTarget(self, action: #selector(buttonAction(_:)), for: .touchUpInside)
        button.translatesAutoresizingMaskIntoConstraints = false
        return button
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(planButton)
        planButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        planButton.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        // Do any additional setup after loading the view.
    }


}

