import { LightningElement, api } from 'lwc';
import generatePDF from '@salesforce/apex/GenerateMortgageStatement.generateAndReturnBase64';

export default class MortgageStatementDownload extends LightningElement {
    @api recordId;

    isLoading = false;
    errorMessage = '';

    get buttonLabel() {
        return this.isLoading ? 'Generating...' : 'Download Payment History';
    }

    async handleDownload() {
        this.isLoading = true;
        this.errorMessage = '';

        try {
            const base64Data = await generatePDF({ recordId: this.recordId });

            const link = document.createElement('a');
            link.href = 'data:application/pdf;base64,' + base64Data;
            link.download = 'Mortgage_Statement.pdf';
            document.body.appendChild(link);
            link.click();
            document.body.removeChild(link);

        } catch (error) {
            console.error('PDF generation failed:', error);
            this.errorMessage = error?.body?.message || 'Failed to generate PDF. Please try again.';
        } finally {
            this.isLoading = false;
        }
    }
}