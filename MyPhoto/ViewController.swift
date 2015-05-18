//
//  ViewController.swift
//  MyPhoto
//
//  Created by AizawaTakashi on 2015/05/16.
//  Copyright (c) 2015年 AizawaTakashi. All rights reserved.
//

import UIKit

class ViewController: UIViewController,CHTCollectionViewDelegateWaterfallLayout,UICollectionViewDataSource,UIScrollViewDelegate {

    private let sectionHeaderIdentifire = "MainCollectionViewHeader"
    private let elementKindSectionHeader = "CHTCollectionElementKindSectionHeader"
    private var collectionLayout:CHTCollectionViewWaterfallLayout!
    private var cellSizes:[[CGSize]] = [[]]
    private var imageManager:ImageManager!
    @IBOutlet weak var collectionView: UICollectionView!
    @IBOutlet weak var sectionHeader: MainCollectionHeaderReusableView!
    var columnCount:Int {
        get{
            return collectionLayout.columnCount
        }
        set(value){
            collectionLayout.columnCount = value
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        imageManager = AssetManager.sharedInstance
        self.collectionView.registerClass( MainCollectionHeaderReusableView.classForCoder(), forSupplementaryViewOfKind: elementKindSectionHeader, withReuseIdentifier: sectionHeaderIdentifire)
        self.collectionView.setTranslatesAutoresizingMaskIntoConstraints(true)
        self.collectionView.frame = CGRectMake(0, 0, self.view.bounds.width-10, self.view.bounds.height)
        imageManager.setupData()
        setupSize()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func numberOfSectionsInCollectionView(collectionView: UICollectionView) -> Int {
        let sections = imageManager.getSectionCount()
        return sections
    }
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        let count = imageManager.getImageCount(section)
        return count
    }
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell:MAINCollectionViewCell = collectionView.dequeueReusableCellWithReuseIdentifier("MainCollectionViewCell", forIndexPath: indexPath) as! MAINCollectionViewCell
        let obj:ImageObject = imageManager.getImageObjectIndexAt(indexPath)!
        //let size = obj.getSize()
        //let newSize = CGSizeMake(size.width/10, size.height/10)
        //obj.getImageWithSize(newSize)
        obj.getThumbnail { (imageData) -> Void in
            cell.imageView.image = imageData
        }
        return cell
    }
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        collectionLayout = collectionViewLayout as! CHTCollectionViewWaterfallLayout
        collectionLayout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
        collectionLayout.headerHeight = 15;
        collectionLayout.minimumColumnSpacing = 5;
        collectionLayout.minimumInteritemSpacing = 5;

        let array = cellSizes[indexPath.section] as [CGSize]
        let size = array[indexPath.row]
        return size
    }
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        var reusableView:UICollectionReusableView!
        if kind == elementKindSectionHeader {
            reusableView = collectionView.dequeueReusableSupplementaryViewOfKind(kind,withReuseIdentifier:sectionHeaderIdentifire, forIndexPath:indexPath) as! UICollectionReusableView
        }
        
        return reusableView
    }
    
    func setupSize() {
        let sections = imageManager.getSectionCount()
        cellSizes.removeAll(keepCapacity: false)
        for var i = 0; i < sections; i++ {
            cellSizes.append([])
            for var j = 0; j < imageManager.getImageCount(i); j++ {
                let width:CGFloat = CGFloat(arc4random() % 50+50)
                let index = NSIndexPath(forRow: j, inSection: i)
                let obj:ImageObject = imageManager.getImageObjectIndexAt(index)!
                let size = obj.getSize()
                let imgWidth:CGFloat = size.width
                let imgHeight:CGFloat = size.height
                
                let height:CGFloat = width*imgHeight/imgWidth
                let newSize:CGSize = CGSizeMake(width, height)
                cellSizes[i].append(newSize)
            }
        }
    }
}

