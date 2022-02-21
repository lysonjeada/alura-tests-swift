//
//  LeilaoTests.swift
//  LeilaoTests
//
//  Created by Ândriu Coelho on 27/04/18.
//  Copyright © 2018 Alura. All rights reserved.
//

import XCTest
@testable import Leilao

class LeilaoTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testDeveReceberUmLance() {
        let leilao = Leilao(descricao: "Playstation 5")
        XCTAssertEqual(0, leilao.lances?.count)
        
        let lucas = Usuario(nome: "Lucas")
        leilao.propoe(lance: Lance(lucas, 2000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveReceberVariosLances() {
        let leilao = Leilao(descricao: "Macbook Pro 16")
        
        let leticia = Usuario(nome: "Leticia")
        leilao.propoe(lance: Lance(leticia, 2000))
        
        let diego = Usuario(nome: "Diego")
        leilao.propoe(lance: Lance(diego, 3000))
        
        XCTAssertEqual(2, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
        XCTAssertEqual(3000, leilao.lances?[1].valor)
    }
    
    func testDeveIgnorarDoisLancesSeguidosDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro 16")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(maria, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        XCTAssertEqual(1, leilao.lances?.count)
        XCTAssertEqual(2000, leilao.lances?.first?.valor)
    }
    
    func testDeveIgnorarMaisDoQue5LancesDoMesmoUsuario() {
        let leilao = Leilao(descricao: "Macbook Pro 16 - M1")
        
        let joao = Usuario(nome: "Joao")
        let maria = Usuario(nome: "Maria")
        
        leilao.propoe(lance: Lance(joao, 2000))
        leilao.propoe(lance: Lance(maria, 3000))
        
        leilao.propoe(lance: Lance(joao, 4000))
        leilao.propoe(lance: Lance(maria, 5000))
        
        leilao.propoe(lance: Lance(joao, 6000))
        leilao.propoe(lance: Lance(maria, 7000))
        
        leilao.propoe(lance: Lance(joao, 8000))
        leilao.propoe(lance: Lance(maria, 9000))
        
        leilao.propoe(lance: Lance(joao, 10000))
        leilao.propoe(lance: Lance(maria, 11000))
        
        leilao.propoe(lance: Lance(joao, 12000))
        
        XCTAssertEqual(10, leilao.lances?.count)
        XCTAssertEqual(11000, leilao.lances?.last?.valor)
    }

    
}
