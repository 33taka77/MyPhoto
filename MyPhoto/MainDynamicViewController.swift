//
//  MainDynamicViewController.swift
//  MyPhoto
//
//  Created by AizawaTakashi on 2015/05/16.
//  Copyright (c) 2015年 AizawaTakashi. All rights reserved.
//

import UIKit

class MainDynamicViewController: MSDynamicsDrawerViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        let application:UIApplication = UIApplication.sharedApplication()
        let appdelegate:AppDelegate = application.delegate as! AppDelegate
        appdelegate.setupDrawer(self)

    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
