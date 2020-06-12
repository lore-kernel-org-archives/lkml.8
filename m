Return-Path: <SRS0=ixK5=7Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BD7DC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:48:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E0484207F7
	for <linux-kernel@archiver.kernel.org>; Fri, 12 Jun 2020 06:48:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726519AbgFLGsR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 12 Jun 2020 02:48:17 -0400
Received: from mga11.intel.com ([192.55.52.93]:5377 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726361AbgFLGsQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Jun 2020 02:48:16 -0400
IronPort-SDR: tTxijOFTS3V0op4ZZJHvQ1vspSQCW3uhtvpXoOLpEg24hZgXghNLP1cFem01n5p86eWGSLFKZD
 ihrx4TwuyBbA==
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Jun 2020 23:14:11 -0700
IronPort-SDR: KEVBMbwJyks9yBUY2fAU6N2kwyKPF7SAsWAYXTNe9TpE1Jg7IX1m9/jkNAlQ3vaDTn2cYmkZmd
 CXP9GE97jxog==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,502,1583222400"; 
   d="gz'50?scan'50,208,50";a="350439413"
Received: from lkp-server01.sh.intel.com (HELO b6eec31c25be) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Jun 2020 23:14:09 -0700
Received: from kbuild by b6eec31c25be with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jjcx6-0000ZF-TD; Fri, 12 Jun 2020 06:14:08 +0000
Date:   Fri, 12 Jun 2020 14:14:05 +0800
From:   kernel test robot <lkp@intel.com>
To:     Florian Fainelli <f.fainelli@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Paul Burton <paul.burton@mips.com>
Subject: drivers/firmware/broadcom/bcm47xx_sprom.c:563:6: warning: no
 previous prototype for 'bcm47xx_fill_sprom'
Message-ID: <202006121400.OQPCr0pw%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="C7zPtVaVf+AK4Oqc"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--C7zPtVaVf+AK4Oqc
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

Hi Florian,

First bad commit (maybe != root cause):

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   b791d1bdf9212d944d749a5c7ff6febdba241771
commit: 5699ad0aaf1091824f22492a708478912c38c7d2 firmware: bcm47xx_nvram: Allow COMPILE_TEST
date:   10 months ago
config: i386-randconfig-r011-20200612 (attached as .config)
compiler: gcc-4.9 (Ubuntu 4.9.3-13ubuntu2) 4.9.3
reproduce (this is a W=1 build):
        git checkout 5699ad0aaf1091824f22492a708478912c38c7d2
        # save the attached .config to linux build tree
        make W=1 ARCH=i386 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All warnings (new ones prefixed by >>, old ones prefixed by <<):

>> drivers/firmware/broadcom/bcm47xx_sprom.c:563:6: warning: no previous prototype for 'bcm47xx_fill_sprom' [-Wmissing-prototypes]
void bcm47xx_fill_sprom(struct ssb_sprom *sprom, const char *prefix,
^
>> drivers/firmware/broadcom/bcm47xx_sprom.c:705:5: warning: no previous prototype for 'bcm47xx_sprom_register_fallbacks' [-Wmissing-prototypes]
int bcm47xx_sprom_register_fallbacks(void)
^

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

--C7zPtVaVf+AK4Oqc
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--C7zPtVaVf+AK4Oqc--
