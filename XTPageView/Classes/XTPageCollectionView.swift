//
//  XTCollectionView.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/8.
//

import UIKit

class XTPageCollectionView : UIView {
    fileprivate var titles : [String]
    fileprivate var layout : UICollectionViewFlowLayout
    
    init(frame: CGRect, titles: [String], isTitleInTop: Bool, layout: UICollectionViewFlowLayout) {
        self.layout = layout
        self.titles = titles
        super.init(frame: frame)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
