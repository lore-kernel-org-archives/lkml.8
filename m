Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 440C9C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:03:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D3E25217F4
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:03:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727922AbgBEEDl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 23:03:41 -0500
Received: from mga05.intel.com ([192.55.52.43]:8955 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727832AbgBEEDk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:03:40 -0500
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga105.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 20:03:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,404,1574150400"; 
   d="gz'50?scan'50,208,50";a="225718924"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 04 Feb 2020 20:03:21 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izBuK-000CCj-Q7; Wed, 05 Feb 2020 12:03:20 +0800
Date:   Wed, 5 Feb 2020 12:02:33 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] platform/chrome: wilco_ec: Platform data shan't
 include kernel.h
Message-ID: <202002051112.XwQW5Zqb%lkp@intel.com>
References: <20200204162729.29175-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gnm23pe37v3wzxfq"
Content-Disposition: inline
In-Reply-To: <20200204162729.29175-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gnm23pe37v3wzxfq
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Andy,

I love your patch! Yet something to improve:

[auto build test ERROR on linus/master]
[also build test ERROR on v5.5 next-20200204]
[if your patch is applied to the wrong git tree, please drop us a note to help
improve the system. BTW, we also suggest to use '--base' option to specify the
base tree in git format-patch, please see https://stackoverflow.com/a/37406982]

url:    https://github.com/0day-ci/linux/commits/Andy-Shevchenko/platform-chrome-wilco_ec-Platform-data-shan-t-include-kernel-h/20200205-035444
base:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git d4e9056daedca3891414fe3c91de3449a5dad0f2
config: x86_64-randconfig-e003-20200204 (attached as .config)
compiler: gcc-7 (Debian 7.5.0-3) 7.5.0
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/platform/chrome/wilco_ec/sysfs.c:66:12: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
        struct device_attribute *attr,
               ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'boot_on_ac_store':
>> drivers/platform/chrome/wilco_ec/sysfs.c:69:31: error: implicit declaration of function 'dev_get_drvdata' [-Werror=implicit-function-declaration]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^~~~~~~~~~~~~~~
>> drivers/platform/chrome/wilco_ec/sysfs.c:69:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
>> drivers/platform/chrome/wilco_ec/sysfs.c:97:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_WO' [-Werror=implicit-int]
    static DEVICE_ATTR_WO(boot_on_ac);
           ^~~~~~~~~~~~~~
>> drivers/platform/chrome/wilco_ec/sysfs.c:97:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_WO(boot_on_ac);
    ^~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'get_info':
   drivers/platform/chrome/wilco_ec/sysfs.c:101:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:122:56: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
    static ssize_t version_show(struct device *dev, struct device_attribute *attr,
                                                           ^~~~~~~~~~~~~~~~
>> drivers/platform/chrome/wilco_ec/sysfs.c:128:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(version);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:128:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(version);
    ^~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:131:15: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
           struct device_attribute *attr, char *buf)
                  ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:136:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(build_revision);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:136:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(build_revision);
    ^~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:139:18: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
              struct device_attribute *attr, char *buf)
                     ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:144:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(build_date);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:144:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(build_date);
    ^~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:147:13: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
         struct device_attribute *attr, char *buf)
                ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:152:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(model_number);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:152:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(model_number);
    ^~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:177:16: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
            struct device_attribute *attr, char *buf)
                   ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'usb_charge_show':
   drivers/platform/chrome/wilco_ec/sysfs.c:179:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:196:17: warning: 'struct device_attribute' declared inside parameter list will not be visible outside of this definition or declaration
             struct device_attribute *attr,
                    ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'usb_charge_store':
   drivers/platform/chrome/wilco_ec/sysfs.c:199:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
>> drivers/platform/chrome/wilco_ec/sysfs.c:223:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RW' [-Werror=implicit-int]
    static DEVICE_ATTR_RW(usb_charge);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:223:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RW(usb_charge);
    ^~~~~~
>> drivers/platform/chrome/wilco_ec/sysfs.c:226:3: error: 'dev_attr_boot_on_ac' undeclared here (not in a function)
     &dev_attr_boot_on_ac.attr,
      ^~~~~~~~~~~~~~~~~~~
