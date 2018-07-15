//
//  PageCell.swift
//  AudibleApp
//
//  Created by Falguni Viral Chauhan on 18/05/18.
//  Copyright © 2018 Falguni Viral Chauhan. All rights reserved.
//

import UIKit

class PageCell: UICollectionViewCell {
    
    //MARK: Instance variables
    let pageImageView: UIImageView = {
       let iv = UIImageView()
        iv.contentMode = .scaleAspectFill
        iv.clipsToBounds = true
        iv.backgroundColor = .clear
        iv.image = #imageLiteral(resourceName: "page1")
        return iv
    }()
    
    let pageTextView: UITextView = {
        let tv = UITextView()
        tv.text = "Sample textview"
        tv.isEditable = false
        tv.contentInset = UIEdgeInsets(top: 24, left: 0, bottom: 0, right: 0)
        return tv
    }()
    
    let seperatorView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.9, alpha: 1)
        return view
    }()
    
    var page: Page? {
        didSet {
            guard let page = page else {
                return
            }
            if UIDevice.current.orientation.isLandscape {
                pageImageView.contentMode = .scaleAspectFit
            } else {
                pageImageView.contentMode = .scaleAspectFill
            }
            pageImageView.image = UIImage(named: page.imageName)
            
            let foregroundColor = UIColor(white: 0.2, alpha: 1)
            let attributedText = NSMutableAttributedString(string: page.title, attributes: [NSAttributedStringKey.font:UIFont.systemFont(ofSize: 18, weight: UIFont.Weight.medium), NSAttributedStringKey.foregroundColor:foregroundColor])
            
            attributedText.append(NSAttributedString(string: "\n\n"+page.message, attributes: [NSAttributedStringKey.font: UIFont.systemFont(ofSize: 14), NSAttributedStringKey.foregroundColor:foregroundColor]))
            
            let paragraphStyle = NSMutableParagraphStyle()
            paragraphStyle.alignment = .center
            
            let length = attributedText.string.count
            attributedText.addAttribute(NSAttributedStringKey.paragraphStyle, value: paragraphStyle, range: NSRange.init(location: 0, length: length) )
            
            pageTextView.attributedText = attributedText
        }
    }
    
    //MARK: Init
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupViews()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    //MARK: Private methods
    private func setupViews() {
        _ = [pageImageView, pageTextView, seperatorView].map { addSubview($0) }
        
        //Set image view contrains
        pageImageView.anchorToTop(topAnchor, left: safeAreaLayoutGuide.leftAnchor, bottom: pageTextView.topAnchor, right: safeAreaLayoutGuide.rightAnchor)
        
        //Set textView contrains
        pageTextView.anchorWithConstantsToTop(nil, left: safeAreaLayoutGuide.leftAnchor, bottom: safeAreaLayoutGuide.bottomAnchor, right: safeAreaLayoutGuide.rightAnchor, topConstant: 0, leftConstant: 16, bottomConstant: 0, rightConstant: 16)
        pageTextView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor, multiplier: 0.3).isActive = true
        
        //Set seperator line contrains
        seperatorView.anchorToTop(nil, left: safeAreaLayoutGuide.leftAnchor, bottom: pageTextView.topAnchor, right: safeAreaLayoutGuide.rightAnchor)
        seperatorView.heightAnchor.constraint(equalToConstant: 1).isActive = true
    }
}
