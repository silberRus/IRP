﻿#Region FormEvents

Procedure OnOpen(Object, Form, Cancel, AddInfo = Undefined) Export
	DocumentsClient.SetTextOfDescriptionAtForm(Object, Form);
EndProcedure

#EndRegion
#Region ItemCompany

Procedure CompanyOnChange(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleGroupTitle(Object, Form);
EndProcedure

Procedure CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsStructure();

	OpenSettings.ArrayOfFilters = New Array();
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True,
		DataCompositionComparisonType.NotEqual));
	OpenSettings.ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("OurCompany", True,
		DataCompositionComparisonType.Equal));
	OpenSettings.FillingData = New Structure("OurCompany", True);

	DocumentsClient.CompanyStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = New Array();
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("DeletionMark", True, ComparisonType.NotEqual));
	ArrayOfFilters.Add(DocumentsClientServer.CreateFilterItem("OurCompany", True, ComparisonType.Equal));
	DocumentsClient.CompanyEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters);
EndProcedure

#EndRegion

Procedure StoreOnChange(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleGroupTitle(Object, Form);
EndProcedure

Procedure DateOnChange(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleGroupTitle(Object, Form);
EndProcedure

#Region ItemDescription

Procedure DescriptionClick(Object, Form, Item, StandardProcessing) Export
	StandardProcessing = False;
	CommonFormActions.EditMultilineText(Item.Name, Form);
EndProcedure

#EndRegion

#Region GroupTitleDecorationsEvents

Procedure DecorationGroupTitleCollapsedPictureClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, True);
EndProcedure

Procedure DecorationGroupTitleCollapsedLabelClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, True);
EndProcedure

Procedure DecorationGroupTitleUncollapsedPictureClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, False);
EndProcedure

Procedure DecorationGroupTitleUncollapsedLabelClick(Object, Form, Item) Export
	DocumentsClientServer.ChangeTitleCollapse(Object, Form, False);
EndProcedure

#EndRegion

Procedure SearchByBarcode(Barcode, Object, Form) Export
	DocumentsClient.SearchByBarcode(Barcode, Object, Form);
EndProcedure

#Region PickUpItems

Procedure OpenPickupItems(Object, Form, Command) Export
	DocumentsClient.OpenPickupItems(Object, Form, Command);
EndProcedure

Procedure PickupItemsEnd(Result, AdditionalParameters) Export
	If Not ValueIsFilled(Result) Or Not AdditionalParameters.Property("Object") Or Not AdditionalParameters.Property(
		"Form") Then
		Return;
	EndIf;

	FilterString = "Item, ItemKey, Unit";
	FilterStructure = New Structure(FilterString);
	For Each ResultElement In Result Do
		FillPropertyValues(FilterStructure, ResultElement);
		ExistingRows = AdditionalParameters.Object.ItemList.FindRows(FilterStructure);
		If ExistingRows.Count() Then
			Row = ExistingRows[0];
		Else
			Row = AdditionalParameters.Object.ItemList.Add();
			FillPropertyValues(Row, ResultElement, FilterString);
		EndIf;
		Row.Quantity = Row.Quantity + ResultElement.Quantity;
	EndDo;
	ItemListOnChange(AdditionalParameters.Object, AdditionalParameters.Form, Undefined, Undefined);
EndProcedure

#EndRegion

#Region FormTableItemsEventHandlers
#Region ItemList

Procedure ItemListOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined) Export
	DocumentsClient.FillRowIDInItemList(Object);
EndProcedure

#Region Item

Procedure ItemListItemOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined) Export
	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
	If CurrentData = Undefined Then
		Return;
	EndIf;
	CurrentData.ItemKey = CatItemsServer.GetItemKeyByItem(CurrentData.Item);
	If ValueIsFilled(CurrentData.ItemKey) 
		And ServiceSystemServer.GetObjectAttribute(CurrentData.ItemKey, "Item")	<> CurrentData.Item Then
		CurrentData.ItemKey = Undefined;
	EndIf;

	CalculationSettings = New Structure();
	CalculationSettings.Insert("UpdateUnit");
	CalculationStringsClientServer.CalculateItemsRow(Object, CurrentData, CalculationSettings);
EndProcedure

Procedure ItemListItemStartChoice(Object, Form, Item, ChoiceData, StandardProcessing) Export
	OpenSettings = DocumentsClient.GetOpenSettingsForSelectItemWithoutServiceFilter();
	DocumentsClient.ItemStartChoice(Object, Form, Item, ChoiceData, StandardProcessing, OpenSettings);
EndProcedure

Procedure ItemListItemEditTextChange(Object, Form, Item, Text, StandardProcessing) Export
	ArrayOfFilters = DocumentsClient.GetArrayOfFiltersForSelectItemWithoutServiceFilter();
	DocumentsClient.ItemEditTextChange(Object, Form, Item, Text, StandardProcessing, ArrayOfFilters);
EndProcedure

#EndRegion

#Region ItemKey
Procedure ItemListItemKeyOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined) Export
	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
	If CurrentData = Undefined Then
		Return;
	EndIf;

	CalculationSettings = New Structure();
	CalculationSettings.Insert("UpdateUnit");
	CalculationStringsClientServer.CalculateItemsRow(Object, CurrentData, CalculationSettings);
EndProcedure
#EndRegion

#Region Quantity
Procedure ItemListQuantityOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined) Export
	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
	If CurrentData = Undefined Then
		Return;
	EndIf;

	CalculationSettings = New Structure();
	CalculationSettings.Insert("CalculateQuantityInBaseUnit");
	CalculationStringsClientServer.CalculateItemsRow(Object, CurrentData, CalculationSettings);
EndProcedure
#EndRegion

#Region Unit

Procedure ItemListUnitOnChange(Object, Form, Item = Undefined, CurrentRowData = Undefined) Export
	CurrentData = DocumentsClient.GetCurrentRowDataList(Form.Items.ItemList, CurrentRowData);
	If CurrentData = Undefined Then
		Return;
	EndIf;

	CalculationSettings = New Structure();
	CalculationSettings.Insert("CalculateQuantityInBaseUnit");
	CalculationStringsClientServer.CalculateItemsRow(Object, CurrentData, CalculationSettings);
EndProcedure

#EndRegion

#EndRegion
#EndRegion