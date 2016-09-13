<%@ Page Title="" Language="C#" MasterPageFile="~/Portal2.master" AutoEventWireup="true" CodeFile="CardInventory.aspx.cs" Inherits="CardInventory" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    <link rel="stylesheet" href="jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="/jqwidgets/styles/jqx.fresh.css" type="text/css" />
    <script type="text/javascript" src="jqwidgets/jqxcore.js"></script>

    <script type="text/javascript" src="jqwidgets/globalization/globalize.js"></script>

    <script type="text/javascript" src="jqwidgets/jqxbuttons.js"></script>

    
    <script type="text/javascript" src="jqwidgets/jqxgrid.js"></script>    
    <script type="text/javascript" src="jqwidgets/jqxgrid.aggregates.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxcalendar.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.columnsreorder.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.columnsresize.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxcombobox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdatetimeinput.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxdata.js"></script>     
    <script type="text/javascript" src="jqwidgets/jqxdropdownlist.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.filter.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.grouping.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.pager.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxgrid.selection.js"></script> 
    <script type="text/javascript" src="jqwidgets/jqxgrid.sort.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxlistbox.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxmaskedinput.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxmenu.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxscrollbar.js"></script>    
    <script type="text/javascript" src="jqwidgets/jqxwindow.js"></script>

    <script type="text/javascript">
        // Global Values        
        var lastCardShipped = GetLastCardShipped();        

        // ============= Initialize Page ==================== Begin
        $(document).ready(function () {
        // ---- Location ---------
            // Load locations
            var ListLocationID;
            var ListNameOfLocation;
            var ListNumberOfLocation;
            var locationURL = "http://52.40.189.219:80/api/v1/locations";
            var locationSource =
            {
                type: "GET",
                datatype: "json",
                root: "data",
                datafields: [
                    { name: 'LocationId' },
                    { name: 'NameOfLocation' }
                ],
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                id: 'LocationID',
                url: locationURL
            };
            // create a new instance of the jqx.dataAdapter.
            var LocationDataAdapter = new $.jqx.dataAdapter(locationSource);

            $('#jqxComboBoxShip').jqxComboBox({ source: LocationDataAdapter, displayMember: "NameOfLocation", valueMember: "LocationId", width: "250px", height: 18, selectedIndex: 0, placeHolder: "Location", animationType: "fade" });
            $('#jqxComboBoxShip').bind('select', function (event) {
                $("#LocationId").val(event.args.item.value);
                validateShipment();
            });

            $('#jqxComboBoxReceive').jqxComboBox({ source: LocationDataAdapter, displayMember: "NameOfLocation", valueMember: "LocationId", width: "250px", height: 18, selectedIndex: 0, placeHolder: "Location", animationType: "fade" });
            $('#jqxComboBoxReceive').bind('select', function (event) {
                $("#LocationId").val(event.args.item.value);
                validateReceipt();
            });

            $('#jqxComboBoxDistribute').jqxComboBox({ source: LocationDataAdapter, displayMember: "NameOfLocation", valueMember: "LocationId", width: "250px", height: 18, selectedIndex: 0, placeHolder: "Location", animationType: "fade" });
            $('#jqxComboBoxDistribute').bind('select', function (event) {
                $("#LocationId").val(event.args.item.value);
                validateDistribute();
            });

            // Distribution DDs
            // Load Buses
            var ListBusID;
            var ListNameBus;
            var ListNumberOfBus;
            var busURL = "http://maxdev:8181/api/Vehicles/Get";
            var busSource =
            {
                type: "GET",
                datatype: "json",
                datafields: [
                    { name: 'VehicleId' },
                    { name: 'VehicleNumber' }
                ],
                id: 'BusID',
                url: busURL
            };
            // create a new instance of the jqx.dataAdapter.
            var BusDataAdapter = new $.jqx.dataAdapter(busSource);

            $('#jqxComboBoxBus').jqxComboBox({ source: BusDataAdapter, displayMember: "VehicleNumber", valueMember: "VehicleId", width: "250px", height: 18, selectedIndex: 0, placeHolder: "Bus", animationType: "fade" });
            $('#jqxComboBoxBus').bind('select', function (event) {
                $("#busId").val(event.args.item.value);
                validateDistribution();
            });
            // Load Reps
            var ListRepID;
            var ListNameRep;
            var ListNumberOfRep;
            var repURL = "http://maxdev:8181/api/MarketingReps/Get";
            var repSource =
            {
                type: "GET",
                datatype: "json",
                datafields: [
                    { name: 'LastName' },
                    { name: 'Location' }
                ],
                id: 'RepID',
                url: repURL
            };
            // create a new instance of the jqx.dataAdapter.
            var RepDataAdapter = new $.jqx.dataAdapter(repSource);

            $('#jqxComboBoxRep').jqxComboBox({ source: RepDataAdapter, displayMember: "LastName", valueMember: "Location", width: "250px", height: 18, selectedIndex: 0, placeHolder: "Sales Rep", animationType: "fade" });
            $('#jqxComboBoxRep').bind('select', function (event) {
                $("#repId").val(event.args.item.value);
                validateDistribution();
            });
            
            //Creates empty grid 
            $("#jqxgridInquiry").jqxGrid(
            {
                theme: 'fresh',
                width: '100%',
                height: 550,
                filterable: true,
                columns: [
                  //{ text: 'Edit', datafield: '' },
                  { text: 'History Id', datafield: 'CardHistoryId' },
                  { text: 'Date', pinned: true, datafield: 'ActivityDate', cellsformat: 'MM/dd/yyyy' },
                  { text: 'StartingNumber', datafield: 'StartingNumber' },
                  { text: 'EndingNumber', datafield: 'EndingNumber' },
                  { text: 'Activity Name', pinned: true, datafield: 'CardDistributionActivityDescription' },
                  { text: 'Activity', pinned: true, datafield: 'ActivityId' },
                  { text: 'DistributionPoint', datafield: 'DistributionPoint' },
                  { text: 'Distributed To', datafield: 'BusOrRepID' },
                  { text: 'Shift', datafield: 'Shift' },
                  { text: 'NumberOfCards', datafield: 'NumberOfCards' },
                  { text: 'LocationID', datafield: 'LocationID' }
                ],
            });

            //----- set initial buttons and component states -----
            $("#ShipButton").hide();

            




        });
        // ============= Initialize Page ================== End

    // ============ Set up page components  based on activity ================== Begin
        function Order(ShowValue)
        {   switch(ShowValue){
                case 'V':
                    var lastOrdered = GetLastCardOrdered();
                    $("#LastCardAPIResult").val(lastOrdered);
                    $("#InquiryButton").hide();
                    $("#Order-Search").show();
                    $("#Order-Body").show();
                    $("#OrderButton").hide();
                    $("#OverRideButton").show();
                    $("#SpecialOrder").hide();
                    $("#NormalOrder").show();
                    $("#RangeMessage").hide();
                    // ---- Calendar ---------
                    $("#jqxdatetimeinputOrder").jqxDateTimeInput({ width: '150px', height: '19px', formatString: 'MM/dd/yyyy' });
                    $("#LastShippedAPIResult").val(lastOrdered);
                    $("#LastCardOrdered").html("Last card ordered " + lastOrdered);
                    break;
                case 'H':
                    $("#OrderButton").hide(); $("#OverRideButton").hide();
                    $("#Order-Search").hide(); $("#Order-Body").hide(); break;
            }
        }
        
        function Ship(ShowValue) {
            switch (ShowValue) {
                case 'V':
                    $("#Ship-Search").show();
                    $("#Ship-Body").show();
                    $("#InquiryButton").hide();
                    var lastOrdered = GetLastCardOrdered();
                    var lastShipped = GetLastCardShipped();
                    if (lastShipped == null) lastShipped = 0;
                    $("#FirstCardValue").val(lastShipped + 1);
                    $("#AvailableQuantity").val( lastOrdered - lastShipped);
                    $("#availableToShip").html( lastOrdered - lastShipped + " available for shipment.");
                    // ---- Calendar ---------
                    $("#jqxdatetimeinputShip").jqxDateTimeInput({ width: '150px', height: '19px', formatString: 'MM/dd/yyyy' });
                    $('#jqxdatetimeinputShip').on('close', function (event) {
                        validateShipment();
                    });
                    break;
                case 'H':
                    $("#Ship-Search").hide(); $("#Ship-Body").hide(); break;
            }
        }

        function Receive(ShowValue) {
            switch (ShowValue) {
                case 'V':
                    $("#Receive-Search").show();
                    $("#Receive-Body").show();
                    $("#InquiryButton").hide();
                    // ---- Card Number Mask ---------
                    $('#jqxFirstCardReceive').jqxMaskedInput({ width: '80px', height: '18px', mask: '###-#####' });
                    $('#jqxLastCardReceive').jqxMaskedInput({ width: '80px', height: '18px', mask: '###-#####' });
                    // bind to jqxMaskedInput valuechanged event.
                    $('#jqxFirstCardReceive').on('change', function (event) {
                        $("#FirstCardValue").value = event.args.value;
                        ValidateReceipt();
                    });
                    $('#jqxLastCardReceive').on('change', function (event) {
                        $("#LastCardValue").value = event.args.value;
                        ValidateReceipt();
                    });
                    // ---- Calendar ---------
                    $("#jqxdatetimeinputReceive").jqxDateTimeInput({ width: '150px', height: '19px', formatString: 'MM/dd/yyyy' });
                    break;
                case 'H':
                    $("#Receive-Search").hide(); $("#Receive-Body").hide(); break;
            }
        }

        function Distribute(ShowValue) {
            switch (ShowValue) {
                case 'V':
                    $("#Distribute-Search").show();
                    $("#Distribute-Body").show();
                    // ---- Calendar ---------
                    $("#jqxdatetimeinputDistribute").jqxDateTimeInput({ width: '150px', height: '19px', formatString: 'MM/dd/yyyy' });
                    // ---- Card Number Mask ---------
                    $('#jqxFirstCardDistribute').jqxMaskedInput({ width: '80px', height: '18px', mask: '###-#####' });
                    $('#jqxLastCardDistribute').jqxMaskedInput({ width: '80px', height: '18px', mask: '###-#####' });
                    // bind to jqxMaskedInput valuechanged event.
                    $('#jqxFirstCardDistribute').on('change', function (event) {
                        $("#FirstCardValue").value = event.args.value;
                        ValidateReceipt();
                    });
                    $('#jqxLastCardDistribute').on('change', function (event) {
                        $("#LastCardValue").value = event.args.value;
                        ValidateReceipt();
                    $("#InquiryButton").hide();
                    });
                    break;
                case 'H':
                    $("#Distribute-Search").hide(); $("#Distribute-Body").hide(); break;
            }
        }

        function Inquiry(ShowValue) {
            switch (ShowValue) {
                case 'V':
                    $("#InquiryButton").show();
                    $("#Inquiry-Search").show(); $("#Inquiry-Body").show();
                    // Mask the card numbers
                    $('#jqxFirstCardInquiry').jqxMaskedInput({ width: '80px', height: '18px', mask: '###-#####' });
                    $('#jqxLastCardInquiry').jqxMaskedInput({ width: '80px', height: '18px', mask: '###-#####' });
                    // bind to jqxMaskedInput valuechanged event.
                    $('#jqxFirstCardInquiry').on('change', function (event) {
                        $("#FirstCardValue").value = event.args.value;
                        if ($("#LastCardValue").value > 0) { $("#InquiryButton").show(); }
                    });
                    $('#jqxLastCardInquiry').on('change', function (event) {
                        $("#LastCardValue").value = event.args.value;
                        $("#InquiryButton").show();
                    });
                    break;
                case 'H':
                    $("#Inquiry-Search").hide(); $("#Inquiry-Body").hide(); break;
            }
        }
        // ============ Set up page components  based on activity ================== End

        // Activity Dropdown sets up page and page components
        function NewActivity()
        {
            Activity = document.getElementById('Card_Activity').value;
            $('#BodyPanel').show();
            switch (Activity) {
                case '1':
                    Order('V');
                    Ship('H');
                    Receive('H');
                    Distribute('H');
                    Inquiry('H');                    
                    break;
                case '2':
                    Order('H');
                    Ship('V');
                    Receive('H');
                    Distribute('H');
                    Inquiry('H');
                    break;
                case '3':
                    Order('H');
                    Ship('H');
                    Receive('V');
                    Distribute('H');
                    Inquiry('H');                    
                    break;
                case '4':
                    Order('H');
                    Ship('H');
                    Receive('H');
                    Distribute('V');
                    Inquiry('H');
                    break;
                case '5':
                    Order('H');
                    Ship('H');
                    Receive('H');
                    Distribute('H');
                    Inquiry('V');
                    break;
            }
        }
        
        // Order Page - Override button pressed to allow a non sequential order to be entered
        function Override() {
            $("#SpecialOrder").show();
            $("#NormalOrder").hide();
            $("#OverRideButton").hide();
            $("#OrderButton").hide();
            $("#InquiryButton").hide();
            // ---- Card Number Mask ---------
            $('#jqxFirstCard').jqxMaskedInput({ width: '90px', height: '18px', mask: '###-#####' });
            $('#jqxLastCard').jqxMaskedInput({ width: '90px', height: '18px', mask: '###-#####' });

            // bind to jqxMaskedInput valuechanged event.
            $('#jqxFirstCard').on('change', function (event) {
                $("#FirstCardValue").value = event.args.value;
                ValidateOrder('Special');
            });
            $('#jqxLastCard').on('change', function (event) {
                //var value = event.args.value;
                ValidateOrder('Special');
            });
        }

        // Call API for greatest ending card number on an order record 
        function  GetLastCardOrdered() {
            var cardNumber;

            $.ajax({
                async: false,
                type: 'GET',
                url: 'http://maxdev:8181/api/CardDistInventorys/GetLastCardOrdered/',
                success: function (data) {
                    //$("#LastCardAPIResult").val(data[0].orderedMax);
                    cardNumber = data[0].orderedMax;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                }
            });

            //return $("#LastCardAPIResult").val();
            return cardNumber;
        }

        // Call API for last card shipped
        function GetLastCardShipped() {
            var cardNumber;
            $.ajax({
                async: false,
                type: 'GET',
                url: 'http://maxdev:8181/api/CardDistHistorys/GetLastShipped/',
                success: function (data) {
                    cardNumber = data[0].maxShipped;
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                }
            });
            return cardNumber;
        }

        // Load Order History into grid
        function LoadOrderInquiry() {
            //Populates Grid with search results from API
            var url = "http://maxdev:8181/api/CardDistHistorys/GetCardRange";

            //var thisStartingNumber = $("#FirstCardValue").val();
            //var thisEndingNumber = $("#LastCardValue").val();
            //url = url + "?startingNumber=" + thisStartingNumber + "&endingNumber=" + thisEndingNumber;

            var thisStartingNumber = $("#jqxFirstCardInquiry").val().replace('-', '');
            var thisEndingNumber = $("#jqxLastCardInquiry").val().replace('-', '');

            url = url + "?startingNumber=" + thisStartingNumber + "&endingNumber=" + thisEndingNumber;

            alert(url);

            // prepare the data
            var source =
            {
                type: "Get",
                datatype: "json",
                datafields: [
                    { name: 'CardHistoryId', type: 'integer' },
                    { name: 'ActivityDate', type: 'date', cellsformat: 'MM/dd/yyyy' },
                    { name: 'ActivityId', type: 'integer' },
                    { name: 'CardDistributionActivityDescription' },
                    { name: 'BusOrRepId', type: 'integer' },
                    { name: 'CardHistoryId', type: 'integer' },
                    { name: 'DistributionPoint', type: 'string' },
                    { name: 'EndingNumber', type: 'integer' },
                    { name: 'LocationID', type: 'integer' },
                    { name: 'NumberOfCards', type: 'integer' },
                    { name: 'OrderConfirmationDate', type: 'date', cellsformat: 'MM/dd/yyyy' },
                    { name: 'RecordDate', type: 'date', cellsformat: 'MM/dd/yyyy' },
                    { name: 'RecordedBy', type: 'string' },
                    { name: 'Shift', type: 'integer' },
                    { name: 'StartingNumber', type: 'integer' }                   
                ],
                id: 'CardHistoryId',
                url: url
            };

            var dataAdapter = new $.jqx.dataAdapter(source);
            $("#jqxgridInquiry").jqxGrid(
            {
                theme: 'fresh',
                width: '100%',
                source: dataAdapter,
                columnsresize: true,
                columnsreorder: true,
                sortable: true,
                altrows: true,
                filterable: true,
                selectionmode: 'multiplerowsextended',
                //pageable: true,
                //groupable: true,
                //showstatusbar: true,
                //showaggregates: true,
                //statusbarheight: 50,
                height: 550,
                columns: [
                  { text: 'History Id', datafield: 'CardHistoryId' },
                  { text: 'Date', datafield: 'ActivityDate', cellsformat: 'MM/dd/yyyy' },
                  { text: 'StartingNumber', datafield: 'StartingNumber' },
                  { text: 'EndingNumber', datafield: 'EndingNumber' },
                  { text: 'Activity Name', datafield: 'CardDistributionActivityDescription' },
                  { text: 'Activity', datafield: 'ActivityId' },
                  { text: 'DistributionPoint', datafield: 'DistributionPoint' },
                  { text: 'Distributed To', datafield: 'BusOrRepID' },
                  { text: 'Shift', datafield: 'Shift' },
                  { text: 'NumberOfCards', datafield: 'NumberOfCards' },
                  { text: 'LocationID', datafield: 'LocationID' }
                ],
            });

        }

        // validate entries and calculate card numbers 
        function ValidateOrder(orderType) {
            //var prefix;
            //var count;
            var firstValue;
            var lastValue;
            var startPrefix;
            var endPrefix;
            var startSuffix;
            var endSuffix
            var startLength;
            var endLength;
            var stringme;
            //  get numbers for a sequential order
            if (orderType == "Normal") {
                if ($("#Quantity").val() > 0) {
                    firstValue = parseInt($("#LastCardAPIResult").val(),10) + 1;
                    lastValue = firstValue + parseInt($("#Quantity").val(), 10);
                    $("#OrderButton").hide();
                    $("#FirstCardValue").val(firstValue);
                    $("#LastCardValue").val(lastValue);
                    // format starting and ending values
                    startLength = firstValue.toString().length;
                    endLength = lastValue.toString().length;
                    // padding
                    if (startLength == 7)
                    {
                        stringme = '0' + firstValue.toString();
                    }
                    else
                    {
                        stringme = firstValue.toString();
                    };
                    startPrefix = stringme.substring(0, 3);
                    startSuffix = stringme.substring(3, 8);
                    if (endLength == 7)
                    {
                        stringme = 0+lastValue.toString();
                    }
                    else {
                        stringme = lastValue.toString();
                    };

                    endPrefix = stringme.substring(0, 3);
                    endSuffix = stringme.substring(3, 8);

                    $("#RangeMessage").val("Ordering Cards: " + startPrefix + "-" + startSuffix + " to " + endPrefix + "-" + endSuffix);
                    $("#RangeMessage").show();
                    $("#OrderButton").show();
                    $("#FirstCardValue").val(firstValue);
                    $("#LastCardValue").val(lastValue);
                    $("#QuantityValue").val($("#Quantity").val());
                }
            }
            else {
                firstValue = $('#jqxFirstCard').jqxMaskedInput('value');
                lastValue = $('#jqxLastCard').jqxMaskedInput('value');
                firstValue = firstValue.replace("-", "");
                lastValue = lastValue.replace("-", "");
                if (firstValue > lastValue)
                {
                    $("#OrderButton").hide();
                    alert('Last card must be a larger number than the first card.');
                }
                else
                {
                    // Create the order
                    $("#OrderButton").show();
                    NumberOfCards = lastValue - firstValue;
                    $("#NumberOfCards").html("Number of Cards " + NumberOfCards);
                    $("#FirstCardValue").val(firstValue);
                    $("#LastCardValue").val(lastValue);
                    $("#QuantityValue").val(NumberOfCards);
                }
                ;
            };
        }

        function placeOrder() {
            var ActivityDateCode = $('#jqxdatetimeinputOrder').jqxDateTimeInput('getDate');
            var ActivityDateValue = ActivityDateCode.toJSON();
            var ActivityIdValue = $("#Card_Activity").val();
            //alert('ADT:' + ActivityDateValue + 'AID:' + ActivityIdValue + 'F:' + $("#FirstCardValue").val() + ' Last:' + $("#LastCardValue").val() + ' Qt:' + $("#QuantityValue").val() + ' OCDt:' + $("#OrderConfirmationDateValue").val() + 'DP:' + $("#DistributionPointValue").val() + ' bus:' + $("#BusOrRepIDValue").val() + ' sft:' + $("#ShiftValue").val() + ' dt:' + new Date().toJSON() + ' Usr:' + $("#txtLoggedinUsername").val())
            $.post("http://maxdev:8181/api/CardDistHistorys/Post",
                { 'ActivityDate': ActivityDateValue, 'ActivityId': ActivityIdValue, 'StartingNumber': $("#FirstCardValue").val(), 'EndingNumber': $("#LastCardValue").val(), 'NumberOfCards': $("#QuantityValue").val(), 'OrderConfirmationDate': $("#OrderConfirmationDateValue").val(), 'DistributionPoint': $("#DistributionPointValue").val(), 'BusOrRepID': $("#BusOrRepIDValue").val(), 'Shift': $("#ShiftValue").val(), 'RecordDate': new Date(), 'RecordedBy': $("#txtLoggedinUsername").val() },
                function (data, status) {
                    switch(status){
                        case 'success':
                            $("#statusMessage").attr("class","status");
                            $("#statusMessage").html('Cards were created successfully');
                            break;
                        default:
                            $("#statusMessage").attr("class", "warning");
                            $("#statusMessage").html('An Error occurred: ' + status + "\n Data:" + data);
                            break;
                    }
                }
            );
        }

        // Validate the shipment information and update screen
        function validateShipment() {
            var ActivityDateCode = $('#jqxdatetimeinputOrder').jqxDateTimeInput('getDate');
            var firstValue;
            var lastValue;
            var startPrefix;
            var endPrefix;
            var startSuffix;
            var endSuffix
            var startLength;
            var endLength;
            var stringme;
            var message;
            // Test card quantity
            if ($("#NumberOfCards2Ship").val() > 0)
            {
                //test location
                if ($("#jqxComboBoxShip").val() > 0)                
                {
                    firstValue = parseInt($("#LastCardAPIResult").val(), 10) + 1;
                    lastValue = firstValue + parseInt($("#NumberOfCards2Ship").val(), 10);
                    $("#FirstCardValue").val(firstValue);
                    $("#LastCardValue").val(lastValue);
                    // format starting and ending values
                    startLength = firstValue.toString().length;
                    endLength = lastValue.toString().length;
                    // padding
                    if (startLength == 7) {
                        stringme = '0' + firstValue.toString();
                    }
                    else {
                        stringme = firstValue.toString();
                    };
                    startPrefix = stringme.substring(0, 3);
                    startSuffix = stringme.substring(3, 8);
                    if (endLength == 7) {
                        stringme = 0 + lastValue.toString();
                    }
                    else {
                        stringme = lastValue.toString();
                    };

                    endPrefix = stringme.substring(0, 3);
                    endSuffix = stringme.substring(3, 8);
                    message = "Ordering Cards: " + startPrefix + "-" + startSuffix + " to " + endPrefix + "-" + endSuffix;
                    $("#ShipMessage").html(message);
                    //enable button
                    $("#ShipButton").show();
                }
                else
                {
                    //Disable button
                    $("#ShipButton").hide();
                }
            }
            else
            {
                //Disable button
                $("#ShipButton").hide();
            }
        }
              
        function shipOrder() {
            var ActivityDateCode = $('#jqxdatetimeinputShip').jqxDateTimeInput('getDate');
            var ActivityDateValue = ActivityDateCode.toJSON();
            var ActivityIdValue = $("#Card_Activity").val();
            alert('ADT:' + ActivityDateValue + 'AID:' + ActivityIdValue + 'F:' + $("#FirstCardValue").val() + ' Last:' + $("#LastCardValue").val() + ' Qt:' + $("#QuantityValue").val() + ' OCDt:' + $("#OrderConfirmationDateValue").val() + 'DP:' + $("#DistributionPointValue").val() + ' bus:' + $("#BusOrRepIDValue").val() + ' sft:' + $("#ShiftValue").val() + ' dt:' + new Date().toJSON() + ' Usr:' + $("#txtLoggedinUsername").val()) + ' Loc:' + $("#jqxComboBoxShip").val();
            $.post("http://maxdev:8181/api/CardDistHistorys/Post", { 'ActivityDate': ActivityDateValue, 'ActivityId': ActivityIdValue, 'StartingNumber': $("#FirstCardValue").val(), 'EndingNumber': $("#LastCardValue").val(), 'NumberOfCards': $("#QuantityValue").val(), 'OrderConfirmationDate': $("#OrderConfirmationDateValue").val(), 'DistributionPoint': $("#DistributionPointValue").val(), 'BusOrRepID': $("#BusOrRepIDValue").val(), 'Shift': $("#ShiftValue").val(), 'RecordDate': new Date(), 'RecordedBy': $("#txtLoggedinUsername").val(), 'LocationID':$("#jqxComboBoxShip").val() });
        }

        function validateReceipt() {
            var ActivityDateCode = $('#jqxdatetimeinputOrder').jqxDateTimeInput('getDate');
            var firstValue;
            var lastValue;
            var startPrefix;
            var endPrefix;
            var startSuffix;
            var endSuffix
            var startLength;
            var endLength;
            var stringme;
            var message;
            // Test card quantity
            if ($("#NumberOfCards2Receipt").val() > 0) {
                //test location
//                if ($("#jqxComboBoxReceipt").val() > 0) {
                if ($("#NumberOfCards2Receipt").val() > 0) {
                    firstValue = parseInt($("#LastCardAPIResult").val(), 10) + 1;
                    lastValue = firstValue + parseInt($("#NumberOfCards2Receipt").val(), 10);
                    $("#FirstCardValue").val(firstValue);
                    $("#LastCardValue").val(lastValue);
                    // format starting and ending values
                    startLength = firstValue.toString().length;
                    endLength = lastValue.toString().length;
                    // padding
                    if (startLength == 7) {
                        stringme = '0' + firstValue.toString();
                    }
                    else {
                        stringme = firstValue.toString();
                    };
                    startPrefix = stringme.substring(0, 3);
                    startSuffix = stringme.substring(3, 8);
                    if (endLength == 7) {
                        stringme = 0 + lastValue.toString();
                    }
                    else {
                        stringme = lastValue.toString();
                    };

                    endPrefix = stringme.substring(0, 3);
                    endSuffix = stringme.substring(3, 8);

                    message = "Ordering Cards: " + startPrefix + "-" + startSuffix + " to " + endPrefix + "-" + endSuffix;
                    $("#ReceiptMessage").html(message);
                    //enable button
                    $("#ReceiptButton").show();
                }
                else {
                    //Disable button
                    $("#ReceiptButton").hide();
                }
            }
            else {
                //Disable button
                $("#ReceiptButton").hide();
            }
        }

        function receiveOrder() {
            var ActivityDateCode = $('#jqxdatetimeinputReceive').jqxDateTimeInput('getDate');
            var ActivityDateValue = ActivityDateCode.toJSON();
            var ActivityIdValue = $("#Card_Activity").val();
            alert('ADT:' + ActivityDateValue + 'AID:' + ActivityIdValue + 'F:' + $("#FirstCardValue").val() + ' Last:' + $("#LastCardValue").val() + ' Qt:' + $("#QuantityValue").val() + ' OCDt:' + $("#OrderConfirmationDateValue").val() + 'DP:' + $("#DistributionPointValue").val() + ' bus:' + $("#BusOrRepIDValue").val() + ' sft:' + $("#ShiftValue").val() + ' dt:' + new Date().toJSON() + ' Usr:' + $("#txtLoggedinUsername").val()) + ' Loc:' + $("#jqxComboBoxReceive").val();
            $.post("http://maxdev:8181/api/CardDistHistorys/Post", { 'ActivityDate': ActivityDateValue, 'ActivityId': ActivityIdValue, 'StartingNumber': $("#FirstCardValue").val(), 'EndingNumber': $("#LastCardValue").val(), 'NumberOfCards': $("#QuantityValue").val(), 'OrderConfirmationDate': $("#OrderConfirmationDateValue").val(), 'DistributionPoint': $("#DistributionPointValue").val(), 'BusOrRepID': $("#BusOrRepIDValue").val(), 'Shift': $("#ShiftValue").val(), 'RecordDate': new Date(), 'RecordedBy': $("#txtLoggedinUsername").val(), 'LocationID': $("#jqxComboBoxReceive").val() });
        }

        function validateDistribute() {
            
            // Test card quantity
            if ($("#NumberOfCards2Distribute").val() > 0) {
                //test location
                if ($("#jqxComboBoxDistribute").val() > 0) {
                    firstValue = parseInt($("#LastCardAPIResult").val(), 10) + 1;
                    lastValue = firstValue + parseInt($("#NumberOfCards2Distribute").val(), 10);
                    $("#FirstCardValue").val(firstValue);
                    $("#LastCardValue").val(lastValue);
                    // format starting and ending values
                    startLength = firstValue.toString().length;
                    endLength = lastValue.toString().length;
                    // padding
                    if (startLength == 7) {
                        stringme = '0' + firstValue.toString();
                    }
                    else {
                        stringme = firstValue.toString();
                    };
                    startPrefix = stringme.substring(0, 3);
                    startSuffix = stringme.substring(3, 8);
                    if (endLength == 7) {
                        stringme = 0 + lastValue.toString();
                    }
                    else {
                        stringme = lastValue.toString();
                    };

                    endPrefix = stringme.substring(0, 3);
                    endSuffix = stringme.substring(3, 8);

                    message = "Ordering Cards: " + startPrefix + "-" + startSuffix + " to " + endPrefix + "-" + endSuffix;
                    $("#DistributeMessage").html(message);
                    //enable button
                    $("#DistributeButton").show();
                }
                else {
                    //Disable button
                    $("#DistributeButton").hide();
                }
            }
            else {
                //Disable button
                $("#DistributeButton").hide();
            }
        }

        function distributeOrder() {
            var ActivityDateCode = $('#jqxdatetimeinputDistribute').jqxDateTimeInput('getDate');
            var ActivityDateValue = ActivityDateCode.toJSON();
            var ActivityIdValue = $("#Card_Activity").val();
            alert('ADT:' + ActivityDateValue + 'AID:' + ActivityIdValue + 'F:' + $("#FirstCardValue").val() + ' Last:' + $("#LastCardValue").val() + ' Qt:' + $("#QuantityValue").val() + ' OCDt:' + $("#OrderConfirmationDateValue").val() + 'DP:' + $("#DistributionPointValue").val() + ' bus:' + $("#BusOrRepIDValue").val() + ' sft:' + $("#ShiftValue").val() + ' dt:' + new Date().toJSON() + ' Usr:' + $("#txtLoggedinUsername").val()) + ' Loc:' + $("#jqxComboBoxDistribute").val();
            $.post("http://maxdev:8181/api/CardDistHistorys/Post", { 'ActivityDate': ActivityDateValue, 'ActivityId': ActivityIdValue, 'StartingNumber': $("#FirstCardValue").val(), 'EndingNumber': $("#LastCardValue").val(), 'NumberOfCards': $("#QuantityValue").val(), 'OrderConfirmationDate': $("#OrderConfirmationDateValue").val(), 'DistributionPoint': $("#DistributionPointValue").val(), 'BusOrRepID': $("#BusOrRepIDValue").val(), 'Shift': $("#ShiftValue").val(), 'RecordDate': new Date(), 'RecordedBy': $("#txtLoggedinUsername").val(), 'LocationID': $("#jqxComboBoxDistribute").val() });
        }

        function DistributionPointChange()
        {
            
            switch (DistributionPoint) {
                case '1':
                    // Booth - hide selects
                    $("#RepSelect").hide();
                    $("#BusSelect").hide();
                    break;
                case '2':
                    // Sales rep - load reps and show DD
                    // alert('2');
                    $("#RepSelect").show();
                    $("#BusSelect").hide();

                    break;
                case '3':
                    // Bus - load buses and show DD
                    // alert('3');
                    $("#RepSelect").hide();
                    $("#BusSelect").hide();

                    break;
                
            }
        }
        
        function validateDistribution() { alert('validateDistribution') }

    </script>
    

    <style>
        <!-- .jqx-widget-content {font-size:10px} -->
        .jqx-combobox-input {width:10%}
        #Card_Activity  {font-size:10px;border-radius:3px;height:20px} 
        #DistributionPoint  {font-size:10px;border-radius:3px;height:20px} 
    </style>

