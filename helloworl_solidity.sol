// SPDX-License-Identifier: MIT
pragma solidity 0.8.34;

contract HelloWorld {
  //Crea la estructura Persona
  struct Persona {
    string nombre;
    uint8 edad;
  }
  mapping (address => Persona) public people;

  //
  address[] public personasReg;

  //Registrar Persona
  function crear_persona(string calldata _nombre, uint8 _edad) public noreg() nnot0(_nombre) enot0(_edad){
    Persona storage persona = people[msg.sender];
    persona.nombre = _nombre;
    persona.edad = _edad;
    //borrar al final
    personasReg.push(msg.sender);
  }
  //se asegura de que los datos no estén vacíos para poder registrarlos
  modifier nnot0(string calldata _nombre){
    require(bytes(_nombre).length > 0, "Necesita ingresar un nombre");
    _;
  }
  modifier enot0(uint8 _edad){
    require(_edad != 0, "Necesita ingresar una edad");
    _;
  }

  //que el usuario/account no esté registrado ya
  modifier noreg(){
    require(bytes(people[msg.sender].nombre).length == 0, "Esta cuenta ya esta registrada");
    //no se pueden usar acentos, no sabia eso
    _;
  }

  //Saludo
  function saludar() public view returns (string memory){
    return string.concat("Hola ", people[msg.sender].nombre);
    //saluda a la cuenta "account" que hayas seleccionado
  }


  //disjdfig verificanding si se registran
  function leertodo() public view returns (Persona[] memory){
    Persona[] memory personas = new Persona[](personasReg.length);
    for (uint i = 0; i < personasReg.length; i++){
      personas[i] = people[personasReg[i]];
    }
    return personas;
  }
  
}
//Esto cumple con lo mínimo creo
//espero haver subido bien esto, le batallo mucho a subir cosas en github, siempre olvido como se hace lol
