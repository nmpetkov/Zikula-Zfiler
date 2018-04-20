<?php
/**
 * Zfiler Zikula Module
 *
 * @copyright Nikolay Petkov
 * @license GNU/GPL
 */
class Zfiler_Controller_Admin extends Zikula_AbstractController
{
    /**
     * Main function
     */
    public function main() {
        return $this->filer();
    }

    /**
     * Call File manager
     */
    public function filer() {
        return $this->elfinder();
    }

    /**
     * Modify module Config
     */
    public function modifyconfig() {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_ADMIN), LogUtil::getErrorMsgPermission());

        // default settings
        $setting_defaults = $this->setting_defaults();
        foreach ($setting_defaults as $key => $value) {
            $vars[$key] = $this->getVar($key, $value);

            if ($key == 'manage_roots') {
                foreach ($vars[$key] as $key1 => $value1) {
                    if (isset($vars[$key][$key1]['mods'])) {
                        natcasesort($vars[$key][$key1]['mods']); // sort array with modules
                    }
                }
            }
        }

        // manage_roots add empty one to be possible to input
        $vars['manage_roots'][] = array('subdir' => '', 'mods' => array('zfiler'), 'alias' => '');
        // array with modules to define access

        // Get list of modules
        $vars['modules'] = ModUtil::apiFunc('Extensions', 'admin', 'listmodules',
                                 array('state' => 3, 'sort' => 'name'));

        // get PHP limit for upload file size
        $max_upload = $this->convertPHPSizeToBytes(ini_get('upload_max_filesize'));
        $max_post = $this->convertPHPSizeToBytes(ini_get('post_max_size'));
        $memory_limit = $this->convertPHPSizeToBytes(ini_get('memory_limit'));
        $this->view->assign('php_file_max_size', min($max_upload, $max_post, $memory_limit));

        $this->view->assign($vars);
        if (Zikula_Core::VERSION_NUM < '1.4.0') {
            $this->view->assign('user_groups', UserUtil::getGroups('', 'ORDER BY gid'));
        } else {
            $this->view->assign('user_groups', UserUtil::getGroups(array(), array('gid' => 'ASC')));
        }
        $this->view->assign('languages', ZLanguage::getInstalledLanguageNames());

        return $this->view->fetch('admin/modifyconfig.tpl');
    }

    /**
     * Update module Config
     */
    public function updateconfig()
    {
        $this->checkCsrfToken();
        $this->throwForbiddenUnless(SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_ADMIN), LogUtil::getErrorMsgPermission());

        $setting_defaults = $this->setting_defaults();
        foreach ($setting_defaults as $key => $value) {
            $newvalue = FormUtil::getPassedValue($key, $value);

            if ($key == 'manage_roots') {
                foreach ($newvalue as $key1 => $value1) {
                    if (!$value1['subdir']) {
                        unset($newvalue[ $key1]); // remove empty elements from array
                    }
                }
            }

            $this->setVar($key, $newvalue);
        }

        // clear the cache
        $this->view->clear_cache();
    
        LogUtil::registerStatus($this->__('Done! Updated configuration.'));
        return $this->modifyconfig();
    }

    // Exactly same functions in Admin.php and User.php
    function setting_defaults() {
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

        $setting_defaults = array(
            'manage_roots' => array(array('subdir' => 'images', 'mods' => array('zfiler'), 'alias' => ''), array('subdir' => 'userdata/uploads', 'mods' => array('zfiler'), 'alias' => '')),
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

        return $setting_defaults;
    }

    /**
    * Transforms the php.ini notation for numbers (like '2M') to an integer (2*1024*1024 in this case)
    * 
    * @param string $sSize
    * @return integer The value in bytes
    */
    function convertPHPSizeToBytes($sSize) {
        //
        $sSuffix = strtoupper(substr($sSize, -1));
        if (!in_array($sSuffix,array('P','T','G','M','K'))){
            return (int)$sSize;  
        } 
        $iValue = substr($sSize, 0, -1);
        switch ($sSuffix) {
            case 'P':
                $iValue *= 1024;
            case 'T':
                $iValue *= 1024;
            case 'G':
                $iValue *= 1024;
            case 'M':
                $iValue *= 1024;
            case 'K':
                $iValue *= 1024;
                break;
        }
        return (int)$iValue;
    }

    /**
     * Display elfinder file manager
     */
    public function elfinder()
    {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_ADMIN), LogUtil::getErrorMsgPermission());

        // Get module configuration vars
        $vars = $this->getVars();

        $this->view->assign('vars', $vars);
        
        $data = array();
        $data = ModUtil::func($this->name, 'user', 'filemanager_elfinder', array('data' => $data, 'additional_roots' => false));
        
        $this->view->assign($data);

        return $this->view->fetch('admin/elfinder_main.tpl');
    }
}
