// SPDX-License-Identifier: UNLICENSED
pragma solidity ^0.8.17;

//import {MultiSig} from "./MultiSig.sol";
import {MultiSig} from "./MultiSig.sol";

contract cloneMultiSig {
    MultiSig[] private _multisigs;

    event child(address _child);

    function createMultiSig(address[] memory _admins)
        public
        returns (MultiSig newMultisig)
    {
       // MultiSig newMultisig = new MultiSig(_admins, msg.sender);
        //uint256 Ballance = new Uint256;
        newMultisig = new MultiSig(_admins, msg.sender);
        _multisigs.push(newMultisig);

        emit child(address(newMultisig));
    }
}