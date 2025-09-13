//
//  XTPageView.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/4.
//

import Foundation

import UIKit


class XTPageView : UIView {
    private var titles : [String]
    private var childVC : [UIViewController]
    private var parentVC : UIViewController
    
    // MARK: UI
    private var contentView : XTContentView
    private var titleView : XTTitleView
    private var currentIndex : Int = 0
    
    init(frame: CGRect, titles: [String], childVC: [UIViewController], parentVC: UIViewController) {
        self.titles = titles
        self.childVC = childVC
        self.parentVC = parentVC
        var titleViewFrame = frame
        titleViewFrame.size.height = 64
        var contentViewFrame = frame
        contentViewFrame.origin.y = 64
        contentViewFrame.size.height -= 64
        self.contentView = XTContentView(frame: contentViewFrame, childVC: childVC, parentVC: parentVC)
        self.titleView = XTTitleView(frame: titleViewFrame, titles: titles, style: XTTitleStyle())
        self.titleView.delegate = self.contentView
        self.contentView.delegate = self.titleView
        super.init(frame: frame)
        addSubview(self.titleView)
        addSubview(self.contentView)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        var titleViewFrame = bounds
        titleViewFrame.size.height = 44
        titleView.frame = titleViewFrame
        var contentViewFrame = bounds
        contentViewFrame.origin.y = 44
        contentViewFrame.size.height -= 44
        contentView.frame = contentViewFrame
    }
    
    // 反正不能从Xib里面加载
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
