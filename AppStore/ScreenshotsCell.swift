//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by Antonio081014 on 8/18/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    private let cellID = "cellID"
    
    var app: App? {
        didSet {
            self.collectionView.reloadData()
        }
    }
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.collectionView)
        self.addSubview(self.dividerLineView)
        
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellID)
        
        self.addConstraint(with: "H:|[v0]|", views: self.collectionView)
        self.addConstraint(with: "V:|[v0][v1(1)]|", views: self.collectionView, self.dividerLineView)
        self.addConstraint(with: "H:|-14-[v0]|", views: self.dividerLineView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.app?.screenshots?.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ScreenshotImageCell
        if let imageName = self.app?.screenshots?[indexPath.item] {
            cell.imageView.image = UIImage(named:imageName)
        }
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 240, height: self.bounds.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class ScreenshotImageCell: BaseCell {
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.layer.masksToBounds = true
            return iv
        }()
        override func setupViews() {
            super.setupViews()
            self.addSubview(self.imageView)
            self.addConstraint(with: "H:|[v0]|", views: self.imageView)
            self.addConstraint(with: "V:|[v0]|", views: self.imageView)
        }
    }
}
