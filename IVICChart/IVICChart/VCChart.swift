//
//  VCChart.swift
//  IVICChart
//
//  Created by ivic on 2017/9/19.
//  Copyright © 2017年 ivic. All rights reserved.
//

import UIKit

class VCChart: UIView {
    
    //距离
    var len = [Double]()
    //数据
    var lendic:Double!
    //中心点
    private var centerX:CGFloat!
    private var centerY:CGFloat!
    //线宽
    var lWidth:CGFloat!
    //线颜色
    var lsCorlor:UIColor!
    //填充颜色
    var lfCorlor:UIColor!
    //动画时间
    private var aTime:CFTimeInterval!
    //顶点数组
    var titleArr = [Double]()
    //xy轴长度
    private var xLen:CGFloat!
    private var yLen:CGFloat!
    //横线个数
    var xLine:Int!
    //纵线个数
    var yLine:Int!
    //y轴最大值
    var yMax:CGFloat!
    
    //MARK:init
    override init(frame: CGRect){
        super.init(frame: frame)
        
        self.clipsToBounds = false
        
        
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
//    public convenience init(lWidth:CGFloat,lsColor:UIColor,lfColor:UIColor,aTime:CFTimeInterval,titleArr:[Double],lendic:Double){
//        
//        self.init()
//        self.lWidth = lWidth
//        self.lsCorlor = lsColor
//        self.lfCorlor = lfColor
//        self.aTime = aTime
//        self.lendic = lendic
//    }
    
    //MARK:画图表
    override func draw(_ rect: CGRect){
        
        
        setUpC()
    }
    
    //建立坐标及网格线
    func setUpC(){
        
        //x、y轴长度
        self.xLen = CGFloat(bounds.size.width)
        self.yLen = CGFloat(bounds.size.height)
        
        let layer = CAShapeLayer.init()
        layer.strokeColor = UIColor.lightGray.cgColor
        layer.fillColor = UIColor.clear.cgColor
        let path = UIBezierPath.init()
        self.centerX = (bounds.size.width - xLen)/CGFloat(2)
        self.centerY = bounds.size.height/2 + yLen/2
        
        let plo = xLen / 10
        for j in 0..<2{
            
            if j == 0{
                
                //画横线
                for i in 0..<xLine{
                    
                    path.move(to: CGPoint(x: centerX, y: centerY - yLen/2*CGFloat(i)))
                    path.addLine(to: CGPoint(x: centerX + xLen  , y: centerY - yLen/2*CGFloat(i)))
                    //                    let str = "\(getY(arr: len, str: creatY(num: 250)*CGFloat(i)))"
                    //                    labelY(label: str, x: centerX + creatX(num: 10) - creatX(num: 40), y: centerY - creatY(num: 250)*CGFloat(i) - 2)
                    
                }
                layer.path = path.cgPath
                self.layer.addSublayer(layer)
                
            }
            else{
                
                //画竖线
                for i in 0..<yLine{
                    
                    print(plo)
                    path.move(to: CGPoint(x: centerX + plo * CGFloat(i), y: centerY))
                    path.addLine(to: CGPoint(x: centerX + plo * CGFloat(i), y: centerY - yLen))
//                    let stringArr = len.map({
//                        "\($0)"
//                    })
                    //                    labelX(label: stringArr, x: centerX + creatX(num: 10 - 30) + creatX(num: 25)*CGFloat(i), y: centerY + 2, num: i)
                }
                layer.path = path.cgPath
                self.layer.addSublayer(layer)
            }
        }
        
        drawLine()
    }
    
    //画折线
    func drawLine(){
        
        let layer = CAShapeLayer.init()
        layer.fillColor = UIColor.clear.cgColor
        layer.strokeColor = UIColor.white.cgColor
        let path = UIBezierPath.init()
        let plo = xLen / CGFloat(self.titleArr.count)
        self.centerX = 0
        self.centerY = bounds.size.height
        path.move(to: CGPoint(x: centerX , y: centerY-CGFloat(titleArr[0])*yLen/yMax))
        for i in 1..<titleArr.count{
            
            path.addLine(to: CGPoint(x: centerX + plo*CGFloat(i), y: centerY - CGFloat(titleArr[i]) * yLen/yMax))
            
            
        }
        UIColor.yellow.set()
        layer.path = path.cgPath
        
        //添加动画
        let pathA = CABasicAnimation.init(keyPath: "strokeEnd")
        pathA.duration = 10
        pathA.timingFunction = CAMediaTimingFunction.init(name: kCAMediaTimingFunctionEaseOut)
        pathA.fromValue = 0
        pathA.toValue = 1
        layer.add(pathA, forKey: "addCAShapeLayerAnimationStrokeEnd")
        self.layer.addSublayer(layer)
        
        drawGradient()
        
        
    }
    
//    func getY(arr:[Double],str:CGFloat) -> CGFloat{
//        
//        let maxY = arr.sorted(by: >)[0]
//        if maxY < 1.0{
//            
//            return str/1000 * 2
//        }else{
//            
//            return str * 4
//        }
//    }
//    
//    func getY1(arr:[Double],str:CGFloat) -> CGFloat{
//        
//        let maxY = arr.sorted(by: >)[0]
//        if maxY < 1.0{
//            
//            return str*1000
//        }else{
//            
//            return str
//        }
//    }
    
//    func labelX(label:[String],x:CGFloat,y:CGFloat,num:Int){
//        
//        let label1 = UILabel(frame:CGRect(x: x, y: y, width: 60, height: 25))
//        label1.text = label[num]
//        label1.textColor = UIColor.white
//        label1.textAlignment = .center
//        self.addSubview(label1)
//        
//    }
//    
//    func labelY(label:String,x:CGFloat,y:CGFloat){
//        
//        let label1 = UILabel(frame:CGRect(x: x, y: y, width: 60, height: 25))
//        label1.text = label
//        label1.textColor = UIColor.white
//        label1.textAlignment = .left
//        self.addSubview(label1)
//    }
    
    
    //渐变阴影
    func drawGradient() {
        
        let plo = self.xLen / CGFloat(self.titleArr.count)
        let gradientLayer = CAGradientLayer()
        gradientLayer.frame = CGRect(x: 0, y: 0, width: frame.size.width, height: frame.size.height)
        gradientLayer.colors = [(UIColor(red: 250 / 255.0, green: 170 / 255.0, blue: 10 / 255.0, alpha: 0.8).cgColor as? Any), (UIColor(white: 1, alpha: 0.1).cgColor as? Any)]
        gradientLayer.locations = [0.0, 1.0]
        gradientLayer.startPoint = CGPoint(x: 0.0, y: 0.0)
        gradientLayer.endPoint = CGPoint(x: 0.0, y: 1)
        let gradientPath = UIBezierPath()
        gradientPath.move(to: CGPoint(x: centerX , y: centerY))
        for i in 0..<titleArr.count {
            gradientPath.addLine(to: CGPoint(x: centerX + plo*CGFloat(i), y: centerY - CGFloat(titleArr[i]) * yLen/1000))
        }
        gradientPath.addLine(to: CGPoint(x: centerX + plo*CGFloat(titleArr.count), y: centerY + xLen))
        let arc = CAShapeLayer()
        arc.path = gradientPath.cgPath
        gradientLayer.mask = arc
        layer.addSublayer(gradientLayer)
    }
    
}
