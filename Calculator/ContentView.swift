//
//  ContentView.swift
//  Calculator
//
//  Created by Brayhan De Aza on 12/9/20.
//

import SwiftUI

enum CalculatorButtons: String {
    case zero, one, two, three, four, five, six, seven, eight, nine
    case equals, plus, minus, multiply, divide
    case dot
    case ac, plusMinus, percent
    
    var title: String {
        switch self {
        case .zero:
            return "0"
        case .one:
            return "1"
        case .two:
            return "2"
        case .three:
            return "3"
        case .four:
            return "4"
        case .five:
            return "5"
        case .six:
            return "6"
        case .seven:
            return "7"
        case .eight:
            return "8"
        case .nine:
            return "9"
        case .equals:
            return "="
        case .plus:
            return "+"
        case .multiply:
            return "X"
        case .minus:
            return "–"
        case .divide:
            return "÷"
        case .dot:
            return "."
        case .plusMinus:
            return "+/-"
        case .percent:
            return "%"
        default:
            return "AC"
        }
    }
    
    var backgoundColor: Color {
        switch self {
        case .zero, .one, .two, .three, .four, .five, .six, .seven, .eight, .nine:
            return Color(.darkGray)
        case .ac, .plusMinus, .percent:
            return Color(.lightGray)
        default:
            return Color(.orange)
        }
    }
}

class GlobalEnvironment: ObservableObject {
    @Published var display = "0"
    @Published var left = "10"
    @Published var right = "10"
    @Published var result: Int = 0
    @Published var operation = ""
        
    func operation(_operation: String)  {
        let intLeft: Int = Int(String(self.left))!
        let intRight: Int = Int(String(self.right))!
        
        if _operation == "+" {
            self.result = intLeft + intRight
            self.display = String(result)
        }
    }
}

struct ContentView: View {
    @EnvironmentObject var env: GlobalEnvironment
    @State var display = "0"
    @State var left = "10"
    @State var right = "10"
    @State var result: Int = 0
    @State var operation = ""
    
    let buttons: [[CalculatorButtons]] = [
        [.ac, .plusMinus, .percent, .divide],
        [.seven, .eight, .nine, .multiply],
        [.four, .five, .six, .minus],
        [.one, .two, .three, .plus],
        [.zero, .dot, .equals]
    ]
    
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.edgesIgnoringSafeArea(.all)
            VStack(spacing: 12) {
                HStack {
                    Spacer()
                    Text(self.display)
                        .font(.system(size: 64))
                        .foregroundColor(Color.white)
                }
                .padding()
                
                ForEach(buttons, id: \.self) { row in
                    HStack(spacing: 12) {
                        ForEach(row, id: \.self) { button in
                            Button(action: {receiveInput(button: button )}) {
                                Text(button.title)
                                    .font(.system(size: 32))
                                    .frame(width: self.buttonsWidth(button: button), height: (UIScreen.main.bounds.width - 5 * 12) / 4)
                                    .foregroundColor(Color.white)
                                    .background(button.backgoundColor)
                                    .cornerRadius(self.buttonsWidth(button: button))
                            }
                        }
                    }
                }
                
            }
            .padding(.bottom)
        }
        
    }
    
    //handle buttons' width
    func buttonsWidth(button: CalculatorButtons) -> CGFloat {
        if button == .zero {
            return (UIScreen.main.bounds.width - 4 * 12) / 4 * 2
        } else {
            return (UIScreen.main.bounds.width - 5 * 12) / 4
        }
    }
    
    //Handle input pressed
    func receiveInput(button: CalculatorButtons) {
        if button.title == "AC" {
            
            // Reset values
            self.left = ""
            self.right = ""
            self.display = "0"
        
        }
        else if button.title == "." && self.display == "0" {
            self.display = "0."
            
        }
        else if button.title == "." && self.display.contains(".") {
           
        }
        else if button.title == "0" && self.display == "0" {
            self.display = "0"
        }
        else if self.display == "0" {
            self.display = ""
            self.display += button.title
        }
        else if button.title == "+" && self.right != "" {
            self.left = self.display
            self.operation = "+"
//            self.display = "0"
        }
        else if button.title == "=" && self.right != "" && self.left != "" {
            if left.isEmpty { self.display = "" }
            self.right = self.display
            self.operation(_operation: "+")
            
            // Reset values
            self.left = ""
            self.right = ""
        }
        else {
            if !left.isEmpty { self.display = "" }
            self.display += button.title
        }
    }
    
    // Handle math operations
    func operation(_operation: String)  {
        let intLeft: Int = Int(String(self.left))!
        let intRight: Int = Int(String(self.right))!
        
        if _operation == "+" {
            self.result = intLeft + intRight
            self.display = String(result)
        }
        else if _operation == "-" {
            self.result = intLeft - intRight
            self.display = String(result)
        }
        else if _operation == "X" {
            self.result = intLeft * intRight
            self.display = String(result)
        }
        else if _operation == "÷" {
            self.result = intLeft / intRight
            self.display = String(result)
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .environmentObject(GlobalEnvironment())
    }
}
