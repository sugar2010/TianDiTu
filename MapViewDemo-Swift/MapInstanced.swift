//
//  MapInstanced.swift
//  MapViewDemo-Swift
//
//  Created by 赵春红(sugar) on 15/7/20.
//  Copyright (c) 2015年 Esri. All rights reserved.
//

import UIKit

let vec = "http://t0.tianditu.com/vec_c/wmts?service=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=vec&STYLE=default&TILEMATRIXSET=c&TILEMATRIX=%d&TILEROW=%d&TILECOL=%d&FORMAT=tiles"
let img = "http://t0.tianditu.com/img_c/wmts?service=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=img&STYLE=default&TILEMATRIXSET=c&TILEMATRIX=%d&TILEROW=%d&TILECOL=%d&FORMAT=tiles"
let anno = "http://t0.tianditu.com/cva_c/wmts?service=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=cva&STYLE=default&TILEMATRIXSET=c&TILEMATRIX=%d&TILEROW=%d&TILECOL=%d&FORMAT=tiles"
let imageanno = "http://t0.tianditu.com/cia_c/wmts?service=WMTS&REQUEST=GetTile&VERSION=1.0.0&LAYER=cia&STYLE=default&TILEMATRIXSET=c&TILEMATRIX=%d&TILEROW=%d&TILECOL=%d&FORMAT=tiles"

private let _mapInstanced = MapInstanced()
class MapInstanced: NSObject,NSURLConnectionDataDelegate {
    let tdtImageLayer: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(img) as! CustomerTiledLayer
    let tdtLayer: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(vec) as! CustomerTiledLayer
    let tdtLayerAnno: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(anno) as! CustomerTiledLayer
    let tdtLayerImageAnno: CustomerTiledLayer = CustomerTiledLayer().initWithCacheSchema(imageanno) as! CustomerTiledLayer
    class var sharedInstance:MapInstanced{
        return _mapInstanced
    }
}
