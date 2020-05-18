<?php
class ModelExtensionTotalProd extends Model {
	public function getTotal($total) {

		if($total['total'] < $this->config->get('total_prod_total')) {
			return;
		}

		if (isset($this->session->data['prod_opt']) 
			&& $this->session->data['prod_opt'] == '1' 
			&& isset($this->session->data['payment_method']) 
			&& $this->session->data['payment_method']['code'] != 'cod') {
			
			$user_method_code = $this->session->data['payment_method']['code'];
			$prod_methods = $this->config->get('total_prod_methods');
			$prod_title = $this->config->get('total_prod_text_total');

			foreach($prod_methods as $method) {
				if($user_method_code == $method['payment_method']) {

					$this->load->language('extension/total/prod');

					$prod_amount = 0;
					$payment_type = $method['payment_type'];
					$payment_amount = (int) $method['payment_amount'];

					if(isset($prod_title[$this->config->get('config_language_id')]) && strlen(trim($prod_title[$this->config->get('config_language_id')])) > 0) {
						$language_text = $prod_title[$this->config->get('config_language_id')];
					} else {
						$language_text = $this->language->get('prod_text_total');
					}
					

					if($payment_type == 'percentage' && $payment_amount > 0 && $payment_amount < 100){
						$prod_amount = round(($payment_amount * $total['total']) / 100, 2, PHP_ROUND_HALF_UP);

						$title = sprintf($language_text, $payment_amount . ($payment_type == 'percentage'? '%' : ''));

					} else if($payment_type == 'flat') {
						$prod_amount = min($total['total'], $payment_amount);

						$title = sprintf($language_text, number_format((float)-1 * $prod_amount, 2, '.', ''));
					}

					if($prod_amount > 0){
						$total['totals'][] = array(
							'code'       => 'prod',
							'title'      => $title,
							'value'      => - $prod_amount,
							'sort_order' => $this->config->get('total_prod_sort_order') + 0.01
						);

						$total['total'] = $total['total'] - $prod_amount;
					}
					break;
				}
			}
		}
	}
}
