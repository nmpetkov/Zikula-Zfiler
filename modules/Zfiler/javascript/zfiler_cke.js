jQuery(window).load(function(){
    if (typeof CKEDITOR !== 'undefined') {
        CKEDITOR.on('dialogDefinition', function (event) {
            var editor = event.editor;
            var dialogDefinition = event.data.definition;
            var tabCount = dialogDefinition.contents.length;
            for (var i = 0; i < tabCount; i++) {
                var browseButton = dialogDefinition.contents[i].get('browse');
                if (browseButton !== null) {
                    browseButton.hidden = false;
                    browseButton.onClick = function() {
                        jQuery('#modal-filer').remove();
                        jQuery.ajax({
                            url: Zikula.Config.baseURL + 'ajax.php?module=zfiler&type=ajax&func=filemanager_repl&multiple=0',
                            dataType: 'json',
                            beforeSend: function() {
                                //$button.prop('disabled', true);
                            },
                            complete: function() {
                                //$button.prop('disabled', false);
                            },
                            success: function(data) {
                                jQuery('body').append('<div id="modal-filer" class="modal">' + data.html + '</div>');
                                jQuery('#modal-filer').dialog({
                                    modal: true, 
                                    width: data.width ? data.width : '80%',
                                    position: { at: 'top+15%' },
                                    resizable: false,
                                    title: data.title
                                });
                            },
                            error: function(xhr, ajaxOptions, thrownError){
                                alert(xhr.responseText);
                            }
                        });	
                    }
                }
            }
        });
    }
});
