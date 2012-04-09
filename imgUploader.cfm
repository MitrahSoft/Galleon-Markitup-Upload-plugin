<cfsilent>
	<cfset uName = getAuthUser()>
	<cfif uName neq ''>
	<cfset userid = application.user.getUserID(getAuthUser())>
	<cfset userDir = ExpandPath( './userfiles/#uName#' )>
	<cfset userWebDir = "userfiles/#uName#">
	
	<cfif not DirectoryExists(userDir)> 
 		<cfdirectory action="create" mode="777" directory="#userDir#">
 	</cfif>
	<cfif isDefined("form.fieldnames")>
		<cfloop	index="strFileIndex" from="1" to="#listlen(form.FIELDNAMES)#"	step="1">
			<cfset strField = "inline_upload_file#strFileIndex#" />
			<cfif (	StructKeyExists( FORM, strField ) AND Len( FORM[ strField ] )	)>
				<cffile	action="upload"	filefield="#strField#"	destination="#userDir#" nameconflict="makeunique"  result="upRes"	/>
			</cfif>
			<!---<cfx_ImageCR3 getimageinfo="#userDir#/#upRes.SERVERFILE#" >
			<cfif imagecr.width > 800>
				<cfset height = imagecr.height* (imagecr.width/800)>
				<cfx_imagecr3 load="#userDir#/#upRes.SERVERFILE#" save="#userDir#/#uName#_resaved.#upRes.SERVERFILEEXT#" resize="800x#ceiling(height)#" >
				<cffile action="delete" file="#userDir#/#upRes.SERVERFILE#">
				<cffile action="rename" source="#userDir#/#uName#_resaved.#upRes.SERVERFILEEXT#" destination="#userDir#/#upRes.SERVERFILENAME#.#upRes.SERVERFILEEXT#">
			</cfif>--->
		</cfloop>
	</cfif>
	<cfdirectory action="list" name="qFiles" directory="#userDir#">	
	</cfif>
</cfsilent>
<cfif uName eq ''><h3>Login error</h3><div><br />Please login again<br /><br /></div><cfabort></cfif>
	<h3>Pictures</h3>
	<div style="display: block;" class="products slide">
	<table width="100%" border="0" cellpadding="2" cellspacing="0">
	<tbody>
		<cfoutput query="qFiles">
		<cfif  qFiles.currentrow eq 0><tr></cfif>
			<td scope="col" width="50">
				<a href="#application.settings.rootURL#/#userWebDir#/#name#" title="#left(name,len(name)-4)#">
				<img src="#userWebDir#/#name#" alt="Product 1" width="50" border="0" height="50">
				</a>
			</td>
		<cfif  qFiles.currentrow mod 4 eq 0 and  qFiles.currentrow neq 0></tr><tr></tr></cfif>			
		</cfoutput>	 
	</tbody></table>
	</div>
