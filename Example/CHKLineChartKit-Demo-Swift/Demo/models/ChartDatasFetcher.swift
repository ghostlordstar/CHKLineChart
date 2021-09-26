//
//  ChartDatasFetcher.swift
//  Example
//
//  Created by Chance on 2018/2/27.
//  Copyright © 2018年 Chance. All rights reserved.
//

import UIKit
import SwiftyJSON

class ChartDatasFetcher: NSObject {
    
    /// 接口地址
    //    var apiURL = "https://www.okex.com/api/v1/"       //okex废了
    var apiURL_gdax = "https://api.gdax.com/products/"       //gdax稳定 --> 已经被废弃（2021-09-18 update）
    var apiURL_sina = "https://quotes.sina.cn/fx/api/openapi.php/BtcService."       //sina稳定（2021-09-18 update）
    
    /// 全局唯一实例
    static let shared: ChartDatasFetcher = {
        let instance = ChartDatasFetcher()
        return instance
    }()
    
    /// 获取服务API的K线数据
    ///
    /// - Parameters:
    ///   - symbol: 市场
    ///   - timeType: 时间周期
    ///   - size: 数据条数
    ///   - callback:
    func getRemoteChartData(symbol: String, timeType: String, size: Int,
                            callback:@escaping (Bool, [KlineChartData]) -> Void) {
        
        //        The granularity field must be one of the following values: {60, 300, 900, 3600, 21600, 86400}. Otherwise, your request will be rejected. These values correspond to timeslices representing one minute, five minutes, fifteen minutes, one hour, six hours, and one day, respectively.
        var granularity = 300
        switch timeType {
        case "5min":
            granularity = 5 * 60
        case "15min":
            granularity = 15 * 60
        case "30min":
            granularity = 30 * 60
        case "1hour":
            granularity = 1 * 60 * 60
        case "2hour":
            granularity = 2 * 60 * 60
        case "4hour":
            granularity = 4 * 60 * 60
        case "6hour":
            granularity = 6 * 60 * 60
        case "1day":
            granularity = 1 * 24 * 60 * 60
        case "1week":
            granularity = 7 * 24 * 60 * 60
        default:
            granularity = 300
        }
        
        // 快捷方式获得session对象
        let session = URLSession.shared
        // /BTC-USD/candles?granularity=300
        let url = URL(string: self.apiURL_gdax + symbol + "/candles?granularity=\(granularity)")
        //        let url = URL(string: self.apiURL + "kline.do?symbol=\(symbol)&type=\(timeType)&size=\(size)")
        // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
        let task = session.dataTask(with: url!, completionHandler: {
            (data, response, error) in
            if let data = data {
                
                DispatchQueue.main.async {
                    
                    var marketDatas = [KlineChartData]()
                    
                    /*
                     对从服务器获取到的数据data进行相应的处理.
                     */
                    do {
                        let json = try JSON(data: data)
                        let chartDatas = json.arrayValue
                        for data in chartDatas {
                            let marektdata = KlineChartData(json: data.arrayValue)
                            marketDatas.append(marektdata)
                        }
                        marketDatas.reverse()
                        callback(true, marketDatas)
                        
                    } catch _ {
                        callback(false, marketDatas)
                    }
                }
                
                
            }
        })
        
        // 启动任务
        task.resume()
    }
    
    /// 获取新浪财经服务API的K线数据
    ///
    /// - Parameters:
    ///   - symbol: 市场
    ///   - timeType: 时间周期
    ///   - size: 数据条数
    ///   - callback:
    func getSinaRemoteChartData(symbol: String, timeType: String, size: Int,
                                callback:@escaping (Bool, [KlineChartData]) -> Void) {
        
        //        The granularity field must be one of the following values: {60, 300, 900, 3600, 21600, 86400}. Otherwise, your request will be rejected. These values correspond to timeslices representing one minute, five minutes, fifteen minutes, one hour, six hours, and one day, respectively.
        
        let symbolParam = symbol.lowercased().replacingOccurrences(of: "-", with: "")
        // 分钟线
        var urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=1&datalen=\(size)"
        
        switch timeType {
        case "5min":
            urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=5&datalen=\(size)"
        case "15min":
            urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=15&datalen=\(size)"
        case "30min":
            urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=30&datalen=\(size)"
        case "1hour":
            urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=60&datalen=\(size)"
        case "2hour":
            urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=120&datalen=\(size)"
        case "4hour":
            urlParams = "getMinKline?symbol=btc\(symbolParam)&scale=240&datalen=\(size)"
        case "6hour":
            urlParams = "" // 没有此项
        case "1day":
            urlParams = "getDayKLine?symbol=btc\(symbolParam)" // 数量限制不生效
        case "1week":
            urlParams = "" // 没有此项
        default:
            urlParams = ""
        }
        
        var marketDatas = [KlineChartData]()
        
        // 快捷方式获得session对象
        let session = URLSession.shared
        let url = URL(string: self.apiURL_sina + urlParams)
        
        // 通过URL初始化task,在block内部可以直接对返回的数据进行处理
        let task = session.dataTask(with: url!, completionHandler: { (data, response, error) in
            if let data = data {
                do {
                    let json = try JSON(data: data)
                    if timeType == "1day" { // 日线数据是特殊格式
                        let dataString = json["result"]["data"].stringValue
                        let dayDataArray = dataString.components(separatedBy: "|")
                        for dayData in dayDataArray {
                            let chartModel = KlineChartData(sinaDayData: dayData.components(separatedBy: ","))
                            marketDatas.append(chartModel)
                        }
                    }else {
                        let dataArray = json["result"]["data"].arrayValue
                        for chartData in dataArray {
                            let chartModel = KlineChartData(sinaMinData: chartData)
                            marketDatas.append(chartModel)
                        }
                    }
              
                    DispatchQueue.main.async {
                        callback(true, marketDatas)
                    }
                } catch _ {
                    DispatchQueue.main.async {
                        callback(false, marketDatas)
                    }
                }
            }else {
                DispatchQueue.main.async {
                    callback(false, marketDatas)
                }
            }
        })
        // 启动任务
        task.resume()
    }
}
