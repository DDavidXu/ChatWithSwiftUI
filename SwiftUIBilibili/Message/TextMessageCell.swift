//
//  TextMessageCell.swift
//  Ipadyou
//
//  Created by boo on 5/7/20.
//  Copyright © 2020 boo. All rights reserved.
//

import SwiftUI
import LeanCloud

struct TextMessageCell: View {
    var message: IMTextMessage
    var isSelf: Bool
    
    var body: some View {
        
        VStack(alignment: isSelf ? .trailing : .leading ) {
            Text(message.fromClientID ?? "-")
                .font(.title)
            Text(message.text ?? "-")
        }
        
    }
}

//struct TextMessageCell_Previews: PreviewProvider {
//    static var previews: some View {
//        TextMessageCell()
//    }
//}