<div id="CardInventory">    
    <%-- Search inputs and buttons --%>       
    <div class="FPR_SearchBox" style="display:block;">
        <div class="FPR_SearchLeft">
            
            <div class="searchlabel" style="width:8rem;">Activity</div>
            <select id="Card_Activity" onchange="NewActivity()">
                <option value="0">-Select-</option>
                <option value="1">Order Cards</option>
                <option value="2">Ship Cards</option> 
                <option value="3">Receive Cards</option>
                <option value="4">Distribute Cards</option>
                <option value="5">Card Inquiry</option>
            </select>    
            <div id="Order-Search" style="display:none">
                <br />
                <div class="searchlabel" style="width:8rem;">Order Date </div><div id='jqxdatetimeinputOrder' style="float:left;"></div>
                <div id="NormalOrder" style="display:block">
                    <div class="searchblock">
                        <div class="searchlabel" style="width:17rem;" id="LastCardOrdered"></div>
                    </div>
                    <div class="searchblock">
                        <div class="searchlabel" style="width:10rem;">Order Quantity </div><input id="Quantity"  type="text" value="0" class="searchobject" onchange ="ValidateOrder('Normal')"/>
                    </div>            
                <div style="clear:both;"></div> 
                <br />
                    <div class="searchblock">
                        <input id="RangeMessage"  type="text" class="searchoutput" style="width:250px;" value="Ordering Cards: 000-00000 to 000-00000"/>
                    </div>
                </div>
                <div id="SpecialOrder" style="display:block">
                    <div class="searchblock">
                        <div class="searchlabel" style="width:11rem;">Order range from </div>
                            &nbsp;<div id='jqxFirstCard'>
                            </div>
                    </div>
                    <div class="searchblock">
                        <div class="searchlabel" style="width:2rem;text-align:center;"> to </div>&nbsp;<div id='jqxLastCard'></div>
                            <div style="clear:both;"></div>
                    </div>
                    <div class="searchblock">
                            <div id='NumberOfCards' class="searchlabel" style="width:400px;">
                            </div>
                    </div>
                </div>
            </div>
                
            <div id="Ship-Search" style="display:none">            
                <br /><br />
                <div class="searchblock">
                    <div class="searchlabel" style="width:10rem;">Ship Date</div><div id='jqxdatetimeinputShip' style="float:left;"></div>
                </div>
                <div class="searchblock">
                    <div class="searchlabel" id="availableToShip"></div>
                </div>
                <div class="searchblock">
                    <div class="searchlabel" style="width:10rem;">Ship To</div><div id='jqxComboBoxShip' class="searchobject" style="float:left;"></div> 
                </div>
                <div class="searchblock">
                    <div class="searchlabel" style="width:10rem;">Number of cards</div><input id="NumberOfCards2Ship"  type="text" value="0" class="searchobject" onchange ="validateShipment()"/>
                </div><br /><br />
                <div class="searchblock">                
                    <div id='ShipMessage' class="searchlabel" style="width:26rem;">
                        </div>
                </div>            
            </div>

            <div id="Receive-Search" style="display:none">
                <br />            
                <div class="searchblock">
                    <div class="searchlabel" style="width:8rem;">Receipt Date</div><div id='jqxdatetimeinputReceive' style="float:left;"></div>
                </div>
                <div class="searchblock">
                    <div class="searchlabel" style="width:8rem;">Location</div><div id='jqxComboBoxReceive' class="searchobject" style="float:left;"></div>
                </div>

                <div style="clear:both;"></div> 
                <br />

                <div class="searchblock">
                    <div class="searchlabel" style="width:11rem;">Received cards from </div>
                        &nbsp;<div id='jqxFirstCardReceive'></div>
                        
                    <div class="searchlabel" style="width:4rem;text-align:center;"> to </div>&nbsp;<div id='jqxLastCardReceive'></div>
                </div>
                <div class="searchblock">
                    <div id='ReceivedDescription' class="searchlabel" style="width:20rem;"></div>
                </div>
            </div>

            <div id="Distribute-Search" style="display:none">
                <br />            
                <div class="searchblock">
                    <div class="searchlabel" style="width:8rem;">Date</div><div id='jqxdatetimeinputDistribute' style="float:left;"></div>
                </div>
                <div class="searchblock">
                    <div class="searchlabel" style="width:8rem;">Location</div><div id='jqxComboBoxDistribute' class="searchobject" style="float:left;"></div>
                </div>
                <div class="searchblock">
                    <div class="searchlabel" style="width:11rem;text-align:right;"> Distributed to </div>
                    <select id="DistributionPoint" onchange="DistributionPointChange()">
                        <option value="0">-Select-</option>
                        <option value="1">Booth</option>
                        <option value="2">Sales Rep</option> 
                        <option value="3">Bus</option>
                    </select> 
                </div>
                <div class="searchblock" id="RepSelect" style="display:none">
                    <div class="searchlabel" style="width:8rem;text-align:right;"> Sales Rep </div>&nbsp;
                    <div id='jqxComboBoxRep' class="searchobject" style="float:left;"></div>
                </div>
                <div class="searchblock" id="BusSelect"  style="display:none">
                    <div class="searchlabel" style="width:8rem;text-align:right;"> Bus #</div>&nbsp;
                    <div id='jqxComboBoxBus' class="searchobject" style="float:left;"></div>
                </div>
                 <div style="clear:both;"></div> 
                <br />
                <div class="searchblock">
                    <div class="searchlabel" style="width:11rem;">Cards from </div>&nbsp;<div id='jqxFirstCardDistribute'></div>
                    <div class="searchlabel" style="width:5rem;text-align:center;"> to </div>&nbsp;<div id='jqxLastCardDistribute'></div>
                </div>
                
                <div class="searchblock">
                    <div class="searchlabel" style="width:5rem;text-align:center;"> to </div>&nbsp;<div id='jqxLastCardDistributeXX'></div>
                </div>    
                <div class="searchblock">
                    <div id='DistributedDescription' class="searchlabel" style="width:20rem;"></div>
                </div> 
            </div>

            <div id="Inquiry-Search" style="display:none">
                <div class="searchblock">
                    <div class="searchlabel" style="width:25rem;">Enter the range of numbers you want to search</div>
                </div><br /><br />
                <div class="searchblock">
                    <div class="searchlabel" style="width:20rem;">Cards from </div>
                        &nbsp;<div id='jqxFirstCardInquiry'>
                        </div>
                </div>
                <div class="searchblock">
                    <div class="searchlabel" style="width:5rem;text-align:center;"> to </div>&nbsp;<div id='jqxLastCardInquiry'></div>
                </div>            
            </div>
        </div>

        <div class="FPR_SearchRight">
            <a href="javascript:" onclick="placeOrder()" id="OrderButton" style="display:none;">Create Order</a> 
            <a href="javascript:" onclick="Override()" id="OverRideButton" style="display:none;">Special Order</a>
            <a href="javascript:" onclick="ShipProduct()" id="ShipButton" >Ship Order</a>
            <a href="javascript:" onclick="LoadOrderInquiry();" id="InquiryButton" style="display:none;">View History</a>     
        </div>
    </div>
        
    <div style="clear:both"></div>
    
    <div id="BodyPanel" class="ContentBody" style="display:none;">
        <div class="ContentBodyInner">
    
            <div id="Order-Body"   style="display:none">
        
                <p>Order</p>
              <p>Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah    </p> 
                </div> <br />
        
            </div>

            <div id="Ship-Body"  style="display:none">
              <p>Ship</p>
              <p>Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah    </p> 
            </div>

            <div id="Receive-Body"  style="display:none">
              <h3>Receive</h3>
              <p>Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah    </p> 
            </div>
    
            <div id="Distribute-Body" style="display:none">
              <h3>Distribute</h3>
              <p>Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah Blah    </p> 
            </div>

            <div id="Inquiry-Body" style="display:none">
              <div id="jqxgridInquiry"></div>
            </div>
        </div>
    
   <div style="visibility:hidden">
       <input id="LastCardAPIResult" type="text" value="0" />
       <input id="LastShippedAPIResult" type="text" value="0" />
       <input id="FirstCardValue" type="text" value="0" />
       <input id="LastCardValue" type="text" value="0"  />
       <input id="QuantityValue" type="text" value="0"  />
       <input id="OrderConfirmationDateValue" type="text" value="0" />
       <input id="DistributionPointValue" type="text" value="0"  />
       <input id="BusOrRepIDValue" type="text" value="0"  />
       <input id="ShiftValue" type="text" value="0"  />
       <input id="AvailableQuantity" type="text" value="0"  />
       <input id="LocationId" type="text" value="0"  />
   </div>
</div>      
<div class="push"></div>
</asp:Content>


