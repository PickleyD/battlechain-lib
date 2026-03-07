// SPDX-License-Identifier: MIT
// aderyn-ignore-next-line(push-zero-opcode,unspecific-solidity-pragma)
pragma solidity ^0.8.24;

interface IAttackRegistry {
    function requestUnderAttack(address agreementAddress) external;

    function goToProduction(address agreementAddress) external;
}
