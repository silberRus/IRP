﻿#language: en
@tree
@Positive
@Forms

Feature: check the display of the header of the collapsible group in documents



Background:
	Given I launch TestClient opening script or connect the existing one




Scenario: _020200 preparation
	When set True value to the constant
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create catalog Countries objects
		When Create catalog Companies objects (second company Ferron BP)
		When Create catalog Companies objects (own Second company)
		When Create catalog ExpenseAndRevenueTypes objects
		When Create catalog BusinessUnits objects
		When Create catalog Partners objects
		When Create catalog Partners objects (Kalipso)
		When Create catalog InterfaceGroups objects (Purchase and production,  Main information)
		When Create catalog ObjectStatuses objects
		When Create catalog ItemKeys objects
		When Create catalog ItemTypes objects
		When Create catalog Units objects
		When Create catalog Items objects
		When Create catalog PriceTypes objects
		When Create catalog Specifications objects
		When Create chart of characteristic types AddAttributeAndProperty objects
		When Create catalog AddAttributeAndPropertySets objects
		When Create catalog AddAttributeAndPropertyValues objects
		When Create catalog Currencies objects
		When Create catalog Companies objects (Main company)
		When Create catalog Stores objects
		When Create catalog Partners objects (Ferron BP)
		When Create catalog Partners objects (Kalipso)
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create catalog Agreements objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When Create catalog CashAccounts objects
		When update ItemKeys
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
	* Tax settings
		When filling in Tax settings for company	
	* Check or create create SalesInvoice024016 (Shipment confirmation does not used)
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		If "List" table does not contain lines Then
			| "Number" |
			| "$$NumberSalesInvoice024016$$" |
			When create SalesInvoice024016 (Shipment confirmation does not used)

Scenario: _018025 check the display of the header of the collapsible group in Purchase Order
	Given I open hyperlink "e1cib/list/Document.PurchaseOrder"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP   Status: Wait" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _018021 check the display of the header of the collapsible group in Purchase Invoice
	Given I open hyperlink "e1cib/list/Document.PurchaseInvoice"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _022017 check the display of the header of the collapsible group in Purchase Return Order
	Given I open hyperlink "e1cib/list/Document.PurchaseReturnOrder"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _022337 check the display of the header of the collapsible group in Purchase Return
	Given I open hyperlink "e1cib/list/Document.PurchaseReturn"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _020016 check the display of the header of the collapsible group in Inventory Transfer Order
	Given I open hyperlink "e1cib/list/Document.InventoryTransferOrder"
	When check the display of the header of the collapsible group in inventory transfer
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Store sender: Store 02   Store receiver: Store 03   Status: Wait" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store sender" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _021050 check the display of the header of the collapsible group in Inventory Transfer
	Given I open hyperlink "e1cib/list/Document.InventoryTransfer"
	When check the display of the header of the collapsible group in inventory transfer
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Store sender: Store 02   Store receiver: Store 03" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store sender" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _023114 check the display of the header of the collapsible group in Sales order
	* Open list form Sales order
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in sales, purchase and return documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP   Status: Approved" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _024044 check the display of the header of the collapsible group in Sales invoice
	Given I open hyperlink "e1cib/list/Document.SalesInvoice"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _028014 check the display of the header of the collapsible group in Sales return order
	Given I open hyperlink "e1cib/list/Document.SalesReturnOrder"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP   Status: Wait" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _028536 check the display of the header of the collapsible group in Sales return
	Given I open hyperlink "e1cib/list/Document.SalesReturn"
	When check the display of the header of the collapsible group in sales, purchase and return documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _028814 check the display of the header of the collapsible group in Shipment Confirmation
	Given I open hyperlink "e1cib/list/Document.ShipmentConfirmation"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _028815 check the display of the header of the collapsible group in ItemStockAdjustment
	Given I open hyperlink "e1cib/list/Document.ItemStockAdjustment"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _028908 check the display of the header of the collapsible group in Goods Receipt
	Given I open hyperlink "e1cib/list/Document.GoodsReceipt"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _028909 check the display of the header of the collapsible group in StockAdjustmentAsWriteOff
	Given I open hyperlink "e1cib/list/Document.StockAdjustmentAsWriteOff"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _028909 check the display of the header of the collapsible group in StockAdjustmentAsSurplus
	Given I open hyperlink "e1cib/list/Document.StockAdjustmentAsSurplus"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _029522 check the display of the header of the collapsible group in Bundling
	Given I open hyperlink "e1cib/list/Document.Bundling"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Store: Store 03   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows




