Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6474FC433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:04:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F2342075D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:04:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729020AbgGMGEi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:04:38 -0400
Received: from mga04.intel.com ([192.55.52.120]:34267 "EHLO mga04.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725859AbgGMGEg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:04:36 -0400
IronPort-SDR: wT6xzo4W10IMJrvQ4qcrXnyQh01hZAHzF1UvBfUxdSZLabPCSyIplYG3smzwRtDwQ4YFLQYZZ0
 SjnuBwkEohdg==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="146043453"
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="gz'50?scan'50,208,50";a="146043453"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 12 Jul 2020 22:55:29 -0700
IronPort-SDR: Cm3Oi7gdIr8SxDaQBKVlmAmGwZobT0yDwHMJMNO4sOA66ubmVTTiZFNumTXDx5dYSI7oHRfgaX
 zpOGCbKTjQNg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,346,1589266800"; 
   d="gz'50?scan'50,208,50";a="459169588"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 12 Jul 2020 22:55:26 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jurQz-0000VJ-NE; Mon, 13 Jul 2020 05:55:25 +0000
Date:   Mon, 13 Jul 2020 13:54:39 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: drivers/firmware/broadcom/bcm47xx_sprom.c:563:6: warning: no
 previous prototype for 'bcm47xx_fill_sprom'
Message-ID: <202007131335.PMGZU0AA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Florian,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11ba468877bb23f28956a35e896356252d63c983
commit: 5699ad0aaf1091824f22492a708478912c38c7d2 firmware: bcm47xx_nvram: Allow COMPILE_TEST
date:   11 months ago
config: i386-randconfig-r022-20200713 (attached as .config)
compiler: gcc-9 (Debian 9.3.0-14) 9.3.0
reproduce (this is a W=1 build):
        git checkout 5699ad0aaf1091824f22492a708478912c38c7d2
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>):

>> drivers/firmware/broadcom/bcm47xx_sprom.c:563:6: warning: no previous prototype for 'bcm47xx_fill_sprom' [-Wmissing-prototypes]
     563 | void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
         |      ^~~~~~~~~~~~~~~~~~
>> drivers/firmware/broadcom/bcm47xx_sprom.c:705:5: warning: no previous prototype for 'bcm47xx_sprom_register_fallbacks' [-Wmissing-prototypes]
     705 | int bcm47xx_sprom_register_fallbacks(void)
         |     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

vim +/bcm47xx_fill_sprom +563 drivers/firmware/broadcom/bcm47xx_sprom.c

