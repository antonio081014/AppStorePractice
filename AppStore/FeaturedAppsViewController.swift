//
//  ViewController.swift
//  AppStore
//
//  Created by Antonio081014 on 8/14/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

class FeaturedAppsViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let cellID = "cellID"
    private let largeCellID = "largeCellID"
    private let headerID = "headerID"
    
    var appCategories: [AppCategory]? {
        didSet {
            self.collectionView?.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = "App Store"
        AppCategory.fetchFeaturedApps { self.appCategories = $0 }
        
        self.collectionView?.backgroundColor = .white
        self.collectionView?.register(CategoryCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView?.register(LargeCategoryCell.self, forCellWithReuseIdentifier: largeCellID)
        self.collectionView?.register(Header.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return self.appCategories?.count ?? 0
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if indexPath.item == 2 {
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeCellID, for: indexPath) as! LargeCategoryCell
            cell.appCategory = self.appCategories?[indexPath.item]
            return cell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! CategoryCell
        cell.appCategory = self.appCategories?[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        if indexPath.item == 2 {
            return CGSize(width: self.view.bounds.width, height: 160)
        }
        return CGSize(width: self.view.bounds.width, height: 230)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let header = collectionView.dequeueReusableSupplementaryView(ofKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID, for: indexPath) as! Header
        header.appCategory = self.appCategories?.first
        return header
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 150)
    }
}

class Header: CategoryCell {
    private let bannerCellID = "bannerCellID"
    
    override func setupViews() {
        
        self.addSubview(self.appsCollectionView)
        self.appsCollectionView.register(BannerCell.self, forCellWithReuseIdentifier: bannerCellID)
        self.appsCollectionView.delegate = self
        self.appsCollectionView.dataSource = self
        
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.appsCollectionView]))
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.appsCollectionView]))
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return .zero
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: bannerCellID, for: indexPath) as! BannerCell
        cell.app = self.appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.bounds.height - 32)
    }
    
    fileprivate class BannerCell: AppCell {
        override func setupViews() {
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.imageView)
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.imageView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.imageView]))
        }
    }
}

class LargeCategoryCell: CategoryCell {
    
    private let largeAppCellID = "largeAppCellID"
    
    override func setupViews() {
        super.setupViews()
        self.appsCollectionView.register(LargeAppCell.self, forCellWithReuseIdentifier: largeAppCellID)
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: largeAppCellID, for: indexPath) as! LargeAppCell
        cell.app = self.appCategory?.apps?[indexPath.item]
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: 200, height: self.bounds.height - 32)
    }
    
    fileprivate class LargeAppCell: AppCell {
        override func setupViews() {
            self.imageView.translatesAutoresizingMaskIntoConstraints = false
            self.addSubview(self.imageView)
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:|[v0]|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.imageView]))
            self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:|-2-[v0]-4-|", options: NSLayoutFormatOptions(), metrics: nil, views: ["v0":self.imageView]))
        }
    }
}
