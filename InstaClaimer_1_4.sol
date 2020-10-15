contract InstaClaimer{
    
    PeriodicStaker public staker;
    uint public tot;
    mapping(address => bool) rewarded;
    
    constructor() public{
        staker=PeriodicStaker(0x7d410AFA45377006A0F79Ae6157A6A873Bfa5567);
        tot=staker.total_stake();
    }
 
    function instaClaim() public returns(bool){
        require(staker.status()==2);
        uint s=staker.stake(msg.sender);
        require(s>0);
        require(!rewarded[msg.sender]);
        rewarded[msg.sender]=true;
        require(ERC20(0x801F90f81786dC72B4b9d51Ab613fbe99e5E4cCD).transfer(msg.sender, 30000000000000000000/(tot/s)));
        return true;
    } 
    
}
