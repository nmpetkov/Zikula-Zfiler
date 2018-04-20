jQuery(document).ready(function() {
    jQuery('a[data-toggle="image"],button[data-toggle="image"]').on('click', function(event) {
        event.preventDefault();
		var $element = jQuery(this);
        var $button = jQuery(this);
        jQuery('#modal-filer').remove();
        jQuery.ajax({
            url: Zikula.Config.baseURL + 'ajax.php?module=zfiler&type=ajax&func=filemanager_repl&multiple=0&target=' + $element.parent().find('input').attr('id') + '&thumb=' + $element.parent().find('a.img-thumb').attr('id') + '&href=' + $element.parent().find('a.img-href').attr('id'),
            dataType: 'json',
            beforeSend: function() {
                $button.prop('disabled', true);
            },
            complete: function() {
                $button.prop('disabled', false);
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
            }
        });
    });

    // Close modal dialog if click outside
    jQuery(".ui-widget-overlay").live("click", function (){
      jQuery("div:ui-dialog:visible").dialog("close");
    });
});
