//
//  EmptyDataView.swift
//  Computer_Company
//
//  Created by Chondro Satrio Wibowo on 08/11/23.
//

import SwiftUI

struct EmptyDataView: View {
    @Binding var isRotating:Double
    var size:CGSize
    var body: some View {
        VStack(alignment:.center){
            Image(systemName: "timelapse").resizable().frame(width:120,height: 120).rotationEffect(.degrees(isRotating))
            Text("Data Not Found")
        }.onAppear(perform: {
            withAnimation(.linear(duration: 2)
                        .speed(0.1).repeatForever(autoreverses: false)) {
                    isRotating = 360.0
                }
        }).frame(width:size.width,height:size.height,alignment: .center)
    }
}

