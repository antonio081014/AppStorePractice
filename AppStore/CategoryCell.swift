//
//  CategoryCell.swift
//  AppStore
//
//  Created by Antonio081014 on 8/14/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class CategoryCell: UICollectionViewCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    let cellID = "cellID"
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let appsCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        collectionView.backgroundColor = .clear
        collectionView.translatesAutoresizingMaskIntoConstraints = false
        return collectionView
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Best New Apps"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    func setupViews() {
        self.backgroundColor = .clear
        
        self.addSubview(self.appsCollectionView)
        self.addSubview(self.dividerLineView)
        self.addSubview(self.nameLabel)
        
        self.appsCollectionView.delegate = self
        self.appsCollectionView.dataSource = self
        
        self.appsCollectionView.register(AppCell.self, forCellWithReuseIdentifier: cellID)
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.nameLabel]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|-14-[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.dividerLineView]))
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.appsCollectionView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[nameLabel(30)][v0][v1(0.5)]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.appsCollectionView, "v1":self.dividerLineView, "nameLabel":self.nameLabel]))
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 25
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 100, height: self.bounds.height - 32)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! AppCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
}

class AppCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.image = UIImage(named: "frozen")
        iv.contentMode = .scaleAspectFit
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
    
    func setupViews() {
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
