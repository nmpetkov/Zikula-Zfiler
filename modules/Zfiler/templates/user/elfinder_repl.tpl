<div id="elfinder"></div>

{include file='user/elfinder_common.tpl'}

<script type="text/javascript"><!--
jQuery(document).ready(function() {
  if (typeof jQuery.ui == 'undefined') {
      alert('alfinder requirment: jQuery.ui is not loaded!');
  } else {
    var opts = {
        baseUrl:     '{{$url_base}}',
        url:         '{{$url_connector}}',
        height:      {{if $elfinder_height}}{{$elfinder_height}}{{else}}Math.max(400, jQuery(window).height()*0.75){{/if}},
        lang:        '{{$lang_elfinder}}',
        loadTmbs:    {{$elfinder_loadtmbs}},
        showFiles:   {{$elfinder_showfiles}},
        resizable:   false,
        ui: ['toolbar', 'tree'{{if $elfinder_places}}, 'places'{{/if}}, 'path', 'stat'],
        commandsOptions: {
            getfile: { multiple: {{if $select_multiple}}true{{else}}false{{/if}} },
            help: { view : ['about', 'shortcuts'] },
            edit: { extraOptions: { creativeCloudApiKey: '6e62687b643a413cbb6aedf72ced95e3' } },
            quicklook: { googleDocsMimes : ['application/pdf', 'image/tiff', 'application/vnd.ms-office', 'application/msword', 'application/vnd.ms-word', 'application/vnd.ms-excel', 'application/vnd.ms-powerpoint', 'application/vnd.openxmlformats-officedocument.wordprocessingml.document', 'application/vnd.openxmlformats-officedocument.spreadsheetml.sheet'] }
        },
        closeOnEditorCallback: true,
        getFileCallback: 
            function(files, fm) {
                var target = {{if $target}}'{{$target}}'{{else}}''{{/if}};
                var thumb = {{if $thumb}}'{{$thumb}}'{{else}}''{{/if}};
                var href = {{if $href}}'{{$href}}'{{else}}''{{/if}};
                if (files.constructor == Array) {
                    // array of files selected
                    comoWriteToTarget(files[0], fm, target, thumb, href);
                } else {
                    // string (single file selected)
                    comoWriteToTarget(files, fm, target, thumb, href);
                }

                jQuery('#modal-filer').dialog('close');
                fm.hide();
            }
    };

    jQuery('#elfinder').elfinder(opts);
  }
});

function comoWriteToTarget(file, fm, target, thumb, href) {
    file.path = file.url.substring(Zikula.Config.baseURL.length); // extract from url, because alias or subdirectory
    if (target || thumb || href) {
        if (target) {
            jQuery('#' + target).val(file.path);
        }
        if (thumb) {
            //jQuery('#' + thumb).find('img').attr('src', file.tmb);
            jQuery('#' + thumb).find('img').attr('src', file.url);
        }
        if (href) {
            jQuery('#' + href).attr('href', file.url);
        }
    } else {
        if (typeof CKEDITOR !== "undefined" && typeof CKEDITOR.dialog !== "undefined") {
            var dialog = CKEDITOR.dialog.getCurrent();
            if (typeof dialog !== "undefined" && dialog) {
                var dialogDefinition = dialog.definition;
                var tabCount = dialogDefinition.contents.length;
                for (var i = 0; i < tabCount; i++) {
                    var browseButton = dialogDefinition.contents[i].get('browse');
                    if (browseButton !== null) {
                        var cke_target = browseButton.filebrowser.target; // like 'tab1:id1'
                        var aTarget = cke_target.split(':');
                        dialog.setValueOf(aTarget[0], aTarget[1], file.url);
                    }
                }
            }
        }
    }
}
//--></script>
