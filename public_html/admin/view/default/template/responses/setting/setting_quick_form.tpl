<div id="setting_form" class="tab-content">
	<?php echo $form['form_open']; ?>
	<div class="panel-body panel-body-nopadding">
		<label class="h4 heading"><?php echo $form_title; ?></label>
			<?php foreach ($form['fields'] as $name => $field) { ?>
			<?php
				//Logic to calculate fields width
				$widthcasses = "col-sm-7";
				if ( is_int(stripos($field->style, 'large-field')) ) {
					$widthcasses = "col-sm-7";
				} else if ( is_int(stripos($field->style, 'medium-field')) || is_int(stripos($field->style, 'date')) ) {
					$widthcasses = "col-sm-5";
				} else if ( is_int(stripos($field->style, 'small-field')) || is_int(stripos($field->style, 'btn_switch')) ) {
					$widthcasses = "col-sm-3";
				} else if ( is_int(stripos($field->style, 'tiny-field')) ) {
					$widthcasses = "col-sm-2";
				}
				$widthcasses .= " col-xs-12";
			?>
		<div class="form-group <? if (!empty($error[$name])) { echo "has-error"; } ?>">
			<label class="control-label col-sm-3 col-xs-12" for="<?php echo $field->element_id; ?>"><?php echo ${'entry_' . $name}; ?></label>
			<div class="input-group afield <?php echo $widthcasses; ?> <?php echo (is_int(strpos($name, 'description')) ? 'ml_ckeditor' : '')?>">
				<?php echo $field; ?>
			</div>
			<?php if (!empty($error[$name])) { ?>
			<span class="help-block field_err"><?php echo $error[$name]; ?></span>
			<?php } ?>
		</div>
		<?php
		if($name=='template'){ ?>
			<div class="form-group">
				<label class="control-label col-sm-3 col-xs-12" ></label>
				<div id="template_preview" class="input-group afield <?php echo $widthcasses; ?>">

				</div>
			</div>
		<?php }
		}  ?>

	</div>
	<div class="panel-footer">
		<div class="row">
		   <div class="center col-sm-6 col-sm-offset-3">
			 <button class="btn btn-primary">
			 <i class="fa fa-save"></i> <?php echo $form['submit']->text; ?>
			 </button>&nbsp;
			 <a class="btn btn-default" data-dismiss="modal" href="<?php echo $cancel; ?>">
			 <i class="fa fa-refresh"></i> <?php echo $form['cancel']->text; ?>
			 </a>
		   </div>
		</div>
	</div>
	</form>
</div>

<script type="text/javascript">
	$('#qsFrm').submit(function () {
		$.ajax(
				{   url: '<?php echo $form['form_open']->action; ?>',
					type: 'POST',
					data: $('#qsFrm').serializeArray(),
					dataType: 'json',
					success: function (data) {
						if (data.error_text != '') {
							error_alert(data.error_text, true, $("#setting_form") );
						} else if (data.result_text != '') {
							success_alert(data.result_text, false, "#setting_form");
						}
					}
				});
		return false;
	});


$('#template_preview').load('<?php echo $template_image; ?>&template=' + $('#qsFrm_config_storefront_template').val());
    $('#qsFrm_config_storefront_template').change(function () {
        $('#template_preview').load('<?php echo $template_image; ?>&template=' + $('#qsFrm_config_storefront_template').val())
    });

</script>




