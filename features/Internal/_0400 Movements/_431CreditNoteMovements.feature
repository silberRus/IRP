﻿#language: en
@tree
@Positive
@Movements
@MovementsCreditNote

Feature: check Credit note movements



Background:
	Given I launch TestClient opening script or connect the existing one



Scenario: _043100 preparation (Credit note)
	When set True value to the constant
	And I close TestClient session
	Given I open new TestClient session or connect the existing one
	* Load info
		When Create information register Barcodes records
		When Create catalog Companies objects (own Second company)
		When Create catalog Agreements objects
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
		When Create catalog Partners objects
		When Create catalog Companies objects (partners company)
		When Create information register PartnerSegments records
		When Create catalog PartnerSegments objects
		When Create chart of characteristic types CurrencyMovementType objects
		When Create catalog TaxRates objects
		When Create catalog Taxes objects	
		When Create information register TaxSettings records
		When Create information register PricesByItemKeys records
		When Create catalog IntegrationSettings objects
		When Create information register CurrencyRates records
		When Create catalog BusinessUnits objects
		When Create catalog LegalNameContracts objects
		When Create catalog ExpenseAndRevenueTypes objects
		When Create catalog Companies objects (second company Ferron BP)
		When Create catalog PartnersBankAccounts objects
		When update ItemKeys
		When Create catalog SerialLotNumbers objects
		When Create catalog CashAccounts objects
	* Add plugin for taxes calculation
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "TaxCalculateVAT_TR" |
			When add Plugin for tax calculation
		When Create information register Taxes records (VAT)
	* Tax settings
		When filling in Tax settings for company
	When Create Document discount
	* Add plugin for discount
		Given I open hyperlink "e1cib/list/Catalog.ExternalDataProc"
		If "List" table does not contain lines Then
				| "Description" |
				| "DocumentDiscount" |
			When add Plugin for document discount
			When Create catalog CancelReturnReasons objects
	* Load documents
		Given I open hyperlink "e1cib/list/Document.PurchaseOrder"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '115' |
			When Create document PurchaseOrder objects (check movements, GR before PI, Use receipt sheduling)
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseOrder.FindByNumber(115).GetObject().Write(DocumentWriteMode.Posting);" |
		Given I open hyperlink "e1cib/list/Document.PurchaseInvoice"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '115' |
			| '116' |
			When Create document PurchaseInvoice objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.PurchaseInvoice.FindByNumber(115).GetObject().Write(DocumentWriteMode.Posting);" |
				| "Documents.PurchaseInvoice.FindByNumber(116).GetObject().Write(DocumentWriteMode.Posting);" |
		Given I open hyperlink "e1cib/list/Document.GoodsReceipt"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '115' |
			| '116' |
			When Create document GoodsReceipt objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.GoodsReceipt.FindByNumber(115).GetObject().Write(DocumentWriteMode.Posting);" |
				| "Documents.GoodsReceipt.FindByNumber(116).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document CreditNote objects (check movements)
		And I execute 1C:Enterprise script at server
				| "Documents.CreditNote.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
				| "Documents.CreditNote.FindByNumber(2).GetObject().Write(DocumentWriteMode.Posting);" |
		And I close all client application windows

	
Scenario: _043101 check Credit note movements by the Register "R5010 Reconciliation statement"
	* Select Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R5010 Reconciliation statement" 
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Credit note 1 dated 05.04.2021 09:30:47'    | ''            | ''                    | ''          | ''             | ''             | ''         | ''                  | ''                       |
			| 'Document registrations records'             | ''            | ''                    | ''          | ''             | ''             | ''         | ''                  | ''                       |
			| 'Register  "R5010 Reconciliation statement"' | ''            | ''                    | ''          | ''             | ''             | ''         | ''                  | ''                       |
			| ''                                           | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''         | ''                  | ''                       |
			| ''                                           | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Currency' | 'Legal name'        | 'Legal name contract'    |
			| ''                                           | 'Expense'     | '05.04.2021 09:30:47' | '500'       | 'Main Company' | 'Front office' | 'TRY'      | 'Company Ferron BP' | 'Contract Ferron BP New' |
		And I close all client application windows

