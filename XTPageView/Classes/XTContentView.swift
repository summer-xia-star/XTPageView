//
//  XTContentView.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/4.
//

import Foundation

import UIKit

// MARK: XTContentTitle
protocol XTContentViewDelegate : NSObjectProtocol {
    func contentViewStartScroll(_: XTContentView)
    func contentView(_: XTContentView, scrollToIndex: Int)
    func contentView(_: XTContentView, scrollToIndex: Int, progress: CGFloat)
}

protocol XTContentViewScrollDelegate : NSObjectProtocol {
    func contentViewDidScroll(_: UIScrollView)
}

class XTContentView : UIView {
    weak var delegate : XTContentViewDelegate?
    weak var scrollDelegate : XTContentViewScrollDelegate?
    private var childVC : [UIViewController]
    private var parentVC : UIViewController
    private lazy var collectionView : UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = UICollectionView.ScrollDirection.horizontal
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.itemSize = self.bounds.size
        let collectionView = UICollectionView(frame: self.bounds, collectionViewLayout: layout)
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: "UICollectionViewCell")
        self.addSubview(collectionView)
        collectionView.dataSource = self
        collectionView.delegate = self
        collectionView.isPagingEnabled = true
        return collectionView
    } ()
    // MARK: 滑动控制
    fileprivate var startOffset : CGFloat = 0
    
    init(frame: CGRect, childVC: [UIViewController], parentVC: UIViewController) {
        self.parentVC = parentVC
        self.childVC = childVC
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        self.collectionView.frame = self.bounds
    }
}

extension XTContentView : UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return childVC.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "UICollectionViewCell", for: indexPath)
        for subView in cell.contentView.subviews {
            subView.removeFromSuperview()
        }
        let childVC = self.childVC[indexPath.item]
        childVC.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(childVC.view)
        childVC.view.backgroundColor = UIColor.randomColor()
        cell.backgroundColor = UIColor.randomColor()
        return cell;
    }
}

extension XTContentView : UICollectionViewDelegate {
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        scrollDelegate?.contentViewDidScroll(scrollView)
        if scrollView.contentOffset.x > startOffset {
            NSLog("[XTContentView] ---->")
        } else {
            NSLog("[XTContentView] <----")
        }
    }
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startOffset = scrollView.contentOffset.x
        delegate?.contentViewStartScroll(self)
    }
    func scrollViewDidEndDecelerating(_ scrollView: UIScrollView) {
        contentEndScroll()
    }
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if !decelerate {
            contentEndScroll()
        }
    }
    private func contentEndScroll() {
        let currentIndex = Int(collectionView.contentOffset.x / collectionView.bounds.width)
        delegate?.contentView(self, scrollToIndex: currentIndex)
    }
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        parentVC.navigationController?.pushViewController(UIViewController(), animated: true)
    }
}

extension XTContentView : XTTitleViewDelegate {
    func titleView(_ : XTTitleView, selectAtIndex: Int) {
        
    }
}
