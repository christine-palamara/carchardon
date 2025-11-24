public with sharing class InvoiceLineCreator {
    /**
     * Creates an Invoice_Line__c detail record for the provided Invoice__c master record.
     *
     * @param invoiceId  Id of the Invoice__c master record.
     * @param productName Name for the invoice line (stored in the Name field).
     * @param unitPrice  Unit price for the line item.
     * @param quantity   Quantity for the line item.
     * @return Id of the newly created Invoice_Line__c record.
     */
    public static Id createInvoiceLine(Id invoiceId, String productName, Decimal unitPrice, Integer quantity) {
        if (invoiceId == null) {
            throw new IllegalArgumentException('An Invoice__c Id is required to create a detail record.');
        }
        if (String.isBlank(productName)) {
            throw new IllegalArgumentException('A product name is required for the invoice line.');
        }
        if (quantity == null || quantity <= 0) {
            throw new IllegalArgumentException('Quantity must be greater than zero.');
        }

        Invoice_Line__c invoiceLine = new Invoice_Line__c(
            Invoice__c = invoiceId,
            Name = productName,
            Unit_Price__c = unitPrice,
            Quantity__c = quantity,
            Total__c = (unitPrice != null && quantity != null) ? unitPrice * quantity : null
        );

        insert invoiceLine;
        return invoiceLine.Id;
    }
}
