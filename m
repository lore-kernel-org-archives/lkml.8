Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9501CC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:55:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F9F8207D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 06:55:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgERGzr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 02:55:47 -0400
Received: from mga11.intel.com ([192.55.52.93]:9317 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726127AbgERGzq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 02:55:46 -0400
IronPort-SDR: cDQOEpTTHvm39+KogoUp5lbJ3N3RnhzpZKe4WdtpWLs6g3f2+iOAS3J8nu9vSYr5m9JtUt1z/j
 mqNWp7W4EXAA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 May 2020 23:17:30 -0700
IronPort-SDR: E23n4D+6TmmDrd6KUaiA9pjlhkuHkjADMD1TuXCKsV2qCbB163kSRh4ZAEWgJIA27AwUKtXUWw
 2nk6h85WxUSA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,406,1583222400"; 
   d="gz'50?scan'50,208,50";a="465652655"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 17 May 2020 23:17:28 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jaZ5c-0009qh-67; Mon, 18 May 2020 14:17:28 +0800
Date:   Mon, 18 May 2020 14:16:19 +0800
From:   kbuild test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>
Subject: drivers/iommu/exynos-iommu.c:673:54: error: 'struct dev_archdata'
 has no member named 'iommu'
Message-ID: <202005181412.frC4juFy%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="J2SCkAp4GZ/dPZZf"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--J2SCkAp4GZ/dPZZf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Krzysztof,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b9bbe6ed63b2b9f2c9ee5cbd0f2c946a2723f4ce
commit: e93a1695d7fb551376b1c1220a267d032b6ad159 iommu: Enable compile testing for some of drivers
date:   3 months ago
config: ia64-randconfig-s001-20200518 (attached as .config)
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.1-193-gb8fad4bc-dirty
        git checkout e93a1695d7fb551376b1c1220a267d032b6ad159
        # save the attached .config to linux build tree
        make C=1 ARCH=ia64 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kbuild test robot <lkp@intel.com>

All error/warnings (new ones prefixed by >>, old ones prefixed by <<):

drivers/iommu/exynos-iommu.c: In function 'exynos_sysmmu_suspend':
>> drivers/iommu/exynos-iommu.c:673:54: error: 'struct dev_archdata' has no member named 'iommu'
673 |   struct exynos_iommu_owner *owner = master->archdata.iommu;
|                                                      ^
drivers/iommu/exynos-iommu.c: In function 'exynos_sysmmu_resume':
drivers/iommu/exynos-iommu.c:691:54: error: 'struct dev_archdata' has no member named 'iommu'
691 |   struct exynos_iommu_owner *owner = master->archdata.iommu;
|                                                      ^
drivers/iommu/exynos-iommu.c: In function 'exynos_iommu_detach_device':
drivers/iommu/exynos-iommu.c:840:50: error: 'struct dev_archdata' has no member named 'iommu'
840 |  struct exynos_iommu_owner *owner = dev->archdata.iommu;
|                                                  ^
drivers/iommu/exynos-iommu.c:176:40: error: 'struct dev_archdata' has no member named 'iommu'
176 | #define has_sysmmu(dev)  (dev->archdata.iommu != NULL)
|                                        ^
>> drivers/iommu/exynos-iommu.c:846:7: note: in expansion of macro 'has_sysmmu'
846 |  if (!has_sysmmu(dev) || owner->domain != iommu_domain)
|       ^~~~~~~~~~
drivers/iommu/exynos-iommu.c: In function 'exynos_iommu_attach_device':
drivers/iommu/exynos-iommu.c:878:50: error: 'struct dev_archdata' has no member named 'iommu'
878 |  struct exynos_iommu_owner *owner = dev->archdata.iommu;
|                                                  ^
drivers/iommu/exynos-iommu.c:176:40: error: 'struct dev_archdata' has no member named 'iommu'
176 | #define has_sysmmu(dev)  (dev->archdata.iommu != NULL)
|                                        ^
drivers/iommu/exynos-iommu.c:884:7: note: in expansion of macro 'has_sysmmu'
884 |  if (!has_sysmmu(dev))
|       ^~~~~~~~~~
drivers/iommu/exynos-iommu.c: In function 'exynos_iommu_add_device':
drivers/iommu/exynos-iommu.c:1240:50: error: 'struct dev_archdata' has no member named 'iommu'
1240 |  struct exynos_iommu_owner *owner = dev->archdata.iommu;
|                                                  ^
drivers/iommu/exynos-iommu.c:176:40: error: 'struct dev_archdata' has no member named 'iommu'
176 | #define has_sysmmu(dev)  (dev->archdata.iommu != NULL)
|                                        ^
drivers/iommu/exynos-iommu.c:1244:7: note: in expansion of macro 'has_sysmmu'
1244 |  if (!has_sysmmu(dev))
|       ^~~~~~~~~~
drivers/iommu/exynos-iommu.c: In function 'exynos_iommu_remove_device':
drivers/iommu/exynos-iommu.c:1269:50: error: 'struct dev_archdata' has no member named 'iommu'
1269 |  struct exynos_iommu_owner *owner = dev->archdata.iommu;
|                                                  ^
drivers/iommu/exynos-iommu.c:176:40: error: 'struct dev_archdata' has no member named 'iommu'
176 | #define has_sysmmu(dev)  (dev->archdata.iommu != NULL)
|                                        ^
drivers/iommu/exynos-iommu.c:1272:7: note: in expansion of macro 'has_sysmmu'
1272 |  if (!has_sysmmu(dev))
|       ^~~~~~~~~~
drivers/iommu/exynos-iommu.c: In function 'exynos_iommu_of_xlate':
drivers/iommu/exynos-iommu.c:1294:50: error: 'struct dev_archdata' has no member named 'iommu'
1294 |  struct exynos_iommu_owner *owner = dev->archdata.iommu;
|                                                  ^
drivers/iommu/exynos-iommu.c:1312:16: error: 'struct dev_archdata' has no member named 'iommu'
1312 |   dev->archdata.iommu = owner;
|                ^

sparse warnings: (new ones prefixed by >>)

   drivers/iommu/exynos-iommu.c:673:68: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:691:68: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:840:57: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:846:14: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:878:57: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:884:14: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:1240:57: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:1244:14: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:1269:57: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:1272:14: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:1294:57: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   drivers/iommu/exynos-iommu.c:1312:30: sparse: sparse: using member 'iommu' in incomplete struct dev_archdata
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@    expected unsigned int [usertype] value @@    got restrunsigned int [usertype] value @@
   include/asm-generic/io.h:225:22: sparse:    expected unsigned int [usertype] value
   include/asm-generic/io.h:225:22: sparse:    got restricted __le32 [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] @@    got restrunsigned int [usertype] @@
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    expected unsigned int [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    got restricted __le32 [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] @@    got restrunsigned int [usertype] @@
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    expected unsigned int [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    got restricted __le32 [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] @@    got restrunsigned int [usertype] @@
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    expected unsigned int [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    got restricted __le32 [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] @@    got restrunsigned int [usertype] @@
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    expected unsigned int [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    got restricted __le32 [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse: sparse: incorrect type in assignment (different base types) @@    expected unsigned int [usertype] @@    got restrunsigned int [usertype] @@
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    expected unsigned int [usertype]
>> drivers/iommu/exynos-iommu.c:728:14: sparse:    got restricted __le32 [usertype]

vim +673 drivers/iommu/exynos-iommu.c

2a96536e77b43c KyongHo Cho      2012-05-12  666  
9b265536c27116 Marek Szyprowski 2016-11-14  667  static int __maybe_unused exynos_sysmmu_suspend(struct device *dev)
622015e407b082 Marek Szyprowski 2015-05-19  668  {
622015e407b082 Marek Szyprowski 2015-05-19  669  	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
47a574fffca102 Marek Szyprowski 2016-11-14  670  	struct device *master = data->master;
622015e407b082 Marek Szyprowski 2015-05-19  671  
47a574fffca102 Marek Szyprowski 2016-11-14  672  	if (master) {
9b265536c27116 Marek Szyprowski 2016-11-14 @673  		struct exynos_iommu_owner *owner = master->archdata.iommu;
9b265536c27116 Marek Szyprowski 2016-11-14  674  
9b265536c27116 Marek Szyprowski 2016-11-14  675  		mutex_lock(&owner->rpm_lock);
92798b4566b1ad Marek Szyprowski 2016-11-14  676  		if (data->domain) {
92798b4566b1ad Marek Szyprowski 2016-11-14  677  			dev_dbg(data->sysmmu, "saving state\n");
92798b4566b1ad Marek Szyprowski 2016-11-14  678  			__sysmmu_disable(data);
92798b4566b1ad Marek Szyprowski 2016-11-14  679  		}
9b265536c27116 Marek Szyprowski 2016-11-14  680  		mutex_unlock(&owner->rpm_lock);
622015e407b082 Marek Szyprowski 2015-05-19  681  	}
622015e407b082 Marek Szyprowski 2015-05-19  682  	return 0;
622015e407b082 Marek Szyprowski 2015-05-19  683  }
622015e407b082 Marek Szyprowski 2015-05-19  684  
9b265536c27116 Marek Szyprowski 2016-11-14  685  static int __maybe_unused exynos_sysmmu_resume(struct device *dev)
622015e407b082 Marek Szyprowski 2015-05-19  686  {
622015e407b082 Marek Szyprowski 2015-05-19  687  	struct sysmmu_drvdata *data = dev_get_drvdata(dev);
47a574fffca102 Marek Szyprowski 2016-11-14  688  	struct device *master = data->master;
622015e407b082 Marek Szyprowski 2015-05-19  689  
47a574fffca102 Marek Szyprowski 2016-11-14  690  	if (master) {
9b265536c27116 Marek Szyprowski 2016-11-14  691  		struct exynos_iommu_owner *owner = master->archdata.iommu;
9b265536c27116 Marek Szyprowski 2016-11-14  692  
9b265536c27116 Marek Szyprowski 2016-11-14  693  		mutex_lock(&owner->rpm_lock);
92798b4566b1ad Marek Szyprowski 2016-11-14  694  		if (data->domain) {
92798b4566b1ad Marek Szyprowski 2016-11-14  695  			dev_dbg(data->sysmmu, "restoring state\n");
47a574fffca102 Marek Szyprowski 2016-11-14  696  			__sysmmu_enable(data);
622015e407b082 Marek Szyprowski 2015-05-19  697  		}
9b265536c27116 Marek Szyprowski 2016-11-14  698  		mutex_unlock(&owner->rpm_lock);
92798b4566b1ad Marek Szyprowski 2016-11-14  699  	}
622015e407b082 Marek Szyprowski 2015-05-19  700  	return 0;
622015e407b082 Marek Szyprowski 2015-05-19  701  }
622015e407b082 Marek Szyprowski 2015-05-19  702  
622015e407b082 Marek Szyprowski 2015-05-19  703  static const struct dev_pm_ops sysmmu_pm_ops = {
9b265536c27116 Marek Szyprowski 2016-11-14  704  	SET_RUNTIME_PM_OPS(exynos_sysmmu_suspend, exynos_sysmmu_resume, NULL)
2f5f44f205cc95 Marek Szyprowski 2016-11-14  705  	SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
9b265536c27116 Marek Szyprowski 2016-11-14  706  				pm_runtime_force_resume)
622015e407b082 Marek Szyprowski 2015-05-19  707  };
622015e407b082 Marek Szyprowski 2015-05-19  708  
9d25e3cc83d731 Marek Szyprowski 2017-10-09  709  static const struct of_device_id sysmmu_of_match[] = {
6b21a5db36427d Cho KyongHo      2014-05-12  710  	{ .compatible	= "samsung,exynos-sysmmu", },
6b21a5db36427d Cho KyongHo      2014-05-12  711  	{ },
6b21a5db36427d Cho KyongHo      2014-05-12  712  };
6b21a5db36427d Cho KyongHo      2014-05-12  713  
6b21a5db36427d Cho KyongHo      2014-05-12  714  static struct platform_driver exynos_sysmmu_driver __refdata = {
2a96536e77b43c KyongHo Cho      2012-05-12  715  	.probe	= exynos_sysmmu_probe,
2a96536e77b43c KyongHo Cho      2012-05-12  716  	.driver	= {
2a96536e77b43c KyongHo Cho      2012-05-12  717  		.name		= "exynos-sysmmu",
6b21a5db36427d Cho KyongHo      2014-05-12  718  		.of_match_table	= sysmmu_of_match,
622015e407b082 Marek Szyprowski 2015-05-19  719  		.pm		= &sysmmu_pm_ops,
b54b874fbaf5e0 Marek Szyprowski 2016-05-20  720  		.suppress_bind_attrs = true,
2a96536e77b43c KyongHo Cho      2012-05-12  721  	}
2a96536e77b43c KyongHo Cho      2012-05-12  722  };
2a96536e77b43c KyongHo Cho      2012-05-12  723  
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  724  static inline void update_pte(sysmmu_pte_t *ent, sysmmu_pte_t val)
2a96536e77b43c KyongHo Cho      2012-05-12  725  {
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  726  	dma_sync_single_for_cpu(dma_dev, virt_to_phys(ent), sizeof(*ent),
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  727  				DMA_TO_DEVICE);
6ae5343c26f9cb Ben Dooks        2016-06-08 @728  	*ent = cpu_to_le32(val);
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  729  	dma_sync_single_for_device(dma_dev, virt_to_phys(ent), sizeof(*ent),
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  730  				   DMA_TO_DEVICE);
2a96536e77b43c KyongHo Cho      2012-05-12  731  }
2a96536e77b43c KyongHo Cho      2012-05-12  732  
e1fd1eaa3323b3 Joerg Roedel     2015-03-26  733  static struct iommu_domain *exynos_iommu_domain_alloc(unsigned type)
2a96536e77b43c KyongHo Cho      2012-05-12  734  {
bfa004893c55ea Marek Szyprowski 2015-05-19  735  	struct exynos_iommu_domain *domain;
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  736  	dma_addr_t handle;
66a7ed84b345d6 Cho KyongHo      2014-05-12  737  	int i;
2a96536e77b43c KyongHo Cho      2012-05-12  738  
740a01eee9ada9 Marek Szyprowski 2016-02-18  739  	/* Check if correct PTE offsets are initialized */
740a01eee9ada9 Marek Szyprowski 2016-02-18  740  	BUG_ON(PG_ENT_SHIFT < 0 || !dma_dev);
e1fd1eaa3323b3 Joerg Roedel     2015-03-26  741  
bfa004893c55ea Marek Szyprowski 2015-05-19  742  	domain = kzalloc(sizeof(*domain), GFP_KERNEL);
bfa004893c55ea Marek Szyprowski 2015-05-19  743  	if (!domain)
e1fd1eaa3323b3 Joerg Roedel     2015-03-26  744  		return NULL;
2a96536e77b43c KyongHo Cho      2012-05-12  745  
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  746  	if (type == IOMMU_DOMAIN_DMA) {
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  747  		if (iommu_get_dma_cookie(&domain->domain) != 0)
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  748  			goto err_pgtable;
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  749  	} else if (type != IOMMU_DOMAIN_UNMANAGED) {
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  750  		goto err_pgtable;
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  751  	}
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  752  
bfa004893c55ea Marek Szyprowski 2015-05-19  753  	domain->pgtable = (sysmmu_pte_t *)__get_free_pages(GFP_KERNEL, 2);
bfa004893c55ea Marek Szyprowski 2015-05-19  754  	if (!domain->pgtable)
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  755  		goto err_dma_cookie;
2a96536e77b43c KyongHo Cho      2012-05-12  756  
bfa004893c55ea Marek Szyprowski 2015-05-19  757  	domain->lv2entcnt = (short *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, 1);
bfa004893c55ea Marek Szyprowski 2015-05-19  758  	if (!domain->lv2entcnt)
2a96536e77b43c KyongHo Cho      2012-05-12  759  		goto err_counter;
2a96536e77b43c KyongHo Cho      2012-05-12  760  
f171abab8f1a75 Sachin Kamat     2014-08-04  761  	/* Workaround for System MMU v3.3 to prevent caching 1MiB mapping */
e75276638c1423 Marek Szyprowski 2017-03-24  762  	for (i = 0; i < NUM_LV1ENTRIES; i++)
e75276638c1423 Marek Szyprowski 2017-03-24  763  		domain->pgtable[i] = ZERO_LV2LINK;
66a7ed84b345d6 Cho KyongHo      2014-05-12  764  
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  765  	handle = dma_map_single(dma_dev, domain->pgtable, LV1TABLE_SIZE,
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  766  				DMA_TO_DEVICE);
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  767  	/* For mapping page table entries we rely on dma == phys */
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  768  	BUG_ON(handle != virt_to_phys(domain->pgtable));
0d6d3da46ac594 Marek Szyprowski 2017-01-09  769  	if (dma_mapping_error(dma_dev, handle))
0d6d3da46ac594 Marek Szyprowski 2017-01-09  770  		goto err_lv2ent;
2a96536e77b43c KyongHo Cho      2012-05-12  771  
bfa004893c55ea Marek Szyprowski 2015-05-19  772  	spin_lock_init(&domain->lock);
bfa004893c55ea Marek Szyprowski 2015-05-19  773  	spin_lock_init(&domain->pgtablelock);
bfa004893c55ea Marek Szyprowski 2015-05-19  774  	INIT_LIST_HEAD(&domain->clients);
2a96536e77b43c KyongHo Cho      2012-05-12  775  
bfa004893c55ea Marek Szyprowski 2015-05-19  776  	domain->domain.geometry.aperture_start = 0;
bfa004893c55ea Marek Szyprowski 2015-05-19  777  	domain->domain.geometry.aperture_end   = ~0UL;
bfa004893c55ea Marek Szyprowski 2015-05-19  778  	domain->domain.geometry.force_aperture = true;
3177bb76a8c510 Joerg Roedel     2012-07-11  779  
bfa004893c55ea Marek Szyprowski 2015-05-19  780  	return &domain->domain;
2a96536e77b43c KyongHo Cho      2012-05-12  781  
0d6d3da46ac594 Marek Szyprowski 2017-01-09  782  err_lv2ent:
0d6d3da46ac594 Marek Szyprowski 2017-01-09  783  	free_pages((unsigned long)domain->lv2entcnt, 1);
2a96536e77b43c KyongHo Cho      2012-05-12  784  err_counter:
bfa004893c55ea Marek Szyprowski 2015-05-19  785  	free_pages((unsigned long)domain->pgtable, 2);
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  786  err_dma_cookie:
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  787  	if (type == IOMMU_DOMAIN_DMA)
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  788  		iommu_put_dma_cookie(&domain->domain);
2a96536e77b43c KyongHo Cho      2012-05-12  789  err_pgtable:
bfa004893c55ea Marek Szyprowski 2015-05-19  790  	kfree(domain);
e1fd1eaa3323b3 Joerg Roedel     2015-03-26  791  	return NULL;
2a96536e77b43c KyongHo Cho      2012-05-12  792  }
2a96536e77b43c KyongHo Cho      2012-05-12  793  
bfa004893c55ea Marek Szyprowski 2015-05-19  794  static void exynos_iommu_domain_free(struct iommu_domain *iommu_domain)
2a96536e77b43c KyongHo Cho      2012-05-12  795  {
bfa004893c55ea Marek Szyprowski 2015-05-19  796  	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
469acebe4a6890 Marek Szyprowski 2015-05-19  797  	struct sysmmu_drvdata *data, *next;
2a96536e77b43c KyongHo Cho      2012-05-12  798  	unsigned long flags;
2a96536e77b43c KyongHo Cho      2012-05-12  799  	int i;
2a96536e77b43c KyongHo Cho      2012-05-12  800  
bfa004893c55ea Marek Szyprowski 2015-05-19  801  	WARN_ON(!list_empty(&domain->clients));
2a96536e77b43c KyongHo Cho      2012-05-12  802  
bfa004893c55ea Marek Szyprowski 2015-05-19  803  	spin_lock_irqsave(&domain->lock, flags);
2a96536e77b43c KyongHo Cho      2012-05-12  804  
bfa004893c55ea Marek Szyprowski 2015-05-19  805  	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
e11723000f1641 Marek Szyprowski 2016-11-14  806  		spin_lock(&data->lock);
b0d4c861a99d00 Marek Szyprowski 2016-11-14  807  		__sysmmu_disable(data);
47a574fffca102 Marek Szyprowski 2016-11-14  808  		data->pgtable = 0;
47a574fffca102 Marek Szyprowski 2016-11-14  809  		data->domain = NULL;
469acebe4a6890 Marek Szyprowski 2015-05-19  810  		list_del_init(&data->domain_node);
e11723000f1641 Marek Szyprowski 2016-11-14  811  		spin_unlock(&data->lock);
2a96536e77b43c KyongHo Cho      2012-05-12  812  	}
2a96536e77b43c KyongHo Cho      2012-05-12  813  
bfa004893c55ea Marek Szyprowski 2015-05-19  814  	spin_unlock_irqrestore(&domain->lock, flags);
2a96536e77b43c KyongHo Cho      2012-05-12  815  
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  816  	if (iommu_domain->type == IOMMU_DOMAIN_DMA)
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  817  		iommu_put_dma_cookie(iommu_domain);
58c6f6a3dc97ed Marek Szyprowski 2016-02-18  818  
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  819  	dma_unmap_single(dma_dev, virt_to_phys(domain->pgtable), LV1TABLE_SIZE,
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  820  			 DMA_TO_DEVICE);
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  821  
2a96536e77b43c KyongHo Cho      2012-05-12  822  	for (i = 0; i < NUM_LV1ENTRIES; i++)
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  823  		if (lv1ent_page(domain->pgtable + i)) {
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  824  			phys_addr_t base = lv2table_base(domain->pgtable + i);
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  825  
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  826  			dma_unmap_single(dma_dev, base, LV2TABLE_SIZE,
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  827  					 DMA_TO_DEVICE);
734c3c732ca91a Cho KyongHo      2014-05-12  828  			kmem_cache_free(lv2table_kmem_cache,
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  829  					phys_to_virt(base));
5e3435eb7e1d8c Marek Szyprowski 2016-02-18  830  		}
2a96536e77b43c KyongHo Cho      2012-05-12  831  
bfa004893c55ea Marek Szyprowski 2015-05-19  832  	free_pages((unsigned long)domain->pgtable, 2);
bfa004893c55ea Marek Szyprowski 2015-05-19  833  	free_pages((unsigned long)domain->lv2entcnt, 1);
bfa004893c55ea Marek Szyprowski 2015-05-19  834  	kfree(domain);
2a96536e77b43c KyongHo Cho      2012-05-12  835  }
2a96536e77b43c KyongHo Cho      2012-05-12  836  
5fa61cbff16224 Marek Szyprowski 2016-02-18  837  static void exynos_iommu_detach_device(struct iommu_domain *iommu_domain,
5fa61cbff16224 Marek Szyprowski 2016-02-18  838  				    struct device *dev)
5fa61cbff16224 Marek Szyprowski 2016-02-18  839  {
5fa61cbff16224 Marek Szyprowski 2016-02-18  840  	struct exynos_iommu_owner *owner = dev->archdata.iommu;
5fa61cbff16224 Marek Szyprowski 2016-02-18  841  	struct exynos_iommu_domain *domain = to_exynos_domain(iommu_domain);
5fa61cbff16224 Marek Szyprowski 2016-02-18  842  	phys_addr_t pagetable = virt_to_phys(domain->pgtable);
5fa61cbff16224 Marek Szyprowski 2016-02-18  843  	struct sysmmu_drvdata *data, *next;
5fa61cbff16224 Marek Szyprowski 2016-02-18  844  	unsigned long flags;
5fa61cbff16224 Marek Szyprowski 2016-02-18  845  
5fa61cbff16224 Marek Szyprowski 2016-02-18 @846  	if (!has_sysmmu(dev) || owner->domain != iommu_domain)
5fa61cbff16224 Marek Szyprowski 2016-02-18  847  		return;
5fa61cbff16224 Marek Szyprowski 2016-02-18  848  
9b265536c27116 Marek Szyprowski 2016-11-14  849  	mutex_lock(&owner->rpm_lock);
9b265536c27116 Marek Szyprowski 2016-11-14  850  
9b265536c27116 Marek Szyprowski 2016-11-14  851  	list_for_each_entry(data, &owner->controllers, owner_node) {
9b265536c27116 Marek Szyprowski 2016-11-14  852  		pm_runtime_get_noresume(data->sysmmu);
9b265536c27116 Marek Szyprowski 2016-11-14  853  		if (pm_runtime_active(data->sysmmu))
e11723000f1641 Marek Szyprowski 2016-11-14  854  			__sysmmu_disable(data);
e11723000f1641 Marek Szyprowski 2016-11-14  855  		pm_runtime_put(data->sysmmu);
e11723000f1641 Marek Szyprowski 2016-11-14  856  	}
e11723000f1641 Marek Szyprowski 2016-11-14  857  
5fa61cbff16224 Marek Szyprowski 2016-02-18  858  	spin_lock_irqsave(&domain->lock, flags);
5fa61cbff16224 Marek Szyprowski 2016-02-18  859  	list_for_each_entry_safe(data, next, &domain->clients, domain_node) {
e11723000f1641 Marek Szyprowski 2016-11-14  860  		spin_lock(&data->lock);
47a574fffca102 Marek Szyprowski 2016-11-14  861  		data->pgtable = 0;
47a574fffca102 Marek Szyprowski 2016-11-14  862  		data->domain = NULL;
5fa61cbff16224 Marek Szyprowski 2016-02-18  863  		list_del_init(&data->domain_node);
e11723000f1641 Marek Szyprowski 2016-11-14  864  		spin_unlock(&data->lock);
5fa61cbff16224 Marek Szyprowski 2016-02-18  865  	}
e11723000f1641 Marek Szyprowski 2016-11-14  866  	owner->domain = NULL;
5fa61cbff16224 Marek Szyprowski 2016-02-18  867  	spin_unlock_irqrestore(&domain->lock, flags);
5fa61cbff16224 Marek Szyprowski 2016-02-18  868  
9b265536c27116 Marek Szyprowski 2016-11-14  869  	mutex_unlock(&owner->rpm_lock);
5fa61cbff16224 Marek Szyprowski 2016-02-18  870  
b0d4c861a99d00 Marek Szyprowski 2016-11-14  871  	dev_dbg(dev, "%s: Detached IOMMU with pgtable %pa\n", __func__,
b0d4c861a99d00 Marek Szyprowski 2016-11-14  872  		&pagetable);
5fa61cbff16224 Marek Szyprowski 2016-02-18  873  }
5fa61cbff16224 Marek Szyprowski 2016-02-18  874  

:::::: The code at line 673 was first introduced by commit
:::::: 9b265536c271163ec4acc140ca0a40a732971cbf iommu/exynos: Add runtime pm support

:::::: TO: Marek Szyprowski <m.szyprowski@samsung.com>
:::::: CC: Joerg Roedel <jroedel@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--J2SCkAp4GZ/dPZZf
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--J2SCkAp4GZ/dPZZf--
