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
    private let cellID = "cellID"
    private let cellID2 = "cellID2"
    
    var app: App? {
        didSet {
            if app?.screenshots != nil { return }
            if let ID = app?.id {
                let urlString = "http://www.statsallday.com/appstore/appdetail?id=\(ID)"
                URLSession.shared.dataTask(with: URL(string: urlString)!, completionHandler: { (data, response, error) in
                    if error != nil {
                        print(error!)
                        return
                    }
                    
                    if let json = try? JSONSerialization.jsonObject(with: data!, options: JSONSerialization.ReadingOptions.mutableContainers) as? [String:Any] {
                        
                        let detailApp = App()
                        detailApp.id = json?["Id"] as? Int
                        detailApp.name = json?["Name"] as? String
                        detailApp.category = json?["Category"] as? String
                        detailApp.price = json?["Price"] as? Double
                        detailApp.imageName = json?["ImageName"] as? String
                        detailApp.screenshots = json?["Screenshots"] as? [String]
                        detailApp.desc = json?["description"] as? String
                        detailApp.appInformation = json?["appInformation"] as? [[String : String]]
                        
                        self.app = detailApp
                        DispatchQueue.main.async {
                            self.collectionView?.reloadData()
                        }
                    }
                }).resume()
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.collectionView?.delegate = self
        self.collectionView?.dataSource = self
        self.collectionView?.backgroundColor = .white
        self.collectionView?.alwaysBounceVertical = true
        self.collectionView?.register(AppDetailHeader.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: headerID)
        self.collectionView?.register(ScreenshotsCell.self, forCellWithReuseIdentifier: cellID)
        self.collectionView?.register(AppDetailDescriptionCell.self, forCellWithReuseIdentifier: cellID2)
    }
    
    override func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let headerView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: headerID, for: indexPath) as! AppDetailHeader
        headerView.app = self.app
        return headerView
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
        return CGSize(width: self.view.bounds.width, height: 170)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 2
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        switch indexPath.item {
        case 0:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID, for: indexPath) as! ScreenshotsCell
            cell.app = self.app
            return cell
        case 1:
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellID2, for: indexPath) as! AppDetailDescriptionCell
            cell.app = self.app
            return cell
        default:
            return UICollectionViewCell()
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if indexPath.item == 1 {
            if let text = self.app?.desc {
                let rect = NSString(string: text).boundingRect(with: CGSize(width: self.view.bounds.width - 16, height: 1000), options: [.usesFontLeading, .usesLineFragmentOrigin], attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14)], context: nil)
                return CGSize(width: self.view.bounds.width, height: rect.height + 16 + 44) // height of textView + margin + nameLabel
            }
        }
        return CGSize(width: self.view.bounds.width, height: 170)
    }
}
