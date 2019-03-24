
import Foundation

class LinearCalculationHelper: CalculationHelper {
    var pArray: [Double]
    var lArray: [Double]
    var mArray: [Double]
    var eArray: [Double]
    var rArray: [Int]
    
    init() {
        self.pArray = [1, 0.15, 0.13, 0.3]
        self.eArray = [2.38]
        for i in 1 ..< pArray.count {
            self.eArray.append(pArray[i] * eArray[0])
        }
        self.lArray = [0.6]
        self.mArray = [1/0.6, 1/0.3, 1/0.4, 1/0.1]
        self.rArray = [1, 1, 1, 2]
    }
    
    func checkCondition() -> Bool {
        var result: [Bool] = []
        for i in 0 ..< eArray.count {
            result.append(lArray[0] * eArray[i] < mArray[i] * Double(rArray[i]) ? true : false)
        }
        return reduceBoolsAnd(values: result)
    }
    
    func calcC_N(at index: Int) -> Double {
        var result = 0.0
        let r = rArray[index]
            let tmp1 = pow(lArray[0] * eArray[index] / mArray[index], Double(r))
            let tmp2 = 1 /
                (Double(breakDownFactorial(n: r)) *
                    (1 -
                        ((lArray[0] * eArray[index]) /
                            (mArray[index] * Double(r))
                        )
                    )
            )
        var tmp3 = 0.0
        for k in 0 ..< r {
            tmp3 += pow(lArray[0] * eArray[index] / mArray[index], Double(k)) *
                (1.0 / Double(breakDownFactorial(n: k)))
        }
        result = tmp1 * tmp2 + tmp3
        return pow(result, -1.0)
    }
    
    func calcP(i: Int, k: Double) -> Double {
        let result = calcC_N(at: i)
        let tmp = pow(eArray[i] * lArray[0] / mArray[i], k)
        return result * tmp
    }
}

extension LinearCalculationHelper {
    func calcL(i: Int) -> Double {
        var result = 0.0
        for j in rArray[i] + 1 ... 4 {
            result += Double(j - rArray[i]) * calcP(i: i, k: Double(j))
        }
        return result
    }
    
    func calcR(i: Int) -> Double {
        let result = eArray[i] * lArray[0] / mArray[i]
        return result
    }
    
    func calcM(i: Int) -> Double {
        let L_i = calcL(i: i)
        let R_i = calcR(i: i)
        return L_i + R_i
    }
    
    func calcLamb(i: Int) -> Double {
        let result = lArray[0] * eArray[i]
        return result
    }
    
    func calcT(i: Int) -> Double {
        let M_i = calcM(i: i)
        let lamb_i = calcLamb(i: i)
        return M_i / lamb_i
    }
    
    func calcQ(i: Int) -> Double {
        let L_i = calcL(i: i)
        let lamb_i = calcLamb(i: i)
        return L_i / lamb_i
    }
}

extension LinearCalculationHelper {
    func breakDownFactorial(n: Int) -> Int {
        if n == 0 { return 1}
        else {
            return n * breakDownFactorial(n: n - 1)
        }
    }
    
    // ||
    func reduceBoolsOr(values: [Bool]) -> Bool {
        return values.contains(true)
    }
    
    // &&
    func reduceBoolsAnd(values: [Bool]) -> Bool {
        return !values.contains(false)
    }
}
