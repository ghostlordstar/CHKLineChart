//
//  KlineChartData.swift
//  Example
//
//  Created by Chance on 2018/2/27.
//  Copyright © 2018年 Chance. All rights reserved.
//

import UIKit
import SwiftyJSON

class KlineChartData: NSObject, Codable {
    
    var time: Int = 0
    var lowPrice: Double = 0
    var highPrice: Double = 0
    var openPrice: Double = 0
    var closePrice: Double = 0
    var vol: Double = 0
    var symbol: String = ""
    var platfom: String = ""
    var rise: Double = 0
    var timeType: String = ""
    //振幅
    var amplitude: Double = 0
    var amplitudeRatio: Double = 0
    
    convenience init(json: [JSON]) {
        self.init()
        self.time = json[0].intValue
        self.highPrice = json[2].doubleValue
        self.lowPrice = json[1].doubleValue
        self.openPrice = json[3].doubleValue
        self.closePrice = json[4].doubleValue
        self.vol = json[5].doubleValue
        
        //振幅
        if self.openPrice > 0 {
            self.amplitude = self.closePrice - self.openPrice
            self.amplitudeRatio = self.amplitude / self.openPrice * 100
        }
        
    }
    
    convenience init(sinaMinData: JSON) {
        self.init()
        self.time = Int(Date.getTimeStampByStamp(timeString: sinaMinData["d"].string ?? "", format: "yyyy-MM-dd hh:mm:ss"))
        self.highPrice = sinaMinData["h"].doubleValue
        self.lowPrice = sinaMinData["l"].doubleValue
        self.openPrice = sinaMinData["o"].doubleValue
        self.closePrice = sinaMinData["c"].doubleValue
        self.vol = sinaMinData["v"].doubleValue
        
        if self.openPrice > 0 {
            self.amplitude = self.closePrice - self.openPrice
            self.amplitudeRatio = self.amplitude / self.openPrice * 100
        }
    }
    
    convenience init(sinaDayData: [String]?) {
        self.init()
        if sinaDayData != nil && sinaDayData!.count >= 6 {
            self.time = Int(Date.getTimeStampByStamp(timeString: sinaDayData![0], format: "yyyy-MM-dd hh:mm:ss"))
            self.highPrice = Double(sinaDayData![2]) ?? 0
            self.lowPrice = Double(sinaDayData![3]) ?? 0
            self.openPrice = Double(sinaDayData![1]) ?? 0
            self.closePrice = Double(sinaDayData![4]) ?? 0
            self.vol = Double(sinaDayData![5]) ?? 0
        }
        
        if self.openPrice > 0 {
            self.amplitude = self.closePrice - self.openPrice
            self.amplitudeRatio = self.amplitude / self.openPrice * 100
        }
    }
    
}

