
contract InstaClaimer{
    
    PeriodicStaker public staker;
    ItemsGifterDB public gifter;
    uint public tot;
    mapping(address => bool) rewarded;
    
    constructor() public{
        staker=PeriodicStaker(0x7d410AFA45377006A0F79Ae6157A6A873Bfa5567);
        gifter=ItemsGifterDB(0xC9746af16e5d5cc414eDF53f91cBA76e6Eaf739D);
        tot=staker.total_stake();
    }
 
    function instaClaim() public returns(bool){
        require(staker.status()==2);
        require(staker.stake(msg.sender)>0);
        require(!rewarded[msg.sender]);
        rewarded[msg.sender]=true;
        require(ERC20(0x801F90f81786dC72B4b9d51Ab613fbe99e5E4cCD).transfer(msg.sender, 30000000000000000000/(staker.total_stake()/staker.stake(msg.sender))));
        return true;
    } 
    
}
