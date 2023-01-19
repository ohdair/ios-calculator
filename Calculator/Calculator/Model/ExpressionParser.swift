//
//  ExpressionParser.swift
//  Calculator
//
//  Created by 이상윤 on 2023/01/17.
//

import Foundation

enum ExpressionParser {
    static func parse(from input: String) -> Formula {
        let operands: [Double] = componentsByOperators(from: input).compactMap { Double($0) }
        let operators: [Operator] = extractOperators(from: input)

        let operandQueue: CalculateItemQueue<Double> = makeQueue(from: operands)
        let operatorQueue: CalculateItemQueue<Operator> = makeQueue(from: operators)

        return Formula(operands: operandQueue, operators: operatorQueue)
    }
    
    static func componentsByOperators(from input: String) -> [String] {
        let operators: String = String(Operator.allCases.map { $0.rawValue })
        let operatorSet: CharacterSet = CharacterSet(charactersIn: operators)
        return input.components(separatedBy: operatorSet)
    }

    static func extractOperators(from input: String) -> [Operator] {
        return input.compactMap { Operator(rawValue: $0) }
    }

    static func makeQueue<T>(from elements: Array<T>) -> CalculateItemQueue<T> {
        var newQueue = CalculateItemQueue<T>()

        elements.forEach { element in
            newQueue.enqueue(element)
        }

        return newQueue
    }
}

struct Formula {
    var operands: CalculateItemQueue<Double>
    var operators: CalculateItemQueue<Operator>

    func result() -> Double {
        return Double()
    }
}

extension String {
    func split(with target: Character) -> [String] {
        return self.components(separatedBy: String(target))
    }
}
