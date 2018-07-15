//
//  PageViewController.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 18/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class PageViewController: UIViewController, LoginViewDelegate {

    //MARK: Instance variables
    let cellId = "cellId"
    let loginCellId = "loginCellId"
    
    let pages = Page.pages()
    
    let orangeColor = UIColor(named: "LightOrange")
    
    var pageControlBottomAnchor: NSLayoutConstraint?
    var skipBtnTopAnchor: NSLayoutConstraint?
    var nextBtnTopAnchor: NSLayoutConstraint?
    
    lazy var pageCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let cv = UICollectionView(frame: .zero, collectionViewLayout: layout)
        cv.backgroundColor = .white
        cv.delegate = self
        cv.dataSource = self
        cv.isPagingEnabled = true
        return cv
    }()
    
    lazy var pageController: UIPageControl = {
        let pc =  UIPageControl()
        pc.pageIndicatorTintColor = .lightGray
        pc.currentPageIndicatorTintColor = self.orangeColor
        pc.numberOfPages = self.pages.count+1
        return pc
    }()
    
    lazy var skipButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Skip", for: .normal)
        btn.setTitleColor(self.orangeColor, for: .normal)
        btn.addTarget(self, action: #selector(skipButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    lazy var nextButton: UIButton = {
        let btn = UIButton(type: .system)
        btn.setTitle("Next", for: .normal)
        btn.setTitleColor(self.orangeColor, for: .normal)
        btn.addTarget(self, action: #selector(nextButtonClicked), for: .touchUpInside)
        return btn
    }()
    
    //MARK: Life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        
        registerCells()
        registerObserver()
        addViewToParentView()
        setupViewContrains()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        unRegisterObserver()
    }
    
    
    //MARK: Private
    fileprivate func registerCells() {
        pageCollectionView.register(PageCell.self, forCellWithReuseIdentifier: cellId)
        pageCollectionView.register(LoginCell.self, forCellWithReuseIdentifier: loginCellId)
    }
    
    fileprivate func addViewToParentView() {
        [pageCollectionView, pageController, skipButton, nextButton].forEach({view.addSubview($0)})
    }
    
    fileprivate func setupViewContrains() {
        //Collectionview Anchor
        pageCollectionView.anchorToTop(view.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor)
        
        //Page Controll
        pageControlBottomAnchor = pageController.anchor(nil, left: view.safeAreaLayoutGuide.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 0, heightConstant: 36)[1]
        
        //Button
        skipBtnTopAnchor = skipButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: view.safeAreaLayoutGuide.leftAnchor, bottom: nil, right: nil, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 30).first
        
        nextBtnTopAnchor = nextButton.anchor(view.safeAreaLayoutGuide.topAnchor, left: nil, bottom: nil, right: view.safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 0, bottomConstant: 0, rightConstant: 0, widthConstant: 50, heightConstant: 30).first
    }

    fileprivate func unRegisterObserver() {
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        NotificationCenter.default.removeObserver(self, name: NSNotification.Name.UIKeyboardDidHide, object: nil)
    }
    
    fileprivate func registerObserver() {
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardShow), name: NSNotification.Name.UIKeyboardWillShow , object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardHide), name: NSNotification.Name.UIKeyboardWillHide , object: nil)
    }
    
    @objc func keyboardShow () {
        UIView.animate(withDuration: 0.37, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            let y: CGFloat = UIDevice.current.orientation.isLandscape ? -100 : -50
            self.view.frame = CGRect(x: 0, y: y, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func keyboardHide() {
        UIView.animate(withDuration: 0.37, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.frame = CGRect(x: 0, y: 0, width: self.view.frame.width, height: self.view.frame.height)
        }, completion: nil)
    }
    
    @objc func nextButtonClicked() {
        if pageController.currentPage == pages.count {
            return
        }
        if pageController.currentPage == pages.count-1 {
            //Last page come for appear
            moveCompoentOutOfScreen()
            UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
                self.view.layoutIfNeeded()
            }, completion: nil)
        }
        let indexPath = IndexPath(item: pageController.currentPage+1, section: 0)
        pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        pageController.currentPage += 1
    }
    
    @objc func skipButtonClicked () {
        pageController.currentPage = pages.count - 1
        nextButtonClicked()
    }
    
    func finishLoggedIn() {
        
        let rootVC = UIApplication.shared.keyWindow?.rootViewController
        guard let mainNavigationController = rootVC as? MainNavigationController else {
            return
        }
        mainNavigationController.viewControllers = [HomeViewController()]
        
        UserDefaults.standard.setIsLoggedIn(value: true)
        
        dismiss(animated: true, completion: nil)
    }
}


extension PageViewController : UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return pages.count+1
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        //Login cell
        if indexPath.item == pages.count {
            let loginCell = collectionView.dequeueReusableCell(withReuseIdentifier: loginCellId, for: indexPath) as! LoginCell
            loginCell.delegate = self
            return loginCell
        }
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! PageCell
        cell.page = pages[indexPath.item]
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        return CGSize(width: view.frame.width, height: view.frame.height)
    }
    
    override func willTransition(to newCollection: UITraitCollection, with coordinator: UIViewControllerTransitionCoordinator) {
        pageCollectionView.collectionViewLayout.invalidateLayout()
        
        let indexPath = IndexPath(item: pageController.currentPage, section: 0)
        DispatchQueue.main.async {
            self.pageCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
            self.pageCollectionView.reloadData()
        }
        
    }
    
    func scrollViewWillEndDragging(_ scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        let pageNumber = Int(targetContentOffset.pointee.x / view.frame.width)
        pageController.currentPage = pageNumber
        
        //Last page detect
        if pageNumber == pages.count {
            moveCompoentOutOfScreen()
        } else {
            moveComponetInsideOfScreen()
        }
        UIView.animate(withDuration: 0.5, delay: 0, usingSpringWithDamping: 1, initialSpringVelocity: 1, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: nil)
        
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        view.endEditing(true)
    }
    
    fileprivate func moveCompoentOutOfScreen() {
        pageControlBottomAnchor?.constant = 40
        nextBtnTopAnchor?.constant = -45
        skipBtnTopAnchor?.constant = -45
    }
    
    fileprivate func moveComponetInsideOfScreen() {
        pageControlBottomAnchor?.constant = 0
        nextBtnTopAnchor?.constant = 0
        skipBtnTopAnchor?.constant = 0
    }
}