Scenario: _029615 check the display of the header of the collapsible group in Unbundling
	Given I open hyperlink "e1cib/list/Document.Unbundling"
	When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Store: Store 03   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _050012 check the display of the header of the collapsible group in Cash receipt
	Given I open hyperlink "e1cib/list/Document.CashReceipt"
	When check the display of the header of the collapsible group in cash receipt document
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Cash account: Cash desk №2   Currency: USD   Transaction type: Payment from customer   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _051011 check the display of the header of the collapsible group in Cash payment
	Given I open hyperlink "e1cib/list/Document.CashPayment"
	When check the display of the header of the collapsible group in cash payment document
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Cash account: Cash desk №2   Currency: USD   Transaction type: Payment to the vendor   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _052012 check the display of the header of the collapsible group in Bank Receipt
	Given I open hyperlink "e1cib/list/Document.BankReceipt"
	When check the display of the header of the collapsible group in bank payments documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Account: Bank account, USD   Currency: USD   Transaction type: Payment from customer   " text	
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _053012 check the display of the header of the collapsible group in Bank payment
	Given I open hyperlink "e1cib/list/Document.BankPayment"
	When check the display of the header of the collapsible group in bank payments documents
	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Account: Bank account, USD   Currency: USD   Transaction type: Payment to the vendor   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows




# Scenario: _056006 check the display of the header of the collapsible group in Invoice Match
# 	Given I open hyperlink "e1cib/list/Document.InvoiceMatch"
# 	When check the display of the header of the collapsible group in invoice match
# 	Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Operation type: With customer   Company: Main Company   Partner: Kalipso   Legal name: Company Kalipso   Partner term: Basic Partner terms, without VAT   " text
# 	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
# 	When I Check the steps for Exception
#         |'And I click Select button of  "Company" field'|
# 	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
# 	And I close all client application windows


Scenario: _02013 check the display of the header of the collapsible group in Reconcilation statement
	Given I open hyperlink "e1cib/list/Document.ReconciliationStatement"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in sales, purchase and return documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _02014 check the display of the header of the collapsible group in PhysicalCountByLocation
	Given I open hyperlink "e1cib/list/Document.PhysicalCountByLocation"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in PhysicalCountByLocation
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Store: Store 01" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Responsible person" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _020140 check the display of the header of the collapsible group in Physical Inventory
	Given I open hyperlink "e1cib/list/Document.PhysicalInventory"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in PhysicalInventory
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Store: Store 01" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Store" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _02015 check the display of the header of the collapsible group in OpeningEntry
	Given I open hyperlink "e1cib/list/Document.OpeningEntry"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in OpeningEntry
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _02016 check the display of the header of the collapsible group in Cash expense
	Given I open hyperlink "e1cib/list/Document.CashExpense"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in expence/revenue documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Account: Bank account, TRY" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _02017 check the display of the header of the collapsible group in CreditNote
	Given I open hyperlink "e1cib/list/Document.CreditNote"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in OpeningEntry
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _02021 check the display of the header of the collapsible group in DebitNote
	Given I open hyperlink "e1cib/list/Document.DebitNote"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in OpeningEntry
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows



Scenario: _02018 check the display of the header of the collapsible group in Internal supply request
	Given I open hyperlink "e1cib/list/Document.InternalSupplyRequest"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in Shipment confirmation, Goods receipt, Bundling/Unbundling
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains " Company: Main Company   Store: Store 03   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _02019 check the display of the header of the collapsible group in OutgoingPaymentOrder
	Given I open hyperlink "e1cib/list/Document.OutgoingPaymentOrder"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in bank payments documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Account: Bank account, USD   Currency: USD   Status: Wait   " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _02020 check the display of the header of the collapsible group in IncomingPaymentOrder
	Given I open hyperlink "e1cib/list/Document.IncomingPaymentOrder"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in bank payments documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Account: Bank account, USD   Currency: USD " text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows


Scenario: _023121 check the display of the header of the collapsible group in Retail sales receipt
	* Open list form Sales order
		Given I open hyperlink "e1cib/list/Document.RetailSalesReceipt"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in sales, purchase and return documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _023122 check the display of the header of the collapsible group in Retail return receipt
	* Open list form Sales order
		Given I open hyperlink "e1cib/list/Document.RetailReturnReceipt"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in sales, purchase and return documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _02023 check the display of the header of the collapsible group in PlannedReceiptReservation
	Given I open hyperlink "e1cib/list/Document.PlannedReceiptReservation"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in OpeningEntry
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Company" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _023124 check the display of the header of the collapsible group in Sales order closing
	* Open list form Sales order closing
		Given I open hyperlink "e1cib/list/Document.SalesOrderClosing"
	* Check the display of the header of the collapsible group
		When check the display of the header of the collapsible group in sales, purchase and return documents
		Then the field named "DecorationGroupTitleUncollapsedLabel" value contains "Company: Main Company   Partner: Ferron BP   Legal name: Company Ferron BP" text
	And I click the hyperlink named "DecorationGroupTitleUncollapsedLabel"
	When I Check the steps for Exception
        |'And I click Select button of  "Partner" field'|
	And I click the hyperlink named "DecorationGroupTitleCollapsedPicture"
	And I close all client application windows

Scenario: _999999 close TestClient session
	And I close TestClient session