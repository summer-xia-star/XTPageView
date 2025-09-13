//
//  XTTitleView.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/5.
//

import UIKit

protocol XTTitleViewDelegate : NSObjectProtocol {
    func titleView(_ : XTTitleView, selectAtIndex: Int)
}

class XTTitleView : UIView {
    weak var delegate : XTTitleViewDelegate?
    fileprivate var style : XTTitleStyle = XTTitleStyle()
    fileprivate var titles : [String] = []
    fileprivate var titleLabels : [UILabel] = []
    fileprivate var currentIndex : Int = 0
    fileprivate lazy var scrollView : UIScrollView = {
        let scrollView = UIScrollView(frame: self.bounds)
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.scrollsToTop = false
        return scrollView
    } ()
    fileprivate var sourceLabel : UILabel?
    
    init(frame: CGRect, titles: [String], style: XTTitleStyle) {
        self.titles = titles
        self.style = style
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

// MARK: UI
extension XTTitleView {
    override func layoutSubviews() {
        super.layoutSubviews()
        self.scrollView.frame = bounds
        setupLabelsFrame()
    }
    
    fileprivate func setupUI() {
        addSubview(scrollView)
        scrollView.backgroundColor = style.backGroundColor
        setupLabels()
        setupLabelsFrame()
        setupSelectedLabel()
    }
    
    private func setupSelectedLabel() {
        sourceLabel = titleLabels[currentIndex]
        sourceLabel?.textColor = style.selectedColor
    }
    
    private func setupLabels() {
        for (index, title) in titles.enumerated() {
            let titleLabel = UILabel()
            titleLabel.text = title
            titleLabel.textColor = style.normolColor
            titleLabel.textAlignment = .center
            titleLabel.font = .systemFont(ofSize: 15)
            titleLabel.tag = index
            titleLabels.append(titleLabel)
            scrollView.addSubview(titleLabel)
            let tapGes = UITapGestureRecognizer(target: self, action: #selector(onClickLabel))
            titleLabel .addGestureRecognizer(tapGes)
            titleLabel.isUserInteractionEnabled = true
        }
    }
    
    private func setupLabelsFrame() {
        var countWidth : CGFloat = 0
        for (i, label) in self.titleLabels.enumerated() {
            var w : CGFloat = 0
            let h = bounds.height
            var x : CGFloat = 0
            let y : CGFloat = 0
            w = (titles[i] as NSString).boundingRect(with: CGSize(width: CGFloat(MAXFLOAT), height: 0),
                                                     options: .usesLineFragmentOrigin,
                                                     attributes: [NSAttributedString.Key.font: label.font!],
                                                     context: nil).width
            x = countWidth + style.itemMargin
            countWidth += (style.itemMargin + w)
            label.frame = CGRect(x: x, y: y, width: w, height: h)
        }
        scrollView.contentSize = CGSize(width: countWidth + style.itemMargin, height: bounds.height)
    }
}

// MARK: 点击事件
extension XTTitleView {
    @objc fileprivate func onClickLabel(_ tapGes: UITapGestureRecognizer) {
        guard let clickedLabel = tapGes.view as? UILabel else {
            return
        }
        if (clickedLabel == titleLabels[currentIndex]) {
            return
        }
        clickedLabel.textColor = style.selectedColor
        titleLabels[currentIndex].textColor = style.normolColor
        switchToIndex(index: clickedLabel.tag, targetLabel: clickedLabel)
        delegate?.titleView(self, selectAtIndex: clickedLabel.tag)
    }
    
    private func switchToIndex(index: Int, targetLabel: UILabel) {
        if index >= titleLabels.count {
            return
        }
        NSLog("__切换到第%d个Title__", index)
        currentIndex = index
        sourceLabel?.textColor = UIColor.black
        targetLabel.textColor = UIColor.orange
        var offsetX = targetLabel.center.x - scrollView.bounds.width / 2
        if offsetX < 0 {
            offsetX = 0
        }
        if offsetX > scrollView.contentSize.width - scrollView.bounds.width {
            offsetX = scrollView.contentSize.width - scrollView.bounds.width
        }
        scrollView.contentOffset = CGPoint(x: offsetX, y: 0)
    }
}

// MARK: XTContentViewDelegate
extension XTTitleView : XTContentViewDelegate {
    func contentViewStartScroll(_: XTContentView) {
        sourceLabel = titleLabels[currentIndex]
    }
    func contentView(_: XTContentView, scrollToIndex: Int) {
        switchToIndex(index: scrollToIndex, targetLabel: titleLabels[scrollToIndex])
    }
    func contentView(_: XTContentView, scrollToIndex: Int, progress: CGFloat) {
        
    }
}
