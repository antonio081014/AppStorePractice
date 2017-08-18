//
//  AppDetailCollectionViewController.swift
//  AppStore
//
//  Created by Antonio081014 on 8/17/17.
//  Copyright © 2017 sample.com. All rights reserved.
//

import UIKit

private let reuseIdentifier = "Cell"

class AppDetailCollectionViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {

    private let headerID = "headerID"
    
    var app: App? {
        didSet {
            self.navigationItem.title = app?.name
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.collectionView?.backgroundColor = .white
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppDetailHeader
        headerView.app = self.app
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 170)
    }
}

class AppDetailHeader: BaseCell {
    
    var app: App? {
        didSet {
            if let imageName = app?.imageName {
                self.imageView.image = UIImage(named: imageName)
            }
        }
    }
    
    let imageView: UIImageView = {
        let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.translatesAutoresizingMaskIntoConstraints = false
        iv.layer.cornerRadius = 16
        iv.layer.masksToBounds = true
        return iv
    }()
    
    let segmentedControl: UISegmentedControl = {
        let sc = UISegmentedControl(items: ["Details", "Reviews", "Related"])
        sc.translatesAutoresizingMaskIntoConstraints = false
        return sc
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.imageView)
        self.addSubview(self.segmentedControl)
        
        self.addConstraint(with: "H:|-14-[v0(100)]", views: self.imageView)
        self.addConstraint(with: "V:|-14-[v0(100)]", views: self.imageView)
    }
}

extension UIView {
    func addConstraint(with format: String, views: UIView...) {
        var dictionary = [String : UIView]()
        for (index, view) in views.enumerated() {
            view.translatesAutoresizingMaskIntoConstraints = false
            dictionary["v\(index)"] = view
        }
        self.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: format, options: NSLayoutFormatOptions(), metrics: nil, views: dictionary))
    }
}

class BaseCell: UICollectionViewCell {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupViews() {}
}
