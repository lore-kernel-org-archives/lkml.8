Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFD01C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:43:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C67F21744
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:43:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727836AbgBECnm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:43:42 -0500
Received: from mga18.intel.com ([134.134.136.126]:35169 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727708AbgBECnm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:43:42 -0500
X-Amp-Result: UNSCANNABLE
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga106.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Feb 2020 18:43:40 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,404,1574150400"; 
   d="gz'50?scan'50,208,50";a="279246861"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by FMSMGA003.fm.intel.com with ESMTP; 04 Feb 2020 18:43:38 -0800
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1izAfB-0005N0-Hi; Wed, 05 Feb 2020 10:43:37 +0800
Date:   Wed, 5 Feb 2020 10:43:14 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     kbuild-all@lists.01.org,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Nick Crews <ncrews@chromium.org>, linux-kernel@vger.kernel.org,
        Daniel Campello <campello@chromium.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Subject: Re: [PATCH v1] platform/chrome: wilco_ec: Platform data shan't
 include kernel.h
Message-ID: <202002051010.tSvPdMMe%lkp@intel.com>
References: <20200204162729.29175-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="hoepbl7lllthy75j"
Content-Disposition: inline
In-Reply-To: <20200204162729.29175-1-andriy.shevchenko@linux.intel.com>
User-Agent: NeoMutt/20170113 (1.7.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hoepbl7lllthy75j
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
config: x86_64-randconfig-s2-20200205 (attached as .config)
compiler: gcc-5 (Ubuntu 5.5.0-12ubuntu1) 5.5.0 20171010
reproduce:
        # save the attached .config to linux build tree
        make ARCH=x86_64 

If you fix the issue, kindly add following tag
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>):

>> drivers/platform/chrome/wilco_ec/sysfs.c:67:5: warning: 'struct device_attribute' declared inside parameter list
        const char *buf, size_t count)
        ^
>> drivers/platform/chrome/wilco_ec/sysfs.c:67:5: warning: its scope is only this definition or declaration, which is probably not what you want
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'boot_on_ac_store':
   drivers/platform/chrome/wilco_ec/sysfs.c:69:31: error: implicit declaration of function 'dev_get_drvdata' [-Werror=implicit-function-declaration]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^
   drivers/platform/chrome/wilco_ec/sysfs.c:69:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:97:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_WO' [-Werror=implicit-int]
    static DEVICE_ATTR_WO(boot_on_ac);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:97:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_WO(boot_on_ac);
    ^
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'get_info':
   drivers/platform/chrome/wilco_ec/sysfs.c:101:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:123:6: warning: 'struct device_attribute' declared inside parameter list
         char *buf)
         ^
   drivers/platform/chrome/wilco_ec/sysfs.c:128:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(version);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:128:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(version);
    ^
   drivers/platform/chrome/wilco_ec/sysfs.c:131:15: warning: 'struct device_attribute' declared inside parameter list
           struct device_attribute *attr, char *buf)
                  ^
   drivers/platform/chrome/wilco_ec/sysfs.c:136:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(build_revision);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:136:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(build_revision);
    ^
   drivers/platform/chrome/wilco_ec/sysfs.c:139:18: warning: 'struct device_attribute' declared inside parameter list
              struct device_attribute *attr, char *buf)
                     ^
   drivers/platform/chrome/wilco_ec/sysfs.c:144:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(build_date);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:144:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(build_date);
    ^
   drivers/platform/chrome/wilco_ec/sysfs.c:147:13: warning: 'struct device_attribute' declared inside parameter list
         struct device_attribute *attr, char *buf)
                ^
   drivers/platform/chrome/wilco_ec/sysfs.c:152:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RO' [-Werror=implicit-int]
    static DEVICE_ATTR_RO(model_number);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:152:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RO(model_number);
    ^
   drivers/platform/chrome/wilco_ec/sysfs.c:177:16: warning: 'struct device_attribute' declared inside parameter list
            struct device_attribute *attr, char *buf)
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'usb_charge_show':
   drivers/platform/chrome/wilco_ec/sysfs.c:179:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:197:10: warning: 'struct device_attribute' declared inside parameter list
             const char *buf, size_t count)
             ^
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'usb_charge_store':
   drivers/platform/chrome/wilco_ec/sysfs.c:199:31: warning: initialization makes pointer from integer without a cast [-Wint-conversion]
     struct wilco_ec_device *ec = dev_get_drvdata(dev);
                                  ^
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:223:8: error: type defaults to 'int' in declaration of 'DEVICE_ATTR_RW' [-Werror=implicit-int]
    static DEVICE_ATTR_RW(usb_charge);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:223:1: warning: parameter names (without types) in function declaration
    static DEVICE_ATTR_RW(usb_charge);
    ^
   drivers/platform/chrome/wilco_ec/sysfs.c:226:3: error: 'dev_attr_boot_on_ac' undeclared here (not in a function)
     &dev_attr_boot_on_ac.attr,
      ^
