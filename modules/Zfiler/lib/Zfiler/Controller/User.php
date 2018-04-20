<?php
/**
 * Zphpbb Zikula Module
 *
 * @copyright Nikolay Petkov
 * @license GNU/GPL
 */
class Zfiler_Controller_User extends Zikula_AbstractController
{
    /**
     * Main function
     */
    public function main()
    {
        return $this->filer();
    }

    /**
     * Call File manager
     */
    public function filer()
    {
        return $this->filemanager();
    }

    /**
     * Display file manager in main window
     */
    public function filemanager()
    {
        $this->throwForbiddenUnless(SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_ADMIN), LogUtil::getErrorMsgPermission());

        // Get module configuration vars
        $vars = $this->getVars();

        $this->view->assign('vars', $vars);
        
        $data = array();
        $data = $this->filemanager_elfinder(array('data' => $data, 'additional_roots' => true));
        
        $this->view->assign($data);

        return $this->view->fetch('user/elfinder_main.tpl');
    }

    public function filemanager_elfinder($args = array()) {
        $data = isset($args['data']) ? $args['data'] : array();
        $additional_roots = isset($args['additional_roots']) ? $args['additional_roots'] : false;

        // get elfinder config data
        $config_data = array(
            'elfinder_theme',
            'elfinder_width',
            'elfinder_height',
            'elfinder_thumbsize',
            'elfinder_loadtmbs',
            'elfinder_showfiles',
            'elfinder_iconfiletype',
            'elfinder_places'
        );
        foreach ($config_data as $conf) {
            $data[$conf] = $this->getVar($conf, null);
        }
        if (is_null($data['elfinder_theme'])) {
            $data['elfinder_theme'] = 'default';
        }
        if (is_null($data['elfinder_width'])) {
            $data['elfinder_width'] = 0;
        }
        if (is_null($data['elfinder_height'])) {
            $data['elfinder_height'] = 0;
        }
        if (is_null($data['elfinder_thumbsize'])) {
            $data['elfinder_thumbsize'] = 75;
        }
        if (is_null($data['elfinder_loadtmbs'])) {
            $data['elfinder_loadtmbs'] = 20;
        }
        if (is_null($data['elfinder_showfiles'])) {
            $data['elfinder_showfiles'] = 30;
        }
        if (is_null($data['elfinder_iconfiletype'])) {
            $data['elfinder_iconfiletype'] = 1;
        }
        if (is_null($data['elfinder_places'])) {
            $data['elfinder_places'] = 1;
        }

        // margins for folder icon
        $data['elfinder_foldmargin_y'] = intval(round(($data['elfinder_thumbsize']-48)*30/52, 0));
        $data['elfinder_foldmargin_x'] = intval(round(($data['elfinder_thumbsize']-48)*20/52, 0));
        
        $data['elfinder_connector_amp'] = str_replace('&amp;', '&', $data['elfinder_connector']);
        $data['lang'] = ZLanguage::getLanguageCode();
        if (in_array($data['lang'], array('en', 'ar', 'bg', 'ca', 'cs', 'da', 'de', 'el', 'es', 'fa', 'fo', 'fr', 'he', 'hr', 'hu', 'id', 'it', 'ja', 'jp', 'ko', 'nl', 'no', 'pl', 'ro', 'ru', 'si', 'sk', 'sl', 'sr', 'sv', 'tr', 'uk', 'vi'))) {
            $data['lang_elfinder'] = $data['lang'];
        } elseif ($data['lang'] == 'pt') {
            $data['lang_elfinder'] = 'pt_BR';
        } elseif ($data['lang'] == 'ug') {
            $data['lang_elfinder'] = 'ug_CN';
        } elseif ($data['lang'] == 'zh') {
            $data['lang_elfinder'] = 'zh_CN';
        } else {
            $data['lang_elfinder'] = 'en';
        }

        $data['url_base'] = 'modules/Zfiler/javascript/vendor/elfinder/';
        $data['url_connector'] = ModUtil::url('Zfiler', 'user', 'elfinderConnector');

        return $data;
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

    public function elfinderConnector($subdirs = null)
    {

        // default settings
        $setting_defaults = $this->setting_defaults();
        foreach ($setting_defaults as $key => $value) {
            $data[$key] = $this->getVar($key, $value);
        }

        if (!SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_ADMIN)) {
            $data['elfinder_ftp_un'] = '';
        }
        if (!SecurityUtil::checkPermission('Zfiler::', '::', ACCESS_ADMIN)) {
            $data['elfinder_ftp_pw'] = '';
        }

        // analyze HTTP_REFERER (to get calling module, type, function)
        $refparams = array();
        parse_str(parse_url(System::serverGetVar('HTTP_REFERER'), PHP_URL_QUERY), $refparams);
        // $refparams: [module] => blocksmanager [type] => admin [func] => modify
        $moduleInfo = ModUtil::getInfoFromName($refparams['module']);
        $refparams['module'] = strtolower($moduleInfo['name']);
        // $refparams: [module] => blocks [type] => admin [func] => modify

        // main directories
        $imgSubDir = 'images/';
        if (is_null($subdirs) || !$subdirs) {
            $subdirs = $this->request->request->get('subdirs');
        }
        if (!$subdirs) {
            if (isset($data['manage_roots']) && is_array($data['manage_roots'])) {
                $subdirs = array();
                $aliases = array();
                foreach ($data['manage_roots'] as $manage_root) {
                    if (isset($manage_root['subdir']) && $manage_root['subdir']) {
                        // check if calling module is in permitted modules for this subdir
                        if (isset($manage_root['mods']) && in_array(strtolower($refparams['module']), $manage_root['mods'])) {
                            $subdirs[] = $manage_root['subdir'];
                            $aliases[] = $manage_root['alias'];
                        }
                    }
                }
            }
        }
        if (!is_array($subdirs)) {
            $subdirs = array($subdirs);
            $aliases = array('');
        }
        $rootdir = System::serverGetVar('DOCUMENT_ROOT') . DIRECTORY_SEPARATOR; // server path to HTTP root
        $server = trim(System::getBaseUrl(), DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR;

        // if to display additional roots
        $add_roots = false;
        if (isset($refparams['type']) && $refparams['type'] == 'admin') {
            $add_roots = true;
        }

        //error_reporting(0); // Set E_ALL for debuging
        error_reporting(E_ALL);

        require 'modules/Zfiler/javascript/vendor/elfinder/php/autoload.php';

        // Enable FTP connector netmount
        elFinder::$netDrivers['ftp'] = 'FTP';

        // define upload mime types allowed
        $data['elfinder_upload_mimeallowed'] = str_replace('/*', '', $data['elfinder_upload_mimeallowed']);
        $mime_allowed = preg_replace('~\r?\n~', "\n", $data['elfinder_upload_mimeallowed']);
        $mime_allowed = explode("\n", $mime_allowed);
        $mime_allowed = array_map('trim', $mime_allowed);

        $uid = UserUtil::getVar('uid');
        $groupsForUser = UserUtil::getGroupsForUser($uid);

        // define access
        $opts_disabled = array();
        if (!$this->userHaveAccess($groupsForUser, $data['access_upload'])) {
            $opts_disabled[] = 'upload';
            $opts_disabled[] = 'duplicate';
            $opts_disabled[] = 'paste';
            $opts_disabled[] = 'mkfile';
        }
        if (!$this->userHaveAccess($groupsForUser, $data['access_delete'])) {
            $opts_disabled[] = 'rm';
            $opts_disabled[] = 'cut';
        }
        if (!$this->userHaveAccess($groupsForUser, $data['access_rename'])) {
            $opts_disabled[] = 'rename';
        }
        if (!$this->userHaveAccess($groupsForUser, $data['access_edit'])) {
            $opts_disabled[] = 'edit';
        }
        if (!$this->userHaveAccess($groupsForUser, $data['access_editimg'])) {
            $opts_disabled[] = 'resize';
        }
        if (!$this->userHaveAccess($groupsForUser, $data['access_mkdir'])) {
            $opts_disabled[] = 'mkdir';
        }

        // thumbnails directory
        $tmpDir = $rootdir . $imgSubDir . 'cache/.elftmp';
        if (!is_dir($tmpDir)) {
            mkdir($tmpDir, 0777, true);
        }

        $roots = array();

        foreach ($subdirs as $keysubdir => $subdir) {
            $subdir = rtrim($subdir, DIRECTORY_SEPARATOR) . DIRECTORY_SEPARATOR;
            $roots[] = array(
                'driver'        => 'LocalFileSystem',           // driver for accessing file system (REQUIRED)
                'path'          => $rootdir . $subdir,          // path to files (REQUIRED)
                'alias'         => isset($aliases[$keysubdir]) ? $aliases[$keysubdir] : '',
                'URL'           => $server . $subdir,           // URL to files (REQUIRED)
                'winHashFix'    => DIRECTORY_SEPARATOR !== '/', // to make hash same to Linux one on windows too
                'uploadDeny'    => array('all'),
                'uploadAllow'   => $mime_allowed,
                'uploadOrder'   => array('deny', 'allow'),
                'uploadMaxSize' => $data['elfinder_upload_maxsize'],
                'tmbPath'       => $tmpDir, // .tmp
                'quarantine'    => $tmpDir,
                'tmbURL'        => $server . $imgSubDir . 'cache/.elftmp',
                'tmbSize'       => $data['elfinder_thumbsize'],
                'tmbCrop'       => $data['elfinder_thumbcrop'] ? true : false,
                'tmbBgColor'    => $data['elfinder_thumbbgcolor'] ? $data['elfinder_thumbbgcolor'] : 'transparent',
                'disabled'      => $opts_disabled,
                'accessControl' => array($this, 'elFinder_access'),
                'uploadOverwrite' => false,
                'copyOverwrite' => false
            );
        }
        if ($add_roots && $data['elfinder_root_status'] && $this->userHaveAccess($groupsForUser, $data['elfinder_root_accessgroups'])) {
            $roots[] = array(
                'driver'        => 'LocalFileSystem',
                'path'          => $rootdir,
                'alias'         => isset($data['elfinder_root_alias'][ZLanguage::getLanguageCode()]) ? $data['elfinder_root_alias'][ZLanguage::getLanguageCode()] : 'Site root',
                'URL'           => $server,
                'winHashFix'    => DIRECTORY_SEPARATOR !== '/', // to make hash same to Linux one on windows too
                'uploadDeny'    => array('all'),
                'uploadAllow'   => $mime_allowed,
                'uploadOrder'   => array('deny', 'allow'),
                'tmbPath'       => '',
                'disabled'      => $opts_disabled,
                'accessControl' => array($this, 'elFinder_access')
            );
        }
        if ($add_roots && $data['elfinder_ftp_status'] && $this->userHaveAccess($groupsForUser, $data['elfinder_ftp_accessgroups'])) {
            $roots[] = array(
                'driver'        => 'FTP',
                'host'          => $data['elfinder_ftp_host'],
                'user'          => $data['elfinder_ftp_un'],
                'pass'          => $data['elfinder_ftp_pw'],
                'port'          => $data['elfinder_ftp_port'],
                'mode'          => $data['elfinder_ftp_mode'],
                'path'          => '/',
                'alias'         => isset($data['elfinder_ftp_alias'][ZLanguage::getLanguageCode()]) ? $data['elfinder_ftp_alias'][ZLanguage::getLanguageCode()] : 'FTP root',
                'timeout'       => 10,
                'owner'         => true,
                'tmpPath'       => '',
                'dirMode'       => 0755,
                'fileMode'      => 0644
            );
        }

        // Documentation for connector options: https://github.com/Studio-42/elFinder/wiki/Connector-configuration-options
        $opts = array(
            'debug' => true,
            'roots' => $roots,
            'bind' => array('upload.presave' => array()),
            'plugin' => array()
        );
        if ($data['autoresize_status']) {
            $opts['bind']['upload.presave'][] = 'Plugin.AutoResize.onUpLoadPreSave';
            $opts['plugin']['AutoResize'] = array(
                    'enable'         => true,
                    'maxWidth'       => $data['autoresize_maxwidth'],
                    'maxHeight'      => $data['autoresize_maxheight'],
                    'quality'        => $data['autoresize_quality'], // JPEG image save quality (95 default)
                    'preserveExif'   => $data['autoresize_exif'], // Preserve EXIF data (Imagick only)
                    'forceEffect'    => false,      // For change quality or make progressive JPEG of small images
                    'targetType'     => IMG_GIF|IMG_JPG|IMG_PNG|IMG_WBMP, // Target image formats ( bit-field )
                    'offDropWith'    => null,       // Enabled by default. To disable it if it is dropped with pressing the meta key
                                                    // Alt: 8, Ctrl: 4, Meta: 2, Shift: 1 - sum of each value
                                                    // In case of using any key, specify it as an array
                    'offDropWith'    => $data['autoresize_mode'] ? $data['autoresize_key'] : null, // Enabled by default. To disable it if it is dropped with pressing the meta key
                                                    // Alt: 8, Ctrl: 4, Meta: 2, Shift: 1 - sum of each value
                                                    // In case of using any key, specify it as an array
                    'onDropWith'     => $data['autoresize_mode'] ? null : $data['autoresize_key'] // Disabled by default. To enable it if it is dropped with pressing the meta key
                                                    // Alt: 8, Ctrl: 4, Meta: 2, Shift: 1 - sum of each value
                                                    // In case of using any key, specify it as an array
                );
        }
        if ($data['watermark_status'] && $data['watermark_source'] && is_file($rootdir . $imgSubDir . $data['watermark_source'])) {
            $opts['bind']['upload.presave'][] = 'Plugin.Watermark.onUpLoadPreSave';
            $opts['plugin']['Watermark'] = array(
                    'enable'         => true,
                    'source'         => $rootdir . $imgSubDir . $data['watermark_source'], // Path to Water mark image 'logo.png'
                    'marginRight'    => $data['watermark_marginright'],          // Margin right pixel
                    'marginBottom'   => $data['watermark_marginbottom'],          // Margin bottom pixel
                    'quality'        => $data['watermark_quality'], // JPEG image save quality (95 default)
                    'transparency'   => $data['watermark_transparency'],         // Water mark image transparency ( other than PNG )
                    'forceEffect'    => false,      // For change quality or make progressive JPEG of small images
                    'targetType'     => IMG_GIF|IMG_JPG|IMG_PNG|IMG_WBMP, // Target image formats ( bit-field )
                    'targetMinPixel' => $data['watermark_minpixel'],        // Target image minimum pixel size
                    'interlace'      => IMG_GIF|IMG_JPG, // Set interlacebit image formats ( bit-field )
                    'offDropWith'    => $data['watermark_mode'] ? $data['watermark_key'] : null, // Enabled by default. To disable it if it is dropped with pressing the meta key
                                                    // Alt: 8, Ctrl: 4, Meta: 2, Shift: 1 - sum of each value
                                                    // In case of using any key, specify it as an array
                    'onDropWith'     => $data['watermark_mode'] ? null : $data['watermark_key'] // Disabled by default. To enable it if it is dropped with pressing the meta key
                                                    // Alt: 8, Ctrl: 4, Meta: 2, Shift: 1 - sum of each value
                                                    // In case of using any key, specify it as an array
                );
        }
//file_put_contents('info_opts.txt', print_r($opts, true));

        // run elFinder
        $connector = new elFinderConnector(new elFinder($opts));
        $connector->run();
    }

    public function elFinder_access($attr, $path, $data, $volume, $isDir, $relpath) {
        $basename = basename($path);
        $condition1 = $basename[0] === '.'        // if file/folder begins with '.' (dot)
                    && strlen($relpath) !== 1;    // but with out volume root
        $condition2 = $basename == 'cache';  // hide cache folder in images/
        return $condition1 || $condition2
        ? !($attr == 'read' || $attr == 'write') // set read+write to false, other (locked+hidden) set to true
        :  null;                                 // else elFinder decide itself
    }

    private function userHaveAccess($groupsForUser, $groupsHasAccess) {
        if(count(array_intersect($groupsForUser, $groupsHasAccess)) > 0){
            return true;
        }
        return false;
    }
}