<?php
/**
 * Zfiler Zikula Module
 *
 * @copyright Nikolay Petkov
 * @license GNU/GPL
 */
class Zfiler_Version extends Zikula_AbstractVersion
{
    public function getMetaData()
    {
        $meta = array();
        $meta['displayname']    = $this->__('File manager');
        $meta['url']            = $this->__(/*!module name that appears in URL*/'zfiler');
        $meta['description']    = $this->__('File manager for Zikula site.');
        $meta['version']        = '1.0.0';
        $meta['securityschema'] = array('Zfiler::' => '::');
        $meta['core_min']       = '1.3.0';
        $meta['capabilities']   = array(HookUtil::SUBSCRIBER_CAPABLE => array('enabled' => true));

        return $meta;
    }

    protected function setupHookBundles()
    {
        // Register hooks
        $bundle = new Zikula_HookManager_SubscriberBundle($this->name, 'subscriber.zfiler.ui_hooks.item', 'ui_hooks', $this->__('Zfiler hooks'));
        $bundle->addEvent('display_view', 'zfiler.ui_hooks.item.display_view');
        $bundle->addEvent('form_edit', 'zfiler.ui_hooks.item.form_edit');
        $this->registerHookSubscriberBundle($bundle);
    }
}