>> drivers/platform/chrome/wilco_ec/sysfs.c:227:3: error: 'dev_attr_build_date' undeclared here (not in a function); did you mean 'dev_attr_boot_on_ac'?
     &dev_attr_build_date.attr,
      ^~~~~~~~~~~~~~~~~~~
      dev_attr_boot_on_ac
>> drivers/platform/chrome/wilco_ec/sysfs.c:228:3: error: 'dev_attr_build_revision' undeclared here (not in a function); did you mean 'dev_attr_build_date'?
     &dev_attr_build_revision.attr,
      ^~~~~~~~~~~~~~~~~~~~~~~
      dev_attr_build_date
>> drivers/platform/chrome/wilco_ec/sysfs.c:229:3: error: 'dev_attr_model_number' undeclared here (not in a function); did you mean 'dev_attr_build_date'?
     &dev_attr_model_number.attr,
      ^~~~~~~~~~~~~~~~~~~~~
      dev_attr_build_date
>> drivers/platform/chrome/wilco_ec/sysfs.c:230:3: error: 'dev_attr_usb_charge' undeclared here (not in a function); did you mean 'send_usb_charge'?
     &dev_attr_usb_charge.attr,
      ^~~~~~~~~~~~~~~~~~~
      send_usb_charge
>> drivers/platform/chrome/wilco_ec/sysfs.c:231:3: error: 'dev_attr_version' undeclared here (not in a function); did you mean 'dev_attr_boot_on_ac'?
     &dev_attr_version.attr,
      ^~~~~~~~~~~~~~~~
      dev_attr_boot_on_ac
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'wilco_ec_add_sysfs':
>> drivers/platform/chrome/wilco_ec/sysfs.c:241:36: error: dereferencing pointer to incomplete type 'struct device'
     return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
                                       ^~
>> drivers/platform/chrome/wilco_ec/sysfs.c:241:36: error: request for member 'kobj' in something not a structure or union
>> drivers/platform/chrome/wilco_ec/sysfs.c:241:28: error: passing argument 1 of 'sysfs_create_group' from incompatible pointer type [-Werror=incompatible-pointer-types]
     return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
                               ^
   In file included from drivers/platform/chrome/wilco_ec/sysfs.c:12:0:
   include/linux/sysfs.h:276:18: note: expected 'struct kobject *' but argument is of type 'struct attribute * (*)[1]'
    int __must_check sysfs_create_group(struct kobject *kobj,
                     ^~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'wilco_ec_remove_sysfs':
   drivers/platform/chrome/wilco_ec/sysfs.c:246:29: error: request for member 'kobj' in something not a structure or union
     sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);
                                ^~
