public with sharing class GenerateMortgageStatement {

    @AuraEnabled
    public static String generateAndReturnBase64(Id recordId) {

        FinancialAccount fa = [
            SELECT Name, FinancialAccountNumber, Status,
                   Original_Loan_Amount__c, Interest_Rate__c, Loan_Maturity_Date__c
            FROM FinancialAccount
            WHERE Id = :recordId
            LIMIT 1
        ];

        List<FinancialAccountTransaction> transactions = [
            SELECT TransactionDate, Amount, Principal_Amount__c, Remaining_Balance__c
            FROM FinancialAccountTransaction
            WHERE FinancialAccountId = :recordId
            ORDER BY TransactionDate ASC
        ];

        String html = '<html><head><style>';
        html += 'body { font-family: Arial, sans-serif; margin: 40px; }';
        html += 'h1 { color: #2c3e50; border-bottom: 2px solid #2c3e50; padding-bottom: 10px; }';
        html += 'h2 { color: #34495e; margin-top: 30px; }';
        html += 'table { width: 100%; border-collapse: collapse; margin-top: 10px; }';
        html += 'th { background-color: #2c3e50; color: white; padding: 10px; text-align: left; }';
        html += 'td { padding: 8px 10px; border-bottom: 1px solid #ddd; }';
        html += '.detail-table td { width: 50%; }';
        html += '.detail-label { font-weight: bold; color: #555; }';
        html += '</style></head><body>';

        html += '<h1>Mortgage Statement</h1>';

        html += '<h2>Financial Account Details</h2>';
        html += '<table class="detail-table">';
        html += '<tr><td class="detail-label">Account Name</td><td>' + String.valueOf(fa.Name != null ? fa.Name : '') + '</td></tr>';
        html += '<tr><td class="detail-label">Account Number</td><td>' + String.valueOf(fa.FinancialAccountNumber != null ? fa.FinancialAccountNumber : '') + '</td></tr>';
        html += '<tr><td class="detail-label">Status</td><td>' + String.valueOf(fa.Status != null ? fa.Status : '') + '</td></tr>';
        html += '<tr><td class="detail-label">Original Loan Amount</td><td>' + (fa.Original_Loan_Amount__c != null ? String.valueOf(fa.Original_Loan_Amount__c) : '') + '</td></tr>';
        html += '<tr><td class="detail-label">Interest Rate</td><td>' + (fa.Interest_Rate__c != null ? String.valueOf(fa.Interest_Rate__c) + '%' : '') + '</td></tr>';
        html += '<tr><td class="detail-label">Maturity Date</td><td>' + (fa.Loan_Maturity_Date__c != null ? String.valueOf(fa.Loan_Maturity_Date__c) : '') + '</td></tr>';
        html += '</table>';

        html += '<h2>Payment History</h2>';
        html += '<table>';
        html += '<tr><th>Transaction Date</th><th>Total Amount</th><th>Principal Amount</th><th>Remaining Balance</th></tr>';

        for (FinancialAccountTransaction txn : transactions) {
            html += '<tr>';
            html += '<td>' + (txn.TransactionDate != null ? txn.TransactionDate.format('yyyy-MM-dd') : '') + '</td>';
            html += '<td>' + (txn.Amount != null ? String.valueOf(txn.Amount) : '') + '</td>';
            html += '<td>' + (txn.Principal_Amount__c != null ? String.valueOf(txn.Principal_Amount__c) : '') + '</td>';
            html += '<td>' + (txn.Remaining_Balance__c != null ? String.valueOf(txn.Remaining_Balance__c) : '') + '</td>';
            html += '</tr>';
        }

        html += '</table></body></html>';

        Blob pdfBlob = Blob.toPdf(html);
        return EncodingUtil.base64Encode(pdfBlob);
    }
}