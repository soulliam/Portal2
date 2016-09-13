<%@ Page Title="" Language="C#" MasterPageFile="~/Portal2.master" AutoEventWireup="true" CodeFile="LocationFeatures.aspx.cs" Inherits="LocationFeatures" %>

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
        // ============= Initialize Page ==================== Begin
        $(document).ready(function () {

            loadGrid();

            
            $("#Save").click(function () {
                if ($("#FeatureId").val() == "") {

                    var newFeatureName = $("#FeatureName").val();
                    var newImageUrl = $("#ImageUrl").val();
                    var newSubtext = $("#Subtext").val();
                    var newDetail = $("#Detail").val();
                    
                    $.ajax({
                        headers: {
                            "Accept": "application/json",
                            "Content-Type": "application/json",
                            "AccessToken": $("#userGuid").val(),
                            "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                        },
                        type: "POST",
                        url: "http://52.40.189.219:80/api/v1/features",
                        data: JSON.stringify({
                            "FeatureName": newFeatureName,
                            "ImageUrl": newImageUrl,
                            "Subtext": newSubtext,
                            "Detail": newDetail
                        }),
                        dataType: "json",
                        success: function (response) {
                            alert("Saved!");
                            loadGrid();
                        },
                        error: function (request, status, error) {
                            alert(request.responseText);
                        }
                    })
                  
                    $("#popupWindow").jqxWindow('hide');
                    clearPopUp();

                } else {
                    if (editrow >= 0) {

                        var newFeatureId = $("#FeatureId").val();
                        var newFeatureName = $("#FeatureName").val();
                        var newImageUrl = $("#ImageUrl").val();
                        var newSubtext = $("#Subtext").val();
                        var newDetail = $("#Detail").val();

                        var putUrl = "http://52.40.189.219:80/api/v1/features/" + newFeatureId
                        
                        $.ajax({
                            headers: {
                                "Accept": "application/json",
                                "Content-Type": "application/json",
                                "AccessToken": $("#userGuid").val(),
                                "ApplicationKey": "3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580"
                            },
                            type: "PUT",
                            url: putUrl,
                            data: JSON.stringify({
                                "FeatureName": newFeatureName,
                                "ImageUrl": newImageUrl,
                                "Subtext": newSubtext,
                                "Detail": newDetail
                            }),
                            dataType: "json",
                            success: function (response) {
                                alert("Saved!");
                                loadGrid();
                            },
                            error: function (request, status, error) {
                                alert(request.responseText);
                            }
                        })

                        $("#popupWindow").jqxWindow('hide');
                        clearPopUp();
                    }
                }
            });

            $("#Cancel").click(function () {
                clearPopUp();
            });

            function clearPopUp() {
                $("#popupWindow").jqxWindow('hide');
                $("#FeatureId").val("");
                $("#FeatureName").val("");
                $("#ImageUrl").val("");
                $("#Subtext").val("");
                $("#Detail").val("");
            }


        });
        // ============= Initialize Page ================== End

        function loadGrid() {

            var url = "http://52.40.189.219:80/api/v1/features";

            var source =
            {
                datafields: [
                    { name: 'FeatureId' },
                    { name: 'FeatureName' },
                    { name: 'ImageUrl' },
                    { name: 'Subtext' },
                    { name: 'Detail' }
                ],
                beforeSend: function (jqXHR, settings) {
                    jqXHR.setRequestHeader('ApplicationKey', '3E36B6D0-A79D-4A7D-B5F3-6C016DBF5580');
                },
                id: 'FeatureId',
                type: 'Get',
                datatype: "json",
                url: url,
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
                columns: [
                      {
                          text: '', pinned: true, datafield: 'Edit', width: 50, columntype: 'button', cellsrenderer: function () {
                              return "Edit";
                          }, buttonclick: function (row) {
                              // open the popup window when the user clicks a button.
                              editrow = row;
                              var offset = $("#jqxgrid").offset();
                              $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 400, y: parseInt(offset.top) + 60 } });
                              $("#popupWindow").css("visibility", "visible");
                              $('#popupWindow').jqxWindow({ width: '300', height: '200' });
                              $('#popupWindow').jqxWindow({ showCloseButton: false });

                              // get the clicked row's data and initialize the input fields.
                              var dataRecord = $("#jqxgrid").jqxGrid('getrowdata', editrow);
                              $("#FeatureId").val(dataRecord.FeatureId);
                              $("#FeatureName").val(dataRecord.FeatureName);
                              $("#ImageUrl").val(dataRecord.ImageUrl);
                              $("#Subtext").val(dataRecord.Subtext);
                              $("#Detail").val(dataRecord.Detail);

                              // show the popup window.
                              $("#popupWindow").jqxWindow('open');
                              

                          }
                      },
                      { text: 'Feature Id', datafield: 'FeatureId' },
                      { text: 'Feature Name', datafield: 'FeatureName' },
                      { text: 'Image Url', datafield: 'ImageUrl' },
                      { text: 'Sub-Text', datafield: 'Subtext' },
                      { text: 'Detail', datafield: 'Detail' }
                ]
            });

        }


        function newFeature() {
            var offset = $("#jqxgrid").offset();
            $("#popupWindow").jqxWindow({ position: { x: parseInt(offset.left) + 400, y: parseInt(offset.top) + 60 } });
            $("#popupWindow").css("visibility", "visible");
            $("#popupWindow").jqxWindow('open');
        }

    </script>
    

    <style>

    </style>

    <div id="LocationFeatures">      
        <div class="FPR_SearchBox" style="display:block;">
            <div class="FPR_SearchLeft">
            

            </div>
            <div class="FPR_SearchRight">
                <a href="javascript:" onclick="newFeature();" id="btnNew">New Feature</a>     
            </div>
        </div>
        <div style="visibility:hidden">
            <input id="LocationId" type="text" value="0"  />
        </div>
    </div>      
    
    <div id="jqxgrid">
    </div>

    <%-- html for popup edit box --%>
    <div id="popupWindow" style="visibility:hidden">
            <div>Edit</div>
            <div style="overflow: hidden;">
                <table>
                    <tr>
                        <td>Feature Id:</td>
                        <td><input id="FeatureId" disabled /></td>
                    </tr>
                    <tr>
                        <td>Feature Name:</td>
                        <td><input id="FeatureName"  /></td>
                    </tr>
                    <tr>
                        <td>Image Url:</td>
                        <td><input id="ImageUrl" /></td>
                    </tr>
                    <tr>
                        <td>Sub-Text:</td>
                        <td><input id="Subtext"  /></td>
                    </tr>
                    <tr>
                        <td>Detail:</td>
                        <td><input id="Detail" /></td>
                    </tr>
                    <tr>
                        <td></td>
                        <td style="padding-top: 10px;"><input style="margin-right: 5px;" type="button" id="Save" value="Save" /><input id="Cancel" type="button" value="Cancel" /></td>
                    </tr>
                </table>
            </div>

       </div>
       <%-- html for popup edit box END --%>
</asp:Content>


