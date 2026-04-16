# Salesforce Org Info

## Login Credentials
- **URL:** https://login.salesforce.com
- **Username:** epic.67e93bd16c85@orgfarm.salesforce.com
- **Password:** orgfarm1234

## Org Details
- **Org ID:** 00DNS00000p9Svm2AE
- **Instance URL:** https://orgfarm-769b58f81d.my.salesforce.com
- **CLI Alias:** challenge-org
- **API Version:** 66.0

## Admin User
- **User ID:** 005NS00000uenrNYAQ
- **Username:** epic.67e93bd16c85@orgfarm.salesforce.com

## Quick CLI Setup (for another terminal)
```bash
sf org login web --instance-url https://login.salesforce.com --alias challenge-org2
sf config set target-org challenge-org2 --global
```

## Key Objects

| Object | API Name | Notes |
|---|---|---|
| Financial Account | FinancialAccount | Standard FSC object |
| Top-Up Loan | Top_Up_Loan__c | Custom object |

## Top_Up_Loan__c Fields

| Field | API Name | Type |
|---|---|---|
| Status | Status__c | Picklist (Pending, Approved, Rejected) |
| Financial Account | Financial_Account__c | Lookup → FinancialAccount |
| Top-up Amount | Top_up_Amount__c | Currency |
| Approver Comments | Approver_Comments__c | String |

## FinancialAccount Key Fields

| Field | API Name | Type |
|---|---|---|
| Original Loan Amount | Original_Loan_Amount__c | Currency |
| Credit Score | Credit_Score__c | Number |
| Principal Amount | PrincipalAmount | Currency |
