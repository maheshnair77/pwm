<%--
  ~ Password Management Servlets (PWM)
  ~ http://code.google.com/p/pwm/
  ~
  ~ Copyright (c) 2006-2009 Novell, Inc.
  ~ Copyright (c) 2009-2014 The PWM Project
  ~
  ~ This program is free software; you can redistribute it and/or modify
  ~ it under the terms of the GNU General Public License as published by
  ~ the Free Software Foundation; either version 2 of the License, or
  ~ (at your option) any later version.
  ~
  ~ This program is distributed in the hope that it will be useful,
  ~ but WITHOUT ANY WARRANTY; without even the implied warranty of
  ~ MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  ~ GNU General Public License for more details.
  ~
  ~ You should have received a copy of the GNU General Public License
  ~ along with this program; if not, write to the Free Software
  ~ Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
  --%>

<!DOCTYPE html>
<%@ page language="java" session="true" isThreadSafe="true"
         contentType="text/html; charset=UTF-8" %>
<%@ taglib uri="pwm" prefix="pwm" %>
<html dir="<pwm:LocaleOrientation/>">
<%@ include file="fragment/header.jsp" %>
<body class="nihilo">
<div id="wrapper">
    <jsp:include page="fragment/header-body.jsp">
        <jsp:param name="pwm.PageName" value="Title_UpdateProfile"/>
    </jsp:include>
    <div id="centerbody">
        <p><pwm:Display key="Display_UpdateProfile"/></p>
        <%@ include file="fragment/message.jsp" %>
        <br/>
        <form action="<pwm:url url='UpdateProfile'/>" method="post" name="updateProfile" enctype="application/x-www-form-urlencoded"
              onsubmit="PWM_MAIN.handleFormSubmit('submitBtn',this);return false"
              onchange="validateForm()" onkeyup="validateForm()">

            <% request.setAttribute("form",PwmSetting.UPDATE_PROFILE_FORM); %>
            <% request.setAttribute("formData",pwmSessionHeader.getUpdateProfileBean().getFormData()); %>
            <jsp:include page="fragment/form.jsp"/>

            <div id="buttonbar">
                <input id="submitBtn" type="submit" class="btn" name="button" value="<pwm:Display key="Button_Update"/>"/>
                <%@ include file="/WEB-INF/jsp/fragment/button-reset.jsp" %>
                <input type="hidden" name="processAction" value="updateProfile"/>
                <%@ include file="/WEB-INF/jsp/fragment/button-cancel.jsp" %>
                <input type="hidden" name="pwmFormID" value="<pwm:FormID/>"/>
            </div>
        </form>
    </div>
    <div class="push"></div>
</div>
<script type="text/javascript">
    function validateForm() {
        var validationProps = new Array();
        validationProps['serviceURL'] = "UpdateProfile" + "?processAction=validate";
        validationProps['readDataFunction'] = function(){
            var paramData = { };
            for (var j = 0; j < document.forms.length; j++) {
                for (var i = 0; i < document.forms[j].length; i++) {
                    var current = document.forms[j].elements[i];
                    paramData[current.name] = current.value;
                }
            }
            return paramData;
        };
        validationProps['processResultsFunction'] = function(data){
            if (data["success"] == "true") {
                PWM_MAIN.getObject("submitBtn").disabled = false;
                PWM_MAIN.showSuccess(data["message"]);
            } else {
                PWM_MAIN.getObject("submitBtn").disabled = true;
                PWM_MAIN.showError(data['message']);
            }
        };

        PWM_MAIN.pwmFormValidator(validationProps);
    }

    PWM_GLOBAL['startupFunctions'].push(function(){
        document.forms.updateProfile.elements[0].focus();
        ShowHidePasswordHandler.initAllForms();
    });
</script>
<%@ include file="fragment/footer.jsp" %>
</body>
</html>

