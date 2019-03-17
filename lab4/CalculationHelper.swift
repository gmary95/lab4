import Foundation

class CalculationHelper {
    var eArray: [Double]
    var kArray: [Double]
    var mArray: [Double]
    var rArray: [Double]
    
    init(eArray: [Double], kArray: [Double], mArray: [Double], rArray: [Double]) {
        self.eArray = eArray
        self.kArray = kArray
        self.mArray = mArray
        self.rArray = rArray
    }
    
    func calcP(at index: Int, k: Double) -> Double {
        var result = pow(eArray[index] / mArray[index], k)
        var tmp = 0.0
        let r = rArray[index]
        if k > r {
            tmp = Double(breakDownFactorial(n: Int(k)))
        } else {
            tmp = Double(breakDownFactorial(n: Int(r)))
            tmp = tmp * pow(r, k - r)
        }
        tmp = 1.0 / tmp
        result = result * tmp
        return result
    }
    
    func calcC_N() -> Double { // ?????
        var result = 0.0
        kArray.forEach { k in
            var tmp = 0.0
            for i in 0 ..< kArray.count {
                tmp *= calcP(at: i, k: k)
            }
            result += tmp
        }
        return pow(result, -1.0)
    }
    
    func calcP(i: Int, j: Int) -> Double{ /// i dont know
        var result = calcC_N()
        var tmp = 0.0
        return result
    }
}

extension CalculationHelper {
    func calcL(i: Int) -> Double {
        var result = 0.0
        for j in Int(rArray[i]) + 1 ... rArray.count { //index??
            result += (Double(j) - rArray[i]) * calcP(i: i, j: j)
        }
        return result
    }
    
    func calcR(i: Int) -> Double {
        var result = rArray[i]
        var tmp = 0.0
        for j in 0 ... Int(result) { //index??
            tmp += (rArray[i] - Double(j)) * calcP(i: i, j: j)
        }
        result = result - tmp
        return result
    }
    
    func calcM(i: Int) -> Double {
        let L_i = calcL(i: i)
        let R_i = calcR(i: i)
        return L_i + R_i
    }
    
    func calcLamb(i: Int) -> Double {
        let R_i = calcR(i: i)
        let result = R_i * mArray[i]
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

extension CalculationHelper {
    func breakDownFactorial(n: Int) -> Int {
        if n == 0 { return 1}
        else {
            return n * breakDownFactorial(n: n - 1)
        }
    }
}