>> drivers/platform/chrome/wilco_ec/sysfs.c:246:21: error: passing argument 1 of 'sysfs_remove_group' from incompatible pointer type [-Werror=incompatible-pointer-types]
     sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);
                        ^
   In file included from drivers/platform/chrome/wilco_ec/sysfs.c:12:0:
   include/linux/sysfs.h:284:6: note: expected 'struct kobject *' but argument is of type 'struct attribute * (*)[1]'
    void sysfs_remove_group(struct kobject *kobj,
         ^~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:97:8: warning: 'DEVICE_ATTR_WO' declared 'static' but never defined [-Wunused-function]
    static DEVICE_ATTR_WO(boot_on_ac);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:152:8: warning: 'DEVICE_ATTR_RO' declared 'static' but never defined [-Wunused-function]
    static DEVICE_ATTR_RO(model_number);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:223:8: warning: 'DEVICE_ATTR_RW' declared 'static' but never defined [-Wunused-function]
    static DEVICE_ATTR_RW(usb_charge);
           ^~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:195:16: warning: 'usb_charge_store' defined but not used [-Wunused-function]
    static ssize_t usb_charge_store(struct device *dev,
                   ^~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:176:16: warning: 'usb_charge_show' defined but not used [-Wunused-function]
    static ssize_t usb_charge_show(struct device *dev,
                   ^~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:146:16: warning: 'model_number_show' defined but not used [-Wunused-function]
    static ssize_t model_number_show(struct device *dev,
                   ^~~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:138:16: warning: 'build_date_show' defined but not used [-Wunused-function]
    static ssize_t build_date_show(struct device *dev,
                   ^~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:130:16: warning: 'build_revision_show' defined but not used [-Wunused-function]
    static ssize_t build_revision_show(struct device *dev,
                   ^~~~~~~~~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:122:16: warning: 'version_show' defined but not used [-Wunused-function]
    static ssize_t version_show(struct device *dev, struct device_attribute *attr,
                   ^~~~~~~~~~~~
   drivers/platform/chrome/wilco_ec/sysfs.c:65:16: warning: 'boot_on_ac_store' defined but not used [-Wunused-function]
    static ssize_t boot_on_ac_store(struct device *dev,
                   ^~~~~~~~~~~~~~~~
   cc1: some warnings being treated as errors

vim +/dev_get_drvdata +69 drivers/platform/chrome/wilco_ec/sysfs.c

79e3f1d3db3d99 Raul E Rangel   2019-06-03   64  
4c1ca625c622b7 Nick Crews      2019-04-16   65  static ssize_t boot_on_ac_store(struct device *dev,
4c1ca625c622b7 Nick Crews      2019-04-16  @66  				struct device_attribute *attr,
4c1ca625c622b7 Nick Crews      2019-04-16   67  				const char *buf, size_t count)
4c1ca625c622b7 Nick Crews      2019-04-16   68  {
4c1ca625c622b7 Nick Crews      2019-04-16  @69  	struct wilco_ec_device *ec = dev_get_drvdata(dev);
4c1ca625c622b7 Nick Crews      2019-04-16   70  	struct boot_on_ac_request rq;
4c1ca625c622b7 Nick Crews      2019-04-16   71  	struct wilco_ec_message msg;
4c1ca625c622b7 Nick Crews      2019-04-16   72  	int ret;
4c1ca625c622b7 Nick Crews      2019-04-16   73  	u8 val;
4c1ca625c622b7 Nick Crews      2019-04-16   74  
4c1ca625c622b7 Nick Crews      2019-04-16   75  	ret = kstrtou8(buf, 10, &val);
4c1ca625c622b7 Nick Crews      2019-04-16   76  	if (ret < 0)
4c1ca625c622b7 Nick Crews      2019-04-16   77  		return ret;
4c1ca625c622b7 Nick Crews      2019-04-16   78  	if (val > 1)
4c1ca625c622b7 Nick Crews      2019-04-16   79  		return -EINVAL;
4c1ca625c622b7 Nick Crews      2019-04-16   80  
4c1ca625c622b7 Nick Crews      2019-04-16   81  	memset(&rq, 0, sizeof(rq));
4c1ca625c622b7 Nick Crews      2019-04-16   82  	rq.cmd = CMD_KB_CMOS;
4c1ca625c622b7 Nick Crews      2019-04-16   83  	rq.sub_cmd = SUB_CMD_KB_CMOS_AUTO_ON;
4c1ca625c622b7 Nick Crews      2019-04-16   84  	rq.val = val;
4c1ca625c622b7 Nick Crews      2019-04-16   85  
4c1ca625c622b7 Nick Crews      2019-04-16   86  	memset(&msg, 0, sizeof(msg));
4c1ca625c622b7 Nick Crews      2019-04-16   87  	msg.type = WILCO_EC_MSG_LEGACY;
4c1ca625c622b7 Nick Crews      2019-04-16   88  	msg.request_data = &rq;
4c1ca625c622b7 Nick Crews      2019-04-16   89  	msg.request_size = sizeof(rq);
4c1ca625c622b7 Nick Crews      2019-04-16   90  	ret = wilco_ec_mailbox(ec, &msg);
4c1ca625c622b7 Nick Crews      2019-04-16   91  	if (ret < 0)
4c1ca625c622b7 Nick Crews      2019-04-16   92  		return ret;
4c1ca625c622b7 Nick Crews      2019-04-16   93  
4c1ca625c622b7 Nick Crews      2019-04-16   94  	return count;
4c1ca625c622b7 Nick Crews      2019-04-16   95  }
4c1ca625c622b7 Nick Crews      2019-04-16   96  
4c1ca625c622b7 Nick Crews      2019-04-16  @97  static DEVICE_ATTR_WO(boot_on_ac);
4c1ca625c622b7 Nick Crews      2019-04-16   98  
79e3f1d3db3d99 Raul E Rangel   2019-06-03   99  static ssize_t get_info(struct device *dev, char *buf, enum get_ec_info_op op)
79e3f1d3db3d99 Raul E Rangel   2019-06-03  100  {
79e3f1d3db3d99 Raul E Rangel   2019-06-03  101  	struct wilco_ec_device *ec = dev_get_drvdata(dev);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  102  	struct get_ec_info_req req = { .cmd = CMD_EC_INFO, .op = op };
79e3f1d3db3d99 Raul E Rangel   2019-06-03  103  	struct get_ec_info_resp resp;
79e3f1d3db3d99 Raul E Rangel   2019-06-03  104  	int ret;
79e3f1d3db3d99 Raul E Rangel   2019-06-03  105  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  106  	struct wilco_ec_message msg = {
79e3f1d3db3d99 Raul E Rangel   2019-06-03  107  		.type = WILCO_EC_MSG_LEGACY,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  108  		.request_data = &req,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  109  		.request_size = sizeof(req),
79e3f1d3db3d99 Raul E Rangel   2019-06-03  110  		.response_data = &resp,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  111  		.response_size = sizeof(resp),
79e3f1d3db3d99 Raul E Rangel   2019-06-03  112  	};
79e3f1d3db3d99 Raul E Rangel   2019-06-03  113  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  114  	ret = wilco_ec_mailbox(ec, &msg);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  115  	if (ret < 0)
79e3f1d3db3d99 Raul E Rangel   2019-06-03  116  		return ret;
79e3f1d3db3d99 Raul E Rangel   2019-06-03  117  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  118  	return scnprintf(buf, PAGE_SIZE, "%.*s\n", (int)sizeof(resp.value),
79e3f1d3db3d99 Raul E Rangel   2019-06-03  119  			 (char *)&resp.value);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  120  }
79e3f1d3db3d99 Raul E Rangel   2019-06-03  121  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  122  static ssize_t version_show(struct device *dev, struct device_attribute *attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  123  			  char *buf)
79e3f1d3db3d99 Raul E Rangel   2019-06-03  124  {
79e3f1d3db3d99 Raul E Rangel   2019-06-03  125  	return get_info(dev, buf, CMD_GET_EC_LABEL);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  126  }
79e3f1d3db3d99 Raul E Rangel   2019-06-03  127  
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @128  static DEVICE_ATTR_RO(version);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  129  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  130  static ssize_t build_revision_show(struct device *dev,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  131  				   struct device_attribute *attr, char *buf)
79e3f1d3db3d99 Raul E Rangel   2019-06-03  132  {
79e3f1d3db3d99 Raul E Rangel   2019-06-03  133  	return get_info(dev, buf, CMD_GET_EC_REV);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  134  }
79e3f1d3db3d99 Raul E Rangel   2019-06-03  135  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  136  static DEVICE_ATTR_RO(build_revision);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  137  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  138  static ssize_t build_date_show(struct device *dev,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  139  			       struct device_attribute *attr, char *buf)
79e3f1d3db3d99 Raul E Rangel   2019-06-03  140  {
79e3f1d3db3d99 Raul E Rangel   2019-06-03  141  	return get_info(dev, buf, CMD_GET_EC_BUILD_DATE);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  142  }
79e3f1d3db3d99 Raul E Rangel   2019-06-03  143  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  144  static DEVICE_ATTR_RO(build_date);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  145  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  146  static ssize_t model_number_show(struct device *dev,
79e3f1d3db3d99 Raul E Rangel   2019-06-03  147  				 struct device_attribute *attr, char *buf)
79e3f1d3db3d99 Raul E Rangel   2019-06-03  148  {
79e3f1d3db3d99 Raul E Rangel   2019-06-03  149  	return get_info(dev, buf, CMD_GET_EC_MODEL);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  150  }
79e3f1d3db3d99 Raul E Rangel   2019-06-03  151  
79e3f1d3db3d99 Raul E Rangel   2019-06-03  152  static DEVICE_ATTR_RO(model_number);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  153  
fdf0fe2df3e321 Daniel Campello 2019-10-08  154  static int send_usb_charge(struct wilco_ec_device *ec,
fdf0fe2df3e321 Daniel Campello 2019-10-08  155  				struct usb_charge_request *rq,
fdf0fe2df3e321 Daniel Campello 2019-10-08  156  				struct usb_charge_response *rs)
fdf0fe2df3e321 Daniel Campello 2019-10-08  157  {
fdf0fe2df3e321 Daniel Campello 2019-10-08  158  	struct wilco_ec_message msg;
fdf0fe2df3e321 Daniel Campello 2019-10-08  159  	int ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  160  
fdf0fe2df3e321 Daniel Campello 2019-10-08  161  	memset(&msg, 0, sizeof(msg));
fdf0fe2df3e321 Daniel Campello 2019-10-08  162  	msg.type = WILCO_EC_MSG_LEGACY;
fdf0fe2df3e321 Daniel Campello 2019-10-08  163  	msg.request_data = rq;
fdf0fe2df3e321 Daniel Campello 2019-10-08  164  	msg.request_size = sizeof(*rq);
fdf0fe2df3e321 Daniel Campello 2019-10-08  165  	msg.response_data = rs;
fdf0fe2df3e321 Daniel Campello 2019-10-08  166  	msg.response_size = sizeof(*rs);
fdf0fe2df3e321 Daniel Campello 2019-10-08  167  	ret = wilco_ec_mailbox(ec, &msg);
fdf0fe2df3e321 Daniel Campello 2019-10-08  168  	if (ret < 0)
fdf0fe2df3e321 Daniel Campello 2019-10-08  169  		return ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  170  	if (rs->status)
fdf0fe2df3e321 Daniel Campello 2019-10-08  171  		return -EIO;
fdf0fe2df3e321 Daniel Campello 2019-10-08  172  
fdf0fe2df3e321 Daniel Campello 2019-10-08  173  	return 0;
fdf0fe2df3e321 Daniel Campello 2019-10-08  174  }
fdf0fe2df3e321 Daniel Campello 2019-10-08  175  
fdf0fe2df3e321 Daniel Campello 2019-10-08  176  static ssize_t usb_charge_show(struct device *dev,
fdf0fe2df3e321 Daniel Campello 2019-10-08  177  				    struct device_attribute *attr, char *buf)
fdf0fe2df3e321 Daniel Campello 2019-10-08  178  {
fdf0fe2df3e321 Daniel Campello 2019-10-08  179  	struct wilco_ec_device *ec = dev_get_drvdata(dev);
fdf0fe2df3e321 Daniel Campello 2019-10-08  180  	struct usb_charge_request rq;
fdf0fe2df3e321 Daniel Campello 2019-10-08  181  	struct usb_charge_response rs;
fdf0fe2df3e321 Daniel Campello 2019-10-08  182  	int ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  183  
fdf0fe2df3e321 Daniel Campello 2019-10-08  184  	memset(&rq, 0, sizeof(rq));
fdf0fe2df3e321 Daniel Campello 2019-10-08  185  	rq.cmd = CMD_USB_CHARGE;
fdf0fe2df3e321 Daniel Campello 2019-10-08  186  	rq.op = USB_CHARGE_GET;
fdf0fe2df3e321 Daniel Campello 2019-10-08  187  
fdf0fe2df3e321 Daniel Campello 2019-10-08  188  	ret = send_usb_charge(ec, &rq, &rs);
fdf0fe2df3e321 Daniel Campello 2019-10-08  189  	if (ret < 0)
fdf0fe2df3e321 Daniel Campello 2019-10-08  190  		return ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  191  
fdf0fe2df3e321 Daniel Campello 2019-10-08  192  	return sprintf(buf, "%d\n", rs.val);
fdf0fe2df3e321 Daniel Campello 2019-10-08  193  }
fdf0fe2df3e321 Daniel Campello 2019-10-08  194  
fdf0fe2df3e321 Daniel Campello 2019-10-08  195  static ssize_t usb_charge_store(struct device *dev,
fdf0fe2df3e321 Daniel Campello 2019-10-08  196  				     struct device_attribute *attr,
fdf0fe2df3e321 Daniel Campello 2019-10-08  197  				     const char *buf, size_t count)
fdf0fe2df3e321 Daniel Campello 2019-10-08  198  {
fdf0fe2df3e321 Daniel Campello 2019-10-08  199  	struct wilco_ec_device *ec = dev_get_drvdata(dev);
fdf0fe2df3e321 Daniel Campello 2019-10-08  200  	struct usb_charge_request rq;
fdf0fe2df3e321 Daniel Campello 2019-10-08  201  	struct usb_charge_response rs;
fdf0fe2df3e321 Daniel Campello 2019-10-08  202  	int ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  203  	u8 val;
fdf0fe2df3e321 Daniel Campello 2019-10-08  204  
fdf0fe2df3e321 Daniel Campello 2019-10-08  205  	ret = kstrtou8(buf, 10, &val);
fdf0fe2df3e321 Daniel Campello 2019-10-08  206  	if (ret < 0)
fdf0fe2df3e321 Daniel Campello 2019-10-08  207  		return ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  208  	if (val > 1)
fdf0fe2df3e321 Daniel Campello 2019-10-08  209  		return -EINVAL;
fdf0fe2df3e321 Daniel Campello 2019-10-08  210  
fdf0fe2df3e321 Daniel Campello 2019-10-08  211  	memset(&rq, 0, sizeof(rq));
fdf0fe2df3e321 Daniel Campello 2019-10-08  212  	rq.cmd = CMD_USB_CHARGE;
fdf0fe2df3e321 Daniel Campello 2019-10-08  213  	rq.op = USB_CHARGE_SET;
fdf0fe2df3e321 Daniel Campello 2019-10-08  214  	rq.val = val;
fdf0fe2df3e321 Daniel Campello 2019-10-08  215  
fdf0fe2df3e321 Daniel Campello 2019-10-08  216  	ret = send_usb_charge(ec, &rq, &rs);
fdf0fe2df3e321 Daniel Campello 2019-10-08  217  	if (ret < 0)
fdf0fe2df3e321 Daniel Campello 2019-10-08  218  		return ret;
fdf0fe2df3e321 Daniel Campello 2019-10-08  219  
fdf0fe2df3e321 Daniel Campello 2019-10-08  220  	return count;
fdf0fe2df3e321 Daniel Campello 2019-10-08  221  }
fdf0fe2df3e321 Daniel Campello 2019-10-08  222  
fdf0fe2df3e321 Daniel Campello 2019-10-08 @223  static DEVICE_ATTR_RW(usb_charge);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  224  
4c1ca625c622b7 Nick Crews      2019-04-16  225  static struct attribute *wilco_dev_attrs[] = {
4c1ca625c622b7 Nick Crews      2019-04-16 @226  	&dev_attr_boot_on_ac.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @227  	&dev_attr_build_date.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @228  	&dev_attr_build_revision.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @229  	&dev_attr_model_number.attr,
fdf0fe2df3e321 Daniel Campello 2019-10-08 @230  	&dev_attr_usb_charge.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @231  	&dev_attr_version.attr,
4c1ca625c622b7 Nick Crews      2019-04-16  232  	NULL,
4c1ca625c622b7 Nick Crews      2019-04-16  233  };
4c1ca625c622b7 Nick Crews      2019-04-16  234  
4c1ca625c622b7 Nick Crews      2019-04-16  235  static struct attribute_group wilco_dev_attr_group = {
4c1ca625c622b7 Nick Crews      2019-04-16  236  	.attrs = wilco_dev_attrs,
4c1ca625c622b7 Nick Crews      2019-04-16  237  };
4c1ca625c622b7 Nick Crews      2019-04-16  238  
4c1ca625c622b7 Nick Crews      2019-04-16  239  int wilco_ec_add_sysfs(struct wilco_ec_device *ec)
4c1ca625c622b7 Nick Crews      2019-04-16  240  {
4c1ca625c622b7 Nick Crews      2019-04-16 @241  	return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
4c1ca625c622b7 Nick Crews      2019-04-16  242  }
4c1ca625c622b7 Nick Crews      2019-04-16  243  
4c1ca625c622b7 Nick Crews      2019-04-16  244  void wilco_ec_remove_sysfs(struct wilco_ec_device *ec)
4c1ca625c622b7 Nick Crews      2019-04-16  245  {
4c1ca625c622b7 Nick Crews      2019-04-16 @246  	sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);

:::::: The code at line 69 was first introduced by commit
:::::: 4c1ca625c622b7a9f04c2949fd1ffdc6effa86de platform/chrome: wilco_ec: Add Boot on AC support

:::::: TO: Nick Crews <ncrews@chromium.org>
:::::: CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--gnm23pe37v3wzxfq
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
ogQKF3bRjZhAn4JBWAVtBvL/BI6a5Q/pAQA=

--gnm23pe37v3wzxfq--
