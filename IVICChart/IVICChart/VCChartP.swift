//
//  VCChartP.swift
//  IVICChart
//
//  Created by ivic on 2017/9/19.
//  Copyright © 2017年 ivic. All rights reserved.
//

import UIKit

class VCChartP: UIView {
    
    //距离
    var len = [Double]()
    //数据
    var lendic:Double!
    //中心点
    private let centerX = Double(UIScreen.main.bounds.size.width / 2.0)
    private let centerY = Double(UIScreen.main.bounds.size.height / 2.0)
    //线宽
    private var lWidth:CGFloat!
    //线颜色
    private var lsCorlor:UIColor!
    //填充颜色
    private var lfCorlor:UIColor!
    //动画时间
    private var aTime:CFTimeInterval!
    //顶点数组
    private var titleArr = [String]()
    
    //MARK:init
    override init(frame polFrame: CGRect){
        super.init(frame: polFrame)
        
        self.clipsToBounds = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    public convenience init(lWidth:CGFloat,lsColor:UIColor,lfColor:UIColor,aTime:CFTimeInterval,titleArr:[String],lendic:Double){
        
        self.init()
        self.lWidth = lWidth
        self.lsCorlor = lsColor
        self.lfCorlor = lfColor
        self.aTime = aTime
        self.lendic = lendic
        self.titleArr = titleArr
    }
    
    //MARK:画图表
    override func draw(_ rect: CGRect){
        
        //MARK:正多边形
        let layerFive = CAShapeLayer.init()
        layerFive.strokeColor = lsCorlor.cgColor
        layerFive.fillColor = lfCorlor.cgColor
        let pathFive = UIBezierPath.init()
        
        for i in 0...1{
            
            let edges = lendic
            //画内线
            if i == 0{
                
                for edg in 0..<titleArr.count{
                    
                    pathFive.move(to: CGPoint(x: centerX, y: centerY))
                    pathFive.addLine(to: CGPoint(x: centerX - sin(360/Double(titleArr.count)*Double(edg) * M_PI / 180)*edges!, y: centerY - cos(360/Double(titleArr.count) * Double(edg) * M_PI / 180)*edges!))
                }
                
            }else{
                
                
                //画边线
                var led = edges!
                for j in 0..<4{
                    
                    pathFive.move(to: CGPoint(x: centerX - sin(360/Double(titleArr.count) * Double(0) * M_PI / 180)*edges!, y: centerY - cos(360/Double(titleArr.count) * Double(0) * M_PI / 180)*edges! + Double(25*j)))
                    for index in 0..<titleArr.count-1{
                        
                        
                        pathFive.addLine(to: CGPoint(x: centerX - sin(360/Double(titleArr.count) * Double(index+1) * M_PI / 180)*led, y: centerY - cos(360/Double(titleArr.count) * Double(index+1) * M_PI / 180)*led))
                        
                    }
                    pathFive.close()
                    led -= 25
                }
                
            }
            
            
        }
        
        
        layerFive.path = pathFive.cgPath
        layerFive.lineWidth = lWidth
        self.layer.addSublayer(layerFive)
        pLabel()
        drawCircle()
        
    }
    
    //MARK:画图
    func drawCircle(){
        
        let center = CGPoint(x: bounds.width/2.0, y: bounds.height / 2.0)
        //MARK:正多边形
        let layerFive = CAShapeLayer.init()
        layerFive.strokeColor = UIColor(red: 1, green: 0, blue: 0, alpha: 1).cgColor
        let pathFive = UIBezierPath.init()
        
        //画边线
        pathFive.move(to: CGPoint(x: centerX - sin(360/Double(titleArr.count) * Double(0) * M_PI / 180)*Double(len[0]), y: centerY - cos(360/Double(titleArr.count) * Double(0) * M_PI / 180)*Double(len[0])))
        //画边线
        for index in 0..<len.count-1{
            
            let led = Double(len[index + 1])
            pathFive.addLine(to: CGPoint(x: centerX - sin(360/Double(titleArr.count) * Double(index+1) * M_PI / 180)*led, y: centerY - cos(360/Double(titleArr.count) * Double(index+1) * M_PI / 180)*led))
        }
        pathFive.close()
        layerFive.path = pathFive.cgPath
        layerFive.fillColor = UIColor(red: 1, green: 0, blue: 0, alpha: 0.5).cgColor
        layerFive.lineWidth = lWidth + 1
        self.layer.addSublayer(layerFive)

        //添加动画
        let beforePath = UIBezierPath(arcCenter: center, radius: 1, startAngle: 0, endAngle: CGFloat(2.0 * Double.pi), clockwise: true).cgPath
        layerFive.path = beforePath
        let anim = CABasicAnimation(keyPath:"path")
        anim.beginTime = CACurrentMediaTime() + 0.5
        anim.fromValue = beforePath
        anim.toValue = pathFive.cgPath
        anim.duration = 2
        anim.isRemovedOnCompletion = false
        anim.fillMode = kCAFillModeForwards
        layerFive.add(anim, forKey: nil)
        
    }
    
    //MARK:添加指标名
    func pLabel(){
        
        for i in 0..<titleArr.count{
            
            let w = Double(50/750 * self.bounds.size.width)
            let h = Double(25/1334 * self.bounds.size.height)
            
            //label的x坐标
            let lx = centerX - sin(360/Double(titleArr.count) * Double(i) * M_PI / 180)*lendic
            //label的y坐标
            let ly = centerY - cos(360/Double(titleArr.count) * Double(i) * M_PI / 180)*lendic
            
            //根据labelx,y范围精确label的坐标
            if lx<centerX {
                
                let cx = lx - w
                if ly < centerY{
                    
                    let cy = ly - h
                    let label = UILabel(frame: CGRect(x: cx, y: cy, width: w, height: h))
                    label.adjustsFontSizeToFitWidth = true
                    label.text = titleArr[i]
                    label.textAlignment = .right
                    label.textColor = lsCorlor
                    self.addSubview(label)
                }else{
                    
                    let label = UILabel(frame: CGRect(x: lx-w, y: ly, width: w, height: h))
                    label.adjustsFontSizeToFitWidth = true
                    label.text = titleArr[i]
                    label.textAlignment = .right
                    label.textColor = lsCorlor
                    self.addSubview(label)
                }
                
            }
            else{
                if ly < centerY{
                    
                    let cy = ly - h
                    let label = UILabel(frame: CGRect(x: lx, y: cy, width: w, height: h))
                    label.adjustsFontSizeToFitWidth = true
                    label.text = titleArr[i]
                    label.textColor = lsCorlor
                    self.addSubview(label)
                }else{
                    
                    let label = UILabel(frame: CGRect(x: lx, y: ly, width: w, height: h))
                    label.adjustsFontSizeToFitWidth = true
                    label.text = titleArr[i]
                    label.textColor = lsCorlor
                    self.addSubview(label)
                }
                
            }
            
        }
        
    }
}
