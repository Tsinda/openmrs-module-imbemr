<%
    ui.includeFragment("appui", "standardEmrIncludes")
    ui.includeCss("imbemr", "login.css")
%>

<!DOCTYPE html>
<html>
<head>
    <title>${ ui.message("imbemr.login.title") }</title>
    <link rel="shortcut icon" type="image/ico" href="/${ ui.contextPath() }/images/openmrs-favicon.ico"/>
    <link rel="icon" type="image/png\" href="/${ ui.contextPath() }/images/openmrs-favicon.png"/>
    ${ ui.resourceLinks() }
</head>
<body>
<script type="text/javascript">
    var OPENMRS_CONTEXT_PATH = '${ ui.contextPath() }';
</script>


${ ui.includeFragment("imbemr", "infoAndErrorMessages") }

<script type="text/javascript">
    jQuery(function() {
    	updateSelectedOption = function() {
	        jQuery('#sessionLocation li').removeClass('selected');
	        
			var sessionLocationVal = jQuery('#sessionLocationInput').val();
	        if(sessionLocationVal != null && sessionLocationVal != "" && sessionLocationVal != 0){
	            jQuery('#sessionLocation li[value|=' + sessionLocationVal + ']').addClass('selected');
	        }
    	};
    
        updateSelectedOption();

        jQuery('#sessionLocation li').click( function() {
            jQuery('#sessionLocationInput').val(jQuery(this).attr("value"));
            updateSelectedOption();
        });
		jQuery('#sessionLocation li').focus( function() {
            jQuery('#sessionLocationInput').val(jQuery(this).attr("value"));
            updateSelectedOption();
        });
		
		// If <Enter> Key is pressed, submit the form
		jQuery('#sessionLocation').keyup(function (e) {
    		var key = e.which || e.keyCode;
    		if (key === 13) {
      			jQuery('#login-form').submit();
    		}
		});
		var  listItem = Array.from(jQuery('#sessionLocation li'));
		for (var i in  listItem){
			 listItem[i].setAttribute('data-key', i);
			 listItem[i].addEventListener('keyup', function (event){
				var keyCode = event.which || event.keyCode;
				switch (keyCode) {
					case 37: // move left
						jQuery(this).prev('#sessionLocation li').focus();
						break;
					case 39: // move right
						jQuery(this).next('#sessionLocation li').focus();
						break;
					case 38: // move up
						jQuery('#sessionLocation li[data-key=' +(Number(jQuery(document.activeElement).attr('data-key')) - 3) + ']').focus(); 
						break;
					case 40: //	move down
						jQuery('#sessionLocation li[data-key=' +(Number(jQuery(document.activeElement).attr('data-key')) + 3) + ']').focus(); 
						break;
					default: break;
				}
			});
		}
		
        jQuery('#loginButton').click(function(e) {
        	var sessionLocationVal = jQuery('#sessionLocationInput').val();
        	
        	if (!sessionLocationVal) {
       			jQuery('#sessionLocationError').show(); 		
        		e.preventDefault();
        	}
        });	
		
        var cannotLoginController = emr.setupConfirmationDialog({
            selector: '#cannotLoginPopup',
            actions: {
                confirm: function() {
                    cannotLoginController.close();
                }
            }
        });
        
		jQuery('#username').focus();
        jQuery('a#cantLogin').click(function() {
            cannotLoginController.show();
        });
        
        pageReady = true;
    });
</script>

<header>
    <div class="logo">
        <a href="${ui.pageLink("imbemr", "home")}">
            <img src="${ui.resourceLink("imbemr", "images/openMrsLogo.png")}"/>
        </a>
    </div>
</header>

<div id="body-wrapper">
    <div id="content">
        <form id="login-form" method="post" autocomplete="off">
            <fieldset>

                <legend>
                    <i class="icon-lock small"></i>
                    ${ ui.message("imbemr.login.loginHeading") }
                </legend>

                <p class="left">
                    <label for="username">
                        ${ ui.message("imbemr.login.username") }:
                    </label>
                    <input id="username" type="text" name="username" placeholder="${ ui.message("imbemr.login.username.placeholder") }"/>
                </p>

                <p class="left">
                    <label for="password">
                        ${ ui.message("imbemr.login.password") }:
                    </label>
                    <input id="password" type="password" name="password" placeholder="${ ui.message("imbemr.login.password.placeholder") }"/>
                </p>

                <p class="clear">
                    <label for="sessionLocation">
                        ${ ui.message("imbemr.login.sessionLocation") }: <span class="location-error" id="sessionLocationError" style="display: none">${ui.message("imbemr.login.error.locationRequired")}</span>
                    </label>
                    <ul id="sessionLocation" class="select">
                        <% locations.sort { ui.format(it) }.each { %>
                        <li id="${ui.encodeHtml(it.name)}" tabindex="0"  value="${it.id}">${ui.encodeHtmlContent(ui.format(it))}</li>
                        <% } %>
                    </ul>
                </p>

                <input type="hidden" id="sessionLocationInput" name="sessionLocation"
                    <% if (lastSessionLocation != null) { %> value="${lastSessionLocation.id}" <% } %> />

                <p></p>
                <p>
                    <input id="loginButton" class="confirm" type="submit" value="${ ui.message("imbemr.login.button") }"/>
                </p>
                <p>
                    <a id="cantLogin" href="javascript:void(0)">
                        <i class="icon-question-sign small"></i>
                        ${ ui.message("imbemr.login.cannotLogin") }
                    </a>
                </p>

            </fieldset>

    		<input type="hidden" name="redirectUrl" value="${redirectUrl}" />

        </form>

    </div>
</div>

<div id="cannotLoginPopup" class="dialog" style="display: none">
    <div class="dialog-header">
        <i class="icon-info-sign"></i>
        <h3>${ ui.message("imbemr.login.cannotLogin") }</h3>
    </div>
    <div class="dialog-content">
        <p class="dialog-instructions">${ ui.message("imbemr.login.cannotLoginInstructions") }</p>

        <button class="confirm">${ ui.message("imbemr.okay") }</button>
    </div>
</div>

</body>
</html>
