pragma solidity >=0.7.0  < 0.9.0;

import "@openzeppelin/contracts/token/ERC20/ERC20.sol";
import "@openzeppelin/contracts/access/Ownable.sol";

contract BremToken is Ownable, ERC20 {
    
    constructor() ERC20("BremToken", "BRE") {}
    
    function mint(address account, uint256 amount) public onlyOwner {
        _mint(account, amount);
    }
}
