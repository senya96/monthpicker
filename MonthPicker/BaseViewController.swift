//
//  BaseViewController.swift
//  FinAppStoryboard
//
//  Created by Сергій Насінник on 12.02.2021.
//

import UIKit

class BaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupBackground()
    }
    
    let backgroundImageView: UIImageView = {
        let backgroundImage = UIImage(named: "background1")
        let backgroundImageView = UIImageView()
        backgroundImageView.image = backgroundImage
        backgroundImageView.translatesAutoresizingMaskIntoConstraints = false
        return backgroundImageView
    }()
    
    func setupNavBar(isHidden: Bool = false){
        self.navigationController?.setNavigationBarHidden(isHidden, animated: true)
        if !isHidden{
            self.navigationController?.navigationBar.setBackgroundImage(UIImage(), for: .default)
            self.navigationController?.navigationBar.shadowImage = UIImage()
            self.navigationController?.navigationBar.isTranslucent = true
        }
    }
    
    func setupBackground(){
        
        view.addSubview(backgroundImageView)
        
        backgroundImageView.leftAnchor.constraint(equalTo: view.leftAnchor).isActive = true
        backgroundImageView.topAnchor.constraint(equalTo: view.topAnchor).isActive = true
        backgroundImageView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        backgroundImageView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        
    }
    
    
    
    
}

