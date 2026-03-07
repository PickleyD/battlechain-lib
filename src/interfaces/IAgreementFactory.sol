// SPDX-License-Identifier: MIT
// aderyn-ignore-next-line(push-zero-opcode,unspecific-solidity-pragma)
pragma solidity ^0.8.24;

import { AgreementDetails } from "src/types/AgreementTypes.sol";

interface IAgreementFactory {
    function create(
        AgreementDetails memory details,
        address owner,
        bytes32 salt
    )
        external
        returns (address agreementAddress);

    function getRegistry() external view returns (address);

    function getBattleChainCaip2ChainId() external view returns (string memory);

    function isAgreementContract(address agreementAddress) external view returns (bool);
}
