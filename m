Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76AEC433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:18:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9B0BD20700
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 01:18:42 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728134AbgGZBSl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jul 2020 21:18:41 -0400
Received: from mga12.intel.com ([192.55.52.136]:40355 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726870AbgGZBSl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jul 2020 21:18:41 -0400
IronPort-SDR: ikl2zARgnsfxKvUdbiovFNX7lfkm6Wa5780CrNCpoZ3aVQOKE/xFeB1FaWMtRgJVzrd2742Bb0
 JuKzSL0K4n7g==
X-IronPort-AV: E=McAfee;i="6000,8403,9693"; a="130418530"
X-IronPort-AV: E=Sophos;i="5.75,395,1589266800"; 
   d="gz'50?scan'50,208,50";a="130418530"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 25 Jul 2020 17:28:38 -0700
IronPort-SDR: YEgLYLa3j3tT1Ce9d2Bm2+Mzmp+KFZCSA0ngyC9qdIH0aBA0CAKQ09lW/EUrosxIYZF3/jx/w3
 SQum04bTca7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,395,1589266800"; 
   d="gz'50?scan'50,208,50";a="272927313"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 25 Jul 2020 17:28:36 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jzUWp-0001BH-IH; Sun, 26 Jul 2020 00:28:35 +0000
Date:   Sun, 26 Jul 2020 08:28:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: drivers/firmware/broadcom/bcm47xx_sprom.c:563:6: warning: no
 previous prototype for 'bcm47xx_fill_sprom'
Message-ID: <202007260801.MravlRi3%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Florian,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   04300d66f0a06d572d9f2ad6768c38cabde22179
commit: 5699ad0aaf1091824f22492a708478912c38c7d2 firmware: bcm47xx_nvram: Allow COMPILE_TEST
date:   11 months ago
config: i386-randconfig-r003-20200726 (attached as .config)
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

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICJfFHF8AAy5jb25maWcAlFxfd+Qmsn/Pp+gzeUkekvhfnMm9xw8IITVpITSA2t1+0XE8
PROfHduzbXs38+1vFUgtQKidu2fP7pgqCgRF1a+Kor//7vsFeX15erh9ub+7/fLl2+Lz7nG3
v33ZfVx8uv+y+99FLhe1NAuWc/MzMFf3j69//3J//v5y8evP5z+f/LS/O12sdvvH3ZcFfXr8
dP/5FXrfPz1+9/138N/vofHhKwja/8/i893dT78vfsh3f97fPi5+t71PL350/wJeKuuClx2l
HdddSenVt6EJ/ujWTGku66vfT85PTg68FanLA+nEE0FJ3VW8Xo1CoHFJdEe06Epp5IRwTVTd
CbLNWNfWvOaGk4rfsNxjlLU2qqVGKj22cvWhu5bKGylreZUbLljHNoZkFeu0VGakm6ViJO94
XUj4n84QjZ3tapV29b8snncvr1/HNcmUXLG6k3WnReMNDbPsWL3uiCrhawU3V+dn42xFw2Fs
wzSODTvh2pcwNlO2eXH/vHh8esHRhl6VpKQaFvTdu+CTOk0q4zUuyZp1K6ZqVnXlDfcm5lMy
oJylSdWNIGnK5mauh5wjXPgf6c3K/8iYbud2jAFneIy+uUmsYTDXqcSLRJecFaStTLeU2tRE
sKt3Pzw+Pe5+fDf219ekSfTUW73mjXdY+gb8f2oqfwaN1HzTiQ8ta1lCElVS604wIdW2I8YQ
uhyltppVPBv/Ji0YhGgriKJLR8CxSVVF7GOr1XU4OIvn1z+fvz2/7B5GXS9ZzRSn9lw1SmbM
swMeSS/ldZpCl74qYksuBeF12Ka5SDF1S84Ufsg2LVwQo2AR4TPgoIAhSHMppplaEwOHqBMy
Z+FIhVSU5b0Z4HXp7V1DlGbI5O+bLzlnWVsWOtTJ3ePHxdOnaEFHGynpSssWxgQbZ+gyl96I
ds98lpwYcoSMJseziB5lDeYSOrOuItp0dEurxM5Zq7ieqMdAtvLYmtVGHyWiQSQ5JdocZxOw
oST/o03yCam7tsEpDxpp7h92++eUUhpOV2B+GWidJ6qW3fIGDa2QdWBib7oGxpA5p4lz5nrx
3K7PoY9tTZqaJS+XqFF28VR66ycz9069Ykw0BgaoU6d+IK9l1daGqG1gMXpiVR3pSSV0HJaQ
Nu0v5vb5X4sXmNHiFmb3/HL78ry4vbt7en18uX/8HC0qdOgItTLcUTgMjupu9WUkJ2aR6RzN
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

--KsGdsel6WgEHnImy--
