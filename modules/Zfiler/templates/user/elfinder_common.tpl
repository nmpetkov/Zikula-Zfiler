<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/css/elfinder.min.css" rel="stylesheet" media="screen" />
{if $elfinder_theme == 'material-gray'}
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/themes/Material/css/theme-gray.min.css" rel="stylesheet" media="screen" />
{elseif $elfinder_theme == 'material'}
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/themes/Material/css/theme.min.css" rel="stylesheet" media="screen" />
{elseif $elfinder_theme == 'libreicons'}
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/themes/LibreICONS/css/theme-bootstrap-libreicons-svg.css" rel="stylesheet" media="screen" />
{elseif $elfinder_theme == 'moono'}
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/themes/moono/css/theme.css" rel="stylesheet" media="screen" />
{elseif $elfinder_theme == 'windows-10'}
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/themes/windows-10/css/theme.css" rel="stylesheet" media="screen" />
{else}
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/css/theme.css" rel="stylesheet" media="screen" />
<link type="text/css" href="modules/Zfiler/javascript/vendor/elfinder/themes/Como/default.overwrite.css" rel="stylesheet" media="screen" />
{/if}
<link type="text/css" href="modules/Zfiler/style/elfinder.css" rel="stylesheet" media="screen" />
<script type="text/javascript" src="modules/Zfiler/javascript/vendor/elfinder/js/elfinder.min.js"></script>
<script type="text/javascript" src="modules/Zfiler/javascript/vendor/elfinder/js/extras/editors.default.min.js"></script>
{if $lang_elfinder != 'en'}<script type="text/javascript" src="modules/Zfiler/javascript/vendor/elfinder/js/i18n/elfinder.{$lang_elfinder}.js"></script>{/if}
<style type="text/css">
{{if !$elfinder_iconfiletype}}
    .elfinder-cwd-icon-image::before {
        display: none;
    }
{{/if}}
.elfinder-cwd-icon {
    margin: {{$elfinder_foldmargin_y}}px {{$elfinder_foldmargin_x}}px !important;
}
.elfinder-cwd-bgurl:after, .elfinder-cwd-bgurl { /* icon/thumbnail */
    width: {{$elfinder_thumbsize}}px !important;
    height: {{$elfinder_thumbsize}}px !important;
    margin:0 !important;
}
.elfinder-cwd-view-icons .elfinder-cwd-file-wrapper { /* icon wrapper to create selected highlight around icon */
    width: {{math equation="x + y" x=$elfinder_thumbsize y=4}}px !important; /* 52px */
    height: {{math equation="x + y" x=$elfinder_thumbsize y=4}}px !important; /* 52px */
}
.elfinder-cwd-view-icons .elfinder-cwd-file { /* file container */
    width: {{math equation="x + y" x=$elfinder_thumbsize y=72}}px !important; /* 120px */
    height: {{math equation="x + y" x=$elfinder_thumbsize y=52}}px !important; /* 90px */
    overflow: hidden !important;
}
.ui-dialog .ui-dialog-content {
    padding: 0;
}
</style>
