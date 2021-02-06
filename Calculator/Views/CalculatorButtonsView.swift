//
//  CalculatorButtonsView.swift
//  Calculator
//
//  Created by Brayhan De Aza on 12/9/20.
//

import SwiftUI

struct CalculatorButtonsView: View {
    var button: CalculatorButtons
    @EnvironmentObject var env: GlobalEnvironment
    
    var body: some View {
        Text("Hello")
//        Button(action: {self.env.receiveInput(button: button)}) {
//            Text(button.title)
//                .font(.system(size: 32))
//                .frame(width: self.buttonsWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
//                .foregroundColor(Color.white)
//                .background(button.backgoundColor)
//                .cornerRadius(self.buttonsWidth(button: button))
//        }
    }
    func buttonsWidth(button: CalculatorButtons) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        } else {
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }
}

