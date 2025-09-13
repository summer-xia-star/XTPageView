//
//  XTXTPageCollectionLayout.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/8.
//

import UIKit

class XTPageCollectionLayout : UICollectionViewFlowLayout {
    var cols : Int = 4
    var rows : Int = 2
    fileprivate var totalWidth : CGFloat = 0
    fileprivate lazy var cellAttrs : [UICollectionViewLayoutAttributes] = [UICollectionViewLayoutAttributes]()
    override func prepare() {
        super.prepare()
        let itemCountInOnePage = cols * rows
        var prePageCount = 0
        for i in 0..<collectionView!.numberOfSections {
            let cellCount = collectionView!.numberOfItems(inSection: i)
            for j in 0..<cellCount {
                let curPageCount = Int(j / itemCountInOnePage)
                let curX = (j % itemCountInOnePage) % cols
                let curY = (j % itemCountInOnePage) / cols
                let attr = UICollectionViewLayoutAttributes(forCellWith: IndexPath(item: j, section: i))
                let width = collectionView!.bounds.width - sectionInset.left - sectionInset.right
                let height = collectionView!.bounds.height - sectionInset.top - sectionInset.bottom
                let cellW : CGFloat = (width - CGFloat(cols - 1) * minimumInteritemSpacing) / CGFloat(cols)
                let cellH : CGFloat = (height - CGFloat(rows - 1) * minimumLineSpacing) / CGFloat(rows)
                let cellX : CGFloat = CGFloat(curPageCount + prePageCount) * collectionView!.bounds.width + sectionInset.left + (cellW + minimumInteritemSpacing) * CGFloat(curX)
                let cellY : CGFloat = sectionInset.top + (cellH + minimumLineSpacing) * CGFloat(curY)
                attr.frame = CGRect(x: cellX, y: cellY, width: cellW, height: cellH)
                NSLog("[XTPageCollectionLayout] i:%d j:%d X:%f Y:%f", i, j, cellX, cellY)
                cellAttrs.append(attr)
            }
            prePageCount += Int(cellCount / itemCountInOnePage)
            if cellCount % itemCountInOnePage > 0 {
                prePageCount += 1
            }
        }
        totalWidth = collectionView!.bounds.width * CGFloat(prePageCount)
    }
    
    override func layoutAttributesForElements(in rect: CGRect) -> [UICollectionViewLayoutAttributes]? {
        return cellAttrs
    }
    
    override var collectionViewContentSize: CGSize {
        return CGSize(width: totalWidth, height: 0)
    }
}
