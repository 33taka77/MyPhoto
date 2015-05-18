//
//  MainCollectionHeaderReusableView.swift
//  MyPhoto
//
//  Created by AizawaTakashi on 2015/05/17.
//  Copyright (c) 2015年 AizawaTakashi. All rights reserved.
//

import UIKit

class MainCollectionHeaderReusableView: UICollectionReusableView {

    required init(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.backgroundColor = UIColor.greenColor()
    }
    override init(frame: CGRect) {
        super.init(frame: frame)
        self.backgroundColor = UIColor.greenColor()
    }
}
