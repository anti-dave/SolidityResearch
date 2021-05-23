pragma solidity >=0.5.0 <0.6.0;
//pragma solidity ^0.8.4;

contract UserFactory {

    event NewUser(uint userId, string name, uint dna);

    uint uuidDig = 16;
    uint uuidmod = 10 ** uuidDig;

    struct User {
        string name;
        uint uuid;
    }

    mapping (uint => address) public zombieToOwner;
    mapping (address => uint) ownerZombieCount;
    
    User[] public users;

    function _createUser(string memory _name, uint _uuid) private {
        uint id = users.push(User(_name, _uuid)) - 1;
        emit NewUser(id, _name, _uuid);
    }

    function _generateRandomUUID(string memory _str) private view returns (uint) {
         uint rand = uint(keccak256(abi.encodePacked(_str)));
         return rand % uuidmod;
    }

     function createRandomZombie(string memory _name) public {
        uint randUUID = _generateRandomUUID(_name);
        _createUser(_name, randUUID);
     }

}