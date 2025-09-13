//
//  XTHoverPageViewController.swift
//  HYVideoApp
//
//  Created by tian xia on 2025/9/10.
//

import UIKit

class XTHoverPageScrollView : UIScrollView, UIGestureRecognizerDelegate {
    override func touchesShouldCancel(in view: UIView) -> Bool {
        return true
    }
    func gestureRecognizer(_ gestureRecognizer: UIGestureRecognizer, shouldRecognizeSimultaneouslyWith otherGestureRecognizer: UIGestureRecognizer) -> Bool {
        return true
    }
}

@objc public class XTHoverPageViewController : UIViewController {
    fileprivate lazy var mainScrollView : XTHoverPageScrollView = {
        var mainScrollView = XTHoverPageScrollView()
        mainScrollView.bounces = false
        mainScrollView.addSubview(headerView)
        mainScrollView.addSubview(pageView)
        mainScrollView.delegate = self
        mainScrollView.showsVerticalScrollIndicator = false
        NSLog("mainScrollView")
        return mainScrollView
    } ()
    fileprivate var childViewControlls : [XTAnchorViewController]
    fileprivate var headerView : UIView
    fileprivate var headerViewHeight : CGFloat
    fileprivate var titles : [String]
    fileprivate lazy var pageView : XTPageView = XTPageView(frame: view.bounds,
                                                            titles: titles,
                                                            childVC: childViewControlls,
                                                            parentVC: self)
    @objc public init(childViewControlls: [XTAnchorViewController],
         headerView: UIView,
         headerViewHeight: CGFloat,
         titles: [String]) {
        self.headerView = headerView
        self.headerViewHeight = headerViewHeight
        self.childViewControlls = childViewControlls
        self.titles = titles
        super.init(nibName: nil, bundle: nil)
        for childViewControll in childViewControlls {
            childViewControll.delegate = self
        }
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public override func viewDidLoad() {
        super.viewDidLoad()
        setupUI()
    }
    
    public override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        setupUI()
    }
}

extension XTHoverPageViewController : XTAnchorViewControllerDelegate {
    public func anchorViewControllerDidScroll(anchorViewController : XTAnchorViewController) {
        if mainScrollView.contentOffset.y > 0 && mainScrollView.contentOffset.y < headerView.frame.height {
            anchorViewController.offsetY = 0
        }
    }
}

extension XTHoverPageViewController : UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        if (scrollView == mainScrollView) {
            var offsetY : CGFloat = 0
            for childViewControll in childViewControlls {
                offsetY = max(offsetY, childViewControll.offsetY)
            }
            NSLog("offsetY = %f", offsetY)
            if offsetY > 0 {
                mainScrollView.contentOffset.y = headerView.frame.height
            } else {
                for childViewControll in childViewControlls {
                    childViewControll.offsetY = 0
                }
            }
        }
    }
}

extension XTHoverPageViewController {
    public func setupUI() {
        view.addSubview(mainScrollView)
        let mainScrollViewH : CGFloat = view.bounds.height
        let mainScrollViewW : CGFloat = view.bounds.width
        let mainScrollViewX : CGFloat = 0
        let mainScrollViewY : CGFloat = 0
        mainScrollView.frame = CGRect(x: mainScrollViewX,
                                      y: mainScrollViewY,
                                      width: mainScrollViewW,
                                      height: mainScrollViewH)
        let headerViewH : CGFloat = headerViewHeight
        let headerViewW : CGFloat = view.bounds.width
        let headerViewX : CGFloat = 0
        let headerViewY : CGFloat = 0
        headerView.frame = CGRect(x: headerViewX, y: headerViewY, width: headerViewW, height: headerViewH)
        let pageViewH : CGFloat = mainScrollView.frame.height
        let pageViewW : CGFloat = view.bounds.width
        let pageViewX : CGFloat = 0
        let pageViewY : CGFloat = headerView.frame.maxY
        pageView.frame = CGRect(x: pageViewX, y: pageViewY, width: pageViewW, height: pageViewH)
        let mainScrollViewContentSizeH : CGFloat = view.bounds.height + headerViewH
        let mainScrollViewContentSizeW : CGFloat = view.bounds.width
        mainScrollView.contentSize = CGSize(width: mainScrollViewContentSizeW, height: mainScrollViewContentSizeH)
        if #available(iOS 11.0, *) {
            mainScrollView.contentInsetAdjustmentBehavior = .never
        } else {
            automaticallyAdjustsScrollViewInsets = false
        }
    }
}
