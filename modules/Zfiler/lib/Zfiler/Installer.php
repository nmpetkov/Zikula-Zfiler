<?php
/**
 * Zfiler Zikula Module
 *
 * @copyright Nikolay Petkov
 * @license GNU/GPL
 */
class Zfiler_Installer extends Zikula_AbstractInstaller
{
    /**
     * Initializes a new install
     *
     * @return  boolean    true/false
     */
    public function install()
    {
        // default access
        if (Zikula_Core::VERSION_NUM < '1.4.0') {
            $user_groups = UserUtil::getGroups('', 'ORDER BY gid');
        } else {
            $user_groups = UserUtil::getGroups(array(), array('gid' => 'ASC'));
        }
        $access_default = array();
        foreach ($user_groups as $user_group) {
            $access_default[] = $user_group['gid'];
        }

        // default settings
        $setting_defaults = array(
            'manage_roots' => array(array('subdir' => 'images', 'mods' => array('zfiler')), array('subdir' => 'userdata/uploads', 'mods' => array('zfiler'))),
            'access_upload' => $access_default,
            'access_delete' => $access_default,
            'access_rename' => $access_default,
            'access_edit' => $access_default,
            'access_editimg' => $access_default,
            'access_mkdir' => $access_default,
            'elfinder_theme' => 'default',
            'elfinder_width' => 0,
            'elfinder_height' => 0,
            'elfinder_iconfiletype' => 1,
            'elfinder_thumbsize' => 75,
            'elfinder_thumbcrop' => 0,
            'elfinder_thumbbgcolor' => 'transparent',
            'elfinder_upload_mimeallowed' => 'image/*' . "\n" . 'video/*' . "\n" . 'audio/*' . "\n" . 'application/*' . "\n" . 'text/plain' . "\n",
            'elfinder_upload_maxsize' => '',
            'elfinder_places' => 1,
            'elfinder_ftp_status' => 0,
            'elfinder_ftp_host' => 'localhost',
            'elfinder_ftp_un' => '',
            'elfinder_ftp_pw' => '',
            'elfinder_ftp_port' => 21,
            'elfinder_ftp_mode' => 'passive',
            'elfinder_ftp_accessgroups' => array(),
            'elfinder_ftp_alias' => array(),
            'elfinder_root_status' => 0,
            'elfinder_root_accessgroups' => array(),
            'elfinder_root_alias' => array(),
            'elfinder_loadtmbs' => 20,
            'elfinder_showfiles' => 30,
            'autoresize_status' => 0,
            'autoresize_mode' => 0,
            'autoresize_key' => array(4, 8),
            'autoresize_maxwidth' => 1200,
            'autoresize_maxheight' => 1200,
            'autoresize_quality' => 85,
            'autoresize_exif' => 1,
            'watermark_status' => 0,
            'watermark_mode' => 0,
            'watermark_key' => array(1, 2),
            'watermark_marginright' => 5,
            'watermark_marginbottom' => 5,
            'watermark_quality' => 85,
            'watermark_transparency' => 70,
            'watermark_minpixel' => 200,
            'watermark_source' => ''
        );

        foreach (ZLanguage::getInstalledLanguageNames() as $langcode => $language) {
            $setting_defaults['elfinder_ftp_alias'][$langcode] = 'FTP root';
            $setting_defaults['elfinder_root_alias'][$langcode] = 'Site root';
        }

        foreach ($setting_defaults as $key => $value) {
            $this->setVar($key, $value);
        }

        // Register hooks
        HookUtil::registerSubscriberBundles($this->version->getHookSubscriberBundles());

        return true;
    }
    
    /**
     * Upgrade module
     *
     * @param   string    $oldversion
     * @return  boolean   true/false
     */
    public function upgrade($oldversion)
    {
        // upgrade dependent on old version number
        switch ($oldversion)
        {
            case '1.0.0':
                // Register hooks
                HookUtil::unregisterSubscriberBundles($this->version->getHookSubscriberBundles());
                HookUtil::registerSubscriberBundles($this->version->getHookSubscriberBundles());

            case '1.0.1':
				// future upgrade routines
        }

        return true;
    }
    
    /**
     * Delete module
     *
     * @return  boolean    true/false
     */
    public function uninstall()
    {
        $this->delVars();

        // Remove hooks
        HookUtil::unregisterSubscriberBundles($this->version->getHookSubscriberBundles());

        return true;
    }
}