5d24ceab4eaf0d arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  562  
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03 @563  void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  564  			bool fallback)
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  565  {
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  566  	bcm47xx_fill_sprom_ethernet(sprom, prefix, fallback);
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  567  	bcm47xx_fill_board_data(sprom, prefix, fallback);
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  568  
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  569  	nvram_read_u8(prefix, NULL, "sromrev", &sprom->revision, 0, fallback);
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  570  
590605c6bc31d5 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-06-21  571  	/* Entries requiring custom functions */
590605c6bc31d5 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-06-21  572  	nvram_read_alpha2(prefix, "ccode", sprom->alpha2, fallback);
590605c6bc31d5 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-06-21  573  	if (sprom->revision >= 3)
590605c6bc31d5 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-06-21  574  		nvram_read_leddc(prefix, "leddc", &sprom->leddc_on_time,
590605c6bc31d5 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-06-21  575  				 &sprom->leddc_off_time, fallback);
590605c6bc31d5 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-06-21  576  
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  577  	switch (sprom->revision) {
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  578  	case 4:
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  579  	case 5:
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  580  		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  581  		bcm47xx_fill_sprom_path_r45(sprom, prefix, fallback);
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  582  		break;
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  583  	case 8:
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  584  	case 9:
b8ebbaff037981 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-10-03  585  		bcm47xx_fill_sprom_path_r4589(sprom, prefix, fallback);
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  586  		break;
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  587  	}
d55a52ccf8f80c arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-04-02  588  
d55a52ccf8f80c arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-04-02  589  	bcm47xx_sprom_fill_auto(sprom, prefix, fallback);
019eee2e34e2d1 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-02-28  590  }
a9bba182a1f3f3 arch/mips/bcm47xx/sprom.c                 Hauke Mehrtens  2012-04-29  591  
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  592  #if IS_BUILTIN(CONFIG_SSB) && IS_ENABLED(CONFIG_SSB_SPROM)
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  593  static int bcm47xx_get_sprom_ssb(struct ssb_bus *bus, struct ssb_sprom *out)
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  594  {
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  595  	char prefix[10];
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  596  
daa7ce02513d21 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-10-25  597  	switch (bus->bustype) {
daa7ce02513d21 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-10-25  598  	case SSB_BUSTYPE_SSB:
daa7ce02513d21 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-10-25  599  		bcm47xx_fill_sprom(out, NULL, false);
daa7ce02513d21 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-10-25  600  		return 0;
daa7ce02513d21 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-10-25  601  	case SSB_BUSTYPE_PCI:
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  602  		memset(out, 0, sizeof(struct ssb_sprom));
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  603  		snprintf(prefix, sizeof(prefix), "pci/%u/%u/",
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  604  			 bus->host_pci->bus->number + 1,
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  605  			 PCI_SLOT(bus->host_pci->devfn));
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  606  		bcm47xx_fill_sprom(out, prefix, false);
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  607  		return 0;
daa7ce02513d21 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-10-25  608  	default:
d548ca6b0784a9 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-12-10  609  		pr_warn("Unable to fill SPROM for given bustype.\n");
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  610  		return -EINVAL;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  611  	}
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  612  }
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  613  #endif
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  614  
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  615  #if IS_BUILTIN(CONFIG_BCMA)
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  616  /*
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  617   * Having many NVRAM entries for PCI devices led to repeating prefixes like
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  618   * pci/1/1/ all the time and wasting flash space. So at some point Broadcom
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  619   * decided to introduce prefixes like 0: 1: 2: etc.
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  620   * If we find e.g. devpath0=pci/2/1 or devpath0=pci/2/1/ we should use 0:
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  621   * instead of pci/2/1/.
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  622   */
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  623  static void bcm47xx_sprom_apply_prefix_alias(char *prefix, size_t prefix_size)
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  624  {
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  625  	size_t prefix_len = strlen(prefix);
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  626  	size_t short_len = prefix_len - 1;
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  627  	char nvram_var[10];
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  628  	char buf[20];
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  629  	int i;
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  630  
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  631  	/* Passed prefix has to end with a slash */
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  632  	if (prefix_len <= 0 || prefix[prefix_len - 1] != '/')
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  633  		return;
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  634  
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  635  	for (i = 0; i < 3; i++) {
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  636  		if (snprintf(nvram_var, sizeof(nvram_var), "devpath%d", i) <= 0)
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  637  			continue;
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  638  		if (bcm47xx_nvram_getenv(nvram_var, buf, sizeof(buf)) < 0)
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  639  			continue;
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  640  		if (!strcmp(buf, prefix) ||
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  641  		    (short_len && strlen(buf) == short_len && !strncmp(buf, prefix, short_len))) {
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  642  			snprintf(prefix, prefix_size, "%d:", i);
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  643  			return;
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  644  		}
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  645  	}
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  646  }
9a6a2b96dfd8b0 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-03-14  647  
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  648  static int bcm47xx_get_sprom_bcma(struct bcma_bus *bus, struct ssb_sprom *out)
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  649  {
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  650  	struct bcma_boardinfo *binfo = &bus->boardinfo;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  651  	struct bcma_device *core;
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  652  	char buf[10];
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  653  	char *prefix;
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  654  	bool fallback = false;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  655  
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  656  	switch (bus->hosttype) {
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  657  	case BCMA_HOSTTYPE_PCI:
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  658  		memset(out, 0, sizeof(struct ssb_sprom));
3d1f664ab94038 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2016-01-01  659  		/* On BCM47XX all PCI buses share the same domain */
97f2645f358b41 drivers/firmware/broadcom/bcm47xx_sprom.c Masahiro Yamada 2016-08-03  660  		if (IS_ENABLED(CONFIG_BCM47XX))
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  661  			snprintf(buf, sizeof(buf), "pci/%u/%u/",
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  662  				 bus->host_pci->bus->number + 1,
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  663  				 PCI_SLOT(bus->host_pci->devfn));
3d1f664ab94038 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2016-01-01  664  		else
3d1f664ab94038 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2016-01-01  665  			snprintf(buf, sizeof(buf), "pci/%u/%u/",
3d1f664ab94038 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2016-01-01  666  				 pci_domain_nr(bus->host_pci->bus) + 1,
3d1f664ab94038 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2016-01-01  667  				 bus->host_pci->bus->number);
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  668  		bcm47xx_sprom_apply_prefix_alias(buf, sizeof(buf));
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  669  		prefix = buf;
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  670  		break;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  671  	case BCMA_HOSTTYPE_SOC:
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  672  		memset(out, 0, sizeof(struct ssb_sprom));
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  673  		core = bcma_find_core(bus, BCMA_CORE_80211);
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  674  		if (core) {
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  675  			snprintf(buf, sizeof(buf), "sb/%u/",
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  676  				 core->core_index);
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  677  			prefix = buf;
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  678  			fallback = true;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  679  		} else {
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  680  			prefix = NULL;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  681  		}
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  682  		break;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  683  	default:
d548ca6b0784a9 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-12-10  684  		pr_warn("Unable to fill SPROM for given bustype.\n");
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  685  		return -EINVAL;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  686  	}
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  687  
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  688  	nvram_read_u16(prefix, NULL, "boardvendor", &binfo->vendor, 0, true);
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  689  	if (!binfo->vendor)
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  690  		binfo->vendor = SSB_BOARDVENDOR_BCM;
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  691  	nvram_read_u16(prefix, NULL, "boardtype", &binfo->type, 0, true);
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  692  
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  693  	bcm47xx_fill_sprom(out, prefix, fallback);
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  694  
2623899459da55 arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2015-05-12  695  	return 0;
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  696  }
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  697  #endif
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  698  
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  699  static unsigned int bcm47xx_sprom_registered;
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  700  
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  701  /*
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  702   * On bcm47xx we need to register SPROM fallback handler very early, so we can't
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  703   * use anything like platform device / driver for this.
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  704   */
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25 @705  int bcm47xx_sprom_register_fallbacks(void)
a59da8fb3b2a1f arch/mips/bcm47xx/sprom.c                 Rafał Miłecki   2014-10-28  706  {
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  707  	if (bcm47xx_sprom_registered)
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  708  		return 0;
2ab71a02c56f82 drivers/firmware/broadcom/bcm47xx_sprom.c Rafał Miłecki   2016-01-25  709  

:::::: The code at line 563 was first introduced by commit
:::::: b8ebbaff03798180c4d9661105670e03276afe83 MIPS: BCM47xx: sprom: read values without prefix as fallback

:::::: TO: Hauke Mehrtens <hauke@hauke-m.de>
:::::: CC: John Crispin <blogic@openwrt.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
9TjYxbz7F68o1a2CCgIA

--HcAYCG3uE/tztfnV--
