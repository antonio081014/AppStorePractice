//
//  AppCell.swift
//  AppStore
//
//  Created by Antonio081014 on 8/18/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class AppCell: BaseCell {
    
    var app: App? {
        didSet {
            if let name = app?.Name {
                self.nameLabel.text = name
                
                let rect = NSString(string: name).boundingRect(with: CGSize.init(width: self.bounds.width, height: 1000), options: [NSStringDrawingOptions.usesFontLeading, NSStringDrawingOptions.usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font : UIFont.systemFont(ofSize: 14)], context: nil)
                self.nameLabel.frame = rect
                if rect.height > 20 {
                    self.categoryLabel.frame = CGRect(x: 0, y: self.bounds.width + 38, width: self.bounds.width, height: 20)
                    self.priceLabel.frame = CGRect(x: 0, y: self.bounds.width + 56, width: self.bounds.width, height: 20)
                } else {
                    self.categoryLabel.frame = CGRect(x: 0, y: self.bounds.width + 22, width: self.bounds.width, height: 20)
                    self.priceLabel.frame = CGRect(x: 0, y: self.bounds.width + 40, width: self.bounds.width, height: 20)
                }
                self.nameLabel.frame = CGRect(x: 0, y: self.bounds.width + 4, width: self.bounds.width, height: 40)
                self.nameLabel.sizeToFit()
            }
            self.categoryLabel.text = app?.Category
            if let price = app?.Price {
                self.priceLabel.text = "$\(price)"
            } else {
                self.priceLabel.text = ""
            }
            
            if let imageName = app?.ImageName {
                self.imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "frozen")
        iv.contentMode = .scaleAspectFill
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Disney Build It: Frozen"
        label.font = UIFont.systemFont(ofSize: 14)
        label.numberOfLines = 2
        return label
    }()
    
    let categoryLabel: UILabel = {
        let label = UILabel()
        label.text = "Entertainment"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    let priceLabel: UILabel = {
        let label = UILabel()
        label.text = "$3.99"
        label.font = UIFont.systemFont(ofSize: 13)
        label.textColor = .darkGray
        return label
    }()
    
    override func setupViews() {
        super.setupViews()
        self.backgroundColor = .clear
        
        self.addSubview(self.imageView)
        self.addSubview(self.nameLabel)
        self.addSubview(self.categoryLabel)
        self.addSubview(self.priceLabel)
        
        self.imageView.frame = CGRect(x: 0, y: 0, width: self.bounds.width, height: self.bounds.width)
        self.nameLabel.frame = CGRect(x: 0, y: self.bounds.width + 2, width: self.bounds.width, height: 40)
        self.categoryLabel.frame = CGRect(x: 0, y: self.bounds.width + 38, width: self.bounds.width, height: 20)
        self.priceLabel.frame = CGRect(x: 0, y: self.bounds.width + 56, width: self.bounds.width, height: 20)
    }
}
