﻿#language: en
@tree
@Positive
@Movements
@MovementsDebitNote

Feature: check Debit note movements



Background:
	Given I launch TestClient opening script or connect the existing one



Scenario: _043000 preparation (Debit note)
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
		When Create catalog LegalNameContracts objects
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
		Given I open hyperlink "e1cib/list/Document.SalesOrder"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '1' |
			| '3' |	
			When Create document SalesOrder objects (check movements, SC before SI, Use shipment sheduling)
			When Create document SalesOrder objects (check movements, SI before SC, not Use shipment sheduling)
			And I execute 1C:Enterprise script at server
				| "Documents.SalesOrder.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
				| "Documents.SalesOrder.FindByNumber(3).GetObject().Write(DocumentWriteMode.Posting);" |
		And I close all client application windows
		Given I open hyperlink "e1cib/list/Document.ShipmentConfirmation"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '2' |
			| '3' |	
			When Create document ShipmentConfirmation objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.ShipmentConfirmation.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
				| "Documents.ShipmentConfirmation.FindByNumber(3).GetObject().Write(DocumentWriteMode.Posting);" |
		Given I open hyperlink "e1cib/list/Document.SalesInvoice"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '1' |
			| '3' |	
			When Create document SalesInvoice objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.SalesInvoice.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
				| "Documents.SalesInvoice.FindByNumber(3).GetObject().Write(DocumentWriteMode.Posting);" |
		Given I open hyperlink "e1cib/list/Document.SalesReturnOrder"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '102' |
			When Create document SalesReturnOrder objects (check movements)
			And I execute 1C:Enterprise script at server
				| "Documents.SalesReturnOrder.FindByNumber(102).GetObject().Write(DocumentWriteMode.Posting);" |
			And I close all client application windows
		Given I open hyperlink "e1cib/list/Document.SalesReturn"
		If "List" table does not contain lines Then
			| 'Number'  |
			| '101' |
			| '104' |
			When Create document SalesReturn objects (check movements)
			And I execute 1C:Enterprise script at server
					| "Documents.SalesReturn.FindByNumber(101).GetObject().Write(DocumentWriteMode.Posting);" |
					| "Documents.SalesReturn.FindByNumber(104).GetObject().Write(DocumentWriteMode.Posting);" |
		When Create document DebitNote objects (check movements)
		And I execute 1C:Enterprise script at server
			| "Documents.DebitNote.FindByNumber(1).GetObject().Write(DocumentWriteMode.Posting);" |
			| "Documents.DebitNote.FindByNumber(2).GetObject().Write(DocumentWriteMode.Posting);" |
		And I close all client application windows
		
Scenario: _043001 check Debit note movements by the Register "R5010 Reconciliation statement"
	* Select Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R5010 Reconciliation statement" 
		And I click "Registrations report" button
		And I select "R5010 Reconciliation statement" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Debit note 1 dated 05.04.2021 09:30:36'     | ''            | ''                    | ''          | ''             | ''             | ''         | ''                  | ''                       |
			| 'Document registrations records'             | ''            | ''                    | ''          | ''             | ''             | ''         | ''                  | ''                       |
			| 'Register  "R5010 Reconciliation statement"' | ''            | ''                    | ''          | ''             | ''             | ''         | ''                  | ''                       |
			| ''                                           | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''         | ''                  | ''                       |
			| ''                                           | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Currency' | 'Legal name'        | 'Legal name contract'    |
			| ''                                           | 'Receipt'     | '05.04.2021 09:30:36' | '2 300'     | 'Main Company' | 'Front office' | 'TRY'      | 'Company Ferron BP' | 'Contract Ferron BP New' |
	And I close all client application windows

