<%@ Page Title="" Language="C#" MasterPageFile="~/Portal2.master" AutoEventWireup="true" CodeFile="Locations.aspx.cs" Inherits="Locations" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">

    <link rel="stylesheet" href="jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="/jqwidgets/styles/jqx.fresh.css" type="text/css" />
    <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxbuttons.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxcombobox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>     
    <script type="text/javascript" src="jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxscrollbar.js"></script>    
    <script type="text/javascript" src="jqwidgets/jqxwindow.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxcheckbox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.edit.js"></script>
    
    <script type="text/javascript">

        var selectedLocationId = 0; //is set to the ID of the location that is selected from the main grid
        var thisNewLocation = false; //determines whether a new Location is being made so the feature grid doesn't get set 

        // ============= Initialize Page ==================== Begin
        $(document).ready(function () {
            //Loads main location grid
            loadLocationGrid();
            
            $("#Save").click(function () {
                // If LocationId is nothing then we are adding a new Location and we need a post
                if ($("#LocationId").val() == "") {
                    var newNameOfLocation = $("#NameOfLocation").val();
                    var newDisplayName =  $("#DisplayName").val();
                    var newShortLocationName =  $("#ShortLocationName").val();
                    var newFacilityNumber =  $("#FacilityNumber").val();
                    var newSkiDataVersion =  $("#SkiDataVersion").val();
                    var newSkiDataLocation =  $("#SkiDataLocation").val();
                    var newLocationAddress =  $("#LocationAddress").val();
                    var newLocationCity =  $("#LocationCity").val();
                    var newLocationZipCode =  $("#LocationZipCode").val();
                    var newLocationPhoneNumber =  $("#LocationPhoneNumber").val();
                    var newLocationFaxNumber =  $("#LocationFaxNumber").val();
                    var newCapacity =  $("#Capacity").val();
                    var newDescription =  $("#Description").val();
                    var newAlert =  $("#Alert").val();
                    var newDailyRate =  $("#DailyRate").val();
                    var newSlug =  $("#Slug").val();
                    var newQualifications =  $("#Qualifications").val();
                    var newManager =  $("#Manager").val();
                    var newManagerEmail =  $("#ManagerEmail").val();
                    var newRateDetail =  $("#RateDetail").val();
                    var newLatitude =  $("#Latitude").val();
                    var newLongitude =  $("#Longitude").val();
                    var newGoogleLink =  $("#GoogleLink").val();
                    var newIsActive =  $("#IsActive").val();
                    var newSpecialFlagsText =  $("#SpecialFlagsText").val();
                    var newSpecialFlagsInformation =  $("#SpecialFlagsInformation").val();
                    var newManagerImageUrl =  $("#ManagerImageUrl").val();
                    var newMemberRateDetail =  $("#MemberRateDetail").val();
                    var newImageUrl =  $("#ImageUrl").val();
                    var newEstimatedCharges =  $("#EstimatedCharges").val();
                    var newEstimatedSavings =  $("#EstimatedSavings").val();
                    var newBrandId = $("#brandCombo").jqxComboBox('getSelectedItem').value;
                    var newCityId = $("#cityCombo").jqxComboBox('getSelectedItem').value;
                    var newStateId = $("#stateCombo").jqxComboBox('getSelectedItem').value;

                    var postUrl = "http://52.40.189.219:80/api/v1/locations"

                    $.ajax({
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json",
                            "AccessToken": $("#userGuid").val(),
                            "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                        },
                        url: PostUrl,
                        type: 'POST',
                        data: "{'NameOfLocation': '" + newNameOfLocation + "',  'DisplayName': '" + newDisplayName + "',  'ShortLocationName': '" + newShortLocationName + "',  'FacilityNumber': '" + newFacilityNumber + "',  'SkiDataVersion': " + newSkiDataVersion + ",  'SkiDataLocation': " + newSkiDataLocation + ",  'LocationAddress': '" + newLocationAddress + "',  'LocationCity': '" + newLocationCity + "',  'BrandId': " + newBrandId + ",  'AirportId': 1004,  'Capacity': " + newCapacity + ",  'CityId': " + newCityId + ",  'LocationStateId': " + newStateId + ",  'LocationZipCode': '" + newLocationZipCode + "',  'LocationPhoneNumber': '" + newLocationPhoneNumber + "',  'LocationFaxNumber': '" + newLocationFaxNumber + "',  'Description': '" + newDescription + "',  'Alert': '" + newAlert + "',  'DailyRate': '" + newDailyRate + "',  'Slug': '" + newSlug + "',  'Qualifications': '" + newQualifications + "',  'Manager': '" + newManager + "',  'ManagerEmail': '" + newManagerEmail + "',  'RateDetail': '" + newRateDetail + "',  'DistanceFromAirport': '" + newDistanceFromAirport + "',  'Latitude': '" + newLatitude + "',  'Longitude': '" + newLongitude + "',  'GoogleLink': '" + newGoogleLink + "',  'IsActiveFlag': " + newIsActive + "}",
                        success: function (response) {
                            alert("Saved!");
                            $("#popupWindow").jqxWindow('hide');
                            //refresh the main grid
                            loadLocationGrid();
                        },
                        error: function (jqXHR, textStatus, errorThrown, data) {
                            alert(textStatus); alert(errorThrown);
                        }
                    });
                    
                    //update main grid
                    loadLocationGrid();

                } else {
                    //if edit row is greater than zero then a row has been selected and we are updating a location
                    if (editrow >= 0) {

                        var newNameOfLocation = $("#NameOfLocation").val();
                        var newDisplayName = $("#DisplayName").val();
                        var newShortLocationName = $("#ShortLocationName").val();
                        var newFacilityNumber = $("#FacilityNumber").val();
                        var newSkiDataVersion = $("#SkiDataVersion").val();
                        var newSkiDataLocation = $("#SkiDataLocation").val();
                        var newLocationAddress = $("#LocationAddress").val();
                        var newLocationCity = $("#LocationCity").val();
                        var newLocationZipCode = $("#LocationZipCode").val();
                        var newLocationPhoneNumber = $("#LocationPhoneNumber").val();
                        var newLocationFaxNumber = $("#LocationFaxNumber").val();
                        var newCapacity = $("#Capacity").val();
                        var newDescription = $("#Description").val();
                        var newAlert = $("#Alert").val();
                        var newDailyRate = $("#DailyRate").val();
                        var newSlug = $("#Slug").val();
                        var newQualifications = $("#Qualifications").val();
                        var newManager = $("#Manager").val();
                        var newManagerEmail = $("#ManagerEmail").val();
                        var newRateDetail = $("#RateDetail").val();
                        var newLatitude = $("#Latitude").val();
                        var newLongitude = $("#Longitude").val();
                        var newGoogleLink = $("#GoogleLink").val();
                        var newIsActive = $("#IsActive").val();
                        var newSpecialFlagsText = $("#SpecialFlagsText").val();
                        var newSpecialFlagsInformation = $("#SpecialFlagsInformation").val();
                        var newManagerImageUrl = $("#ManagerImageUrl").val();
                        var newMemberRateDetail = $("#MemberRateDetail").val();
                        var newImageUrl = $("#ImageUrl").val();
                        var newEstimatedCharges = $("#EstimatedCharges").val();
                        var newEstimatedSavings = $("#EstimatedSavings").val();
                        var newBrandId = $("#brandCombo").jqxComboBox('getSelectedItem').value;
                        var newCityId = $("#cityCombo").jqxComboBox('getSelectedItem').value;
                        var newStateId = $("#stateCombo").jqxComboBox('getSelectedItem').value;
                        var newDistanceFromAirport = $("#DistanceFromAirport").val();

                        var putUrl = "http://52.40.189.219:80/api/v1/locations/" + selectedLocationId //ID of the location to update

                        $.ajax({
                            headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json",
                                "AccessToken": $("#userGuid").val(),
                                "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                            },
                            url: putUrl,
                            type: 'PUT',
                            data: "{'NameOfLocation': '" + newNameOfLocation + "',  'DisplayName': '" + newDisplayName + "',  'ShortLocationName': '" + newShortLocationName + "',  'FacilityNumber': '" + newFacilityNumber + "',  'SkiDataVersion': " + newSkiDataVersion + ",  'SkiDataLocation': " + newSkiDataLocation + ",  'LocationAddress': '" + newLocationAddress + "',  'LocationCity': '" + newLocationCity + "',  'BrandId': " + newBrandId + ",  'AirportId': 1004,  'Capacity': " + newCapacity + ",  'CityId': " + newCityId + ",  'LocationStateId': " + newStateId + ",  'LocationZipCode': '" + newLocationZipCode + "',  'LocationPhoneNumber': '" + newLocationPhoneNumber + "',  'LocationFaxNumber': '" + newLocationFaxNumber + "',  'Description': '" + newDescription + "',  'Alert': '" + newAlert + "',  'DailyRate': '" + newDailyRate + "',  'Slug': '" + newSlug + "',  'Qualifications': '" + newQualifications + "',  'Manager': '" + newManager + "',  'ManagerEmail': '" + newManagerEmail + "',  'RateDetail': '" + newRateDetail + "',  'DistanceFromAirport': '" + newDistanceFromAirport + "',  'Latitude': '" + newLatitude + "',  'Longitude': '" + newLongitude + "',  'GoogleLink': '" + newGoogleLink + "',  'IsActiveFlag': " + newIsActive + "}",
                            success: function (response) {
                                alert("Saved!");
                                $("#popupWindow").jqxWindow('hide');
                                //refresh the main grid
                                loadLocationGrid();
                            },
                            error: function (jqXHR, textStatus, errorThrown, data) {
                                alert(textStatus); alert(errorThrown);
                            }
                        });

                       
                    }
                }
            });

            $("#Cancel").click(function () {
                //clears all of the inputs in the location edit window
                $("#popupWindow").jqxWindow('hide');
                $("#thisLocationId").val('');
                $("#NameOfLocation").val('');
                $("#DisplayName").val('');
                $("#ShortLocationName").val('');
                $("#FacilityNumber").val('');
                $("#SkiDataVersion").val('');
                $("#SkiDataLocation").val('');
                $("#LocationAddress").val('');
                $("#LocationCity").val('');
                $("#LocationZipCode").val('');
                $("#LocationPhoneNumber").val('');
                $("#LocationFaxNumber").val('');
                $("#Capacity").val('');
                $("#Description").val('');
                $("#Alert").val('');
                $("#DailyRate").val('');
                $("#Slug").val('');
                $("#Qualifications").val('');
                $("#Manager").val('');
                $("#ManagerEmail").val('');
                $("#RateDetail").val('');
                $("#Latitude").val('');
                $("#Longitude").val('');
                $("#GoogleLink").val('');
                $("#IsActive").val('');
                $("#SpecialFlagsText").val('');
                $("#SpecialFlagsInformation").val('');
                $("#ManagerImageUrl").val('');
                $("#MemberRateDetail").val('');
                $("#ImageUrl").val('');
                $("#EstimatedCharges").val('');
                $("#EstimatedSavings").val('');
                $("#BrandId").val('');
                $("#CityId").val('');
                $("#StateId").val('');
            });

            //set up the state combobox
            var stateSource =
            {
                datatype: "json",
                type: "Get",
                root: "data",
                datafields: [
                    { name: 'StateName' },
                    { name: 'StateId' }
                ],
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                url: "http://52.40.189.219:80/api/v1/States",

            };
            var stateDataAdapter = new $.jqx.dataAdapter(stateSource);
            $("#stateCombo").jqxComboBox(
            {
                width: 200,
                height: 25,
                source: stateDataAdapter,
                selectedIndex: 0,
                displayMember: "StateName",
                valueMember: "StateId"
            });
            $("#stateCombo").on('select', function (event) {
                if (event.args) {
                    var item = event.args.item;
                    if (item) {
                        var valueelement = $("<div></div>");
                        valueelement.text("Value: " + item.value);
                        var labelelement = $("<div></div>");
                        labelelement.text("Label: " + item.label);
                        $("#selectionlog").children().remove();
                        $("#selectionlog").append(labelelement);
                        $("#selectionlog").append(valueelement);
                    }
                }
            });

            //setup the city combobox
            var citySource =
           {
               datatype: "json",
               type: "Get",
               root: "data",
               datafields: [
                   { name: 'CityName' },
                   { name: 'CityId' }
               ],
               beforeSend: function (jqXHR, settings) {
                   jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
               },
               url: "http://52.40.189.219:80/api/v1/Cities",

           };
            var cityDataAdapter = new $.jqx.dataAdapter(citySource);
            $("#cityCombo").jqxComboBox(
            {
                width: 200,
                height: 25,
                source: cityDataAdapter,
                selectedIndex: 0,
                displayMember: "CityName",
                valueMember: "CityId"
            });
            $("#cityCombo").on('select', function (event) {
                if (event.args) {
                    var item = event.args.item;
                    if (item) {
                        var valueelement = $("<div></div>");
                        valueelement.text("Value: " + item.value);
                        var labelelement = $("<div></div>");
                        labelelement.text("Label: " + item.label);
                        $("#selectionlog").children().remove();
                        $("#selectionlog").append(labelelement);
                        $("#selectionlog").append(valueelement);
                    }
                }
            });

            //setup brand combobox
            var brandSource =
            {
                datatype: "json",
                type: "Get",
                root: "data",
                datafields: [
                    { name: 'BrandName' },
                    { name: 'BrandId' }
                ],
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                url: "http://52.40.189.219:80/api/v1/Brands",

            };
            var brandDataAdapter = new $.jqx.dataAdapter(brandSource);
            $("#brandCombo").jqxComboBox(
            {
                width: 200,
                height: 25,
                source: brandDataAdapter,
                selectedIndex: 0,
                displayMember: "BrandName",
                valueMember: "BrandId"
            });
            $("#brandCombo").on('select', function (event) {
                if (event.args) {
                    var item = event.args.item;
                    if (item) {
                        var valueelement = $("<div></div>");
                        valueelement.text("Value: " + item.value);
                        var labelelement = $("<div></div>");
                        labelelement.text("Label: " + item.label);
                        $("#selectionlog").children().remove();
                        $("#selectionlog").append(labelelement);
                        $("#selectionlog").append(valueelement);
                    }
                }
            });

            //setup featur combobox
            var FeatureComboSource =
            {
                datatype: "json",
                type: "Get",
                root: "data",
                datafields: [
                    { name: 'FeatureName' },
                    { name: 'FeatureId' }
                ],
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                url: "http://52.40.189.219:80/api/v1/features",

            };
            var featureDataAdapter = new $.jqx.dataAdapter(FeatureComboSource);
            $("#featureCombo").jqxComboBox(
            {
                width: 590,
                height: 25,
                source: featureDataAdapter,
                selectedIndex: 0,
                displayMember: "FeatureName",
                valueMember: "FeatureId"
            });
            $("#featureCombo").on('select', function (event) {
                if (event.args) {
                    var item = event.args.item;
                    if (item) {
                        var valueelement = $("<div></div>");
                        valueelement.text("Value: " + item.value);
                        var labelelement = $("<div></div>");
                        labelelement.text("Label: " + item.label);
                        $("#selectionlog").children().remove();
                        $("#selectionlog").append(labelelement);
                        $("#selectionlog").append(valueelement);
                    }
                }
            });
            
            //Opens the features pop out form with grid
            $("#btnShowFeatures").click(function () {
                var offset = $("#popupWindow").offset();
                //positions the window just of the main window
                $("#popupFeatureWindow").jqxWindow({ position: { x: parseInt(offset.left) + 60, y: parseInt(offset.top) + 15 } });
                $("#popupFeatureWindow").css("visibility", "visible");
                $("#popupFeatureWindow").jqxWindow({ width: '615', height: '510' });
                $("#popupFeatureWindow").jqxWindow('open');
                //gets rid of the X button on the window
                $('#popupFeatureWindow').jqxWindow({ showCloseButton: false });
                $("#popupFeatureWindow").jqxWindow('bringToFront');
                //opens and closes from the corner
                $('#popupFeatureWindow').jqxWindow({ animationType: 'combined' });
                $('#popupFeatureWindow').jqxWindow({ showAnimationDuration: 300 });
                $('#popupFeatureWindow').jqxWindow({ closeAnimationDuration: 500 });
                //doesn't try to load the feature grid if this is a new location
                if (thisNewLocation == false) {
                    loadFeatureGrid(selectedLocationId);
                } else {
                    thisNewLocation = false;
                }
                
            });

            $("#cancelFeature").click(function () {
                clearFeatureForm();
                $("#popupFeatureWindow").jqxWindow("hide");
            });

            $("#addFeature").click(function () {
                //gets the data from the feature form to save as new feature for site
                var newFeatureId = $("#featureCombo").jqxComboBox('getSelectedItem').value;
                var newMaxAvailable = $("#MaxAvailable").val();
                var newFeatureAvailableDatetime = $("#FeatureAvailableDatetime").val();
                var newAddToReservationText = $("#AddToReservationText").is(':checked');
                var newIsDisplayed = $("#IsDisplayed").is(':checked');

                var featurePostUrl = "http://52.40.189.219:80/api/v1/locations/" + selectedLocationId + "/features"

                $.ajax({
                    headers: {
                        "Accept": "application/json",
                        "Content-Type": "application/json",
                        "AccessToken": $("#userGuid").val(),
                        "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                    },
                    type: "POST",
                    url: featurePostUrl,
                    data: JSON.stringify({
                        "FeatureId": newFeatureId,
                        "MaxAvailable": newMaxAvailable,
                        "FeatureAvailableDatetime": newFeatureAvailableDatetime,
                        "AddToReservationText": newAddToReservationText,
                        "IsDisplayed": newIsDisplayed
                    }),
                    dataType: "json",
                    success: function (response) {
                        alert("Saved!");
                        clearFeatureForm();
                        //refreshes feature grid after succesful save
                        loadFeatureGrid(selectedLocationId);
                    },
                    error: function (request, status, error) {
                        alert(request.responseText);
                    }
                })

            });


        });
        // ============= Initialize Page ================== End

        //loads main location grid
        function loadLocationGrid() {
            var url = "http://52.40.189.219:80/api/v1/locations/";

            var source =
            {
                datafields: [
                    { name: 'LocationId' },
                    { name: 'NameOfLocation' },
                    { name: 'DisplayName' },
                    { name: 'ShortLocationName' },
                    { name: 'FacilityNumber' },
                    { name: 'SkiDataVersion' },
                    { name: 'SkiDataLocation' },
                    { name: 'LocationAddress' },
                    { name: 'LocationCity' },
                    { name: 'LocationZipCode' },
                    { name: 'LocationPhoneNumber' },
                    { name: 'LocationFaxNumber' },
                    { name: 'Capacity' },
                    { name: 'Description' },
                    { name: 'Alert' },
                    { name: 'DailyRate' },
                    { name: 'Slug' },
                    { name: 'Qualifications' },
                    { name: 'Manager' },
                    { name: 'ManagerEmail' },
                    { name: 'RateDetail' },
                    { name: 'DistanceFromAirport' },
                    { name: 'Latitude' },
                    { name: 'Longitude' },
                    { name: 'GoogleLink' },
                    { name: 'IsActive' },
                    { name: 'SpecialFlagsText' },
                    { name: 'SpecialFlagsInformation' },
                    { name: 'ManagerImageUrl' },
                    { name: 'MemberRateDetail' },
                    { name: 'ImageUrl' },
                    { name: 'EstimatedCharges' },
                    { name: 'EstimatedSavings' },
                    { name: 'BrandId', map: 'Brand>BrandId' },
                    { name: 'BrandName', map: 'Brand>BrandName' },
                    { name: 'CityId', map: 'City>CityId' },
                    { name: 'CityName', map: 'City>CityName' },
                    { name: 'StateId', map: 'State>StateId' },
                    { name: 'StateName', map: 'State>StateName' },
                    { name: 'LocationHasFeatureId' }
                ],

                id: 'LocationId',
                type: 'Get',
                datatype: "json",
                url: url,
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                root: "data"
            };

            // creage jqxgrid
            $("#jqxgrid").jqxGrid(
            {
                width: '100%',
                height: 500,
                source: source,
                rowsheight: 35,
                sortable: true,
                altrows: true,
                filterable: true,
                columnsresize: true,

                columns: [
                      {
                          //creates the edit button
                          text: '', pinned: true, datafield: 'Edit', width: 50, columntype: 'button', cellsrenderer: function () {
                              return "Edit";
                          }, buttonclick: function (row) {
                              // open the popup window when the user clicks a button.
                              editrow = row;
                              var offset = $("#jqxgrid").offset();
                              $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 75, y: parseInt(offset.top) + 20 } });
                              $("#popupWindow").css("visibility", "visible");
                              $('#popupWindow').jqxWindow({ width: '800', height: '500' });
                              $('#popupWindow').jqxWindow({ showCloseButton: false });
                              $('#popupWindow').jqxWindow({ animationType: 'combined' });
                              $('#popupWindow').jqxWindow({ showAnimationDuration: 300 });
                              $('#popupWindow').jqxWindow({ closeAnimationDuration: 500 });

                              // get the clicked row's data and initialize the input fields.
                              var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
                              $("#thisLocationId").val(dataRecord.LocationId);
                              $("#NameOfLocation").val(dataRecord.NameOfLocation);
                              $("#DisplayName").val(dataRecord.DisplayName);
                              $("#ShortLocationName").val(dataRecord.ShortLocationName);
                              $("#FacilityNumber").val(dataRecord.FacilityNumber);
                              $("#SkiDataVersion").val(dataRecord.SkiDataVersion);
                              $("#SkiDataLocation").val(dataRecord.SkiDataLocation);
                              $("#LocationAddress").val(dataRecord.LocationAddress);
                              $("#LocationCity").val(dataRecord.LocationCity);
                              $("#LocationZipCode").val(dataRecord.LocationZipCode);
                              $("#LocationPhoneNumber").val(dataRecord.LocationPhoneNumber);
                              $("#LocationFaxNumber").val(dataRecord.LocationFaxNumber);
                              $("#Capacity").val(dataRecord.Capacity);
                              $("#Description").val(dataRecord.Description);
                              $("#Alert").val(dataRecord.Alert);
                              $("#DailyRate").val(dataRecord.DailyRate);
                              $("#Slug").val(dataRecord.Slug);
                              $("#Qualifications").val(dataRecord.Qualifications);
                              $("#Manager").val(dataRecord.Manager);
                              $("#ManagerEmail").val(dataRecord.ManagerEmail);
                              $("#RateDetail").val(dataRecord.RateDetail);
                              $("#Latitude").val(dataRecord.Latitude);
                              $("#Longitude").val(dataRecord.Longitude);
                              $("#GoogleLink").val(dataRecord.GoogleLink);
                              $("#IsActive").val(dataRecord.IsActive);
                              $("#SpecialFlagsText").val(dataRecord.SpecialFlagsText);
                              $("#SpecialFlagsInformation").val(dataRecord.SpecialFlagsInformation);
                              $("#ManagerImageUrl").val(dataRecord.ManagerImageUrl);
                              $("#MemberRateDetail").val(dataRecord.MemberRateDetail);
                              $("#ImageUrl").val(dataRecord.ImageUrl);
                              $("#EstimatedCharges").val(dataRecord.EstimatedCharges);
                              $("#EstimatedSavings").val(dataRecord.EstimatedSavings);
                              $("#BrandId").val(dataRecord.BrandId);
                              $("#cityCombo").jqxComboBox('selectItem', dataRecord.CityId);
                              $("#stateCombo").jqxComboBox('selectItem', dataRecord.StateId);
                              $("#brandCombo").jqxComboBox('selectItem', dataRecord.BrandId);

                              //sets the current selected location
                              selectedLocationId = dataRecord.LocationId;

                              // show the popup window.
                              $("#popupWindow").jqxWindow('open');
                          }
                      },
                      // loads the rest of the columns for the location grid
                      { text: 'LocationId', datafield: 'LocationId', hidden: true },
                      { text: 'Name', datafield: 'NameOfLocation' },
                      { text: 'Display Name', datafield: 'DisplayName', hidden: true },
                      { text: 'Short Name', datafield: 'ShortLocationName' },
                      { text: 'Facility #', datafield: 'FacilityNumber', hidden: true },
                      { text: 'SkiData Version', datafield: 'SkiDataVersion', hidden: true },
                      { text: 'SkiData Location', datafield: 'SkiDataLocation', hidden: true },
                      { text: 'Address', datafield: 'LocationAddress' },
                      { text: 'City', datafield: 'LocationCity', hidden: true },
                      { text: 'Zip', datafield: 'LocationZipCode' },
                      { text: 'Phone', datafield: 'LocationPhoneNumber' },
                      { text: 'Fax', datafield: 'LocationFaxNumber', hidden: true },
                      { text: 'Capacity', datafield: 'Capacity' },
                      { text: 'Description', datafield: 'Description', hidden: true },
                      { text: 'Alert', datafield: 'Alert', hidden: true },
                      { text: 'Daily Rate', datafield: 'DailyRate' },
                      { text: 'Slug', datafield: 'Slug', hidden: true },
                      { text: 'Qualifications', datafield: 'Qualifications', hidden: true },
                      { text: 'Manager', datafield: 'Manager' },
                      { text: 'Manager Email', datafield: 'ManagerEmail', hidden: true },
                      { text: 'Rate Detail', datafield: 'RateDetail', hidden: true },
                      { text: 'Distance From Airport', datafield: 'DistanceFromAirport', hidden: true },
                      { text: 'Latitude', datafield: 'Latitude', hidden: true },
                      { text: 'Longitude', datafield: 'Longitude', hidden: true },
                      { text: 'Google Link', datafield: 'GoogleLink', hidden: true },
                      { text: 'IsActive', datafield: 'IsActive', hidden: true },
                      { text: 'Special Flags Text', datafield: 'SpecialFlagsText', hidden: true },
                      { text: 'Special Flags Info', datafield: 'SpecialFlagsInformation', hidden: true },
                      { text: 'Manager Image Url', datafield: 'ManagerImageUrl', hidden: true },
                      { text: 'Member Rate Detail', datafield: 'MemberRateDetail', hidden: true },
                      { text: 'Image Url', datafield: 'ImageUrl', hidden: true },
                      { text: 'Estimated Charges', datafield: 'EstimatedCharges', hidden: true },
                      { text: 'Estimated Savings', datafield: 'EstimatedSavings', hidden: true },
                      { text: 'BrandName', datafield: 'BrandName', hidden: true },
                      { text: 'City', datafield: 'CityName' },
                      { text: 'State', datafield: 'StateName' }
                ]
            });
        }

        //loads feature grid, requires locationID
        function loadFeatureGrid(thisLocationId) {

            var url = "http://52.40.189.219:80/api/v1/locations/" + thisLocationId + "/features";

            var featureSource =
            {
                datafields: [
                    { name: 'FeatureId', map: 'LocationFeature>FeatureId' },
                    { name: 'FeatureName', map: 'LocationFeature>FeatureName' },
                    { name: 'ImageUrl', map: 'LocationFeature>ImageUrl' },
                    { name: 'Subtext', map: 'LocationFeature>Subtext' },
                    { name: 'Detail', map: 'LocationFeature>Detail' }
                ],

                id: 'FeatureId',
                type: 'Get',
                datatype: "json",
                url: url,
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                root: "data"
            };

            // creage jqxgrid
            $("#jqxFeatureGrid").jqxGrid(
            {
                width: '100%',
                height: 300,
                source: featureSource,
                rowsheight: 35,
                selectionmode: 'none',
                altrows: true,
                editable: true,
                columns: [
                      //Just showing one column currently  uncomment below to show the rest
                        { text: 'Feature Name', datafield: 'FeatureName', editable: false }
                      //,
                      //{ text: 'Feature Id', datafield: 'FeatureId', hidden: true, editable: false },
                      //{ text: 'Image Url', datafield: 'ImageUrl', editable: false },
                      //{ text: 'Sub-Text', datafield: 'Subtext', editable: false },
                      //{ text: 'Detail', datafield: 'Detail', editable: false },
                      
                      
                ]
            });

        }

        //opens the location Pop out form empty for new location
        function newLocation() {
            var offset = $("#jqxgrid").offset();
            //sets the varialbe to true so form doesn't try to load feature grid
            thisNewLocation = true;
            $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 75, y: parseInt(offset.top) + 20 } });
            $("#popupWindow").css("visibility", "visible");
            $('#popupWindow').jqxWindow({ width: '800', height: '500' });
            $('#popupWindow').jqxWindow({ showCloseButton: false });
            $('#popupWindow').jqxWindow({ animationType: 'combined' });
            $('#popupWindow').jqxWindow({ showAnimationDuration: 300 });
            $('#popupWindow').jqxWindow({ closeAnimationDuration: 500 });
            $("#popupWindow").jqxWindow('open');
        }

        //clears feature form so when it is open by new Location button there is now content there
        function clearFeatureForm() {
            $("#featureCombo").jqxComboBox('selectItem', 0);
            $("#MaxAvailable").val('');
            $("#FeatureAvailableDatetime").val('');
            $("#AddToReservationText").prop('checked', false);
            $("#IsDisplayed").prop('checked', false);
            $("#jqxFeatureGrid").jqxGrid('clear');
        }

    </script>

    <div id="Locations">      
        <div class="FPR_SearchBox" style="display:block;">
            <div class="FPR_SearchLeft">

            </div>
            <div class="FPR_SearchRight">
                <a href="javascript:" onclick="newLocation();" id="btnNew">New Location</a>     
            </div>
        </div>
        <div style="visibility:hidden">
            <input id="LocationId" type="text" value="0"  />
        </div>
    </div>      
    
    <div id="jqxgrid"></div>

    <%-- html for popup edit box --%>
    <div id="popupWindow" style="visibility:hidden">
            <div>Edit</div>
           
            <div style="overflow: hidden">
                <table>
                    <tr>
                        <td>&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</td>
                        <td>
                            <table>
                                <tr>
                                    <td>LocationId:</td>
                                    <td><input id="thisLocationId" disabled /></td>
                                </tr>
                                <tr>
                                    <td>Name Of Location:</td>
                                    <td><input id="NameOfLocation" /></td>
                                </tr>
                                <tr>
                                    <td>DisplayName:</td>
                                    <td><input id="DisplayName" /></td>
                                </tr>
                                <tr>
                                    <td>Short Location Name:</td>
                                    <td><input id="ShortLocationName" /></td>
                                </tr>
                                <tr>
                                    <td>Facility Number:</td>
                                    <td><input id="FacilityNumber"  /></td>
                                </tr>
                                <tr>
                                    <td>SkiDataVersion:</td>
                                    <td><input id="SkiDataVersion" /></td>
                                </tr>
                                 <tr>
                                    <td>SkiDataLocation:</td>
                                    <td><input id="SkiDataLocation"  /></td>
                                </tr>
                                <tr>
                                    <td>Address:</td>
                                    <td><input id="LocationAddress" /></td>
                                </tr>
                                <tr>
                                    <td>City:</td>
                                    <td><div id="cityCombo"></div></td>
                                </tr>
                                <tr>
                                    <td>Zip:</td>
                                    <td><input id="LocationZipCode" /></td>
                                </tr>
                                 <tr>
                                    <td>Phone:</td>
                                    <td><input id="LocationPhoneNumber"  /></td>
                                </tr>
                                <tr>
                                    <td>Fax:</td>
                                    <td><input id="LocationFaxNumber" /></td>
                                </tr>
                                <tr>
                                    <td>Capacity:</td>
                                    <td><input id="Capacity" /></td>
                                </tr>
                                <tr>
                                    <td>Description:</td>
                                    <td><input id="Description" /></td>
                                </tr>
                                <tr>
                                    <td>Alert:</td>
                                    <td><input id="Alert" /></td>
                                </tr>
                                <tr>
                                    <td>Daily Rate:</td>
                                    <td><input id="DailyRate" /></td>
                                </tr>
                                <tr>
                                    <td>Slug:</td>
                                    <td><input id="Slug" /></td>
                                </tr>
                                <tr>
                                    <td>Qualifications:</td>
                                    <td><input id="Qualifications" /></td>
                                </tr>
                            </table>
                        </td>
                        <td>&nbsp;&nbsp;</td>
                        <td>
                            <table>
                                <tr>
                                    <td>Manager:</td>
                                    <td><input id="Manager" /></td>
                                </tr>
                                <tr>
                                    <td>Manager Email:</td>
                                    <td><input id="ManagerEmail" /></td>
                                </tr>
                                <tr>
                                    <td>Rate Detail:</td>
                                    <td><input id="RateDetail" /></td>
                                </tr>
                                <tr>
                                    <td>Distance From Airport:</td>
                                    <td><input id="DistanceFromAirport" /></td>
                                </tr>
                                <tr>
                                    <td>Latitude:</td>
                                    <td><input id="Latitude" /></td>
                                </tr>
                                <tr>
                                    <td>Longitude:</td>
                                    <td><input id="Longitude" /></td>
                                </tr>
                                <tr>
                                    <td>Google Link:</td>
                                    <td><input id="GoogleLink" /></td>
                                </tr>
                                <tr>
                                    <td>Active:</td>
                                    <td><input id="IsActive" /></td>
                                </tr>
                                <tr>
                                    <td>Special Flags Text:</td>
                                    <td><input id="SpecialFlagsText" /></td>
                                </tr>
                                <tr>
                                    <td>SpecialFlagsInformation:</td>
                                    <td><input id="SpecialFlagsInformation" /></td>
                                </tr>
                                <tr>
                                    <td>Manager Image Url:</td>
                                    <td><input id="ManagerImageUrl" /></td>
                                </tr>
                                 <tr>
                                    <td>Member Rate Detail:</td>
                                    <td><input id="MemberRateDetail" /></td>
                                </tr>
                                <tr>
                                    <td>ImageUrl:</td>
                                    <td><input id="ImageUrl" /></td>
                                </tr>
                                <tr>
                                    <td>Estimated Charges:</td>
                                    <td><input id="EstimatedCharges" /></td>
                                </tr>
                                <tr>
                                    <td>Estimated Savings:</td>
                                    <td><input id="EstimatedSavings" /></td>
                                </tr>
                                <tr>
                                    <td>Brand:</td>
                                    <td><div id="brandCombo"></div></td>
                                </tr>
                                <tr>
                                    <td>City:</td>
                                    <td><input id="CityId" /></td>
                                </tr>
                                <tr>
                                    <td>State:</td>
                                    <td><div id="stateCombo"></div></td>
                                </tr>
                                <tr>
                                    <td colspan="2"><input id="btnShowFeatures" type="button" value="Show Features" /></td>
                                </tr>
                            </table>
                        </td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 10px;" align="right"><input style="margin-right: 5px;" type="button" id="Save" value="Save" /></td>
                        <td></td>
                        <td style="padding-top: 10px;" align="left"><input id="Cancel" type="button" value="Cancel" /></td>
                        
                    </tr>
                </table>
                    
            </div>

       </div>
       <%-- html for popup edit box END --%>

        <%-- html for popup feature box --%>
    <div id="popupFeatureWindow" style="visibility:hidden">
            <div>Edit</div>
           
            <div style="overflow: hidden">
                <table>
                    <tr>
                        <td colspan="4">
                            <div id="jqxFeatureGrid"></div>
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4"><div id="featureCombo"></div></td>
                    </tr>
                    <tr>
                        <td colspan="4">
                           &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Max Available:
                        </td>
                        <td>
                            <input type="text" id="MaxAvailable" />
                        </td>
                        <td>
                            Date Available:
                        </td>
                        <td>
                            <input type="text" id="FeatureAvailableDatetime" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">
                            &nbsp;
                        </td>
                    </tr>
                    <tr>
                        <td>
                            Reservation Text?:
                        </td>
                        <td>
                            <input id="AddToReservationText" type="checkbox" />
                        </td>
                        <td>
                            Display?:
                        </td>
                        <td>
                            <input type="checkbox" id="IsDisplayed" />
                        </td>
                    </tr>
                    <tr>
                        <td colspan="4">&nbsp;</td>
                    </tr>
                    <tr>
                        <td colspan="2">
                            <input id="addFeature" type="button" value="Add" />
                        </td>
                        <td colspan="2" align="right">
                            <input id="cancelFeature" type="button" value="Cancel" />
                        </td>
                    </tr>
                </table>
            </div>
       </div>
       <%-- html for popup feature box END --%>
    <div id='Menu' style="visibility: hidden">
        <ul>
            <li>Edit Selected Row</li>
            <li>Delete Selected Row</li>
        </ul>
    </div>

</asp:Content>


