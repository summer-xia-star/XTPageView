//
//  XTAnchorViewController.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/6.
//

import UIKit

@objc protocol XTAnchorViewControllerDelegate : NSObjectProtocol {
    func anchorViewControllerDidScroll(anchorViewController : XTAnchorViewController)
}

@objc public class XTAnchorViewController: UIViewController {
    weak var delegate : XTAnchorViewControllerDelegate?
    weak var naviVC : UINavigationController?
    var offsetY : CGFloat {
        get {
            return collectionView.contentOffset.y
        }
        set {
            collectionView.contentOffset.y = newValue
        }
    }
    fileprivate lazy var collectionView : UICollectionView = {
        let layout = XTWaterfallFlowLayout()
        let collectionView = UICollectionView(frame: CGRectZero, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionView")
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.backgroundColor = UIColor.white
        return collectionView
    } ()
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(collectionView)
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        collectionView.frame = view.bounds
    }
}

extension XTAnchorViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        delegate?.anchorViewControllerDidScroll(anchorViewController: self)
    }
}

extension XTAnchorViewController : UICollectionViewDataSource {
    public func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionView", for: indexPath)
        cell.backgroundColor = UIColor.randomColor()
        return cell
    }
    
    public func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 30
    }
}

extension XTAnchorViewController : UICollectionViewDelegate {
    public func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        naviVC?.pushViewController(UIViewController(), animated: true)
    }
}
