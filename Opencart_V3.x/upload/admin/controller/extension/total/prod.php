<?php
class ControllerExtensionTotalProd extends Controller {
	private $error = array();

	public function index() {

		// load all language variables
		$data = $this->load->language('extension/total/prod');

		$this->document->setTitle($this->language->get('heading_title'));

		$this->load->model('setting/setting');

		if (($this->request->server['REQUEST_METHOD'] == 'POST') && $this->validate()) {
			$this->model_setting_setting->editSetting('total_prod', $this->request->post);

			$this->session->data['success'] = $this->language->get('text_success');

			$this->response->redirect($this->url->link('extension/total/prod', 'user_token=' . $this->session->data['user_token'] . '&type=total', true));
		}

		if (isset($this->error['warning'])) {
			$data['error_warning'] = $this->error['warning'];
		} else {
			$data['error_warning'] = '';
		}

		if (isset($this->session->data['success'])) {
			$data['success'] = $this->session->data['success'];
			unset($this->session->data['success']);
		} else {
			$data['success'] = '';
		}

		if (isset($this->error['prod_methods'])) {
			$data['error_prod_methods'] = $this->error['prod_methods'];
		} else {
			$data['error_prod_methods'] = array();
		}
		
		$data['breadcrumbs'] = array();

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_home'),
			'href' => $this->url->link('common/dashboard', 'user_token=' . $this->session->data['user_token'], true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('text_extension'),
			'href' => $this->url->link('extension/extension', 'user_token=' . $this->session->data['user_token'] . '&type=total', true)
		);

		$data['breadcrumbs'][] = array(
			'text' => $this->language->get('heading_title'),
			'href' => $this->url->link('extension/total/prod', 'user_token=' . $this->session->data['user_token'], true)
		);

		$data['action'] = $this->url->link('extension/total/prod', 'user_token=' . $this->session->data['user_token'], true);

		$data['cancel'] = $this->url->link('extension/extension', 'user_token=' . $this->session->data['user_token'] . '&type=total', true);

		if (isset($this->request->post['total_prod_total'])) {
			$data['total_prod_total'] = $this->request->post['total_prod_total'];
		} else if(null != $this->config->get('total_prod_total')){
			$data['total_prod_total'] = $this->config->get('total_prod_total');
		} else {
			$data['total_prod_total'] = '';
		}

		if (isset($this->request->post['total_prod_geo_zone'])) {
			$data['total_prod_geo_zone'] = $this->request->post['total_prod_geo_zone'];
		} else if(null != $this->config->get('total_prod_geo_zone')){
			$data['total_prod_geo_zone'] = $this->config->get('total_prod_geo_zone');
		} else {
			$data['total_prod_geo_zone'] = '';
		}

		if (isset($this->request->post['total_prod_text_opt'])) {
			$data['total_prod_text_opt'] = $this->request->post['total_prod_text_opt'];
		} else if(null != $this->config->get('total_prod_text_opt')){
			$data['total_prod_text_opt'] = $this->config->get('total_prod_text_opt');
		} else {
			$data['total_prod_text_opt'] = array();
		}

		if (isset($this->request->post['total_prod_text_total'])) {
			$data['total_prod_text_total'] = $this->request->post['total_prod_text_total'];
		} else if(null != $this->config->get('total_prod_text_total')){
			$data['total_prod_text_total'] = $this->config->get('total_prod_text_total');
		} else {
			$data['total_prod_text_total'] = array();
		}

		if (isset($this->request->post['total_prod_status'])) {
			$data['total_prod_status'] = $this->request->post['total_prod_status'];
		} else if(null != $this->config->get('total_prod_status')){
			$data['total_prod_status'] = $this->config->get('total_prod_status');
		} else {
			$data['total_prod_status'] = '';
		}

		if (isset($this->request->post['total_prod_sort_order'])) {
			$data['total_prod_sort_order'] = $this->request->post['total_prod_sort_order'];
		} else if(null != $this->config->get('total_prod_sort_order')){
			$data['total_prod_sort_order'] = $this->config->get('total_prod_sort_order');
		} else {
			$data['total_prod_sort_order'] = $this->config->get('sub_total_sort_order') + 1;
		}

		if (isset($this->request->post['total_prod_methods'])) {
			$data['total_prod_methods'] = $this->request->post['total_prod_methods'];
		} else if(null != $this->config->get('total_prod_methods')){
			$data['total_prod_methods'] = $this->config->get('total_prod_methods');
		} else {
			$data['total_prod_methods'] = array();
		}

		// get all languages
		$this->load->model('localisation/language');
		$data['languages'] = $this->model_localisation_language->getLanguages();

		// get all geo zones
		$this->load->model('localisation/geo_zone');
		$data['geo_zones'] = $this->model_localisation_geo_zone->getGeoZones();


		//get all payment methods
		// Compatibility code for old extension folders
		$files = glob(DIR_APPLICATION . 'controller/{extension/payment,payment}/*.php', GLOB_BRACE);

		if ($files) {
			foreach ($files as $file) {

				$extension = basename($file, '.php');

				// partial payment not available on cod
				if($extension == 'cod') continue;

				$this->load->language('extension/payment/' . $extension);

				$text_link = $this->language->get('text_' . $extension);

				if ($text_link != 'text_' . $extension) {
					$link = $this->language->get('text_' . $extension);
				} else {
					$link = '';
				}

				$data['payment_methods'][] = array(
					'code'       => $extension,
					'name'       => $this->language->get('heading_title'),
				);
			}
		}

		$data['header'] = $this->load->controller('common/header');
		$data['column_left'] = $this->load->controller('common/column_left');
		$data['footer'] = $this->load->controller('common/footer');

		$this->response->setOutput($this->load->view('extension/total/prod', $data));
	}

	protected function validate() {
		if (!$this->user->hasPermission('modify', 'extension/total/prod')) {
			$this->error['warning'] = $this->language->get('error_permission');
		}
		if(!empty($this->request->post['total_prod_methods'])){
			foreach($this->request->post['total_prod_methods'] as $k=>$v){
				if (empty($v['payment_method'])){
					$this->error['total_prod_methods'][$k]['payment_method'] = $this->language->get('error_payment_method');
				}

				if(empty($v['payment_type']) || ($v['payment_type'] != 'percentage' && $v['payment_type'] != 'flat')){
					$this->error['total_prod_methods'][$k]['payment_type'] = $this->language->get('error_payment_type');
				}

				if(!empty($v['payment_type']) && $v['payment_type'] == 'percentage' && (100 < (int)$v['payment_amount'] || 0 >= (int)$v['payment_amount'])){
					$this->error['total_prod_methods'][$k]['payment_amount'] = $this->language->get('error_percentage');
				}

				if(!empty($v['payment_type']) && $v['payment_type'] == 'flat' && (!is_numeric($v['payment_amount']) || 0 >= (int)$v['payment_amount'])){
					$this->error['total_prod_methods'][$k]['payment_amount'] = $this->language->get('error_amount');
				}
			}
		}

		return !$this->error;
	}
}