// SPDX-License-Identifier: MIT
// aderyn-ignore-next-line(push-zero-opcode,unspecific-solidity-pragma)
pragma solidity ^0.8.24;

/// @notice Registry of chains where CreateX is deployed at the well-known address.
/// Source: https://github.com/pcaversaccio/createx#createx-deployments
/// Well-known address: 0xba5Ed099633D3B313e4D5F7bdc1305d3c28ba5Ed (same on all chains)
library CreateXChains {
    function isSupported(uint256 chainId) internal pure returns (bool) {
        return _isProductionChain(chainId) || _isTestChain(chainId);
    }

    // solhint-disable-next-line function-max-lines
    function _isProductionChain(uint256 chainId) private pure returns (bool) {
        // @formatter:off
        return chainId == 1             // Ethereum
            || chainId == 10            // Optimism
            || chainId == 25            // Cronos
            || chainId == 40            // Telos
            || chainId == 42            // LUKSO
            || chainId == 50            // XDC Network
            || chainId == 56            // BNB Smart Chain
            || chainId == 100           // Gnosis Chain
            || chainId == 122           // Fuse Network
            || chainId == 130           // Unichain
            || chainId == 137           // Polygon
            || chainId == 143           // Monad
            || chainId == 146           // Sonic
            || chainId == 169           // Manta Pacific
            || chainId == 196           // X Layer
            || chainId == 204           // opBNB
            || chainId == 232           // Lens
            || chainId == 239           // TAC
            || chainId == 250           // Fantom
            || chainId == 252           // Fraxtal
            || chainId == 288           // Boba Network
            || chainId == 314           // Filecoin
            || chainId == 324           // ZKsync Era
            || chainId == 360           // Shape
            || chainId == 480           // World Chain
            || chainId == 648           // Endurance
            || chainId == 747           // EVM on Flow
            || chainId == 841           // Taraxa
            || chainId == 995           // 5ireChain
            || chainId == 999           // HyperEVM
            || chainId == 1088          // Metis Andromeda
            || chainId == 1101          // Polygon zkEVM
            || chainId == 1116          // Core
            || chainId == 1135          // Lisk
            || chainId == 1155          // Intuition
            || chainId == 1284          // Moonbeam
            || chainId == 1285          // Moonriver
            || chainId == 1329          // Sei
            || chainId == 1514          // Story
            || chainId == 1625          // Gravity Alpha
            || chainId == 1750          // Metal L2
            || chainId == 1868          // Soneium
            || chainId == 1890          // LightLink Phoenix
            || chainId == 1923          // Swellchain
            || chainId == 2020          // Ronin
            || chainId == 2222          // Kava
            || chainId == 2741          // Abstract
            || chainId == 2818          // Morph
            || chainId == 2911          // HYCHAIN
            || chainId == 3637          // Botanix
            || chainId == 4114          // Citrea
            || chainId == 4162          // SX Network
            || chainId == 4326          // MegaETH
            || chainId == 4352          // MemeCore
            || chainId == 4689          // IoTeX
            || chainId == 5000          // Mantle
            || chainId == 5330          // Superseed
            || chainId == 7000          // ZetaChain
            || chainId == 7700          // Canto
            || chainId == 7897          // Arena-Z
            || chainId == 7979          // DOS Chain
            || chainId == 8217          // Kaia
            || chainId == 8453          // Base
            || chainId == 9001          // Evmos
            || chainId == 9745          // Plasma
            || chainId == 13_371        // Immutable zkEVM
            || chainId == 17_771        // DMD Diamond
            || chainId == 23_294        // Oasis Sapphire
            || chainId == 33_139        // ApeChain
            || chainId == 34_443        // Mode
            || chainId == 42_161        // Arbitrum One
            || chainId == 42_170        // Arbitrum Nova
            || chainId == 42_220        // Celo
            || chainId == 42_793        // Etherlink
            || chainId == 43_111        // Hemi
            || chainId == 43_114        // Avalanche
            || chainId == 48_900        // Zircuit
            || chainId == 50_104        // Sophon
            || chainId == 57_073        // Ink
            || chainId == 59_144        // Linea
            || chainId == 60_808        // BOB
            || chainId == 80_094        // Berachain
            || chainId == 81_457        // Blast
            || chainId == 88_888        // Chiliz
            || chainId == 98_866        // Plume
            || chainId == 167_000       // Taiko Alethia
            || chainId == 200_901       // Bitlayer
            || chainId == 534_352       // Scroll
            || chainId == 747_474       // Katana
            || chainId == 1_440_000     // XRPL EVM
            || chainId == 5_734_951     // Jovay
            || chainId == 7_777_777     // Zora
            || chainId == 21_000_000    // Corn Maizenet
            || chainId == 1_313_161_554 // Aurora
            || chainId == 1_666_600_000 // Harmony
        ;
        // @formatter:on
    }

    // solhint-disable-next-line function-max-lines
    function _isTestChain(uint256 chainId) private pure returns (bool) {
        // @formatter:off
        return chainId == 31            // Rootstock Testnet
            || chainId == 41            // Telos Testnet
            || chainId == 51            // XDC Testnet (Apothem)
            || chainId == 97            // BNB Smart Chain Testnet
            || chainId == 111           // BOB Sepolia Testnet
            || chainId == 195           // X Layer Sepolia Testnet
            || chainId == 300           // ZKsync Era Sepolia Testnet
            || chainId == 338           // Cronos Testnet
            || chainId == 842           // Taraxa Testnet
            || chainId == 919           // Mode Sepolia Testnet
            || chainId == 997           // 5ireChain Testnet
            || chainId == 998           // HyperEVM Testnet
            || chainId == 1115          // Core Testnet
            || chainId == 1287          // Moonbeam Testnet (Moonbase Alpha)
            || chainId == 1301          // Unichain Sepolia Testnet
            || chainId == 1315          // Story Testnet (Aeneid)
            || chainId == 1328          // Sei Atlantic Testnet
            || chainId == 1442          // Polygon Testnet (zkEVM)
            || chainId == 1740          // Metal L2 Sepolia Testnet
            || chainId == 1891          // LightLink Testnet (Pegasus)
            || chainId == 1924          // Swellchain Sepolia Testnet
            || chainId == 1946          // Soneium Sepolia Testnet (Minato)
            || chainId == 2021          // Ronin Testnet (Saigon)
            || chainId == 2391          // TAC Testnet (Saint Petersburg)
            || chainId == 2523          // Fraxtal Hoodi Testnet
            || chainId == 2910          // Morph Hoodi Testnet
            || chainId == 3636          // Botanix Testnet
            || chainId == 3939          // DOS Chain Testnet
            || chainId == 4002          // Fantom Testnet
            || chainId == 4201          // LUKSO Testnet
            || chainId == 4202          // Lisk Sepolia Testnet
            || chainId == 4690          // IoTeX Testnet
            || chainId == 4801          // World Chain Sepolia Testnet
            || chainId == 5003          // Mantle Sepolia Testnet
            || chainId == 5115          // Citrea Testnet
            || chainId == 5611          // opBNB Testnet
            || chainId == 6343          // MegaETH Testnet
            || chainId == 7001          // ZetaChain Testnet (Athens-3)
            || chainId == 7701          // Canto Testnet
            || chainId == 9000          // Evmos Testnet
            || chainId == 9746          // Plasma Testnet
            || chainId == 9897          // Arena-Z Sepolia Testnet
            || chainId == 10_143        // Monad Testnet
            || chainId == 10_200        // Gnosis Chain Testnet (Chiado)
            || chainId == 11_011        // Shape Sepolia Testnet
            || chainId == 11_124        // Abstract Sepolia Testnet
            || chainId == 13_473        // Immutable zkEVM Sepolia Testnet
            || chainId == 13_579        // Intuition Sepolia Testnet
            || chainId == 29_112        // HYCHAIN Testnet
            || chainId == 31_337        // Anvil (local)
            || chainId == 33_111        // ApeChain Sepolia Testnet (Curtis)
            || chainId == 37_111        // Lens Sepolia Testnet
            || chainId == 37_373        // DMD Diamond Testnet
            || chainId == 42_431        // Tempo Testnet (Moderato)
            || chainId == 43_113        // Avalanche Testnet (Fuji)
            || chainId == 43_522        // MemeCore Testnet (Insectarium)
            || chainId == 53_302        // Superseed Sepolia Testnet
            || chainId == 57_054        // Sonic Testnet (Blaze)
            || chainId == 59_141        // Linea Sepolia Testnet
            || chainId == 59_902        // Metis Sepolia Testnet
            || chainId == 80_002        // Polygon Sepolia Testnet (Amoy)
            || chainId == 80_069        // Berachain Testnet (Bepolia)
            || chainId == 84_532        // Base Sepolia Testnet
            || chainId == 88_882        // Chiliz Testnet (Spicy)
            || chainId == 127_823       // Etherlink Testnet (Shadownet)
            || chainId == 167_013       // Taiko Hoodi Testnet
            || chainId == 200_810       // Bitlayer Testnet
            || chainId == 314_159       // Filecoin Testnet (Calibration)
            || chainId == 421_614       // Arbitrum Sepolia Testnet
            || chainId == 534_351       // Scroll Sepolia Testnet
            || chainId == 560_048       // Hoodi
            || chainId == 713_715       // Sei Arctic Devnet
            || chainId == 737_373       // Katana Sepolia Testnet (Bokuto)
            || chainId == 743_111       // Hemi Sepolia Testnet
            || chainId == 763_373       // Ink Sepolia Testnet
            || chainId == 1_449_000     // XRPL EVM Testnet
            || chainId == 2_019_775     // Jovay Sepolia Testnet
            || chainId == 3_441_006     // Manta Pacific Sepolia Testnet
            || chainId == 5_042_002     // Arc Testnet
            || chainId == 11_142_220    // Celo Sepolia Testnet
            || chainId == 11_155_111    // Sepolia
            || chainId == 11_155_420    // Optimism Sepolia Testnet
            || chainId == 21_000_001    // Corn Sepolia Testnet
            || chainId == 79_479_957    // SX Network Sepolia Testnet (Toronto)
            || chainId == 168_587_773   // Blast Sepolia Testnet
            || chainId == 531_050_104   // Sophon Sepolia Testnet
            || chainId == 999_999_999   // Zora Sepolia Testnet
            || chainId == 1_313_161_555 // Aurora Testnet
            || chainId == 1_666_700_000 // Harmony Testnet
        ;
        // @formatter:on
    }
}
