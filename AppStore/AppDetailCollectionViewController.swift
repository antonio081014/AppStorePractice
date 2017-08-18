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
    
    var app: App? 
    
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
            self.nameLabel.text = app?.name
            if let price = app?.price {
                self.buyButton.setTitle("$\(price)", for: .normal)
            } else {
                self.buyButton.setTitle("GET", for: .normal)
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
        sc.tintColor = .darkGray
        sc.selectedSegmentIndex = 0
        return sc
    }()
    
    let nameLabel: UILabel = {
        let label = UILabel()
        label.text = "Test"
        label.font = UIFont.systemFont(ofSize: 16)
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let buyButton: UIButton = {
        let button = UIButton(type: .system)
        button.setTitle("BUY", for: .normal)
        button.layer.borderColor = UIColor(red: 0, green: 129/255, blue: 250/255, alpha: 1).cgColor
        button.layer.borderWidth = 1
        button.layer.cornerRadius = 5
        button.layer.masksToBounds = true
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 14)
        return button
    }()
    
    let dividerLineView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.4)
        return view
    }()
    
    override func setupViews() {
        super.setupViews()
        
        self.addSubview(self.imageView)
        self.addSubview(self.segmentedControl)
        self.addSubview(self.nameLabel)
        self.addSubview(self.buyButton)
        self.addSubview(self.dividerLineView)
        
        self.addConstraint(with: "H:|-14-[v0(100)]-8-[v1]|", views: self.imageView, self.nameLabel)
        self.addConstraint(with: "V:|-14-[v0(100)]", views: self.imageView)
        
        self.addConstraint(with: "V:|-14-[v0(20)]", views: self.nameLabel)
        
        self.addConstraint(with: "H:|-40-[v0]-40-|", views: self.segmentedControl)
        self.addConstraint(with: "V:[v0(32)]-8-[v1(34)]-8-[v2(0.8)]|", views:self.buyButton, self.segmentedControl, self.dividerLineView)
        
        self.addConstraint(with: "H:[v0(60)]-16-|", views: self.buyButton)
        self.addConstraint(with: "H:|[v0]|", views: self.dividerLineView)
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
