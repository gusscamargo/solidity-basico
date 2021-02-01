pragma solidity 0.5.3;

library SafeMath{
     function sum(uint a, uint b) internal pure returns(uint){
        uint c = a + b;
        require(c >= a, "Sum Overflow!");

         
        return c;
    }

    function sub(uint a, uint b) internal pure returns(uint) {
        require(b <= a, "Sub Underflow");
        uint c = a - b;

        return c;
    }

    function mul(uint a, uint b) internal pure returns(uint){
        if(a == 0){
            return 0;
        }

        uint c = a * b;
        require(c / a == b, "Mul Overflow!");
        
        return c;
    }

    function div(uint a, uint b) internal pure returns(uint){
        uint c = a / b;
        
        return c;
    }
}

contract Ownable{
    address payable public owner;

    event OwnershipTransferred(address newOwner);

     constructor() public{
        owner = msg.sender;
    }

    modifier onlyOwner() {
        require(msg.sender == owner, "You are not the owner!");
        _;
    }

    function transferOwnership(address payable newOwner) onlyOwner public{
        owner = newOwner;

        emit OwnershipTransferred(owner);
    }

}



contract Contrato is Ownable{
    using SafeMath for uint;

    string public text;
    uint8 public number;
    uint public price = 25 finney;

    event changeValue(uint totalValue);

    function setNumber(uint n) public payable{      
        require(n >= 0 || n <= 10, "setNumber error: Out of scope number");
        require(msg.value >= price, "Insufficient ETH send!");

        if(n > 5){
            text = "É maior que cinco!";
        }else if(n <= 5){
            text = "É menor ou igual a cinco!";
        }

        uint8 temp = uint8(n);
        number = temp;

        doublePrice();  
    }

    function doublePrice() private {
        price = price.mul(2);

        emit changeValue(price);
    }
    
    function withdraw() onlyOwner public{
        require(address(this).balance > 0, "Insufficient founds.");

        owner.transfer(address(this).balance);
    }

    function withdraw(uint value) onlyOwner public{
        require(address(this).balance > 0 && value <= address(this).balance, "Insufficient founds.");

        owner.transfer(value);
    }
    
}