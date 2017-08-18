//
//  AppDetailDescriptionCell.swift
//  AppStore
//
//  Created by Antonio081014 on 8/18/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class AppDetailDescriptionCell: BaseCell {
    var app: App? {
        didSet {
            if let text = app?.desc {
                self.textView.text = text
            }
        }
    }
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Description"
        label.font = UIFont.boldSystemFont(ofSize: 16)
        return label
    }()
    
    let textView: UITextView = {
        let tv = UITextView()
        tv.font = UIFont.systemFont(ofSize: 14)
        return tv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.nameLabel)
        self.addSubview(self.textView)
        self.addSubview(self.dividerLineView)
        
        self.addConstraint(with: "H:|-8-[v0]-8-|", views: self.nameLabel)
        self.addConstraint(with: "H:|-8-[v0]-8-|", views: self.textView)
        self.addConstraint(with: "H:|-14-[v0]|", views: self.dividerLineView)
        self.addConstraint(with: "V:|-8-[v0]-8-[v1][v2(1)]|", views: self.nameLabel, self.textView, self.dividerLineView)
    }
}
