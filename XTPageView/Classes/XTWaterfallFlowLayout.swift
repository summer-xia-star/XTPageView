//
//  XTWaterfallFlowLayout.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/6.
//

import UIKit

class XTWaterfallFlowLayout: UICollectionViewFlowLayout {
    fileprivate lazy var cellAttrs = [UICollectionViewLayoutAttributes]()
    fileprivate lazy var totalHeights = Array(repeating: sectionInset.top, count: 3)
}

// MARK: 准备布局
extension XTWaterfallFlowLayout {
    override func prepare() {
        super.prepare()
        guard let itemCount = collectionView?.numberOfItems(inSection: 0) else {
            return
        }
        for i in 0..<itemCount {
            // 创建indexPath
            let indexPath = IndexPath(item: i, section: 0)
            // 创建Attributes
            let attr = UICollectionViewLayoutAttributes(forCellWith: indexPath)
            // 设置Attributes的Frame
            let cellH : CGFloat = CGFloat(Float.random(in: 100..<200))
            let cellW : CGFloat = (collectionView!.bounds.width - 2 * minimumInteritemSpacing - sectionInset.left - sectionInset.right) / 3
            var minH = totalHeights[0]
            var minIndex = 0
            for (i, curH) in totalHeights.enumerated() {
                if curH < minH {
                    minH = curH
                    minIndex = i
                }
            }
            let cellX : CGFloat = sectionInset.left + CGFloat(minIndex) * (cellW + minimumInteritemSpacing)
            let cellY : CGFloat = minH + minimumInteritemSpacing
            totalHeights[minIndex] += (minimumInteritemSpacing + cellH)
            attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
            // 保存attr
            cellAttrs.append(attr)
        }
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: collectionView!.bounds.width, height: totalHeights.max()!)
    }
    
}
