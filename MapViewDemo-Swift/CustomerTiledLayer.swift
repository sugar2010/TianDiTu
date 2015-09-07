//
//  CustomerTiledLayer.swift
//  MapViewDemo-Swift
//
//  Created by 赵春红(sugar) on 15/7/16.
//  Copyright (c) 2015年 Esri. All rights reserved.
//

import UIKit
import Foundation
import ArcGIS

struct CustomerTiledStruct {
    var spatialReference: AGSSpatialReference = AGSSpatialReference.spatialReferenceWithWKID(4490) as! AGSSpatialReference
    var fullEnvelope: AGSEnvelope = AGSEnvelope.envelopeWithXmin(-180, ymin: -90, xmax: 180, ymax: 90, spatialReference: AGSSpatialReference.spatialReferenceWithWKID(4490) as! AGSSpatialReference) as! AGSEnvelope
    var tiledInfo1: AGSTileInfo = AGSTileInfo(dpi: 96, format: "PNG", lods: [
        AGSLOD(level: 0, resolution: 1.40625, scale: 591658710.9),
        AGSLOD(level: 1, resolution: 0.703125, scale: 295829355.45),
        AGSLOD(level: 2, resolution: 0.3515625, scale: 147914677.725),
        AGSLOD(level: 3, resolution: 0.17578125, scale: 73957338.8625),
        AGSLOD(level: 4, resolution: 0.087890625, scale: 36978669.43125),
        AGSLOD(level: 5, resolution: 0.0439453125, scale: 18489334.715625),
        AGSLOD(level: 6, resolution: 0.02197265625, scale: 9244667.3578125),
        AGSLOD(level: 7, resolution: 0.010986328125, scale: 4622333.67890625),
        AGSLOD(level: 8, resolution: 0.0054931640625, scale: 2311166.839453125),
        AGSLOD(level: 9, resolution: 0.00274658203125, scale: 1155583.4197265625),
        AGSLOD(level: 10, resolution: 0.00137329101563, scale: 577791.70986328125),
        AGSLOD(level: 11, resolution: 0.00068664550782, scale: 288895.854931640625),
        AGSLOD(level: 12, resolution: 0.00034332275391, scale: 144447.9274658203125),
        AGSLOD(level: 13, resolution: 0.00017166137696, scale: 72223.96373291015625),
        AGSLOD(level: 14, resolution: 0.00008583068848, scale: 36111.98186645507813),
        AGSLOD(level: 15, resolution: 0.00004291534424, scale: 18055.99093322753907),
        AGSLOD(level: 16, resolution: 0.00002145767212, scale: 9027.99546661376954)], origin: AGSPoint(x: -180, y: 90, spatialReference: AGSSpatialReference.spatialReferenceWithWKID(4490) as! AGSSpatialReference), spatialReference: AGSSpatialReference.spatialReferenceWithWKID(4490) as! AGSSpatialReference, tileSize: CGSizeMake(256,256))
}

class CustomerTiledLayer: AGSTiledServiceLayer {
    var mapType:String = ""
    override var tileInfo: AGSTileInfo {
        return CustomerTiledStruct().tiledInfo1
    }
    override var fullEnvelope: AGSEnvelope{
        return CustomerTiledStruct().fullEnvelope
    }
    override var spatialReference: AGSSpatialReference{
        return CustomerTiledStruct().spatialReference
    }
    var requestQueue: NSOperationQueue  = {
        var queue = NSOperationQueue()
        queue.maxConcurrentOperationCount = 16
        return queue
    }()
    func initWithCacheSchema(mapType: String) -> AnyObject{
        self.mapType = mapType
        self.tileInfo.computeTileBounds(CustomerTiledStruct().fullEnvelope)
        super.layerDidLoad()
        return self
    }
    
   func didFinishedOperation(op: CustomerLayerOperation){
        super.setTileData(op.imageData, forKey: op.tileKey)
    }
    override func requestTileForKey(key: AGSTileKey!) {
        let customerOp = CustomerLayerOperation(tile: key,mapType:self.mapType,fatherView: self)
        requestQueue.addOperation(customerOp)
    }
    override func cancelRequestForKey(key: AGSTileKey!) {
        for op in AGSRequestOperation.sharedOperationQueue().operations{
            if op is CustomerLayerOperation{
                let offOp: CustomerLayerOperation = op as! CustomerLayerOperation
                if(offOp.tileKey.isEqualToTileKey(key)){
                   offOp.cancel()
                }
            }
        }
    }
}
