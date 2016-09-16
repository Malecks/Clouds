//
//  CloudView.swift
//  Clouds
//
//  Created by Alex Mathers on 2016-08-17.
//  Copyright © 2016 Alex Mathers. All rights reserved.
//
import UIKit

@IBDesignable class CloudView: UIView {
    
    struct CloudPoint {
        let point: CGPoint
        let radius: CGFloat
    }
    
    @IBInspectable var cloudColor: UIColor = UIColor(white: 1.0, alpha: 1.0)
    @IBInspectable var strokeColor: UIColor = UIColor(red: 185/255.0, green: 190/255.0, blue: 220/255.0, alpha: 1.0)
    
    static let cloudPillarsCount: Int = 20
    static let smallCloudsCount: Int = 5000
    
    
    override func draw(_ rect: CGRect) {
        let cloudPillars = createPillars(rect: rect)
        let smallClouds = createSmallCloudPoints(rect: rect, around: cloudPillars)
        
        self.strokeColor.setStroke()
        self.cloudColor.setFill()
        
        
        for cloud in cloudPillars {
            let path = createCircleForCloudPoint(cloudPoint: cloud)
            path.fill()
            for x in 1...arc4random_uniform(5) + 3 {
                let path = UIBezierPath()
                path.addArc(
                    withCenter: cloud.point,
                    radius: cloud.radius - CGFloat(x) * 4,
                    startAngle: CGFloat.angle(0 + Double(x * 5)),
                    endAngle: CGFloat.angle(130 - Double(x * 5)),
                    clockwise: true
                )
                path.lineWidth = 2.0
                path.stroke()
            }
        }
        
        for cloud in smallClouds {
            let path = createCircleForCloudPoint(cloudPoint: cloud)
            path.fill()
            for x in 1...arc4random_uniform(4) + 1 {
                let path = UIBezierPath()
                path.addArc(
                    withCenter: cloud.point,
                    radius: cloud.radius - CGFloat(x) * 3,
                    startAngle: CGFloat.angle(0 + Double(x * 10)),
                    endAngle: CGFloat.angle(130 - Double(x * 10)),
                    clockwise: true
                )
                path.stroke()
            }

        }
    }
}

extension CloudView {
    
    func getRadiusForPoint(point:CGPoint, rect: CGRect) -> CGFloat {
        var offset: CGFloat {
            if rect.maxX - point.x > point.x - rect.minX {
                return CGFloat(rect.maxX - point.x)
            } else {
                return CGFloat(point.x - rect.minX)
            }
        }
        
        return rect.width / (CGFloat(arc4random_uniform(10)) + 10) * (rect.width/offset)
    }
    
    func createPillars(rect: CGRect) -> [CloudPoint] {
        var pillars = [CloudPoint]()
        for _ in 1...CloudView.cloudPillarsCount {
            let x = CGFloat(arc4random_uniform(UInt32(rect.width)))
            let y = CGFloat(arc4random_uniform(UInt32(rect.height / 3))) + rect.height / 6
            let radius = getRadiusForPoint(point: CGPoint(x: x, y: y), rect: rect) * (CGFloat(arc4random_uniform(10) + 10) / 20)
            
            pillars.append(CloudPoint(point: CGPoint(x: x, y: y), radius: radius))
        }
        
        return pillars
    }

    func createSmallCloudPoints(rect: CGRect, around pillars: [CloudPoint]) -> [CloudPoint] {
        var points = [CloudPoint]()
        for _ in 1...CloudView.smallCloudsCount {
            let randomPillar = pillars[Int(arc4random_uniform(UInt32(pillars.count)))]
            
            let x = (randomPillar.point.x - randomPillar.radius) + CGFloat(arc4random_uniform(UInt32(randomPillar.radius * 2.0)))
            let y = (randomPillar.point.y - randomPillar.radius) + CGFloat(arc4random_uniform(UInt32(randomPillar.radius * 1.65)))
            let radius = getRadiusForPoint(point: CGPoint(x: x, y: y), rect: rect) * (CGFloat(arc4random_uniform(30) + 5) / 100)
            points.append(CloudPoint(point: CGPoint(x: x, y: y), radius: radius))
        }
        return points
    }

    func createCircleForCloudPoint(cloudPoint: CloudPoint) -> UIBezierPath {
        return UIBezierPath(
            arcCenter: cloudPoint.point,
            radius: cloudPoint.radius,
            startAngle: CGFloat.angle(0.0),
            endAngle: CGFloat.angle(360.0),
            clockwise: true
        )
    }
}

extension CGFloat {
    static func angle(_ double: Double) -> CGFloat {
        return CGFloat(double / 180 * M_PI)
    }
}
