pragma solidity^0.5.0;


contract KYC {

    struct Customer {
        string username;
        string dataHash;
        address bankAddress;
        uint upvotes;
        uint rating;
    }

    struct Bank {
        string name;
        address ethAddress;
        uint ratings;
        uint kycCount;
        string regNumber;
    }

    struct Request {
        string username;
        string dataHash;
        address bankAddress;
        bool isAllowed;
    }

    address admin;

    /*mapping(address => Customer) private customers;
    mapping(address => Bank) private banks;
    mapping(address => Request) private requests;*/
    
    mapping(string => Customer) private customers;
    mapping(string => Request) private requests;
    mapping(string => Bank) private banks;
    
    /*Customer[] public uniqCid;
    Bank[] public banks;
    Request[] public uniqRid;
    Request[] public validKyc;*/

    constructor() public {
        admin = msg.sender;
    }
    modifier onlyAdmin {
        require(msg.sender == admin);
        _;
    }
    function addCustomer(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        require(!isEmpty(_dataHash), 'dataHash required');
        
        if(!isEmpty(customers[_username].dataHash)) {
            revert('already exists');
        }
        Customer memory customer = Customer(_username, _dataHash, msg.sender, 0, 0);
        customers[_username] = customer;
        return 1;
    }
    
    function modifyCustomer(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        require(!isEmpty(_dataHash), 'dataHash required');
        
        if(isEmpty(customers[_username].dataHash)) {
            revert('user not found');
        }
        
        customers[_username].dataHash = _dataHash;
        return 1;
    }
    
    function deleteCustomer(string memory _username) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        
        if(isEmpty(customers[_username].dataHash)) {
            revert('user not found');
        }
        delete customers[_username];
        return 1;
    }
    
    function addRequest(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username),'username required');
        require(!isEmpty(_dataHash), 'dataHash required');
        
        if(!isEmpty(requests[_username].dataHash)) {
            revert('already exists');
        }
        Request memory request = Request(_username, _dataHash, msg.sender, false);
        requests[_username] = request;
        return 1;
    }
    
    function modifyRequest(string memory _username, string memory _dataHash) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        require(!isEmpty(_dataHash), 'dataHash required');

        if(isEmpty(requests[_username].dataHash)){
            revert('request not found');
        }

        requests[_username].dataHash = _dataHash;
        return 1;
    }
    
    function deleteRequest(string memory _username) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        
        if(isEmpty(requests[_username].dataHash)){
            revert('request not found');
        }

        delete requests[_username];
        return 1;
           
    }

    function upvote(string memory _username) public returns (uint) {
        require(!isEmpty(_username), 'username required');
        
        if(isEmpty(customers[_username].dataHash)){
            revert('customer not found');
        }
        customers[_username].upvotes++;
        return 1;

    } 

    function addBank(string memory _bankName, address _bankAddress, string memory _regNumber) public onlyAdmin returns (uint) {
        require(!isEmpty(_bankName), 'bank name required');
        require(!isEmpty(_regNumber), 'register no. required');

        Bank memory bank = Bank(_bankName, _bankAddress, 0, 0, _regNumber);
        banks[_bankName] = bank;
        return 1;
    }

    function removeBank(string memory _bankName) public onlyAdmin returns (uint) {
        require(!isEmpty(_bankName), 'bank name required');

        if(isEmpty(banks[_bankName].name)){
            revert('bank not found');
        }

        delete banks[_bankName];
        return 1;
    }
    
    /*Helper Functions*/

    function equalsTo(string memory _param1, string memory _param2) internal pure returns (bool) {
        bytes memory param1 = bytes(_param1);
        bytes memory param2 = bytes(_param2);

        if(param1.length != param2.length) {
            return false;
        }

        for(uint i=0; i< param1.length; i++) {
            if(param1[i] != param2[i]) 
                return false;
        }
        return true;
    }

    function isEmpty(string memory _param1) internal pure returns (bool) {
        bytes memory param1 = bytes(_param1);
        if(param1.length == 0)
            return true;
        return false;
    }

}
