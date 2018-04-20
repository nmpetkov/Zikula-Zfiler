<?php
/**
 * Zfiler Zikula Module
 *
 * @copyright Nikolay Petkov
 * @license GNU/GPL
 */
class Zfiler_Controller_Ajax extends Zikula_Controller_AbstractAjax {

    /**
     * Return code for file manager in modal window from Ajax call
     */
    public function filemanager_repl()
    {
        // Get module configuration vars
        $vars = $this->getVars();

        Zikula_AbstractController::configureView();
        $this->view->assign('vars', $vars);
        
        $data = array();
        $data = ModUtil::func($this->name, 'user', 'filemanager_elfinder', array('data' => $data, 'additional_roots' => false));

        $data['select_multiple'] = false;
        if ($this->request->query->get('multiple')) {
            $data['select_multiple'] = true;
        }

		// for image selections
		// target ID to set the input tag value
		if ($this->request->query->get('target')) {
			$data['target'] = $this->request->query->get('target');
		} else {
			$data['target'] = '';
		}
		// to set src for thumbnail (if specified)
		if ($this->request->query->get('thumb')) {
			$data['thumb'] = $this->request->query->get('thumb');
		} else {
			$data['thumb'] = '';
		}
		// to set href on a tag (if specified)
		if ($this->request->query->get('href')) {
			$data['href'] = $this->request->query->get('href');
		} else {
			$data['href'] = '';
		}

        if (SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_COMMENT)) {
            $this->view->assign($data);
            $html = $this->view->fetch('user/elfinder_repl.tpl');
        } else {
            $html = $this->__('Zfiler: No access permissions!!');
        }

        $json = array(
            'html' => $html,
            'width' => $data['elfinder_width'] ? $data['elfinder_width'] : '',
            'title' => $this->__('File manager')
        );

        //header('Content-Type: application/json', true, 200);
        //echo json_encode($json);
        return new Zikula_Response_Ajax_Json($json);
    }
}
