//
//  View4HorizontalMenu.swift
//  iTVCloud
//
//  Created by 丁偉哲 on 2017/6/2.
//  Copyright © 2017年 丁偉哲. All rights reserved.
//

import UIKit
protocol  View4HorizontalMenuDelegate : class {
    func sendDidSelectMuneTag(buttonTag:Int)
}
class View4HorizontalMenu: UIView {
    weak var delegate:View4HorizontalMenuDelegate?
    
    fileprivate var menuTitles = [String]()
    fileprivate var selectMenuBackgroundColor:UIColor!
    fileprivate var deselectMenuBackgroundColor:UIColor!
    fileprivate var selectMenuTitleColor:UIColor!
    fileprivate var deselectMenuTitleColor:UIColor!
    fileprivate var showBottomLine:Bool!
    fileprivate var bottomLineColor:UIColor!
    fileprivate var bottomLineHeight:CGFloat!
    fileprivate var buttons = [UIButton]()//用來儲存所有的按鈕
    
    fileprivate var bottomLine:UIView!
    
    init(frame: CGRect, menuTitles:[String], selectMenuBackgroundColor:UIColor , deselectMenuBackgroundColor:UIColor,selectMenuTitleColor:UIColor, deselectMenuTitleColor:UIColor, showBottomLine:Bool, bottomLineColor:UIColor, bottomLineHeight:CGFloat) {
        super.init(frame: frame)
        self.menuTitles = menuTitles
        self.selectMenuBackgroundColor = selectMenuBackgroundColor
        self.deselectMenuBackgroundColor = deselectMenuBackgroundColor
        self.selectMenuTitleColor = selectMenuTitleColor
        self.deselectMenuTitleColor = deselectMenuTitleColor
        self.showBottomLine = showBottomLine
        self.bottomLineColor = bottomLineColor
        self.bottomLineHeight = bottomLineHeight
        creatMenuButton()
        if showBottomLine {
            creatBottomLine()
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    //public method
    /// 裝置旋轉時重新設定按鈕寬度的方法
    ///
    /// - Parameter viewFrame: 要傳入旋轉後你的superView
    public func resetButtonsWidthWhenViewWillTransition(viewFrame:CGRect){
        let menuWidth = viewFrame.width / CGFloat(buttons.count)
        for (index, button) in buttons.enumerated() {
            button.frame = CGRect(x: menuWidth * CGFloat(index), y: 0, width: menuWidth, height: viewFrame.height)
        }
    }
    public func setDefaultSelectButton(defaultButtonIs:Int? = nil){
        if let defaultButtonIs = defaultButtonIs {
            if defaultButtonIs > buttons.count {
                print("Error default button index out of buttons range.")
                return
            }
            for button in buttons {
                button.setTitleColor(deselectMenuTitleColor, for: .normal)
                button.backgroundColor = deselectMenuBackgroundColor
            }
            let defaultButton = buttons[defaultButtonIs]
            defaultButton.setTitleColor(selectMenuTitleColor, for: .normal)
            defaultButton.backgroundColor = selectMenuBackgroundColor
        }else{
            for button in buttons {
                button.setTitleColor(deselectMenuTitleColor, for: .normal)
                button.backgroundColor = deselectMenuBackgroundColor
            }
        }
       
    }
    
    
    //private method
    private func creatMenuButton(){
        let menuWidth = self.bounds.width / CGFloat(menuTitles.count)
        
        for (index , value) in menuTitles.enumerated() {
            let button = UIButton(frame: CGRect(x: menuWidth * CGFloat(index), y: 0, width: menuWidth, height: self.bounds.height))
            button.tag = index//用來判斷點的是哪個按鈕
            button.backgroundColor = deselectMenuBackgroundColor
            button.setTitle(value, for: .normal)
            button.setTitleColor(deselectMenuTitleColor, for: .normal)
            button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
            self.addSubview(button)
            buttons.append(button)
        }
    }
    
    @objc private func buttonAction(sender:UIButton){
        print("sender=\(sender.tag)")
        setDefaultSelectButton()
        sender.setTitleColor(selectMenuTitleColor, for: .normal)
        sender.backgroundColor = selectMenuBackgroundColor
        delegate?.sendDidSelectMuneTag(buttonTag: sender.tag)
        UIView.animate(withDuration: 0.3) { 
            self.bottomLine.frame.origin.x = sender.bounds.width * CGFloat(sender.tag)
            self.layoutIfNeeded()
        }
        
    }
    
    private func creatBottomLine(){
        let menuWidth = self.bounds.width / CGFloat(menuTitles.count)
        bottomLine = UIView(frame: CGRect(x: 0, y: self.bounds.height - bottomLineHeight, width: menuWidth, height: bottomLineHeight))
        bottomLine.backgroundColor = bottomLineColor
        self.addSubview(bottomLine)

    }
    
}
