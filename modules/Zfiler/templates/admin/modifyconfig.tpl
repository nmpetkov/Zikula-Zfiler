{if $coredata.version_num < '1.4.0'}
    {pageaddvar name='stylesheet' value='javascript/jquery-ui-1.12/themes/base/jquery-ui.css'}
    {pageaddvar name='javascript' value='javascript/jquery-ui-1.12/jquery-ui.min.js'}
{else}
    {pageaddvar name='stylesheet' value='web/jquery-ui/themes/base/jquery-ui.css'}
{/if}
{pageaddvar name='javascript' value='javascript/jquery-plugins/spectrum/spectrum.js'}
{pageaddvar name="stylesheet" value="javascript/jquery-plugins/spectrum/spectrum.css"}
{pageaddvar name='javascript' value='modules/Zfiler/javascript/zfiler_img.js'}
{adminheader}
<div class="z-admin-content-pagetitle">
    {icon type="config" size="small"}
    <h3>{gt text='Module settings'}</h3>
</div>

<form class="z-form" action="{modurl modname='Zfiler' type='admin' func='updateconfig'}" method="post" enctype="application/x-www-form-urlencoded">
    <input type="hidden" name="csrftoken" value="{insert name='csrftoken'}" />

      <fieldset>
          <legend>{gt text='Access permissions'}</legend>
          <div class="z-formrow">
            <label>{gt text='Upload'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="access_upload[]" value="{$user_group.gid}"{if in_array($user_group.gid, $access_upload)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Delete'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="access_delete[]" value="{$user_group.gid}"{if in_array($user_group.gid, $access_delete)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Rename'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="access_rename[]" value="{$user_group.gid}"{if in_array($user_group.gid, $access_rename)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Edit file'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="access_edit[]" value="{$user_group.gid}"{if in_array($user_group.gid, $access_edit)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Edit image'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="access_editimg[]" value="{$user_group.gid}"{if in_array($user_group.gid, $access_editimg)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Create directory'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="access_mkdir[]" value="{$user_group.gid}"{if in_array($user_group.gid, $access_mkdir)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
      </fieldset>

      <fieldset>
          <legend>{gt text='Options elFinder'}</legend>
          <div class="z-formrow">
            <label for="input-elfinder_theme">{gt text='Theme'}</label>
            <select name="elfinder_theme" id="input-elfinder_theme" class="form-control">
                <option value="default"{if $elfinder_theme == 'default'} selected="selected"{/if}>{gt text='Default'}</option>
                <option value="material-gray"{if $elfinder_theme == 'material-gray'} selected="selected"{/if}>Material grey</option>
                <option value="material"{if $elfinder_theme == 'material'} selected="selected"{/if}>Material dark</option>
                <option value="libreicons"{if $elfinder_theme == 'libreicons'} selected="selected"{/if}>Bootstrap LibreICONS</option>
                <option value="moono"{if $elfinder_theme == 'moono'} selected="selected"{/if}>Moono</option>
                <option value="windows-10"{if $elfinder_theme == 'windows-10'} selected="selected"{/if}>windows-10</option>
              </select>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_width">{gt text='Width'}</label>
            <input type="number" min="0" step="25" name="elfinder_width" value="{$elfinder_width}" placeholder="{gt text='Width'}" id="input-elfinder_width" class="form-control" />
            <span class="z-formnote z-sub">{gt text='Width of the window when selecting in pixels. Leave zero for automatic.'}"</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_height">{gt text='Height'}</label>
            <input type="number" min="0" step="25" name="elfinder_height" value="{$elfinder_height}" placeholder="{gt text='Height'}" id="input-elfinder_height" class="form-control" />
            <span class="z-formnote z-sub">{gt text='Height of the window when selecting in pixels. Leave zero for automatic.'}"</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_iconfiletype">{gt text='Show icon file type'}</label>
            <div>
                  <label class="radio-inline"><input type="radio" name="elfinder_iconfiletype" value="1"{if $elfinder_iconfiletype} checked="checked"{/if} /> {gt text='Enabled'}</label>
                  <label class="radio-inline"><input type="radio" name="elfinder_iconfiletype" value="0"{if !$elfinder_iconfiletype} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
            <span class="z-formnote z-sub">{gt text='If to show a little icon with type of the file in thumbnail.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_thumbsize">{gt text='Thumbnail size'}</label>
            <input type="number" min="0" max="300" step="5" name="elfinder_thumbsize" value="{$elfinder_thumbsize}" placeholder="{gt text='Thumbnail size'}" id="input-elfinder_thumbsize" class="form-control" />
            <span class="z-formnote z-sub">{gt text='Size of small images in pixels. At bigger value, they are slow to generate. Default 70.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_thumbcrop">{gt text='Thumbnail crop'}</label>
            <div>
                  <label class="radio-inline"><input type="radio" name="elfinder_thumbcrop" value="1"{if $elfinder_thumbcrop} checked="checked"{/if} /> {gt text='Enabled'}</label>
                  <label class="radio-inline"><input type="radio" name="elfinder_thumbcrop" value="0"{if !$elfinder_thumbcrop} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
            <span class="z-formnote z-sub">{gt text='If to resize and crop images to fit thumbnail size, or scale images to fit thumbnail size.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_thumbbgcolor">{gt text='Thumbnail background color'}</label>
            <input type="text" name="elfinder_thumbbgcolor" value="{$elfinder_thumbbgcolor}" id="input-elfinder_thumbbgcolor" class="colorpicker" />
            <span class="z-formnote z-sub">{gt text='Default: transparent'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-upload_mimeallowed">{gt text='Allowed MIME types'}</label>
            <textarea name="elfinder_upload_mimeallowed" rows="5" placeholder="{gt text='Allowed MIME types'}" id="input-upload_mimeallowed" class="form-control">{$elfinder_upload_mimeallowed}</textarea>
            <span class="z-formnote z-sub">{gt text='List of MIME types, with delimiter new line.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-upload_maxsize">{gt text='Maximum upload file size'}</label>
            <div>
              <input type="number" min="0" name="elfinder_upload_maxsize" value="{$elfinder_upload_maxsize}" placeholder="{gt text='Maximum upload file size'}" id="input-upload_maxsize" class="form-control" style="width: 33%;" />
              <input type="text" id="input-php_file_max_size" value="{$php_file_max_size|number_format}" title="{gt text='Data from PHP configuration'} min(upload_max_filesize, post_max_size, memory_limit)" class="form-control" style="width: 33%;" readonly />
            </div>
            <span class="z-formnote z-sub">{gt text='Number in bytes. Leave empty to use PHP limit. Note you still have to configure PHP files upload limits.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_loadtmbs">{gt text='Load thumbs'}</label>
            <input type="number" min="0" name="elfinder_loadtmbs" value="{$elfinder_loadtmbs}" placeholder="{gt text='Load thumbs'}" id="input-elfinder_loadtmbs" class="form-control" />
            <span class="z-formnote z-sub">{gt text='Amount of thumbnails to create per one request.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_showfiles">{gt text='Show files'}</label>
            <input type="number" min="0" name="elfinder_showfiles" value="{$elfinder_showfiles}" placeholder="{gt text='Show files'}" id="input-elfinder_showfiles" class="form-control" />
            <span class="z-formnote z-sub">{gt text='Amount of files display at once.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_places">{gt text='Folder selected'}</label>
            <div>
                  <label class="radio-inline"><input type="radio" name="elfinder_places" value="1"{if $elfinder_places} checked="checked"{/if} /> {gt text='Enabled'}</label>
                  <label class="radio-inline"><input type="radio" name="elfinder_places" value="0"{if !$elfinder_places} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
            <span class="z-formnote z-sub">{gt text='Whether to have an accessible folder (selected, favorites) to place links to places for easier and quicker access.'}</span>
          </div>
      </fieldset>

      {foreach from=$manage_roots key='rootid' item='manage_root'}
          <fieldset>
            <legend>{gt text='User drive'}</legend>
              <div class="z-formrow">
                <label for="input-manage_roots-subdir-{$rootid}">{gt text='Directory'}</label>
                <input type="text" name="manage_roots[{$rootid}][subdir]" value="{$manage_root.subdir}" placeholder="{gt text='Directory'}" id="input-manage_roots-subdir-{$rootid}" class="form-control" />
                <span class="z-formnote z-sub">{gt text='Directory relative to site root.'}</span>
              </div>
              <div class="z-formrow">
                <label for="input-manage_roots-alias-{$rootid}">{gt text='Alias'}</label>
                <input type="text" name="manage_roots[{$rootid}][alias]" value="{$manage_root.alias}" placeholder="{gt text='Alias'}" id="input-manage_roots-alias-{$rootid}" class="form-control" />
              </div>
              <div class="z-formrow">
                <label>{gt text='Access from modules'}</label>
                <div class="checkboxgroup" style="max-height: 105px;">
                    {foreach from=$manage_root.mods item='root_mod'}
                    <div class="checkbox" style="display: inline-block;">
                      <label><input type="checkbox" name="manage_roots[{$rootid}][mods][]" value="{$root_mod|lower}" checked="checked" /> {$root_mod|ucfirst} </label>
                    </div>
                    {/foreach}
                    <br />
                    {foreach from=$modules item='module'}
                      {if !in_array($module.name|lower, $manage_root.mods)}
                        <div class="checkbox" style="display: inline-block;">
                          <label><input type="checkbox" name="manage_roots[{$rootid}][mods][]" value="{$module.name|lower}" /> {$module.name} </label>
                        </div>
                      {/if}
                    {/foreach}
                </div>
              </div>
          </fieldset>
      {/foreach}

      <fieldset>
          <legend>{gt text='FTP drive'}</legend>
          <div class="z-informationmsg"><i class="fa fa-info-circle"></i> {gt text='Mounting FTP root on server for access with file manger. Available in menu "File manager" (not when selecting images)'}</div>
          <div class="z-formrow">
            <label>{gt text='Status'} {gt text='FTP drive'}</label>
            <div>
              <label class="radio-inline"><input type="radio" name="elfinder_ftp_status" value="1"{if $elfinder_ftp_status} checked="checked"{/if} /> {gt text='Enabled'}</label>
              <label class="radio-inline"><input type="radio" name="elfinder_ftp_status" value="0"{if !$elfinder_ftp_status} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Name'}</label>
            <div class="input-block">
            {foreach from=$languages key='langcode' item='language'}
                <div class="input-group">
                    <input type="text" name="elfinder_ftp_alias[{$langcode}]" value="{$elfinder_ftp_alias[$langcode]}"  placeholder="{gt text='Name'}" class="form-control" /> 
                    {$language}<br />
                </div>
            {/foreach}
            </div>
            <span class="z-formnote z-sub">{gt text='Name to display in the file manager directory field.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_ftp_host">{gt text='Host'}</label>
            <input type="text" name="elfinder_ftp_host" value="{$elfinder_ftp_host}" placeholder="{gt text='Host'}" id="input-elfinder_ftp_host" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_ftp_un">{gt text='Username'}</label>
            <div class="input-group">
                <span class="input-group-addon" id="toggle-ftpunview"><img src="images/icons/small/xeyes.png" alt="" /></span>
                <input type="password" name="elfinder_ftp_un" value="{$elfinder_ftp_un}" placeholder="{gt text='Username'}" id="input-elfinder_ftp_un" class="form-control" />
            </div>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_ftp_pw">{gt text='Password'}</label>
            <div class="input-group">
                <span class="input-group-addon" id="toggle-ftppwview"><img src="images/icons/small/xeyes.png" alt="" /></i></span>
                <input type="password" name="elfinder_ftp_pw" value="{$elfinder_ftp_pw}" placeholder="{gt text='Password'}" id="input-elfinder_ftp_pw" class="form-control" />
            </div>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_ftp_port">{gt text='FTP port'}</label>
            <input type="number" min="0" name="elfinder_ftp_port" value="{$elfinder_ftp_port}" placeholder="{gt text='FTP port'}" id="input-elfinder_ftp_port" class="form-control" />
            <span class="z-formnote z-sub">{gt text='Default FTP port is 21.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-elfinder_ftp_mode">{gt text='FTP mode'}</label>
            <div>
              <label class="radio-inline"><input type="radio" name="elfinder_ftp_mode" value="active"{if $elfinder_ftp_mode == 'active'} checked="checked"{/if} /> active</label>
              <label class="radio-inline"><input type="radio" name="elfinder_ftp_mode" value="passive"{if !$elfinder_ftp_mode == 'passive'} checked="checked"{/if} /> passive</label>
            </div>
            <span class="z-formnote z-sub">{gt text='Try passive mode if you have problems in FTP connection.'}</span>
          </div>
          <div class="z-formrow">
            <label>{gt text='Available for groups'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="elfinder_ftp_accessgroups[]" value="{$user_group.gid}"{if in_array($user_group.gid, $elfinder_ftp_accessgroups)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
      </fieldset>

      <fieldset>
          <legend>{gt text='Root drive'}</legend>
          <div class="z-informationmsg"><i class="fa fa-info-circle"></i> {gt text='Mounting root of the site on server for access with file manger. Available in menu "File manager" (not when selecting images)'}</div>
          <div class="z-formrow">
            <label>{gt text='Status'} {gt text='Root drive'}</label>
            <div>
              <label class="radio-inline"><input type="radio" name="elfinder_root_status" value="1"{if $elfinder_root_status} checked="checked"{/if} /> {gt text='Enabled'}</label>
              <label class="radio-inline"><input type="radio" name="elfinder_root_status" value="0"{if !$elfinder_root_status} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
          </div>
          <div class="z-formrow">
            <label>{gt text='Name'}</label>
            <div class="input-block">
            {foreach from=$languages key='langcode' item='language'}
                <div class="input-group">
                    <input type="text" name="elfinder_root_alias[{$langcode}]" value="{$elfinder_root_alias[$langcode]}"  placeholder="{gt text='Name'}" class="form-control" />
                    {$language}<br />
                </div>
            {/foreach}
            </div>
            <span class="z-formnote z-sub">{gt text='Name to display in the file manager directory field.'}</span>
          </div>
          <div class="z-formrow">
            <label>{gt text='Available for groups'}</label>
            <div class="checkboxgroup">
                {foreach from=$user_groups item='user_group'}
                <div class="checkbox">
                  <label><input type="checkbox" name="elfinder_root_accessgroups[]" value="{$user_group.gid}"{if in_array($user_group.gid, $elfinder_root_accessgroups)} checked="checked"{/if} /> {$user_group.name} </label>
                </div>
                {/foreach}
            </div>
          </div>
      </fieldset>

      <fieldset>
          <legend>{gt text='Auto resize'}</legend>
          <div class="z-formrow">
            <label>{gt text='Status'} {gt text='Auto resize'}</label>
            <div>
              <label class="radio-inline"><input type="radio" name="autoresize_status" value="1"{if $autoresize_status} checked="checked"{/if} /> {gt text='Enabled'}</label>
              <label class="radio-inline"><input type="radio" name="autoresize_status" value="0"{if !$autoresize_status} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
          </div>
          <div class="z-formrow">
            <label for="input-autoresize_mode">{gt text='Mode'}</label>
            <select name="autoresize_mode" id="input-autoresize_mode" class="form-control">
                <option value="0"{if $autoresize_mode == 0} selected="selected"{/if}>{gt text='Inactive by default, it is activated with a control key while drag and drop'}</option>
                <option value="1"{if $autoresize_mode == 1} selected="selected"{/if}>{gt text='Active by default, it is deactivated with a control key while drag and drop'}</option>
            </select>
          </div>
          <div class="z-formrow">
            <label for="input-autoresize_key">{gt text='Control key while dropping image'}</label>
            <select name="autoresize_key[]" id="input-autoresize_key" size="4" multiple class="form-control">
                <option value="8"{if in_array(8, $autoresize_key)} selected="selected"{/if}>Alt</option>
                <option value="4"{if in_array(4, $autoresize_key)} selected="selected"{/if}>Ctrl</option>
                <option value="1"{if in_array(1, $autoresize_key)} selected="selected"{/if}>Shift</option>
                <option value="2"{if in_array(2, $autoresize_key)} selected="selected"{/if}>Meta</option>
            </select>
            <span class="z-formnote z-sub">{gt text='Control key while dropping image to activate or deactivate according to mode. You can select more than one, will act each of the selected ones.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-autoresize_maxwidth">{gt text='Max width'}</label>
            <input type="number" min="0" step="50" name="autoresize_maxwidth" value="{$autoresize_maxwidth}" placeholder="{gt text='Max width'}" id="input-autoresize_maxwidth" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-autoresize_maxheight">{gt text='Max height'}</label>
            <input type="number" min="0" step="50" name="autoresize_maxheight" value="{$autoresize_maxheight}" placeholder="{gt text='Max height'}" id="input-autoresize_maxheight" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-autoresize_quality">{gt text='JPG quality'}</label>
            <input type="number" min="0" step="5" max="100" name="autoresize_quality" value="{$autoresize_quality}" placeholder="{gt text='JPG quality'}" id="input-autoresize_quality" class="form-control" />
          </div>
          <div class="z-formrow">
            <label>{gt text='Preserve EXIF data'}</label>
            <div>
              <label class="radio-inline"><input type="radio" name="autoresize_exif" value="1"{if $autoresize_exif} checked="checked"{/if} /> {gt text='Enabled'}</label>
              <label class="radio-inline"><input type="radio" name="autoresize_exif" value="0"{if !$autoresize_exif} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
          </div>
      </fieldset>

      <fieldset>
          <legend>{gt text='Watermark'}</legend>
          <div class="z-formrow">
            <label>{gt text='Status'} {gt text='Watermark'}</label>
            <div>
              <label class="radio-inline"><input type="radio" name="watermark_status" value="1"{if $watermark_status} checked="checked"{/if} /> {gt text='Enabled'}</label>
              <label class="radio-inline"><input type="radio" name="watermark_status" value="0"{if !$watermark_status} checked="checked"{/if} /> {gt text='Disabled'}</label>
            </div>
          </div>
          <div class="z-formrow">
            <label for="input-watermark_mode">{gt text='Mode'}</label>
            <select name="watermark_mode" id="input-watermark_mode" class="form-control">
                <option value="0"{if $watermark_mode == 0} selected="selected"{/if}>{gt text='Inactive by default, it is activated with a control key while drag and drop'}</option>
                <option value="1"{if $watermark_mode == 1} selected="selected"{/if}>{gt text='Active by default, it is deactivated with a control key while drag and drop'}</option>
            </select>
          </div>
          <div class="z-formrow">
            <label for="input-watermark_key">{gt text='Control key while dropping image'}</label>
            <select name="watermark_key[]" id="input-watermark_key" size="4" multiple class="form-control">
                <option value="8"{if in_array(8, $watermark_key)} selected="selected"{/if}>Alt</option>
                <option value="4"{if in_array(4, $watermark_key)} selected="selected"{/if}>Ctrl</option>
                <option value="1"{if in_array(1, $watermark_key)} selected="selected"{/if}>Shift</option>
                <option value="2"{if in_array(2, $watermark_key)} selected="selected"{/if}>Meta</option>
            </select>
            <span class="z-formnote z-sub">{gt text='Control key while dropping image to activate or deactivate according to mode. You can select more than one, will act each of the selected ones.'}</span>
          </div>
          <div class="z-formrow">
            <label for="input-watermark_source">{gt text='Watermark image'}</label>
            <a href="#" id="button-watermark_source" data-toggle="image" class="z-iconlink z-icon-es-search" title="{gt text='Select image'}"></a>
            <input type="text" name="watermark_source" value="{$watermark_source}" placeholder="{gt text='Watermark image'}" id="input-watermark_source" style="display: inline; width: 60%;" />
            {if $watermark_source}
            <div class="z-formnote">
                <a href="{$watermark_source}" id="href-watermark_source" class="img-href img-thumb"  rel="lightbox" target="_blank"><img src="{$watermark_source}" id="thumb-watermark_source" class="img-thumb" alt="" /></a>
            </div>
            {/if}
          </div>
          <div class="z-formrow">
            <label for="input-watermark_marginright">{gt text='Margin right, px'}</label>
            <input type="number" name="watermark_marginright" value="{$watermark_marginright}" placeholder="{gt text='Margin right, px'}" id="input-watermark_marginright" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-watermark_marginbottom">{gt text='Margin bottom, px'}</label>
            <input type="number" name="watermark_marginbottom" value="{$watermark_marginbottom}" placeholder="{gt text='Margin bottom, px'}" id="input-watermark_marginbottom" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-watermark_quality">{gt text='JPG quality'}</label>
            <input type="number" min="0" step="5" max="100" name="watermark_quality" value="{$watermark_quality}" placeholder="{gt text='JPG quality'}" id="input-watermark_quality" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-watermark_transparency">{gt text='Transparency, %'}</label>
            <input type="number" min="0" step="5" max="100" name="watermark_transparency" value="{$watermark_transparency}" placeholder="{gt text='Transparency, %'}" id="input-watermark_transparency" class="form-control" />
          </div>
          <div class="z-formrow">
            <label for="input-watermark_minpixel">{gt text='Target image minimum size, px'}</label>
            <input type="number" min="0" step="10" name="watermark_minpixel" value="{$watermark_minpixel}" placeholder="{gt text='Target image minimum size, px'}" id="input-watermark_minpixel" class="form-control" />
          </div>
      </fieldset>

    <div class="z-buttons z-formbuttons">
        {button src="button_ok.png" set="icons/extrasmall" __alt="Save" __title="Save" __text="Save"}
        <a href="{modurl modname="Zfiler" type="admin" func='main'}" title="{gt text="Cancel"}">{img modname=core src="button_cancel.png" set="icons/extrasmall" __alt="Cancel" __title="Cancel"} {gt text="Cancel"}</a>
    </div>
</form>
<script type="text/javascript"><!--
jQuery(document).ready(function() {
    jQuery('#toggle-ftppwview').on('click', function() {
        var input = jQuery('#input-elfinder_ftp_pw');
        if (input.attr('type') == 'password') {
            input.attr('type', 'text');
        } else {
            input.attr('type', 'password');
        }
    });

    jQuery('#toggle-ftpunview').on('click', function() {
        var input = jQuery('#input-elfinder_ftp_un');
        if (input.attr('type') == 'password') {
            input.attr('type', 'text');
        } else {
            input.attr('type', 'password');
        }
    });

    // load color picker for colors
    jQuery('.colorpicker').each(function(){
        jQuery(this).spectrum({
            //color: jQuery(this).val(),
            allowEmpty: true,
            preferredFormat: "rgb",
            showAlpha: true,
            showInitial: true,
            showInput: true,
            showPalette: true,
            showSelectionPalette: true,
            maxSelectionSize: 20,
            palette: [
        ["#000","#444","#666","#999","#ccc","#eee","#f3f3f3","#fff"],
        ["#f00","#f90","#ff0","#0f0","#0ff","#00f","#90f","#f0f"],
        ["#f4cccc","#fce5cd","#fff2cc","#d9ead3","#d0e0e3","#cfe2f3","#d9d2e9","#ead1dc"],
        ["#ea9999","#f9cb9c","#ffe599","#b6d7a8","#a2c4c9","#9fc5e8","#b4a7d6","#d5a6bd"],
        ["#e06666","#f6b26b","#ffd966","#93c47d","#76a5af","#6fa8dc","#8e7cc3","#c27ba0"],
        ["#c00","#e69138","#f1c232","#6aa84f","#45818e","#3d85c6","#674ea7","#a64d79"],
        ["#900","#b45f06","#bf9000","#38761d","#134f5c","#0b5394","#351c75","#741b47"],
        ["#600","#783f04","#7f6000","#274e13","#0c343d","#073763","#20124d","#4c1130"]
            ],
            localStorageKey: "spectrum.comopl",
            cancelText: '{{gt text='Cancel'}}',
            chooseText: '{{gt text='Yes'}}'
        });
     });
});
//--></script>
{adminfooter}