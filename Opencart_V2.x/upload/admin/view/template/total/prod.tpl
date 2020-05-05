<?php echo $header; ?><?php echo $column_left; ?>
<div id="content">
	<div class="page-header">
		<div class="container-fluid">
			<div class="pull-right">
				<button type="submit" form="form-prod" data-toggle="tooltip" title="<?php echo $button_save; ?>" class="btn btn-primary"><i class="fa fa-save"></i></button>
				<a href="<?php echo $cancel; ?>" data-toggle="tooltip" title="<?php echo $button_cancel; ?>" class="btn btn-default"><i class="fa fa-reply"></i></a></div>
			<h1><?php echo $heading_title; ?></h1>
			<ul class="breadcrumb">
				<?php foreach ($breadcrumbs as $breadcrumb) { ?>
				<li><a href="<?php echo $breadcrumb['href']; ?>"><?php echo $breadcrumb['text']; ?></a></li>
				<?php } ?>
			</ul>
		</div>
	</div>
	<div class="container-fluid">
		<?php if ($error_warning) { ?>
		<div class="alert alert-danger"><i class="fa fa-exclamation-circle"></i> <?php echo $error_warning; ?>
			<button type="button" class="close" data-dismiss="alert">&times;</button>
		</div>
		<?php } ?>
		<?php if ($success) { ?>
	    <div class="alert alert-success"><i class="fa fa-check-circle"></i> <?php echo $success; ?>
	      <button type="button" class="close" data-dismiss="alert">&times;</button>
	    </div>
	    <?php } ?>
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="fa fa-pencil"></i> <?php echo $text_edit; ?></h3>
			</div>
			<div class="panel-body">
				<form action="<?php echo $action; ?>" method="post" enctype="multipart/form-data" id="form-prod" class="form-horizontal">
					<div class="form-group">
			            <label class="col-sm-2 control-label" for="input-total"><span data-toggle="tooltip" title="<?php echo $help_entry_total; ?>"><?php echo $entry_total; ?></span></label>
			            <div class="col-sm-10">
			              <input type="text" name="prod_total" value="<?php echo $prod_total; ?>" placeholder="<?php echo $entry_total; ?>" id="input-total" class="form-control" />
			            </div>
			          </div>
					
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_geo_zone; ?></label>
						<div class="col-sm-10">
							<select name="prod_geo_zone" class="form-control">
								<option value="0"><?php echo $text_all_zones; ?></option>
								<?php foreach($geo_zones as $geo_zone) { ?>
								<?php if($geo_zone['geo_zone_id'] == $prod_geo_zone) { ?>
								<option value="<?php echo $geo_zone['geo_zone_id']; ?>" selected="selected"><?php echo $geo_zone['name']; ?></option>
								<?php } else { ?>
								<option value="<?php echo $geo_zone['geo_zone_id']; ?>"><?php echo $geo_zone['name']; ?></option>
								<?php } ?>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">
							<span data-toggle="tooltip" title="<?php echo $help_entry_text_opt; ?>">
								<?php echo $entry_text_opt; ?>
							</span>
						</label>
						<div class="col-sm-10">
							<?php foreach($languages as $language) { ?>
							<div class="input-group">
								<span class="input-group-addon">
									<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
								</span>
								<input type="text" name="prod_text_opt[<?php echo $language['language_id']; ?>]" value="<?php echo isset($prod_text_opt[$language['language_id']])? $prod_text_opt[$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_text_opt_default; ?>" class="form-control" />
							</div>
							<br/>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label">
							<span data-toggle="tooltip" title="<?php echo $help_entry_text_total; ?>">
								<?php echo $entry_text_total; ?>
							</span>
						</label>
						<div class="col-sm-10">
							<?php foreach($languages as $language) { ?>
							<div class="input-group">
								<span class="input-group-addon">
									<img src="view/image/flags/<?php echo $language['image']; ?>" title="<?php echo $language['name']; ?>" />
								</span>
								<input type="text" name="prod_text_total[<?php echo $language['language_id']; ?>]" value="<?php echo isset($prod_text_total[$language['language_id']])? $prod_text_total[$language['language_id']] : ''; ?>" placeholder="<?php echo $entry_text_total_default; ?>" class="form-control" />
							</div>
							<br/>
							<?php } ?>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_status; ?></label>
						<div class="col-sm-10">
							<select name="prod_status" class="form-control">
								<?php if ($prod_status) { ?>
								<option value="1" selected="selected"><?php echo $text_enabled; ?></option>
								<option value="0"><?php echo $text_disabled; ?></option>
								<?php } else { ?>
								<option value="1"><?php echo $text_enabled; ?></option>
								<option value="0" selected="selected"><?php echo $text_disabled; ?></option>
								<?php } ?>
							</select>
						</div>
					</div>
					<div class="form-group">
						<label class="col-sm-2 control-label"><?php echo $entry_sort_order; ?></label>
						<div class="col-sm-10">
							<input type="text" name="prod_sort_order" value="<?php echo $prod_sort_order; ?>" placeholder="<?php echo $entry_sort_order; ?>" id="input-sort-order" class="form-control" />
						</div>
					</div>
					 <div class="form-group">
		            	<div class="col-sm-12">
							<table id="prod_methods" class="table table-striped table-bordered table-hover">
								<thead>
									<tr>
										<td width="30%">
											<span data-toggle="tooltip" title="<?php echo $help_column_payment_method; ?>"><?php echo $column_payment_method; ?>
											</span>
										</td>
										<td width="30%">
											<span data-toggle="tooltip" title="<?php echo $help_column_payment_type; ?>">
												<?php echo $column_payment_type; ?>
											</span>
										</td>
										<td width="30%">
											<span data-toggle="tooltip" title="<?php echo $help_column_payment_amount; ?>">
											<?php echo $column_payment_amount; ?>
											</span>
										</td>
										<td>&nbsp;</td>
									</tr>
								</thead>
								<tbody>
									<?php $row = 0; ?>
									<?php foreach($prod_methods as $method) { ?>
									<tr id="prod-row<?php echo $row; ?>">
										<td class="text-left">
											<select name="prod_methods[<?php echo $row; ?>][payment_method]" class="form-control">
												<?php foreach($payment_methods as $key => $value) { ?>
												<?php if($value['code'] == $method['payment_method']) { ?>
												<option value="<?php echo $value['code']; ?>" selected="selected"><?php echo $value['name']; ?></option>
												<?php } else { ?>
												<option value="<?php echo $value['code']; ?>"><?php echo $value['name']; ?></option>
												<?php } ?>
												<?php } ?>
											</select>
											<?php if(isset($error_prod_methods[$row]['payment_method'])) { ?>
											<div class="text-danger"><?php echo $error_prod_methods[$row]['payment_method']; ?></div>
											<?php } ?>
					                 	</td>
					                 	<td class="text-left">
											<select name="prod_methods[<?php echo $row; ?>][payment_type]" class="form-control">
												<option value="percentage" <?php echo !empty($method['payment_type']) && $method['payment_type'] == "percentage"? 'selected' : ''; ?>>
													<?php echo $text_percentage; ?>
												</option>
												<option value="flat" <?php echo !empty($method['payment_type']) && $method['payment_type'] == "flat"? 'selected' : ''; ?>>
													<?php echo $text_flat_amount; ?>
												</option>
											</select>
											<?php if(isset($error_prod_methods[$row]['payment_type'])) { ?>
											<div class="text-danger"><?php echo $error_prod_methods[$row]['payment_type']; ?></div>
											<?php } ?>
										</td>
										<td class="text-left">
											<input type="text" name="prod_methods[<?php echo $row; ?>][payment_amount]" class="form-control" value="<?php echo $method['payment_amount']; ?>">
											<?php if(isset($error_prod_methods[$row]['payment_amount'])) { ?>
											<div class="text-danger"><?php echo $error_prod_methods[$row]['payment_amount']; ?></div>
											<?php } ?>
										</td>
										<td>
											<button type="button" onclick="addRow();" data-toggle="tooltip" title="<?php echo $button_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button>
										</td>
					                 </tr>
					            <?php $row = $row + 1; ?>
								<?php } ?>
								</tbody>
							<tfoot>
				                  <tr>
				                    <td colspan="3"></td>
				                    <td class="text-left"><button type="button" onclick="addRow();" data-toggle="tooltip" title="<?php echo $button_banner_add; ?>" class="btn btn-primary"><i class="fa fa-plus-circle"></i></button></td>
				                  </tr>
				                </tfoot>
				              </table>
						</div>
					</div>
				</form>
			</div>
		</div>
	</div>
</div>
<script type="text/javascript"><!--
var row = <?php echo $row; ?>

function addRow() {
	html	=	'<tr id="prod-row' + row + '">';

	html	+=		'<td class="text-left">'
			+			'<select name="prod_methods[' + row + '][payment_method]" class="form-control">';
							<?php foreach($payment_methods as $key => $value) { ?>
	html	+=				'<option value="<?php echo $value['code'];?>"><?php echo $value['name']; ?></option>';
							<?php } ?>
	html	+=			'</select>'
			+		'</td>';

	html	+=		'<td class="text-left">'
			+			'<select name="prod_methods[' + row + '][payment_type]" class="form-control">'
			+				'<option value="percentage"><?php echo $text_percentage; ?></option>'
			+				'<option value="flat"><?php echo $text_flat_amount; ?></option>'
			+		'</td>';

	html	+=		'<td class="text-left">'
			+			'<input type="text" name="prod_methods[' + row + '][payment_amount]" class="form-control">'
			+		'</td>';

	html	+= 	'<td class="text-left">'
			+		'<button type="button" onclick="$(\'#prod-row' + row  + ', .tooltip\').remove();" data-toggle="tooltip" title="<?php echo $button_remove; ?>" class="btn btn-danger"><i class="fa fa-minus-circle"></i></button>'
			+	'</td>';

	html += '</tr>';

	$('#prod_methods tbody').append(html);
	
	row++;
}
//--></script>
<?php echo $footer; ?>