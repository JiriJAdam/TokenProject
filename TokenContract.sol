pragma solidity >=0.4.0 <0.6.0;

contract TokenContract {
    
    address public minter;
    
    mapping(address => uint) public balances; 
    
    event Sent(address from, address to, uint amount);
    
    constructor() public {
        minter = msg.sender;
    }
    
    function mintTokens(address receiver, uint amount) public {
        require(msg.sender == minter);
        require(amount < 1e35);
        balances[receiver] += amount;
    }
    
    function sendTokens(address receiver, uint amount) public {
        require(amount <= balances[msg.sender], "insufficient balace");
        balances[msg.sender] -= amount;
        balances[receiver] += amount;
        emit Sent(msg.sender, receiver, amount);
    }
}
