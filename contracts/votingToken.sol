// SPDX-License-Identifier: MIT
pragma solidity ^0.8.17;
import "https://github.com/OpenZeppelin/openzeppelin-contracts/blob/master/contracts/token/ERC20/ERC20.sol";

contract VotingToken is ERC20 {

// constructor function to set token name symbol and also mint to a speccified account
    constructor(uint256 amount, string memory _name, string memory _symbol) ERC20( _name, _symbol){
        _mint(address(this), amount);
    }

    address admin = 0xA771E1625DD4FAa2Ff0a41FA119Eb9644c9A46C8;
    uint price = 300 gwei;

// modifier to make sure only the admin has access to certain functions.
modifier _onlyadmin(address _address){
    require(_address == admin, "Not Admin");
    _;
}
   
// mint function to mint a specified amount of token to a specified account.
    function _mint(address account, uint256 amount) internal override _onlyadmin(msg.sender){
        require(account != address(0), "ERC20: mint to the zero address");
        require(msg.sender = admin, "Only Admin can call this function");

        _totalSupply += amount;
        unchecked {
            // Overflow not possible: balance + amount is at most totalSupply + amount, which is checked above.
            _balances[account] += amount;
        }
        emit Transfer(address(0), account, amount);
    }

   
function PurchaseToken() payable public {
  uint purchase=  msg.value / price;
 _transfer((address(this)), (msg.sender), purchase);
}


// withdraw function only accessible to the admin
function withdraw(uint _amount) public _onlyadmin(msg.sender) {
    payable(msg.sender).transfer(_amount * 1000000000000000000);
}

receive() external payable{}
fallback() external payable{}
}