Scenario: _043002 check Debit note movements by the Register "R2021 Customer transactions" (with customer)
	* Select Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
		And I go to line in "List" table
			| 'Number'  |
			| '2' |
	* Check movements by the Register  "R2021 Customer transactions" 
		And I click "Registrations report" button
		And I select "R2021 Customer transactions" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Debit note 2 dated 05.04.2021 09:31:09'  | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                         | ''                                       | ''                     | ''                           |
			| 'Document registrations records'          | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                         | ''                                       | ''                     | ''                           |
			| 'Register  "R2021 Customer transactions"' | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                         | ''                                       | ''                     | ''                           |
			| ''                                        | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''                             | ''         | ''                  | ''          | ''                         | ''                                       | 'Attributes'           | ''                           |
			| ''                                        | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Agreement'                | 'Basis'                                  | 'Deferred calculation' | 'Customers advances closing' |
			| ''                                        | 'Receipt'     | '05.04.2021 09:31:09' | '17,12'     | 'Main Company' | 'Front office' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Debit note 2 dated 05.04.2021 09:31:09' | 'No'                   | ''                           |
			| ''                                        | 'Receipt'     | '05.04.2021 09:31:09' | '100'       | 'Main Company' | 'Front office' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Debit note 2 dated 05.04.2021 09:31:09' | 'No'                   | ''                           |
			| ''                                        | 'Receipt'     | '05.04.2021 09:31:09' | '100'       | 'Main Company' | 'Front office' | 'TRY'                          | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Debit note 2 dated 05.04.2021 09:31:09' | 'No'                   | ''                           |
			| ''                                        | 'Receipt'     | '05.04.2021 09:31:09' | '100'       | 'Main Company' | 'Front office' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Basic Partner terms, TRY' | 'Debit note 2 dated 05.04.2021 09:31:09' | 'No'                   | ''                           |
	And I close all client application windows
	

Scenario: _043003 check absence Debit note movements by the Register "R1021 Vendors transactions" (with customer)
	* Select Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
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


Scenario: _043004 check Debit note movements by the Register "R1020 Advances to vendors" (with vendor)
	* Select Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Check movements by the Register  "R1020 Advances to vendors" 
		And I click "Registrations report" button
		And I select "R1020 Advances to vendors" exact value from "Register" drop-down list
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Debit note 1 dated 05.04.2021 09:30:36' | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                       | ''                     | ''                         |
			| 'Document registrations records'         | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                       | ''                     | ''                         |
			| 'Register  "R1020 Advances to vendors"'  | ''            | ''                    | ''          | ''             | ''             | ''                             | ''         | ''                  | ''          | ''                                       | ''                     | ''                         |
			| ''                                       | 'Record type' | 'Period'              | 'Resources' | 'Dimensions'   | ''             | ''                             | ''         | ''                  | ''          | ''                                       | 'Attributes'           | ''                         |
			| ''                                       | ''            | ''                    | 'Amount'    | 'Company'      | 'Branch'       | 'Multi currency movement type' | 'Currency' | 'Legal name'        | 'Partner'   | 'Basis'                                  | 'Deferred calculation' | 'Vendors advances closing' |
			| ''                                       | 'Receipt'     | '05.04.2021 09:30:36' | '393,76'    | 'Main Company' | 'Front office' | 'Reporting currency'           | 'USD'      | 'Company Ferron BP' | 'Ferron BP' | 'Debit note 1 dated 05.04.2021 09:30:36' | 'No'                   | ''                         |
			| ''                                       | 'Receipt'     | '05.04.2021 09:30:36' | '2 300'     | 'Main Company' | 'Front office' | 'Local currency'               | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Debit note 1 dated 05.04.2021 09:30:36' | 'No'                   | ''                         |
			| ''                                       | 'Receipt'     | '05.04.2021 09:30:36' | '2 300'     | 'Main Company' | 'Front office' | 'en description is empty'      | 'TRY'      | 'Company Ferron BP' | 'Ferron BP' | 'Debit note 1 dated 05.04.2021 09:30:36' | 'No'                   | ''                         |		
	And I close all client application windows

Scenario: _043005 check absence Debit note movements by the Register "R2021 Customer transactions" (with vendor)
	* Select Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
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

Scenario: _043030 Debit note clear posting/mark for deletion
	And I close all client application windows
	* Select Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
		And I go to line in "List" table
			| 'Number'  |
			| '1' |
	* Clear posting
		And in the table "List" I click the button named "ListContextMenuUndoPosting"
		Then user message window does not contain messages
		And I click "Registrations report" button
		And I click "Generate report" button
		Then "ResultTable" spreadsheet document is equal
			| 'Debit note 1 dated 05.04.2021 09:30:36' |
			| 'Document registrations records'                    |
		And I close current window
	* Post Debit note
		Given I open hyperlink "e1cib/list/Document.DebitNote"
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
		Given I open hyperlink "e1cib/list/Document.DebitNote"
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
			| 'Debit note 1 dated 05.04.2021 09:30:36' |
			| 'Document registrations records'                    |
		And I close current window
	* Unmark for deletion and post document
		Given I open hyperlink "e1cib/list/Document.DebitNote"
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