# 🗳️ Block-Ballot

A blockchain-based decentralized voting application built using Solidity (smart contracts), React (frontend), Web3.js, and MetaMask for Ethereum account management.

## 🚀 Features

- ✅ Admin (contract deployer) can:

  - Start and end the election
  - Add candidates and voters

- ✅ Voters can:

  - Vote only once
  - View candidates and their vote counts (after voting ends)

- 🔐 Role-based access:

  - Admin (`role = 1`)
  - Voter (`role = 2`)
  - Unauthorized users (`role = 3`) are denied access

## 💠 Tech Stack

- **Frontend**: React, Material UI
- **Smart Contract**: Solidity
- **Blockchain Framework**: Truffle
- **Web3 Integration**: Web3.js + MetaMask
- **Package Manager**: Yarn

---

## 📦 Installation

1. **Clone the repository**

   ```bash
   git clone https://github.com/vlalit834/BlockBallot-IIIT-A.git
   cd your-repo-name
   ```

2. **Install frontend dependencies**

   ```bash
   yarn install
   ```

3. **Start the frontend**

   ```bash
   yarn start
   ```

4. **Deploy smart contract**

   Make sure [Truffle](https://trufflesuite.com/docs/truffle/quickstart/) and [Ganache](https://trufflesuite.com/ganache/) are installed.

   ```bash
   truffle compile
   truffle migrate --reset
   ```

5. **Connect MetaMask**

   - Open your browser and unlock MetaMask.
   - Switch MetaMask network to the same local network (e.g., Ganache).
   - Use the **first account** (Ganache default) to deploy — this is the Admin.
   - If you're using another account, have Admin call `addVoter(address)` for it.

---

## 👤 User Roles

| Role       | Description                       |
| ---------- | --------------------------------- |
| **Admin**  | Contract deployer. Full access.   |
| **Voter**  | Can vote once during election.    |
| **Others** | Unauthorized. View access denied. |

The role is determined automatically via the smart contract's `getRole()` function.

---

## 🔐 Security

- All voting actions are recorded on the blockchain.
- Voters can only vote once.
- Only Admin can manage election phases and participants.

---

## 🧠 Future Improvements

- Election result visualization (charts)
- Voter registration via form
- IPFS integration for identity proof
-Zero-Knowledge Proofs for Privacy-Preserving Voting
