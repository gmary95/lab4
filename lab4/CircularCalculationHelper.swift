import Foundation

class CircularCalculationHelper: CalculationHelper {

    var pArray: [Double]
    var lArray: [Double]
    var mArray: [Double]
    var eArray: [Double]
    var rArray: [Int]
    var N: Int
    
    init() {
        self.N = 20
        self.pArray = [0.23, 0.77] // p12?
        self.eArray = [pArray[0], 1]
        self.lArray = [0.6]
        self.mArray = [1/0.8, 1/0.6]
        self.rArray = [1, 1]
    }
    
    func calcP(at index: Int, k: Double) -> Double {
        var result = pow(eArray[index] / mArray[index], k)
        var tmp = 0.0
        let r = Double(rArray[index])
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
    
    func calcC_N(at index: Int) -> Double {
        var result = 0.0
        var tmp = 0.0
        for l in 0 ... N {
            result += calcP(at: 0, k: Double(l)) + calcP(at: 1, k: Double(N - l))
        }
        return pow(result, -1.0)
    }
    
    func calcP(i: Int, j: Int) -> Double{
        var result = calcC_N(at: i)
        var tmp = 0.0
        if i == 0 {
            tmp = calcP(at: 0, k: Double(j)) * calcP(at: 1, k: Double(N - j))
        } else {
            tmp = calcP(at: 0, k: Double(N - j)) * calcP(at: 1, k: Double(j))
        }
        return result * tmp
    }
}

extension CircularCalculationHelper {
    func calcL(i: Int) -> Double {
        var result = 0.0
        for j in rArray[i] + 1 ... 4 {
            result += Double(j - rArray[i]) * calcP(i: i, j: j)
        }
        return result
    }
    
    func calcR(i: Int) -> Double {
        var result = Double(rArray[i])
        var tmp = 0.0
        for j in 0 ... Int(result) { //index??
            tmp += Double(rArray[i] - j) * calcP(i: i, j: j)
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

extension CircularCalculationHelper {
    func breakDownFactorial(n: Int) -> Int {
        if n == 0 { return 1}
        else {
            return n * breakDownFactorial(n: n - 1)
        }
    }
}