Scenario: _043102 check Credit note movements by the Register "R2020 Advances from customer" (with customer)
	* Select Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
	* Check movements by the Register  "R2020 Advances from customer" 
		And I click "Registrations report" button
		And I select "R2020 Advances from customer" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Credit note 2 dated 05.04.2021 09:30:58'  | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                        | ''                     | ''                           |
			| 'Document registrations records'           | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                        | ''                     | ''                           |
			| 'Register  "R2020 Advances from customer"' | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                        | ''                     | ''                           |
			| ''                                         | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''                             | ''         | ''                  | ''          | ''                                        | 'Attributes'           | ''                           |
			| ''                                         | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Basis'                                   | 'Deferred calculation' | 'Customers advances closing' |
			| ''                                         | 'Receipt'     | '05.04.2021 09:30:58' | '119,84'    | 'Main Company' | 'Front office' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | 'Credit note 2 dated 05.04.2021 09:30:58' | 'No'                   | ''                           |
			| ''                                         | 'Receipt'     | '05.04.2021 09:30:58' | '700'       | 'Main Company' | 'Front office' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Credit note 2 dated 05.04.2021 09:30:58' | 'No'                   | ''                           |
			| ''                                         | 'Receipt'     | '05.04.2021 09:30:58' | '700'       | 'Main Company' | 'Front office' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Credit note 2 dated 05.04.2021 09:30:58' | 'No'                   | ''                           |		
		And I close all client application windows



Scenario: _043103 check absence Credit note movements by the Register "R1021 Vendors transactions" (with customer)
	* Select Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
	* Check movements by the Register  "R1021 Vendors transactions" 
		And I click "Registrations report" button
		And I select "R1021 Vendors transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'Register  "R1021 Vendors transactions'   |           
	And I close all client application windows

Scenario: _043104 check Credit note movements by the Register "R1021 Vendors transactions" (with vendor)
	* Select Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R1021 Vendors transactions" 
		And I click "Registrations report" button
		And I select "R1021 Vendors transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Credit note 1 dated 05.04.2021 09:30:47' | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                   | ''                                        | ''                     | ''                         |
			| 'Document registrations records'          | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                   | ''                                        | ''                     | ''                         |
			| 'Register  "R1021 Vendors transactions"'  | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                   | ''                                        | ''                     | ''                         |
			| ''                                        | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''                             | ''         | ''                  | ''          | ''                   | ''                                        | 'Attributes'           | ''                         |
			| ''                                        | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Agreement'          | 'Basis'                                   | 'Deferred calculation' | 'Vendors advances closing' |
			| ''                                        | 'Receipt'     | '05.04.2021 09:30:47' | '85,6'      | 'Main Company' | 'Front office' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Credit note 1 dated 05.04.2021 09:30:47' | 'No'                   | ''                         |
			| ''                                        | 'Receipt'     | '05.04.2021 09:30:47' | '500'       | 'Main Company' | 'Front office' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Credit note 1 dated 05.04.2021 09:30:47' | 'No'                   | ''                         |
			| ''                                        | 'Receipt'     | '05.04.2021 09:30:47' | '500'       | 'Main Company' | 'Front office' | 'TRY'                          | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Credit note 1 dated 05.04.2021 09:30:47' | 'No'                   | ''                         |
			| ''                                        | 'Receipt'     | '05.04.2021 09:30:47' | '500'       | 'Main Company' | 'Front office' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Vendor Ferron, TRY' | 'Credit note 1 dated 05.04.2021 09:30:47' | 'No'                   | ''                         |
		And I close all client application windows


Scenario: _043105 check absence Credit note movements by the Register "R2021 Customer transactions" (with vendor)
	* Select Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R2021 Customer transactions" 
		And I click "Registrations report" button
		And I select "R2021 Customer transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document does not contain values
			| 'Register  "R2021 Customer transactions'   |           
	And I close all client application windows


Scenario: _043130 Credit note clear posting/mark for deletion
	And I close all client application windows
	* Select Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Clear posting
		And in the table "List" I click the button named "ListContextMenuUndoPosting"
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Credit note 1 dated 05.04.2021 09:30:47' |
			| 'Document registrations records'                    |
		And I close current window
	* Post Credit note
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
		And in the table "List" I click the button named "ListContextMenuPost"		
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document contains values
			| 'R5010 Reconciliation statement' |
		And I close all client application windows
	* Mark for deletion
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
		And in the table "List" I click the button named "ListContextMenuSetDeletionMark"
		Then "1C:Enterprise" window is opened
		And I click "Yes" button
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Credit note 1 dated 05.04.2021 09:30:47' |
			| 'Document registrations records'                    |
		And I close current window
	* Unmark for deletion and post document
		Given I open hyperlink "e1cib/list/Document.CreditNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
		And in the table "List" I click the button named "ListContextMenuSetDeletionMark"
		Then "1C:Enterprise" window is opened
		And I click "Yes" button				
		Then user message window does not contain messages
		And in the table "List" I click the button named "ListContextMenuPost"	
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document contains values
			| 'R5010 Reconciliation statement' |
		And I close all client application windows