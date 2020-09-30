/* 
 *  Ticket 1.0
 *  VERSION: 1.0
 *
 */

pragma solidity ^0.6.0;


contract ERC20{
    function allowance(address owner, address spender) external view returns (uint256){}
    function transfer(address recipient, uint256 amount) external returns (bool){}
    function transferFrom(address sender, address recipient, uint256 amount) external returns (bool){}
    function balanceOf(address account) external view returns (uint256){}
}


contract HappyBox{
    
    event Gifted(address gifted);
    
    address[] public modules_list;
    mapping(address => bool)public modules;
    
    ERC20 public token;
    address master;
    address public receiver;
    
    constructor() public{
        master=msg.sender;
    }
    
    function gift(address tkn,uint amount,address gifted) public returns(bool){
        require(modules[msg.sender]);
        ERC20 token=ERC20(tkn);
        require(token.transfer(gifted, amount));
        emit Gifted(gifted);
        return true;
    } 
    
    
    //mode 1 = install module
    //mode 2 = set master
    //mode 3 = enable module
    //mode 4 = pull token
    function move(address tkn,bool what,uint mode)public{
        require(msg.sender==master);
        if(mode==1){
            modules[tkn]=true;
            modules_list.push(tkn);
        }else if(mode==2){
               master=tkn;
        }else if(mode==3){
            modules[tkn]=what;
        }else if(mode==4){
            ERC20 token=ERC20(tkn);
            token.transfer(master, token.balanceOf(address(this)));
        }
    }
}
