protocol CalculationHelper {
    var pArray:[Double] {get set}
    
    func calcC_N(at index: Int) -> Double
    
    func calcL(i: Int) -> Double
    
    func calcR(i: Int) -> Double
    
    func calcM(i: Int) -> Double
    
    func calcLamb(i: Int) -> Double
    
    func calcT(i: Int) -> Double
    
    func calcQ(i: Int) -> Double
}
