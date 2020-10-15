contract InstaClaimer{
    
    PeriodicStaker public staker;
    uint public tot;
    mapping(address => bool) rewarded;
    
    constructor() public{
        staker=PeriodicStaker(0x6d2813951911a16d3a23A9e40342e15eEf6Cc2e8);
        tot=staker.total_stake();
    }
    
 
    function instaClaim() public returns(bool){
        require(staker.status()==0);
        uint s=staker.stake(msg.sender);
        require(s>0);
        require(!rewarded[msg.sender]);
        rewarded[msg.sender]=true;
        require(ERC20(0x722dd3F80BAC40c951b51BdD28Dd19d435762180).transfer(msg.sender, 3000000000000000000/(tot*1000/s)*1000));
        return true;
    } 
    
}
