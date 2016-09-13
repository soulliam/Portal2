<%@ Page Title="" Language="C#" MasterPageFile="~/Portal2.master" AutoEventWireup="true" CodeFile="MemberSearch.aspx.cs" Inherits="MemberSearch" %>

<asp:Content ID="Content1" ContentPlaceHolderID="MainContent" runat="server">
    
    <style>


        #search_content-box1, #search_content-box2, #search_content-box3 {
			padding:5px;
			/*border:1px solid #bbb;*/
			position:absolute;
			margin-top:0px;
			height:118px;
            width:185px;
		}
        #search_content-box1 {
            margin-left:0px;
        }
        #search_content-box2 {
            margin-left:185px;
        }
        #search_content-box3 {
            margin-left:370px;
        }

        #SearchMemberId, #SearchPhoneNumber, #SearchEmail {
            margin-top:0px;
        }
        #SearchFirstName, #SearchLastName, #SearchUserName, #SearchFPNumber, #SearchCompany, #SearchMailerCompany, #SearchMailerCode, #SearchPhone, #SearchSteetAddress {
            margin-top:5px;
        }

        #MemberSearch .FPR_SearchBox{
            width:100%;height:130px;
        }
        .FPR_SearchRight {
            position:absolute;
            float:none;
            margin-left:580px;
            /*border:1px solid #bbb;*/
        }
        #memberSearchRightButtons {
            margin-left:690px;
            height:90px;
            width:180px;
            position:absolute;
            margin-top:0px;
            /*border:1px solid #bbb;*/
        }
        #btnMarketing, #btnImportStatus, #btnFindTransaction {
            width:170px;
            position:absolute;
            border-radius: 14px!important;
        }
        #btnMarketing {
            margin-top:0px;
        }
        #btnImportStatus {
            margin-top:30px;
        }
        #btnFindTransaction {
            margin-top:60px;
        }
        #content-box0 {
            padding:10px;
			/*border:1px solid #bbb;*/
			position:absolute;
			margin-top:10px;
			height:40px;
            margin-left:12px;
            width:850px;
        }
        #content-box1, #content-box2, #content-box3, #content-box4 {
			padding:10px;
			/*border:1px solid #bbb;*/
			position:absolute;
			margin-top:60px;
			height:250px;
		}
		#content-box1 {
			margin-left:12px;
			width:200px;
		}
		#content-box2 {
			margin-left:228px;
			width:200px;
		}
		#content-box3 {
			margin-left:444px;
			width:200px;
		}
        #content-box4 {
			margin-left:662px;
			width:200px;
		}
        #content-box5, #content-box6 {
            padding:10px;
			/*border:1px solid #bbb;*/
			position:absolute;
			margin-top:320px;
			height:200px;
            
        }
        #content-box5 {
            margin-left:12px;
            width:632px;
        }
        #content-box6 {
            margin-left:662px;
            width:200px;
        }

        #SendNewPassword, #SendLoginInstructions, #DisplayQA, #editMember, #updateMemberInfo {
            margin-left:5px;
            width:170px;
            position:absolute;
            border-radius: 14px!important;
        }
        #SendNewPassword {
            margin-top:10px;
        }
        #SendLoginInstructions {
            margin-top:40px;
        }
        #DisplayQA {
            margin-top:70px;
        }
        #editMember {
            margin-top:100px;
        }
        #updateMemberInfo {
            margin-top:130px;
            visibility:hidden;
        }

        input[type=text]:disabled {
            background: #ffffff;
        }

        input[type=text] {
            border-radius: 5px!important;
        }

    </style>


    <link rel="stylesheet" href="/jqwidgets/styles/jqx.base.css" type="text/css" />
    <link rel="stylesheet" href="/jqwidgets/styles/jqx.shinyblack2.css" type="text/css" />
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
    <script type="text/javascript" src="jqwidgets/jqxtabs.js"></script>
    <script type="text/javascript" src="jqwidgets/jqxloader.js"></script>

    <script type="text/javascript">
        var thisMemberID = 0;
        var firstMemberID = 0;
        var memberSet = false;

        // ============= Initialize Page ==================== Begin
        $(document).ready(function () {
            //create loader Icon
            $("#jqxLoader").jqxLoader({ isModal: true, width: 100, height: 60, imagePosition: 'top' });

            // Create jqxMemberTabs.*****************************************************************
            $('#jqxMemberTabs').jqxTabs({ width: '100%', height: 29, position: 'top' });
            $('#settings div').css('margin-top', '10px');
            $('#animation').on('change', function (event) {
                var checked = event.args.checked;
                $('#jqxMemberTabs').jqxTabs({ selectionTracker: checked });
            });

            $('#contentAnimation').on('change', function (event) {
                var checked = event.args.checked;
                if (checked) {
                    $('#jqxMemberTabs').jqxTabs({ animationType: 'fade' });
                }
                else {
                    $('#jqxMemberTabs').jqxTabs({ animationType: 'none' });
                }
            });
            // END Create jqxMemberTabs.*****************************************************************

            // Create jqxMemberInfoTabs.***************************************************************
            $('#jqxMemberInfoTabs').jqxTabs({ width: '100%', height: 570, position: 'top' });
            $('#settings div').css('margin-top', '10px');
            $('#animation').on('change', function (event) {
                var checked = event.args.checked;
                $('#jqxMemberInfoTabs').jqxTabs({ selectionTracker: checked });
            });

            $('#contentAnimation').on('change', function (event) {
                var checked = event.args.checked;
                if (checked) {
                    $('#jqxMemberInfoTabs').jqxTabs({ animationType: 'fade' });
                }
                else {
                    $('#jqxMemberInfoTabs').jqxTabs({ animationType: 'none' });
                }
            });
            // END Create jqxMemberInfoTabs.***************************************************************

            loadStateCombo();
            loadHomeLocationCombo();

            //Loads member from hidden field in member name tab labels
            $('#jqxMemberTabs').on('tabclick', function (event) {
                var clickedItem = event.args.item;
   
                loadMember($("#" + clickedItem).val(), false);
                loadManualEdits(1744670);
            });

            //Gets member and members acct number to load associated members
            $("#btnSearch").on("click", function (event) {
                if ($("#jqxSearchGrid").is(":visible")) {
                    loadSearchResults();
                }else
                {
                    $("#MemberDetails").toggle();
                    $("#jqxSearchGrid").toggle();

                    loadSearchResults();
                }
                
            });

            //removes place holder tab
            $('#jqxMemberTabs').jqxTabs('removeAt', 0);

           
            //defines search grid double click to load member info
            $("#jqxSearchGrid").bind('rowdoubleclick', function (event) {
                alert($("#userGuid").val());
                var row = event.args.rowindex;
                var dataRecord = $("#jqxSearchGrid").jqxGrid('getrowdata', row);
                findMember(dataRecord.MemberId);
                $("#jqxSearchGrid").toggle();
                $("#MemberDetails").toggle();

            });


            $("#saveNote").on("click", function (event) {
                saveNote();
            });

            $("#cancelNote").on("click", function (event) {
                $("#popupNote").jqxWindow('close');
            });
            
            $("#addNote").on("click", function (event) {
                newNote();
            });

            $("#editMember").on("click", function (event) {
                if ($("#editMember").val() == "Disable Edit") {
                    jQuery("#tabMemberInfo").find("input[type=text]").attr("disabled", true);
                    $("#stateCombo").jqxComboBox({ disabled: true });
                    $("#homeLocationCombo").jqxComboBox({ disabled: true });
                    $("#editMember").val("Edit");
                    $("#updateMemberInfo").css("visibility", "hidden");;
                }
                else
                {
                    jQuery("#tabMemberInfo").find("input[type=text]").attr("disabled", false);
                    $("#stateCombo").jqxComboBox({ disabled: false });
                    $("#homeLocationCombo").jqxComboBox({ disabled: false });
                    $("#editMember").val("Disable Edit");
                    $("#updateMemberInfo").css("visibility", "visible");;
                }
            });

            //initializes return to search button and member tabs as not visible
            $("#MemberDetails").toggle();
            //Disables member detail inputs
            jQuery("#tabMemberInfo").find("input[type=text]").attr("disabled", true);
            $("#stateCombo").jqxComboBox({ disabled: true });
            $("#homeLocationCombo").jqxComboBox({ disabled: true });


        });
        // ============= Initialize Page ================== End


        //part of the load Account Members process (findMember/loadMemberList/loadMember/LoadCards/loadManualEdits
        function loadMemberList(acctNum, compareMemberId) {
            $('#jqxLoader').jqxLoader('open');
            $.ajax({
                async: true,
                type: 'GET',
                url: 'http://52.40.189.219:80/api/v1/accounts/' + acctNum + '/members',
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "AccessToken": $("#userGuid").val(),
                    "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                },
                success: function (thisData) {
                    var tabNameContent = "";
                    var FirstName = "";
                    var LastName = "";
                    var MemberId = "";
                    var counter = 0;
                    var memberPicked = 0;
                    for (i = 0; i < thisData.result.ResultCount; i++) {
                        $.each(thisData.result.data[i].MemberInformation, function (key, val) {
                            // gets info to put in member name tab
                            if (key == 'FirstName') {
                                FirstName = val;
                            }
                            if (key == 'LastName') {
                                LastName = val;
                            }
                            if (key == 'MemberId') {
                                MemberId = val;
                                if (compareMemberId == MemberId) {
                                    memberPicked = i;
                                }
                            }


                            if (FirstName != "" && LastName != "" && MemberId != "") {
                                //creates Member Name tab
                                $('#jqxMemberTabs').jqxTabs('addLast', FirstName + ' ' + LastName + '<input type="hidden" id="' + counter + '" value="' + MemberId + '">', '');

                                //clears the variables to the if statement won't catch it again
                                FirstName = "";
                                LastName = "";
                                MemberId = "";
                                counter = counter + 1;
                            }
                        });
                    }
                    
                    //loads the first member in the list

                    
                    $('#jqxMemberTabs').jqxTabs('select', memberPicked);
                    loadMember($("#" + memberPicked).val());

                    loadManualEdits(1744670);
                    $('#jqxLoader').jqxLoader('close');
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                }
               
            });
        }
        //part of the load Account Members process (findMember/loadMemberList/loadMember/LoadCards/loadManualEdits
        function loadMember(thisMemberId) {
            var locationId = 0;

            $.ajax({
                type: 'GET',
                url: 'http://52.40.189.219:80/api/v1/members/' + thisMemberId,
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "AccessToken": $("#userGuid").val(),
                    "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                },
                success: function (thisData) {
                    //Fill out member detail tab info
                    $("#topName").val(thisData.result.data.Title.TitleName + " " + thisData.result.data.FirstName + " " + thisData.result.data.LastName)
                    $("#topMemberSince").val(thisData.result.data.MemberSince);
                    $("#Title").val(thisData.result.data.Title.TitleName);
                    $("#MemberId").val(thisData.result.data.MemberId);
                    $("#FirstName").val(thisData.result.data.FirstName);
                    $("#LastName").val(thisData.result.data.LastName);
                    $("#Email").val(thisData.result.data.EmailAddress);
                    $("#UserName").val(thisData.result.data.UserName);
                    $("#HomePhone").val(thisData.result.data.UserName);
                    $("#IsActive").val(thisData.result.data.IsActive);
                    $("#StreetAddress").val(thisData.result.data.StreetAddress);
                    $("#StreetAddress2").val(thisData.result.data.StreetAddress2);
                    $("#stateCombo").jqxComboBox('selectItem', thisData.result.data.StateId);
                    $("#CityName").val(thisData.result.data.CityName);
                    $("#Zip").val(thisData.result.data.Zip);
                    $("#Company").val(thisData.result.data.Company);
                    $("#homeLocationCombo").jqxComboBox('selectItem', thisData.result.data.LocationId);
                    
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                },
                complete: function () {
                    
                    loadCards(thisMemberId);
                    loadNotes(thisMemberId);
                }
            });
           
        }
        //part of the load Account Members process (findMember/loadMemberList/loadMember/LoadCards/loadManualEdits
        function loadCards(thisMemberId) {
            //Loads card list
            var url = "http://52.40.189.219:80/api/v1/Members/" + thisMemberId + "/Cards";

            var source =
            {
                datafields: [
                    { name: 'CardId' },
                    { name: 'MemberId' },
                    { name: 'FPNumber' },
                    { name: 'IsPrimary' },
                    { name: 'IsActive' }
                ],

                id: 'CardId',
                type: 'Get',
                datatype: "json",
                url: url,
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('AccessToken', $("#userGuid").val());
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                root: "data"
            };

            // create jqxCardGrid
            $("#jqxCardGrid").jqxGrid(
            {
                theme: 'shinyblack2',
                width: '100%',
                height: 200,
                source: source,
                rowsheight: 35,
                sortable: true,
                altrows: true,
                filterable: true,
                columns: [
                      { text: 'Card Id', datafield: 'CardId' },
                      { text: 'Member Id', datafield: 'MemberId' },
                      { text: 'FPNumber', datafield: 'FPNumber' },
                      { text: 'Primary', datafield: 'IsPrimary' },
                      { text: 'Active', datafield: 'IsActive' }
                ]
            });
        }

        //part of the load Account Members process (findMember/loadMemberList/loadMember/LoadCards/loadManualEdits
        function findMember(thisMemberId) {
            //gets member by memberID
            $.ajax({
                async: true,
                type: 'GET',
                url: 'http://52.40.189.219:80/api/v1/members/' + thisMemberId,
                headers: {
                    "Accept": "application/json",
                    "Content-Type": "application/json",
                    "AccessToken": $("#userGuid").val(),
                    "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                },
                success: function (thisData) {
                    var acctNum = thisData.result.data.AccountNumber;
                    //gets tab count to clear all tabs if the member is found
                    var tabsCount = $("#jqxMemberTabs").jqxTabs('length');
                    //is member found
                    if (thisData.result.ResultCount > 0) {
                        //does member have account
                        if (thisData.result.data.AccountNumber > 0) {
                            for (var i = tabsCount - 1; i >= 0; i--) {
                                $("#jqxMemberTabs").jqxTabs('removeAt', i);
                            };
                            //loads members from account number
                            loadMemberList(acctNum, thisData.result.data.MemberId);
                        } else {
                            alert("Member has no account assigned!")
                        }
                    }
                },
                error: function (XMLHttpRequest, textStatus, errorThrown) {
                    alert("Error: " + errorThrown);
                }
            });
        };
        //part of the load Account Members process (findMember/loadMemberList/loadMember/LoadCards/loadManualEdits
        function loadManualEdits(thisMemberId) {
            //Loads card list
            var url = "http://maxdev:8181/api/ManualEdits/ManualEditByMemberId/" + thisMemberId;

            var source =
            {
                datafields: [
                    { name: 'ManualEditId' },
                    { name: 'MemberId' },
                    { name: 'LocationId' },
                    { name: 'ManualEditDate' },
                    { name: 'SubmittedDate' },
                    { name: 'PerformedBy' },
                    { name: 'SubmittedBy' },
                    { name: 'ExplanationId' },
                    { name: 'PointsChanged' },
                    { name: 'CertificateNumber' },
                    { name: 'ParkingTransactionNumber' },
                    { name: 'CompanyId' },
                    { name: 'Notes' },
                    { name: 'PerformedByUserId' },
                    { name: 'SubmittedByUserId' }
                ],

                id: 'ManualEditId',
                type: 'Get',
                datatype: "json",
                url: url,
            };

            // create jqxManualEditGrid
            $("#jqxManualEditGrid").jqxGrid(
            {
                theme: 'shinyblack2',
                width: '100%',
                height: 200,
                source: source,
                rowsheight: 35,
                sortable: true,
                altrows: true,
                filterable: true,
                columns: [
                      { text: 'ManualEditId', datafield: 'ManualEditId' },
                      { text: 'MemberId', datafield: 'MemberId' },
                      { text: 'LocationId', datafield: 'LocationId' },
                      { text: 'ManualEditDate', datafield: 'ManualEditDate' },
                      { text: 'SubMittedDate', datafield: 'SubMittedDate' },
                      { text: 'PerformedBy', datafield: 'PerformedBy' },
                      { text: 'SubmittedBy', datafield: 'SubmittedBy' },
                      { text: 'ExplanationId', datafield: 'ExplanationId' },
                      { text: 'PointsChanged', datafield: 'PointsChanged' },
                      { text: 'CertificateNumber', datafield: 'CertificateNumber' },
                      { text: 'ParkingTransactionNumber', datafield: 'ParkingTransactionNumber' },
                      { text: 'CompanyId', datafield: 'CompanyId' },
                      { text: 'Notes', datafield: 'Notes' },
                      { text: 'PerformedByUserId', datafield: 'PerformedByUserId' },
                      { text: 'SubmittedByUserId', datafield: 'SubmittedByUserId' }
                ]
            });
        }

        function loadSearchResults() {
            //Loads SearchList from parameters
            var thisMemberId = $("#SearchMemberId").val();

            var url = "http://52.40.189.219:80/api/v1/members/" + thisMemberId;

            var source =
            {
                datafields: [
                    { name: 'MemberId' },
                    { name: 'FirstName' },
                    { name: 'LastName' },
                    { name: 'Company' },
                    { name: 'EmailAddress' }
                ],
                loadComplete: function () { $('#jqxLoader').jqxLoader('close'); },
                id: 'MemberId',
                type: 'Get',
                datatype: "json",
                url: url,
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('AccessToken', $("#userGuid").val());
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                root: "data"
            };

            // create Searchlist Grid
            $("#jqxSearchGrid").jqxGrid(
            {
                theme: 'shinyblack2',
                width: '100%',
                height: 200,
                source: source,
                rowsheight: 35,
                sortable: true,
                altrows: true,
                filterable: true,
                columns: [
                      {
                          text: 'Select', pinned: true, datafield: 'Select', width: 50, columntype: 'button', cellsrenderer: function () {
                              return "Select";
                          }, buttonclick: function (row) {
                              
                              editrow = row;
                              
                              var dataRecord = $("#jqxSearchGrid").jqxGrid('getrowdata', editrow);
                              findMember(dataRecord.MemberId);
                              $("#jqxSearchGrid").toggle();
                              $("#MemberDetails").toggle();

                          }
                      },
                      { text: 'MemberId', datafield: 'MemberId' },
                      { text: 'First Name', datafield: 'FirstName' },
                      { text: 'Last Name', datafield: 'LastName' },
                      { text: 'Company', datafield: 'Company' },
                      { text: 'Email', datafield: 'EmailAddress' }
                ]
            });
        }

        function loadNotes(thisMemberId) {
            //Loads card list
            var url = "http://maxdev:8181/api/MemberNotes/NotesByMemberId/" + thisMemberId;

            var source =
            {
                datafields: [
                    { name: 'Date' },
                    { name: 'Note' },
                    { name: 'SubmittedBy' }
                ],

                id: 'NotesId',
                type: 'Get',
                datatype: "json",
                url: url
            };

            // create jqxNotesGrid
            $("#jqxNotesGrid").jqxGrid(
            {
                theme: 'shinyblack2',
                width: '100%',
                height: 140,
                source: source,
                rowsheight: 35,
                sortable: true,
                altrows: true,
                filterable: true,
                columns: [
                      { text: 'Date', datafield: 'Date' },
                      { text: 'Note', datafield: 'Note' },
                      { text: 'SubmittedBy', datafield: 'SubmittedBy' }
                ]
            });
        }

        function newNote() {
            var offset = $("#MemberDetails").offset();
            $("#popupNote").jqxWindow({ position: { x: parseInt(offset.left) + 350, y: parseInt(offset.top) + 150 } });
            $('#popupNote').jqxWindow({ width: "433px" });
            $("#popupNote").css("visibility", "visible");
            $("#popupNote").jqxWindow('open');
        }

        function saveNote() {
            var thisDate = new Date();
            var dateFormat = thisDate.toLocaleString().replace(",", "");
            var memberId = Number($("#MemberId").val());
            var note = $("#txtNote").val();
            var submittedBy = "test";

            $.ajax({
                type: "POST",
                url: "http://localhost:52839/api/MemberNotes/AddNote/",
                data: { "NotesId": 0, "MemberId": memberId, "Note": note, "Date": dateFormat, "SubmittedBy": submittedBy },
                dataType: "json",
                success: function (response) {
                    alert("Saved!");
                },
                error: function (request, status, error) {
                    alert(request.responseText);
                }
            });

        }

        function loadStateCombo() {
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
                theme: 'shinyblack2',
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
        }

        function loadHomeLocationCombo() {
            //set up the location combobox
            var locationSource =
            {
                datatype: "json",
                type: "Get",
                root: "data",
                datafields: [
                    { name: 'DisplayName' },
                    { name: 'LocationId' }
                ],
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                url: "http://52.40.189.219:80/api/v1/locations",

            };
            var locationDataAdapter = new $.jqx.dataAdapter(locationSource);
            $("#homeLocationCombo").jqxComboBox(
            {
                theme: 'shinyblack2',
                width: 200,
                height: 25,
                source: locationDataAdapter,
                selectedIndex: 0,
                displayMember: "DisplayName",
                valueMember: "LocationId"
            });
            $("#homeLocationCombo").on('select', function (event) {
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
        }
    </script>
    <style>
        
    </style>

    <div id="MemberSearch">    
        <div id="jqxLoader"></div>
        <div class="FPR_SearchBox" style="display:block;">
            <div class="FPR_SearchLeft">
                <div id="search_content-box1">
                    <input type="text" id="SearchMemberId" placeholder="MemberId" />
                    <input type="text" id="SearchFirstName" placeholder="First Name" />
                    <input type="text" id="SearchLastName" placeholder="Last Name"  />
                    <input type="text" id="SearchFPNumber" placeholder="Card Number" />
                </div>
                <div id="search_content-box2">
                    <input type="text" id="SearchPhoneNumber" placeholder="Phone Number" />
                    <input type="text" id="SearchUserName" placeholder="User Name"  />
                    <input type="text" id="SearchCompany" placeholder="Company" />
                    <input type="text" id="SearchMailerCompany" placeholder="Mailer Company" />
                </div>
                <div id="search_content-box3">
                    <input type="text" id="SearchEmail" placeholder="Email" />
                    <input type="text" id="SearchMailerCode" placeholder="Mailer Code"  />
                    <input type="text" id="SearchPhone" placeholder="Phone" />
                    <input type="text" id="SearchSteetAddress" placeholder="Street Address" />
                </div>
            </div>
            
            <div class="FPR_SearchRight">
                <a href="javascript:" id="btnSearch">Search</a>   
            </div>
            <div id="memberSearchRightButtons">
                <input type="button" id="btnMarketing" value="Marketing" />
                <input type="button" id="btnImportStatus" value="Import Status" />
                <input type="button" id="btnFindTransaction" value="Find Transaction" />
            </div>
            
        </div>
        
        <div id="jqxSearchGrid"></div>
        <div id="MemberDetails">
            <div id='jqxMemberTabs'>
                <ul>
                    <li style="margin-left: 30px;">Account Members</li>
                </ul>
                <div>
                </div>       
            </div>
            <div id='jqxMemberInfoTabs'>
                <ul>
                    <li style="margin-left: 30px;">Member Info</li>
                    <li>Activity</li>
                    <li>Manual Edits</li>
                    <li>Redemptions</li>
                    <li>Reservations</li>
                    <li>Referrals</li>
                    <li>Cards</li>
                    <li>Modified</li>
                </ul>
                <div id="tabMemberInfo">
                    <div id="content-box0">
                        <input type="text" id="topName" style="border:none; font-weight:bold" disabled />
                        <input type="text" id="pointsLabel" style="border:none; font-weight:bold; width:123px" value="Points Balance:" disabled />
                        <input type="text" id="topPointsBalance" style="border:none; width:40px" value="100" disabled />
                        <input type="text" id="lastLoginLabel" style="border:none; font-weight:bold; width:90px" value="Last Login:" disabled />
                        <input type="text" id="topLastLogin" style="border:none; width:75px" value="8/31/2012" disabled />
                        <input type="text" id="memberSinceLabel" style="border:none; font-weight:bold; width:120px" value="Member Since:" disabled />
                        <input type="text" id="topMemberSince" style="border:none; width:75px" value="2/2/2012" disabled />
                    </div>
                    <div id="content-box1">
                            <input id="MemberId" type="hidden"  />
                            Title: <input id="Title" type="text" />
                            FirstName: <input id="FirstName" type="text" />
                            LastName: <input id="LastName" type="text" />
                            Email: <input id="Email" type="text" />
                            Home: <div id="homeLocationCombo"></div>
                            Company: <input id="Company" type="text" />
                    </div>
	                <div id="content-box2">
                        <p>
                            Rate: <input id="Rate" type="text" />
                            Always Price: <input id="AlwaysPrice" type="text" />
                            UserName: <input id="UserName" type="text" />
                            Home Phone: <input id="HomePhone" type="text" />
                            Work Phone: <input id="WorkPhone" type="text" />
                            Mobile Phone: <input id="MobilePhone" type="text" />
                        </p>
	                </div>
	                <div id="content-box3">
                        <p>
                            Rep Code: <input id="RepCode" type="text" />
                            Mailer Co.: <input id="MailerCo" type="text" />
                            Mailer Code: <input id="MailerCode" type="text" />
                            Address Type: <input id="AddressType" type="text" />
                            Country: <input id="Country" type="text" />
                            Street Address: <input id="StreetAddress" type="text" />
	                    </p>
	                </div>
                    <div id="content-box4">
                            Street Address 2: <input id="StreetAddress2" type="text" />
                            City: <input id="CityName" type="text" />
                            State Id: <div id="stateCombo"></div>
                            Zip: <input id="Zip" type="text" />
                            Active: <input id="IsActive" type="text" /> 
                    </div>
                    <div id="content-box5">
                        <div>Notes <input id="addNote" value="Add Note" type="button" style="float:right" /></div>
                        <div id="jqxNotesGrid"></div>
                    </div>
                    <div id="content-box6">
                        <input type="button" id="SendNewPassword" value="Send New Password" />
                        <input type="button" id="SendLoginInstructions" value="Send Login Instructions" />
                        <input type="button" id="DisplayQA" value="Display Q & A" />
                        <input type="button" id="editMember" value="Edit" />
                        <input type="button" id="updateMemberInfo" value="Save Member Info" />
                    </div>
                </div>
                <div id="tabActivity"></div>
                <div id="tabManualEdits">
                    <div id="jqxManualEditGrid"></div>
                </div>
                <div id="tabRedemptions"></div>
                <div id="tabReservations"></div>
                <div id="tabReferrals"></div>
                <div id="tabCards">
                    <div id="jqxCardGrid"></div>
                </div>
                <div id="tabModified"></div>
            </div>
        </div>
    </div>

    


    <%-- html for popup Note box --%>
    <div id="popupNote" style="visibility:hidden">
        <div>Note</div>
        <div style="overflow: hidden;">
            <table width="100%">
                <tr>
                    <td>
                        <textarea rows="4" cols="50" id="txtNote"></textarea>
                    </td>
                </tr>
                <tr>
                    <td style="padding-top: 10px;"><input style="margin-right: 5px;" type="button" id="saveNote" value="Save" /><input id="cancelNote" type="button" value="Cancel" /></td>
                </tr>
            </table>
        </div>

    </div>
    <%-- html for popup Note box END --%>
</asp:Content>

