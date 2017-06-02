//
//  TestVC.swift
//  iTVCloud
//
//  Created by 丁偉哲 on 2017/6/2.
//  Copyright © 2017年 丁偉哲. All rights reserved.
//

import UIKit
extension TestVC : View4HorizontalMenuDelegate {
    func sendDidSelectMuneTag(buttonTag: Int) {
        print("TestVC get button Index = \(buttonTag)")
    }
}
class TestVC: UIViewController {
    @IBOutlet weak var view4HorizontalMenu: UIView!
    lazy fileprivate var horizontalMenu:View4HorizontalMenu! = { [weak self] in
        guard let view4HorizontalMenu = self?.view4HorizontalMenu else { return nil }
        let view = View4HorizontalMenu(frame: view4HorizontalMenu.bounds, menuTitles: ["測試1","測試2","測試3","測試4","測試5"], selectMenuBackgroundColor: .red, deselectMenuBackgroundColor: .green, selectMenuTitleColor: .white, deselectMenuTitleColor: .black, showBottomLine: true, bottomLineColor: .yellow, bottomLineHeight: 5)
        return view
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
                // Do any additional setup after loading the view.
    }

    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        

    }
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setHorizontalMenu()
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
        super.viewWillTransition(to: size, with: coordinator)
        coordinator.animate(alongsideTransition: { [weak self] (context) in
            guard let view4HorizontalMenu = self?.view4HorizontalMenu else { return }
            self?.horizontalMenu?.resetButtonsWidthWhenViewWillTransition(viewFrame: view4HorizontalMenu.bounds)
            }, completion: nil)
    }

    private func setHorizontalMenu(){
        view4HorizontalMenu.addSubview(horizontalMenu)
        horizontalMenu.delegate = self
        horizontalMenu.setDefaultSelectButton(defaultButtonIs: 0)
    }

}
