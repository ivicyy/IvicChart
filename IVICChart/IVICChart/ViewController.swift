//
//  ViewController.swift
//  IVICChart
//
//  Created by ivic on 2017/9/19.
//  Copyright © 2017年 ivic. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        creatUIT()
//        creatUI()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension ViewController{

    
    func creatUI(){
    
        let drawView = VCChart(frame: CGRect(x: 50, y: 200, width: 300, height: 300))
        drawView.backgroundColor = UIColor.init(red: 50/255.0, green: 74/255.0, blue: 58/255.0, alpha: 1)
        drawView.titleArr = [500,600,800,700,250,300,900,700,600,800,700,220,500,600,800,700,250,300,900,700,600,800,700,220]
        drawView.xLine = 3
        drawView.yLine = 10
        drawView.yMax = 1000
        self.view.addSubview(drawView)
    }
    
    func creatUIT(){
    
        let tArr = ["医院","学校","公司","酒店","酒吧"]
        let ary1 = [100.0,100,100,100,100]
        let lenary = [50.0,50,50,50,50]
        let drawView = VCChartP(lWidth: 1, lsColor: UIColor.white, lfColor: UIColor.clear, aTime: 5, titleArr: tArr, lendic: 100)
        drawView.len = [50.0,70,90,30,80]
        drawView.backgroundColor = UIColor.init(red: 50/255.0, green: 74/255.0, blue: 58/255.0, alpha: 1)
        self.view = drawView
    }
    
}