>> drivers/platform/chrome/wilco_ec/sysfs.c:227:3: error: 'dev_attr_build_date' undeclared here (not in a function)
     &dev_attr_build_date.attr,
      ^
>> drivers/platform/chrome/wilco_ec/sysfs.c:228:3: error: 'dev_attr_build_revision' undeclared here (not in a function)
     &dev_attr_build_revision.attr,
      ^
>> drivers/platform/chrome/wilco_ec/sysfs.c:229:3: error: 'dev_attr_model_number' undeclared here (not in a function)
     &dev_attr_model_number.attr,
      ^
>> drivers/platform/chrome/wilco_ec/sysfs.c:230:3: error: 'dev_attr_usb_charge' undeclared here (not in a function)
     &dev_attr_usb_charge.attr,
      ^
>> drivers/platform/chrome/wilco_ec/sysfs.c:231:3: error: 'dev_attr_version' undeclared here (not in a function)
     &dev_attr_version.attr,
      ^
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'wilco_ec_add_sysfs':
   drivers/platform/chrome/wilco_ec/sysfs.c:241:36: error: dereferencing pointer to incomplete type 'struct device'
     return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
                                       ^
   drivers/platform/chrome/wilco_ec/sysfs.c:241:36: error: request for member 'kobj' in something not a structure or union
   drivers/platform/chrome/wilco_ec/sysfs.c:241:28: error: passing argument 1 of 'sysfs_create_group' from incompatible pointer type [-Werror=incompatible-pointer-types]
     return sysfs_create_group(&ec->dev->kobj, &wilco_dev_attr_group);
                               ^
   In file included from drivers/platform/chrome/wilco_ec/sysfs.c:12:0:
   include/linux/sysfs.h:276:18: note: expected 'struct kobject *' but argument is of type 'struct attribute * (*)[1]'
    int __must_check sysfs_create_group(struct kobject *kobj,
                     ^
   drivers/platform/chrome/wilco_ec/sysfs.c: In function 'wilco_ec_remove_sysfs':
   drivers/platform/chrome/wilco_ec/sysfs.c:246:29: error: request for member 'kobj' in something not a structure or union
     sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);
                                ^
   drivers/platform/chrome/wilco_ec/sysfs.c:246:21: error: passing argument 1 of 'sysfs_remove_group' from incompatible pointer type [-Werror=incompatible-pointer-types]
     sysfs_remove_group(&ec->dev->kobj, &wilco_dev_attr_group);
                        ^
   In file included from drivers/platform/chrome/wilco_ec/sysfs.c:12:0:
   include/linux/sysfs.h:284:6: note: expected 'struct kobject *' but argument is of type 'struct attribute * (*)[1]'
    void sysfs_remove_group(struct kobject *kobj,
         ^
   drivers/platform/chrome/wilco_ec/sysfs.c: At top level:
   drivers/platform/chrome/wilco_ec/sysfs.c:65:16: warning: 'boot_on_ac_store' defined but not used [-Wunused-function]
    static ssize_t boot_on_ac_store(struct device *dev,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:97:8: warning: 'DEVICE_ATTR_WO' declared 'static' but never defined [-Wunused-function]
    static DEVICE_ATTR_WO(boot_on_ac);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:122:16: warning: 'version_show' defined but not used [-Wunused-function]
    static ssize_t version_show(struct device *dev, struct device_attribute *attr,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:152:8: warning: 'DEVICE_ATTR_RO' declared 'static' but never defined [-Wunused-function]
    static DEVICE_ATTR_RO(model_number);
           ^
   drivers/platform/chrome/wilco_ec/sysfs.c:130:16: warning: 'build_revision_show' defined but not used [-Wunused-function]
    static ssize_t build_revision_show(struct device *dev,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:138:16: warning: 'build_date_show' defined but not used [-Wunused-function]
    static ssize_t build_date_show(struct device *dev,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:146:16: warning: 'model_number_show' defined but not used [-Wunused-function]
    static ssize_t model_number_show(struct device *dev,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:176:16: warning: 'usb_charge_show' defined but not used [-Wunused-function]
    static ssize_t usb_charge_show(struct device *dev,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:195:16: warning: 'usb_charge_store' defined but not used [-Wunused-function]
    static ssize_t usb_charge_store(struct device *dev,
                   ^
   drivers/platform/chrome/wilco_ec/sysfs.c:223:8: warning: 'DEVICE_ATTR_RW' declared 'static' but never defined [-Wunused-function]
    static DEVICE_ATTR_RW(usb_charge);
           ^
   cc1: some warnings being treated as errors

vim +/dev_attr_build_date +227 drivers/platform/chrome/wilco_ec/sysfs.c

79e3f1d3db3d99 Raul E Rangel   2019-06-03   64  
4c1ca625c622b7 Nick Crews      2019-04-16   65  static ssize_t boot_on_ac_store(struct device *dev,
4c1ca625c622b7 Nick Crews      2019-04-16   66  				struct device_attribute *attr,
4c1ca625c622b7 Nick Crews      2019-04-16  @67  				const char *buf, size_t count)
4c1ca625c622b7 Nick Crews      2019-04-16   68  {
4c1ca625c622b7 Nick Crews      2019-04-16   69  	struct wilco_ec_device *ec = dev_get_drvdata(dev);
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
4c1ca625c622b7 Nick Crews      2019-04-16   97  static DEVICE_ATTR_WO(boot_on_ac);
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
79e3f1d3db3d99 Raul E Rangel   2019-06-03  128  static DEVICE_ATTR_RO(version);
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
fdf0fe2df3e321 Daniel Campello 2019-10-08  223  static DEVICE_ATTR_RW(usb_charge);
79e3f1d3db3d99 Raul E Rangel   2019-06-03  224  
4c1ca625c622b7 Nick Crews      2019-04-16  225  static struct attribute *wilco_dev_attrs[] = {
4c1ca625c622b7 Nick Crews      2019-04-16  226  	&dev_attr_boot_on_ac.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @227  	&dev_attr_build_date.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @228  	&dev_attr_build_revision.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @229  	&dev_attr_model_number.attr,
fdf0fe2df3e321 Daniel Campello 2019-10-08 @230  	&dev_attr_usb_charge.attr,
79e3f1d3db3d99 Raul E Rangel   2019-06-03 @231  	&dev_attr_version.attr,
4c1ca625c622b7 Nick Crews      2019-04-16  232  	NULL,
4c1ca625c622b7 Nick Crews      2019-04-16  233  };
4c1ca625c622b7 Nick Crews      2019-04-16  234  

:::::: The code at line 227 was first introduced by commit
:::::: 79e3f1d3db3d99ac7ae4f29b00da545df231a5a7 platform/chrome: wilco_ec: Add version sysfs entries

:::::: TO: Raul E Rangel <rrangel@chromium.org>
:::::: CC: Enric Balletbo i Serra <enric.balletbo@collabora.com>

---
0-DAY kernel test infrastructure                 Open Source Technology Center
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org Intel Corporation

--hoepbl7lllthy75j
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--hoepbl7lllthy75j--
