//
//  ScreenshotsCell.swift
//  AppStore
//
//  Created by Antonio081014 on 8/18/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class ScreenshotsCell: BaseCell, UICollectionViewDelegateFlowLayout, UICollectionViewDelegate, UICollectionViewDataSource {
    
    // http://www.statsallday.com/appstore/appdetail?id=1
    private let cellID = "cellID"
    
    let collectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .clear
        return cv
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.collectionView)
        self.collectionView.delegate = self
        self.collectionView.dataSource = self
        self.collectionView.register(ScreenshotImageCell.self, forCellWithReuseIdentifier: cellID)
        
        self.addConstraint(with: "H:|[v0]|", views: self.collectionView)
        self.addConstraint(with: "V:|[v0]|", views: self.collectionView)
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ScreenshotImageCell
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.bounds.height - 28)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 0, left: 14, bottom: 0, right: 14)
    }
    
    private class ScreenshotImageCell: BaseCell {
        let imageView: UIImageView = {
            let iv = UIImageView()
            iv.contentMode = .scaleAspectFill
            iv.backgroundColor = .green
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
