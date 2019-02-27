{pageaddvar name='javascript' value='jquery-1.11.2'}
{if $coredata.version_num < '1.4.0'}
    {pageaddvar name='stylesheet' value='javascript/jquery-ui-1.12/themes/base/jquery-ui.css'}
    {pageaddvar name='javascript' value='javascript/jquery-ui-1.12/jquery-ui.min.js'}
{else}
    {pageaddvar name='stylesheet' value='web/jquery-ui/themes/base/jquery-ui.css'}
{/if}

<div id="elfinder"></div>

{include file='user/elfinder_common.tpl'}
<script type="text/javascript"><!--
jQuery(document).ready(function() {
    var opts = {
        baseUrl:     '{{$url_base}}',
        url:         '{{$url_connector}}',
        height:      Math.max(350, jQuery(window).height() - jQuery('#theme_header').height() - jQuery('#theme_navigation_bar').height() - 270),
        lang:        '{{$lang_elfinder}}',
        loadTmbs:    {{$elfinder_loadtmbs}},
        showFiles:   {{$elfinder_showfiles}},
        resizable:   true,
         ui: ['toolbar', 'tree'{{if $elfinder_places}}, 'places'{{/if}}, 'path', 'stat'],
        commandsOptions: {
            help: { view : ['about', 'shortcuts'] },
            edit: { extraOptions: { creativeCloudApiKey: '6e62687b643a413cbb6aedf72ced95e3' } },
            quicklook: { googleDocsMimes : ['application/pdf', 'image/tiff', 'application/vnd.ms-office', 'application/msword', 'application/vnd.ms-word', 'application/vnd.ms-excel', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'] }
        },
    };
    jQuery('#elfinder').elfinder(opts);
});
//--></script>
