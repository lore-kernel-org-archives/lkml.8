Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA5F3C433E7
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9E6132071B
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 06:45:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgGNGpU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 02:45:20 -0400
Received: from mga09.intel.com ([134.134.136.24]:59288 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725905AbgGNGpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 02:45:19 -0400
IronPort-SDR: N4m3Yl2ZrtOZ2mUw7CcThkBvIwHtXJ3K7+j1Id0Cy9puvH2TJ5meCoovjcCcqRErHQEsYlq6od
 kjaWXkvTP1/w==
X-IronPort-AV: E=McAfee;i="6000,8403,9681"; a="150258442"
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="gz'50?scan'50,208,50";a="150258442"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 23:44:36 -0700
IronPort-SDR: moDejwCGfuCrqsuwzbdBEIUd+/AS9QxajbXg5BnuZxKbPHSjgzuhTR/q6S5gRbPjU7/K5fcLbX
 m0DbqLbZKRIw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,350,1589266800"; 
   d="gz'50?scan'50,208,50";a="459577385"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by orsmga005.jf.intel.com with ESMTP; 13 Jul 2020 23:44:33 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jvEg5-00018K-A6; Tue, 14 Jul 2020 06:44:33 +0000
Date:   Tue, 14 Jul 2020 14:43:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202007141432.WDURBXiz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="HcAYCG3uE/tztfnV"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--HcAYCG3uE/tztfnV
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0dc589da873b58b70f4caf4b070fb0cf70fdd1dc
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: arc-randconfig-s032-20200714 (attached as .config)
compiler: arc-elf-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-41-g14e84ffc-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] value @@     got restricted __le32 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     expected unsigned int [usertype] value
   drivers/isdn/hardware/mISDN/hfcmulti.c:452:22: sparse:     got restricted __le32 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] value @@     got restricted __le16 [usertype] @@
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     expected unsigned short [usertype] value
   drivers/isdn/hardware/mISDN/hfcmulti.c:457:22: sparse:     got restricted __le16 [usertype]
   drivers/isdn/hardware/mISDN/hfcmulti.c:472:17: sparse: sparse: cast from restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:478:17: sparse: sparse: cast from restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:496:32: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:501:32: sparse: sparse: cast to restricted __le16
   drivers/isdn/hardware/mISDN/hfcmulti.c:518:25: sparse: sparse: cast to restricted __le32
   drivers/isdn/hardware/mISDN/hfcmulti.c:524:25: sparse: sparse: cast to restricted __le16
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem *addr @@     got void * @@
>> drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     expected void const [noderef] __iomem *addr
   drivers/isdn/hardware/mISDN/hfcmulti.c:1092:26: sparse:     got void *
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:490:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:477:15: sparse: sparse: cast to restricted __le16
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]
   include/asm-generic/io.h:521:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] w @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:521:22: sparse:     expected unsigned int [usertype] w
   include/asm-generic/io.h:521:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:511:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short [usertype] s @@     got restricted __le16 [usertype] @@
   include/asm-generic/io.h:511:22: sparse:     expected unsigned short [usertype] s
   include/asm-generic/io.h:511:22: sparse:     got restricted __le16 [usertype]

vim +1092 drivers/isdn/hardware/mISDN/hfcmulti.c

af69fb3a8ffa37 Karsten Keil 2008-07-27  1034  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1035  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1036  /*
af69fb3a8ffa37 Karsten Keil 2008-07-27  1037   * free hardware resources used by driver
af69fb3a8ffa37 Karsten Keil 2008-07-27  1038   */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1039  static void
af69fb3a8ffa37 Karsten Keil 2008-07-27  1040  release_io_hfcmulti(struct hfc_multi *hc)
af69fb3a8ffa37 Karsten Keil 2008-07-27  1041  {
c31655fcf2c61f Hannes Eder  2008-12-12  1042  	void __iomem *plx_acc_32;
c31655fcf2c61f Hannes Eder  2008-12-12  1043  	u_int	pv;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1044  	u_long	plx_flags;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1045  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1046  	if (debug & DEBUG_HFCMULTI_INIT)
af69fb3a8ffa37 Karsten Keil 2008-07-27  1047  		printk(KERN_DEBUG "%s: entered\n", __func__);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1048  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1049  	/* soft reset also masks all interrupts */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1050  	hc->hw.r_cirm |= V_SRES;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1051  	HFC_outb(hc, R_CIRM, hc->hw.r_cirm);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1052  	udelay(1000);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1053  	hc->hw.r_cirm &= ~V_SRES;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1054  	HFC_outb(hc, R_CIRM, hc->hw.r_cirm);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1055  	udelay(1000); /* instead of 'wait' that may cause locking */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1056  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1057  	/* release Speech Design card, if PLX was initialized */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1058  	if (test_bit(HFC_CHIP_PLXSD, &hc->chip) && hc->plx_membase) {
af69fb3a8ffa37 Karsten Keil 2008-07-27  1059  		if (debug & DEBUG_HFCMULTI_PLXSD)
af69fb3a8ffa37 Karsten Keil 2008-07-27  1060  			printk(KERN_DEBUG "%s: release PLXSD card %d\n",
af69fb3a8ffa37 Karsten Keil 2008-07-27  1061  			       __func__, hc->id + 1);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1062  		spin_lock_irqsave(&plx_lock, plx_flags);
c31655fcf2c61f Hannes Eder  2008-12-12  1063  		plx_acc_32 = hc->plx_membase + PLX_GPIOC;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1064  		writel(PLX_GPIOC_INIT, plx_acc_32);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1065  		pv = readl(plx_acc_32);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1066  		/* Termination off */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1067  		pv &= ~PLX_TERM_ON;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1068  		/* Disconnect the PCM */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1069  		pv |= PLX_SLAVE_EN_N;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1070  		pv &= ~PLX_MASTER_EN;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1071  		pv &= ~PLX_SYNC_O_EN;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1072  		/* Put the DSP in Reset */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1073  		pv &= ~PLX_DSP_RES_N;
af69fb3a8ffa37 Karsten Keil 2008-07-27  1074  		writel(pv, plx_acc_32);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1075  		if (debug & DEBUG_HFCMULTI_INIT)
eac74af9b547e2 Karsten Keil 2009-05-22  1076  			printk(KERN_DEBUG "%s: PCM off: PLX_GPIO=%x\n",
af69fb3a8ffa37 Karsten Keil 2008-07-27  1077  			       __func__, pv);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1078  		spin_unlock_irqrestore(&plx_lock, plx_flags);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1079  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  1080  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1081  	/* disable memory mapped ports / io ports */
af69fb3a8ffa37 Karsten Keil 2008-07-27  1082  	test_and_clear_bit(HFC_CHIP_PLXSD, &hc->chip); /* prevent resync */
db9bb63a1b5b65 Karsten Keil 2009-05-22  1083  	if (hc->pci_dev)
af69fb3a8ffa37 Karsten Keil 2008-07-27  1084  		pci_write_config_word(hc->pci_dev, PCI_COMMAND, 0);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1085  	if (hc->pci_membase)
c31655fcf2c61f Hannes Eder  2008-12-12  1086  		iounmap(hc->pci_membase);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1087  	if (hc->plx_membase)
c31655fcf2c61f Hannes Eder  2008-12-12  1088  		iounmap(hc->plx_membase);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1089  	if (hc->pci_iobase)
af69fb3a8ffa37 Karsten Keil 2008-07-27  1090  		release_region(hc->pci_iobase, 8);
db9bb63a1b5b65 Karsten Keil 2009-05-22  1091  	if (hc->xhfc_membase)
db9bb63a1b5b65 Karsten Keil 2009-05-22 @1092  		iounmap((void *)hc->xhfc_membase);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1093  
af69fb3a8ffa37 Karsten Keil 2008-07-27  1094  	if (hc->pci_dev) {
af69fb3a8ffa37 Karsten Keil 2008-07-27  1095  		pci_disable_device(hc->pci_dev);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1096  		pci_set_drvdata(hc->pci_dev, NULL);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1097  	}
af69fb3a8ffa37 Karsten Keil 2008-07-27  1098  	if (debug & DEBUG_HFCMULTI_INIT)
af69fb3a8ffa37 Karsten Keil 2008-07-27  1099  		printk(KERN_DEBUG "%s: done\n", __func__);
af69fb3a8ffa37 Karsten Keil 2008-07-27  1100  }
af69fb3a8ffa37 Karsten Keil 2008-07-27  1101  

:::::: The code at line 1092 was first introduced by commit
:::::: db9bb63a1b5b65df41d112a8c21adbbfc6a4ac08 mISDN: Add XHFC support for embedded Speech-Design board to hfcmulti

:::::: TO: Karsten Keil <keil@b1-systems.de>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--HcAYCG3uE/tztfnV
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICAlQDV8AAy5jb25maWcAjDzLdts2sPt+hU66aRdJ/UjU5N7jBQiCEq5IggZASfaGR7GV
VKe2lSPJbfP3dwZ8ASCopIvGnBkMBsBgXgD06y+/Tsjraf+8Oe0eNk9P3ydfty/bw+a0fZx8
2T1t/3cSi0ku9ITFXL8D4nT38vrfH5vDw+TDu4/vLt4eHi4ni+3hZfs0ofuXL7uvr9B4t3/5
5ddfqMgTPqsorZZMKi7ySrO1vnkDjd9un768/frwMPltRunvk0/vrt9dvLEacFUB4uZ7C5r1
TG4+XVxfXLSINO7gV9fvL8x/HZ+U5LMOfWGxnxNVEZVVM6FF34mF4HnKc2ahRK60LKkWUvVQ
Lm+rlZCLHhKVPI01z1ilSZSySgmpAQuT8etkZib2aXLcnl6/9dMTSbFgeQWzo7LC4p1zXbF8
WREJo+QZ1zfXV8ClEygrOHSgmdKT3XHysj8h425aBCVpO/I3b0LgipT24I3klSKptujnZMmq
BZM5S6vZPbfEszHpfUYA08lmNQiI5jZqgDFLSJlqM2qr/xY8F0rnJGM3b3572b9sf3/Td6ZW
xOmlR9ypJS9oQIJCKL6ustuSldYS21BsTHVqD2pFNJ1XBhtgSaVQqspYJuRdRbQmdG43LhVL
eRRoR0rYVq2CgDpNjq+fj9+Pp+1zryAzljPJqdE2NRcra1dYGDq3lwchscgIz12Y4pm9hnkM
KlTTIdoW2eYds6icJcqd5u3L42T/xRPal4yCxi3YkuVataPUu+ft4RgaqOZ0AfuAwSC1JeV9
VQAvEXNqy5cLxHAYQGBaDdJiwWfzSjJV4c40G7gTfyBN30MhGcsKDcxyFtSwlmAp0jLXRN6F
dK2msdSsaUQFtBmAcbs280SL8g+9Of49OYGIkw2IezxtTsfJ5uFh//py2r189WYOGlSEGr48
n9lzFakYOhCUgY4CRchgaKIWShOt7HYIhMVPyd2gmUuzHuFaKG7zg89uS8dcoYWMg0r1E2M3
cyRpOVEBRYLJrAA3nPUa2AkEnxVbg3qFhFcOB8PTA+GcGR6NugdQA1AZsxBcS0I9BDKGJUlT
NPaZyF1MzhiYazajUcqVtlXanZRu9y/qPyx7sOgmR1AbPGckZrafSwX6hwSsD0/0zdVFP6s8
1wtwGgnzaC6vfUug6BwENvag1XD18Nf28fVpe5h82W5Or4ft0YCbYQSwnbWdSVEWloAFmbF6
RzHZQ8Ec05n3WS3gH8vrpYuGm+XrzXe1klyziNDFAGOG0kMTwmXlYno3nagqAjO74rGeB/eP
1HbbIEnTbcFjdQ4v44ycwyegwfdMniOJ2ZLTsLFrKGBnjuz1hiAqEmcCWsbgQUJ7TNBFR0O0
FRGgu1cFbAprmUutqtyxUODgARIUGHyuHMPBVHqotlemvR5gVeiiEKDo6EEg/gtPT63eGFKZ
wYxFJKAOMQNjRIkeWWyJ5jYgGWoqLI+JkKSlfeabZMBYiVJSZkVPMvaCNgBEALhyIG4gBoD1
vYcX3vd7x7cIgc4M/w4pBa0EeLWM37MqERI9OfyTkZwyZ5LHySpxHdZHr4mCP0IK1gZyrbhG
PZuP2vRbFgIcE0e96UFqxnSGLg4ZgS22pa7Xs0EE+k7qAMsPMbsgxLGidiTuOG+WJjC/I2oX
EQXDL8Pdl5BuWWYKP0HzvRi+BtOsWNO5ZSxZIVJr2hSf5SRNLL0zo7ABJsqzAWpem9pOWMJF
QEwuqlJ6AQuJl1yxdmpDGxVYR0RKbq/VAmnvMjWEVMQeTAc1s4cbTvMlc3QktNyoGCZ2SeKA
QCAPi2PbL5jpRU2uugC4N0D08uK9zcV4viaPLraHL/vD8+blYTth/2xfIPAh4BMphj4QrNbR
YcOnZx8MpH6SY89wmdXsWm8amnuVllFt0a3FRljtYettYccrmKwSDZnuwtk+KQmlRMjJJRNR
2JxCe+hSgutvgsogNyBCz4dRUiVhQ4rMF6LHz4mMIV4JW2Y1L5ME8iUTbIBuQC4N7iBsczTL
jD/D6gNPOFDWkb2VO4iEp6D2oVgcY0HjcpxUxa0fdBmktGI3+JibGgaFBBRiMp4zYxjtMBbj
TEjakpTMwHiVRSFsE4jxGXioIaJ2cCLjGqYLfHNlBLS3X5fzqTLzRILONChHxXKM+S2Dm1nx
LiRtXGCnVUaKAFsCKbQEv1lnJEOC+YpBnmeLDGn4oh5wPxyze0CoCTk8/LU7bR8wtByUrjqq
4mlzwq3zh9rTP6L95vDYpxmArwoYWaWjy4u1M+QaTtbKReD3pWPoWlJ2nxfhLTwiRWc+FUEu
uMOodkKjGrG8GpgZ5Ahx3Fi9DmXCXPLPDxexL6uB/3kR9siAi9AS5jEneXgLZeHIyLBGlR3F
olJzSrOzBPE5AtC1ankZqsG0yCtvCXGf4+6pPi5cTDPbpjaSgrlMlYtPYCYUWv8mYvRaEzCv
4IGoP7k4BCxnsVE9GK5at295Xq7x/wvj1W4u/vt44VZDawrYugOCTgisk8A2HZmjxZLEcR1o
3Vx9mDpDKqWESBTGO/MHxSCoqkoIHiCCYCHHOb+/ueylNIvBNFkRyao5jsdnGEchm4kYLGFq
kCLWUVVXC9+403dmy3dRkoAYGgzQuroXORPgDuTN5WUXqlmGrcg6H9hb9QxDFwxb49GUB2ho
6oxqdQvGdAXZCkvAVXD0vgGH5tSQN9ZI3j5uv8EgwatP9t9wMMd+L5sYRNTOxom4FwCLWMi7
myYctBasMLopuxRnir51Sx8qmQ4ijP03RnguxGJotcEkmCpepeeSkdhzHNdXETgckSSVJUZT
pzfmHQVkWJY3ZTqv70zENRtVMIpu2PI8Ii5TpjCoMxE2RoHW2s7q8n2zua8crlQUd420lba3
Pk1BhApLBqC9sY2o4596MBg4WygwFeD4+pVPEqfwAumxFY91RdQZFcu3nzfH7ePk7zrE+3bY
f9k9OVVBJGrK7U4cca6tH2z8QNG6vBCcNiYS9vKb6FplGEVfutOO6URlEjw9WBFbSRvqek+m
goTjsoaqzM9RNIce4XJAKxV4y/ZsJJhR9dIHpFSt9Tjb0M1ELLiak8sRroC6unp/VvKG6sP0
J6iuP/4Mrw+XV+cHAltwfvPm+Nfm8s2AByo8+L6zs40R9KrKuFIQBfflnopnGKmN1HRy2K8x
BNhZJNIwiZY8a+kWmOWNjkLVNd0UzJJd/ouaEmX3uajAzZt439u7iFJUcTAetyVT2sVgsSZS
syAQItkhHMPpmeT67gyq0pcXTvWlIUBnFdb9lgIMltB6JOMwZdAsNvlCQWRdAXFYrKJQdtWX
T8FjQBjLcupJ32GpGE4QOMgqUX5XuHKiIOnocOrDWYgzqbwzRyYDN1lsDqcdWqiJ/v5ta/lD
GJzm2uzwxk874QUVMu9pQmEGX/d4u6lQSbhhzzzjM3KeuSaSO+xbfSU03GumYqF+0G8aZz+g
UDP+AwoIRaQ98lDSW+Yh0RcErHwIwZLgUPHUdvoxhLH005qIxl35C27rWQbhFeWu7gFsyYGP
cMEmvqvPYkV/AOFUXKAlF3UyHEMEgCKFLExPtbiL3O3UIqLkNnyi6nTdKYfKL61KeN5sAlVA
wIuurz9WYf9tH15Pm89PW3ODY2IqPydrE0Q8TzKNYY+1HGlCnUylIVJU8sLJKxsEGO7Q2Toy
iUtzkaEb0JhARtps+7w/fJ9km5fN1+1zMIhtqgdWKRMz5lzEDCtObrVAFSnEWIU2kRMEV+rm
vROF0UEhBrM8ydDnhG0jbFs5KN8sVChLas82MwydM45GJpY37y8+dcmSObUrINTHuG/hVKJo
ysAgjSbBdORw574QIhSr3EelFUzfmzhMOClnC+uiXZC68OZgSIyHxKEqbtxWxjDWX9T13Ha5
TL1oacJ0Z+qZxGkwx84BljM8TQIjP8+IdBPwusZVaFYH9sQJb8cVql8EyxPhiQ9Ii9FKu4Hy
7enf/eFviIeHuggatLCb199VzMnM2Z1r9wv2UeZBmiZ94DIS0KwTmZnacxCL4i/YXbhlXJgD
NhacXl5Pg3WUVp9/UKLCJ/1A0CW34NQ1C9U+gajI7Yso5ruK57TwOkMwHh6FK0INgSQyjDfL
VvBzSFhT2JFZuR4554MudJm3yVHnf3IwFGLBWXg16oZLzUexiSjP4fpuwx3gslQkfFZscBAm
jyN5gVZuZLX74dpAV3VrOloM1NMgyrhGjAsgyeoHFIiFdVFairDaYu/w56zTtlCJvKWhZWSn
9a0FbvE3bx5eP+8e3rjcs/iDCh5XwspOXTVdThtdxyskyYiqAlF9Fqlg+1TxSBaKo5+eW9rp
2bWdBhbXlSHjRTj/M1iehh2IQXoKbaMU14MpAVg1laGFMeg8huDAOGh9V7BB61oNz4wDzVCR
NncoR7aJITRLM45XbDat0tWP+jNk4GXoOIks0vOMYIFSEo0gswK0bqwZXiAFESh6uRFLVegC
L7NCppzc2bPZti7mdyY1BU+a+R68J014qt1ItAMGt1od9e4PW3SIELidtoexI4OeUe9KByic
IqznPo+i8BKRhcZz7zw38YQDxatGzZWoZ2swNQJYQbobmgGLnbny5GaeDtosZfB+iE2V6CIs
bcUl9UTrcSBgBCnAyP0Tm1Jxj7+25jCwiO0sztKSVcE7OsAkJ9phCt+DgSCsHoIL8wVCWEbU
bckkiZk3m8PNOxB4XdPcPNe6tjY5wnHysH/+vHvZPk6e95gEHUN6tsae5cJvetocvm5PYy0g
v57BdnK1zCaoJycwtX3jHO+DhDxskDip+zrLERImLll4vQLk1oSHB9HQgcnJ1GBuIfGC3HJ8
SvGSM2YtxnCH+ddEoa05pMLYnpkJaG92nrMnTvin2GgYulQDO8WL//kJM5VggCCJMervvR1a
R8oGEzbVoNJgNtZ3Z0liLHZ5eNdAQUQ7sGaNOD1Qsv9jVHtwGDmgIB1vd40Db8y7B+10DPn5
SE/dnRa9moWjfKDMSD5L2ZADxIDhwsaZNWoW8Z/puWUML1c45nGWa5SkWa5peLn6VZiGlmxq
z+d0bG2m9VThbsA29eXaAcFw9aZnl286tgDT8ytwboKD22Q66sgiyePZyLW0oh7P2AaO6Ug8
hPuejqSEcuT6qw6/8iDavXym8dw1+CIFUSnJmU+eFSIcMiMyklfTkYOU9EqHulHavtWCZqAv
8EonOx7ObIMw548miVLEC+QQFGixhIFVHy+uLm/73npYNVvaYliIzEHEjHrVghoyXgdIU6fW
BJ+h4ySiSbqwu1lWpIDI3wXzIo696gEAsP4fdMTrqw9O16QIXTMr5sIb0jQVq2Lk4gpnjOHE
fAgadqa7m9/GSt2+bl+3u5evfzR13PpU1lkthS40uh3nVs115ETRNTBRdAj1VL0FF9K9cDkg
MInWORmkfZ+xBaokCvWm/HK2h9fsdjR1qgmi5IwoNFJDUSDgGAI1wYEP4bPgaGLllhdbOPxr
l5w7culnUPVM3vqT7c/OIgpLRediwUIsb38wnxTS61Dht8UntzVJoEuyYENochtQt3lgfgse
lBf6A8wZgYrUvSzTL+J4qc1M+chdGPq0OR53X3YPw2QULL2nLQDACwmcDsGa8jw2N6WdrhFl
zNvYlkeCZDXkV15bF8kagLmoO4QOVc/0qpZFGDoNCQk5xuqMiN3zlkFD8NLnhpbinaRQOxPM
eDckHCJmKEbRyIOM5Tu1LvFEON6Ghkx4nCu8YSfwRasdpURgD4k54Q2KIAqWL9WKeyK2PrCp
mFtesYF4ldIOnApRuO+E6qPFECsXMXjY1WbwfvE1K0aqxfV7ldA45mpoqMyYveqIQ5FeY9yP
GVy4hnIrtcMVvyuVheudBqnLsEM1glMVLqM3lwZM6StsVi2KujDmWXa5rqJS3VXuK4bo1qn1
m3v+WjKSNZceBiamOQmanLbHU8CJFws9Y+Pji6UoKlhf7l0T78LxAXsPYZ9A9aznJIO0bMS1
UxI6nI/cE1y8is/iUNgGKPeeoAGMBN6Ay1SCb/rH0MGHwz1asTTxH7CbOY6eXren/f701+Rx
+8/uYTt5POz+8Q7iof2c8kirsamoCUoSfNxZI5dzyr3RZnI5cvMEcHpxrjdA+711Kzo6Iiur
gLxtLYtwFRqQCxo6c15xyVKn4tpCKvyxhR4KX5V7xG9A7uNPA1LF3YCIL52z6mSG0XDoNnXK
I4PqObSQylzXAYbFKI7SbBypFzyEbC/h1rrRCvay3T4eJ6f95PMWlgBrX49472CSEWoI+nCh
hWCtylxqM7d/zS3ni35KAWbPMJLU95fMFdGbj1aamix48PYgmoRPnmP/VPT3UBzb8Wn8zSQl
3A4l4Gt4EdlAh6VwF1+q8MMayop5Ff69gjyxA6iEgqeacU1SF5i7u6oBVcPNYRHATgyY381h
kuy2T/hU6fn59aWJ9Sa/QYvfm51k1zKBj/MLBwhI3NyxAVX8KlQ0QGyRf7i+dnkYEDbxOSHi
6vzAlDaDH+8vXxfNjA2BTZ82u+tkJfMPQWAnYedGfmr+upRYEQg0vNSAJxagPQIbQtyHlTEM
2lxlsQoeUoBipXZcnhCeiqX9hIjpuRYi7Y45ml0d1yYz7pxA5wnxhZ09df5H6B0fgM11HwgQ
QnUBwBLlXPRvIG0i4vMyOHOBH998BPXAJcPXSD9F3L+CHSWsCh1+8oKDz1ToVBcxtyWXC+9F
Ih9/soATqcvInVpiR7YIYJRkPksuwgYIceBVRjoriBPRzYXG5LFZ3T4Q6sEVLWg4lrSJ1Nz1
rvVdUWj4sH85HfZP+GMDj76SYcNEw/8vLy7c8eKv0gxC+A4x+E0Is1xrfPS37hX7uPv6stoc
tkYMcziiXr992x9O9k8hnCOrL9HtP4PUuydEb0fZnKGqnefmcYsvRA26nxL8dZSelz0YSmKG
T7TNCzYcdDD0+THb7hZneCm6ZWIvj9/2uxdfEHxxZl4jBrt3Gnasjv/uTg9//XDh1arJmjRz
LOt5FrZ0lMiRh/6k4F4w2T/x2T001m4i/BtoZf0eZM7SwjadDhg2kJ47v6O01FlhvyxpIZCf
OL9DA0FQHpPUeUtTyJp3wmVm3mWZ34pqdTjZHZ7/RdV82sNCH6xrmyvzZsMWsgOZq4Ix/mCI
ZfzXWpKuE0v6vpX5TQd/5EE0OJc0dbPynq59nmCvqD+MLtYj5jnW0r3Z2kbl5g2DjQ0udR0p
xhBEB2vlDZotpfv8pYZjgtS0rSTLxIjXMGRE3eW0JTbPsQLdSTZzrszW326k0cBWlwNQltlV
zLatvB3AFKWWw4gzgq9KZL3oiVtYQmRiLIl5KBbcxiPbok4XX4/DYBACQbxDBH4UHL1TTJnz
yvP9fZpmcbICYgEhDg0/9p7lyuGO35gJQnIrOQnlAYZCcZk0JIPWZbQeb51p58kCfJqlH56I
91fiv20OR8eyYSMi/zRX6S2bgGD7lr2HEkkICitqfgLkDKq+3oC/jFa/rXl76crvsDBvRc3b
+pEHLcMW+BJP5Old2PwPpsHMTgl/gkM090vMbyHow+bl+FSHx+nm+2C+onQBO1T5c29GNCqn
wVYyVMFKtJM0+V+VXNldcYSF3UgSVx6u3QAqiZ2ERWUjlGZ1RTEYXPfUAnZtXRccaJn8f86e
ZMlxHNdf8enFdMTUK0te0j70gZZom5XaUpRtuS6K7KrsqYzOWqIyO6b77wcgKZmkQHveO9Ri
AFzEBQRBLCx/X5f5++3L4yuchV+ef4wPUrWutsJdHB94yhPFolw4iE1dD3Y6AzWgSldZWpak
8RRSIefZsOK+UxGXusit3MPGV7Fzb2dA+yIiYDEBKxqeafXL+BtyuB2FlzaSwCFMveX26EMj
Mm+nsdwDuFEu1IbfSB4Qka5MohYvH3/8QF2kASpFiqJ6/ASM0p/pEvlu23sTeDyh2p+lc/pY
QOMnS+NgTOrm4rVOkWTcivJpI3BS1ZxePHltdLkdLXyDQXdQBqNNuvhYdDuei0KEatlVolRG
VaFaEm9vqOXTHdGnufZGAyTt2tyyeqn+xuToUGsYbxUl1UdlWAdVjTWrdjN5slhEo+9RUIxP
tBVtcAEbqtBdEklkNlqw1X4Egj8+DKMXNGXDMq2fsz1rDJbXyusYsVG8chk48OJYH5/68vX8
+se78tu7BAcrpGLAkmmZ7CyF0EZbv4G4lf8azcfQ5tf5ZXZuD7zdUgHCt6ekVby54IghgTrC
zFmHq6MpRjdRG1k2FY2IW+TDu9G0KCRPErwb7RmIg27opgAJHD6U/kszr1NnPi9Yy8Z9q9NH
z+O/38OZ/ghXr5cJEk9+1/zrcsV051FVCDdWlgnikzTC1zH46JR6TLhMHduOzi2FyFsR+nw9
RZUtVQ9g3O6oAiLrNLfv4EZURAz2Axs7yObPr5/cwQHhwFdlDJXgX45edcDAsir31GAKeV8W
JiYtMZgDWp/111w9rhVK1S1ueo10s2n6raG+PKuQEf+P/jeGi3w++ao9xkhOqMjcD3wAYay0
ZBSz029XbFdy2HhrEADdKVNxJeS+hOu1x9wUwYZvTCzoeOoOK2K3IKLRtsk9BVqGUw33Pu9O
lfsz3KNpJWnaWNzEPT7hlnAoRBOISw1YdN5Ex3u7go6zOjvTqPty88EBpOeC5cLpwLAUbJhz
KS23rtsf/M5Te8+VaO4Jt64jyrq25Y9GoJGBA0PFtQ5DdVH2sBr1ytRro3bCt84Q45VfHLIM
f1wwSaplN48Q9W1S4qEoqlncOtYqH4FHhxvtDqOIpwhFqwUaqjxXdXjilY9XL3GlKXt5+zTY
tN5QO3j42E06blG2qzHQOXQsoOlWtKRwI5FADSU+0ifpMfVGuAcbbYS8fKqLPnnPGBjTDace
nyouUGPXsXHj+gyd21wPzVDLth1x6OKYc0uJ218NAeoJCMPoHu3YFIpQO1KxxolFrjD7U056
8Svklm2Ar8tRoS39NK1wnoOTg1I2zF7XBlcMexXamG0yav/i2EBbU9gjNpxyY8UQSxfxou3S
yg5tZAFdTVh6yPOzy0uqPSsae5M2Ypv3s3JRyCHwrm2pR3IY3fUslnM3GByc5lkpDzVH7c9R
JHR4pqoTmcW3WJXK9WoaM/tlTcgsXk+nMx8SWy8YcBuUZS27BjCLBYHY7KO7OwKuWlzbce32
ebKcLax7cCqj5cr6LZ0NbavslfLqgtLPI51Mt9x+OTlWrLA5fhLb0fw4h8M4p14pNAY2bUwZ
8RlsxnfMDltiwDlrl6u7xQi+niXtcgSF22W3Wu8rLh3WbLCcR9PpnFy1XueHL9zcRdPRmtLQ
oGHABdsxKQ86nvwl8P7TX4+vE/Ht9e3nn19VDNDXL48/4VLyhqovbH3yApeUyWfYNc8/8L/2
UDaoliC/4P9Rr6WTMosqE3IWeCNn6EnAUAFQZf23iG9vIPSDFAAC18+nF5Wu5NVnlkc4y7Tu
9wKwJbZrlQzTm+wd2wwMewE9SjBIceDFUZHUjWx9in63sA0rWMecewZG1aYV3w4T05d5tJsz
t8jRR6uARHlpnXc1EynmpLBjDiOV+wuV8I6yEGFoHNRtx7pl1QPT9OTt7x9Pk3/A7P7xz8nb
44+nf06S9B2s6V+siCP9YW8fw/taw1zbtJ6SUpYMRXZENW7GDdX9BO/jbBQb1ybJyt2O9phV
aJmgISm+qvQrT31606/sV2/gZSWGoXYb2iYaEe6KUH+PiJzqMT3NeCYVPBMb+IdA6LDqblsI
V6/UkowWoGnqyvqWXp/hff5oOE/KICr8lemeXOXUmrZkLuuzUALbO8GkKgSh+73WNl5e53T8
3U2JMf7qmny+QRoVtc0ZIoRW7sgYb+jL6/W/n9++APbbO7ndTr49vsEdb/KM4ZR/f/z0ZC0L
rIvtbRWfAuXlBvP3ZMooJBNwAE1HRcj7v0Ik/EhpiBXuoazFw+hzBByg0TKmgmHo9vChmuqo
FFlsqcIVaLsdtgN8/Cd/VD79+fr2/etE5SMYj0iVwlbwuQ1W+yAD8ZRVm63XiU2u69DdAAjd
F0VmH2RqboUIDkR6SrwRAEgHN/IRh+xxweQGap6PXm3FcbzUgFsKGUgsYOYgOC5C+hN2PI1a
OGTUSaRQR+HvrqMAoUwOGpPq5tja+9BRrmlInvqQunEvkBrawKxQ3Mhgq9XyrvVqSvJ0OW9H
VSXnUfhBG823rB6V2VfNbEk7ig74O2rVDNg2LrzuKeiMbKqddV6+DptCNKs4mnm1KaA/Ah9A
fqn9kFa47lgNfJhmxIqg4E3CSUNVjRbFB2Z7smioXN3No8WoNdgegT2l0SCJertHwYEVxNM4
PKrIKsrMXz5o/S7PclRbndIXVIWUpLeHRqHWp8ZIGtJrCfbdcjUdAX2yppR7sWE+tBbbjPvz
5Ww3BTmJYlMWw7NEJcp337+9/O1vOW+fqZU/9dXVeuqvTYWeQf+bcILGs2NOn1BV9Ue41Ux/
/du1W/r98eXlt8dPf0zeT16e/vX4iVCsYuHLo4TbqL6NUTpMQnmUu48GOgFLyhs6mgLg0baB
2frcVInH0xEkGkPGRPPF0mt/0LjQzSv7UTtCpqdd0r/H5twGbtQDcnzi+JTaEKjmOyEb6Gkg
rOOgt6NNSI2+JZh8ZHuQVPBN9JWdRLP1fPKP7fPPpxP8+WV8T9mKmqOngv2ZPawr9+TNacDL
jUpiMy5YBIJGXAhKSduJXO31oKBSFvXCSUpU8GZ0T8f9TN8qlDrJJsVe7Q6MDKbEHw5wnH60
jd2KXjVm/W44y8cQvARyzC7JUgzpFiKoy0OR1iCMOkeIR6PSZtDKP4cQwyseVdKsQyBEikWM
xngblvm5gHKWoB862ZqogqhjG8IgpwkYzW1YzQ8pbbS3I534oXeSu+MP/5Nl5vvEGmj/WkGP
huueplzKSpXvrWhq+I/nfolh7cMuHSFPO4B3R7VIVY7KjB6JIyd5llFsO08nRea8ErI6cdD6
dxfFo0wXCjxdRGQHDH4UucJF0x7/PbLM19O//hp1xcBdJ5u+PZF3tBrnUjieTuMp1WyTG1tL
O/8DAv1NjkBaQ25iTzDh1sCLMcBPudODYYLRJLe293iPU+CuabtoefI75OBXlAvxiGp+vZL4
diV135UQdnWliRp78N80EXstwN0X7YdIoEoBIA+u+Y6PF2lzdwdrl14pTa4J4kUcJiDv64AA
CYvDChtFH+nhqn1MEplxSqhxSGEOat7UZ+uFzMHrFTS1cftRw3s+DEnwa4C1lYFkhMofTe+K
kWiQPr++/Xz+7U/UtEptPu/k5LDdPHvfh/+yyHBmNnvMeOCdd0cOJ1jdzRLXLq45V/uSfgi7
FGIpq3rz/34INEgZpaFocaOCHXfFA95EsygUlrQvlLEE7RY8tWYmkpK82DpFG+7eCFkC2yPg
WKq164289RE5++i5ql9QbhT1PF1FUdTxQMbLCvnqjAoHY9cJok/R2HclG1mPcudwL3wjUQgX
RukpCLPQhs0CpxQgAkmKABMa4VtTfajL2rkca0hXbFarKXXyWIW1gOcu682cDky0SXIUhgLu
2kVLD0YSWjqN2JUFnZ0RK6NNBHVyNN9Owi4YCgxx+eDEiza4KSjmapUxplKemEk6uNqFjuKQ
kwsQrliZdOUJA+oaeuEM6EA2yx5NT9wFfQyF7Oh7JmTi9Mvf+EQRFfrcWX/annXgpWSf0oI8
j6yKU5dpKun/QIfgskv5SZ/SLKYt7OGESn3nyHF9mIDKje6y4fHNvvOPvvGahnRFhQFQCuDp
OfpE+dtpXNOuLHe+U61B7Q/sxAWJEqt40bY0Cq2DnZ5FJJPgRjvj0E0D4XJ3tCs4wI+BqMdt
qAggAo3Mg63TDOZDfmNujZLT2dfHPBSiQd4HwtXJ+/ON4yiHVlhROssoz9p5Fwj/AbhFWHEC
WHm6it6GIvr0/RFJ7S6Ce7lazWkGjqhFBNXS2uB7+RGKhl6rvUZLf1vAsNzNZzdOOFVSAlMh
F3R+rl2bW/gdTQNzteUsK240V7DGNHZhPhpE6zDkarYib3h2nRzkJC8LhIwDK+3YkuH73Orq
sihzmjG4lxHgxFDf/43rrGbrqct84/vbM1wcRSqck0C9jaa0csAqWN47PQb68sapYxIn8GIn
CtftcQ+iJqwycmDPHD0ut+KGyF7xQqLOihzch6zcuYrnh4zN2paWVx6yoPwDdba86ELoB9Kc
2e7IAQ1Jckd0e0jYHXDpcEiJhwTtiULByuv85sqoXaewejmd31j6NcdLgnMmr6LZOhDCE1FN
Se+LehUt17cag+XAJDlzNYbNqkmUZDmIA47SXOJB5N9CiJKcP9BVlhnc7uCPaxsQsIKUGFcE
5/PG0pQCOKZTYbKOpzPKStAp5VqUCLl2z3wbFa1vTKjM3eSjvBJJFKoPaNdRFBDmETm/xTpl
maAPYUvfyWWjTgfn85ocU17dnrpD4TKOqjrnPJA5DJcHp5XYCUYQC2g7CnG40YlzUVbecyRa
BbTZ7uadtOH7g/vwpiE3SrklMPgFiBOYBEAGLG+ajAwLZtV5dNk+/OzqvZfbysGC3AXT2lAv
dVa1J/GxcKOsakh3WoQW3EAwu3X1HWJpDGWN+ShrRZhFGposg7GmJ2ibps4Ip3wbOBzk/ZZm
giAkVdQsomza6Sck+zURbcdtQ0UNSTCRoYA+uo+MiBLNhtHZqkxdXX5oxy0gtPc18mo0SHTv
r/mtmocUHS2vvVb2Ao3dONVrUT3Mp9GaHLCeYDVdUqa6Cg3MJgFRUuSjmtsqIY099mcn06I8
AeTyM+MpPtLvdhgsQSG01bgQE/h5JfQcS0WBJSh1bJ52TiO9IsuDtqvV3Xq5caEw43cghxig
rbZZ3Wkw0SIuE/Vy5H1srxgialvMIzQd2NP5d7C5+WoVBdpLRMJS5tdqlAjBSlMGa153hqgz
rVACj93RQGCTrKJoDIb+EcDlnd8rDV4HWt2KlnuzJZIqgyXuwpQ3bntiZxeeSdSQRNMoSjxE
2/gdMRfVQEd6LFx63Jr0NW8MK7UXHA1uIgKDlx+/U4VKa8dCvcIQZM0HBmd/6y3eZjWdebAH
q4Fe2NNiow9U4p0HBLlu/EUoXPhdlg2PpqSRGGqxYRuIxKvbGLP5FZlTYAebPa7xb4p9VJZv
CvzoNhI3lAeE0wEzn7rAca4dhOZVRV0LFQoZqtF8XcCljuxtAbhfp7L0oPXsgFVmIE1D70lJ
6+Jkth+snfffX9/evT5/fppgsMDe4hvLPD19NiEVEdNHMmWfH39gYoGRucdJS73DGW9CVJ5S
R25CqsuzSw6rh+ifQ+T6NsHPoDUm4Bb3rq+9W1Nux7WzUZSK3cYrneuNjvZKuwCqlnZIBzRv
tmMk6N+X0EghBNzfazcEmyGoyCeIHunEzKuFhPOB7ulF3UYheSqYd0208TXD5U2LfDaZ5ho3
hrOWItROIHuhTRLI3meTfDynjBIpbBp1svOiGKyQT885aydoOvTy9Po62fz8/vj5t8dvny0f
NO2wpAKSOlvq7Tu08mRqQATxFHqz+qGT9l7bp1ni/kIjizHE9WhU0P4xwYZtaw+guaROMvS/
8eK9yrdgcYrPz68q/KoTWC2eToE1WQuJFa0XpBHEf0+N0B/brDYOGdYTQcAX55i3+NgYUt9g
RB9B2TcqM6tReEoh08L9hQYptj+1S6F+dqmsfFAWlWIYta8Imnx5/PlZxR8j5E1daL/1gxz6
aHWIOGKHwrBjvq1F85EWvBWJrDhPt4ziEppAwP8L71VZY07L5ZrWO2s8DOUHUidlKq6YbU51
dDNZHEFi3GQONzD+Xz/+fAv6QImiOljKBvVThbH2Ydst+nq74ZM1Bu2wHI9tDZYqUPi9E8FG
Y3KGKbINZggx9YLbc/CBcCbVFCsxUz0ZbF0TfCjPRD/4kQRakZD1CIXCmugC9/y8KVntvN73
MDh/qbuxha4WC9uf1MWsVoFKEUepAC8kzf2G7tEDCNsLSifgUNxNA4XjaHm1cGpC79fL1YKs
Iru/D3hyDyR4t77WhgoFhGvLTkUyYJuELefRksas5tGKwOh1R/c3X81imvc5NLPZtS7DmXM3
W6yppl0f8Qu8qqOYfgYfaAp+akhV6UCBaRrwiUwSLV+0vSNMU57YyY3LcEEeipszWMIOpjQQ
l6nI464pD8keIEQH2uDyhaMC71LXm9+QQd4vQ9tgknrbFdpiI9Ypgz+7SjpG0gOwY1lFxk8b
CDbnlKgMnSUF/Gtfiy5IOJNZ1ei4AWEk3Or8cIwDEeG1Q1Cp5GNEuNcRIc9QPCPdPqyOcRTM
neBIl5bULIuGwm3LBOXUZE9+Lf2N45iOHoHOfYWtXiFC/c36jlSSKXxyZhXze4Vj4ccvdzEB
52uPKPBlR9m2LaOTpWkKnzH6QzOsD68bQbpQ8Prh1MRczPR1Q5OoTH2BFJOaACdCJjUPvPGb
nQcyMjFudS7mXqAOBXKjrCIEhtSDbO3ADT1ErZ7Sg8epcaC3p0SXIJMzGFQ8Jp/RyniDpK2S
NHJxFelYzGqVQi/oivflxPehdr9R/cS/TbQHBwyysGZwDjQTG4/tabhnV+7gjAkkURuAci/i
uylSJ4ik1SqaotpcJ9CiQIDkoGiIHu9Yzt3R6CFdIUG0srs6YDKKWwxYnh+i6X1E1LjNV8aI
39xAqbm7RFMgRHIt8MLd5vETqoVGsViaxjmpj9Q94VCIdr3qquZsHS3aTSwINIGC4sVgB52p
nOToH4Z+J72ULJ9+Pj++jD3UNKvWYakS2+zVIFaxGzFlAHYph0NMRa/tI5XSdNFysZiy7sgA
VDTSX2I92Ra1Q5Q2xCZKBg8UqkM5oxGO3sdG8NZ1j7VxOS9A7qMsJ22qolYGDPLXOYWtYWpE
zgcSsiHeNrxIAzGAbUKm7q7dMWgx4QwG7V3i9K6JV6vAc58mw0DIhGukDtv0/ds7rAYgamUp
LQgRmcZUhZ3ORENphQ2Fe4ZYQGvW/Vo/SPqd26Cl2IqAQ1RPkSRFS79sDhTRUsi70LuoJjKM
9UPDdrdmx5DeIjNq+0repAQOfQ1dV2HeDOitzLqsutWGohIFevneIk3QAEKFkhc7kQAPonPj
GmrcZR+jGe1u0s9A5ScWGEKOOjzNWzp50tTZ6A3YIAsdMCUN5Swoul1gaRXlxzJkXocx7kJv
ECrgO6zI4gqPQxdV53ncgquvgcrNmXipF86AqgbmSYuAxq/NbCFavIN7VreHwciCeYzzjXnL
1zr87Sh2vaHcnwgXSoNDmV94jwtQaR4wVQHUvYfrBS52Mn43lvDPWg3HyOXWYQi/XSGiSeCP
nfRGAYT02I+BOgNtCPF2oN5Q6Gm2qHpVIvWIZ5EVh2PZ2EcvIo8NxkvBtN7jrspmNvtY2bFK
fIwrfQMvyc7edaaHAY8n99ZYlLEkXjXFsKIPsukwPL3ONjHWXcINZ6yytHuGn6/u+xhp1O4e
InSQbEpfiMg9lHI0gwDUpiDatuHPl7fnHy9Pf8EXYD9U7GOqM8A/N1pEVak+ebHjfkd6W5JA
VzTaMUPpwVmTzGfTJVVhlbD1Yk7GzHMo/hrXWokCuQFVq2fR4uBTbhUOUimjl6xNqoxmulcH
1q3KJChBUTTwmf0te1gu7OVf338+v335+upNUrYrN6LxPxnBVUJ5ilywzJbrvTaGdgd5H/Ni
XJaJyaIzgX4C/Mv317eriXR0oyJazBbjngJ4SesoB3x7BZ+ndws6aItBoytaYCCEvt3YEGkr
dBCCoTTmfq8LZRVNuQworDKihrV/8MtJAVe09SI060IuZ1OizHpJvcsg0rPaM6CqHmcVUkzn
79e3p6+T3zDHiQkW/4+vMHkvf0+evv729Bkf9N8bqncgx2IU+V/caUyQN7rBqvUekmJXqCdo
98DwkDJjxzDWinYVILBvLIjjOT/GLmjcOcXFVOQNOHo+qEwkLkHZq5mdgYQtci0CCpLU9zOP
u0mRN9zj5G7KL/4XnB7fQD4D1Hu9gR6N0QTx8oflG1bKDiSC0ZyWb180tzH1/IexK+uO20bW
f0WPmXNvbgiAC/iQBzbJ7mZEdtNN9mK/9NHImkTn2pKPJGeS+fWDArhgKVB+sCzVV8S+VAGF
Kq1j7TTWdqRdbeKjk9wahP0RU/kkNHSpyQ/EwfnlwsILjiq9r2BmFliw3mHxxfPR91rtO+bR
DVpcgu1aj2i7xQPsmZFUxJ8LDlt2fQscTucC7f7Lo/KnicRfE4nmdQWPQW5BmcZFVI1Lnn+8
x2Rv51NJfgfnPndvzy/uNtC3opzP9//vihECupKIc/Bbk0/BHAfjB2WueAP3o7uyB+dL0oIZ
6iJUkAZCh4xGEWKYiznyWUbxERNH5vb6f0ZrGDnBY3xOW4ZvGy5v3qBjx63ZVLFJ0hgIgzOj
EbjK6NS6l6hqZwhCGj8IFuuj+Mw8KoKUxG94FgagJoBTpLEoWccSahyITsilpQFujTuyFFka
xNg+NzI0eUtZF3BTfrVRFxEKn/EocqJfSBRcsNJ2fbPGDxum3LJLksQUP8gemdqsbjL8imlk
Odxyj6OHkWOfl/UeE8HnogjBP3Orl3dhUrPIA3AfkAY+gLpAvyK6b2aY0oZd8ECQ0QLAU9UQ
UCAiU2yc/draRcdPqsMH+/mfGn3e2x2593YfuzV23yjB2Q+YUlBUyISvd9++CWlEpuvIk/K7
JLxcxmB0ZnbqKMmX3/wUXKcW56xdOSnBQai/Wuse/gsIZlSgVw2RaxR8cFv5uq3PhVMO+WDt
hF0zSbhZ8bhLLs5nTbn7RGji+6zLmiwqqBg4+9XRKkYHz5xzoTbZ9I9druvkkjiOODN3Jfb4
mw8s5df2TeeoTflHwSTNSurDX9/EDuKODsQGRafDSPY1S1bsWrunzqIP3W6RlhHoI5UZptZU
HKmDR3kzQanasoU2E0odj1B3iaoj2iqnnAS2amc1lZpo6+IHmpAGbhMeqk971OGChFdFGiWk
OZ/sGSa2Et1FvCT+lu0+Xfu+dkd8y9IQ37+HViysOe52jb0XuLh+h6PaV+4O9vBuuzhKiV32
/kNz4bFNPNfwnlLvAKShpyi0ix2w6vnFHj0ypDK8eCF2zjIgr4Ro6DTnocgZtd/waaFsnfKZ
Pb7ZiJUg88S/lM25B49vc4lk3FBZS/Lzvx8H1aK5E4qlXsszGaIKSiOm/UX/fkSKjobcEF90
jJwx1WzmMBfYmd5tKr2LkELqhe++3P35YJZbKTjgHqMx0lf0zoi4MpGhLkFk1UWDOF6XmUP3
CGt+GnsAynzZ+WQc43OPVYDJgx2vmBzeQghI7DLYxmZycbx6UXDBgUR32moCxNsgZYBdk5ss
JEHGzTA+JkFMxnjPzFih8tl23nrUNPkFhB9ChcoxZnxbm+GGNPqCgmmwOXFfZjZ40wWs2Bwf
BJmsyK+rrBczSH9elF14SiP1sXEzABGJnSQnGI6q4eUd7DNBjA2iISvwKsnTMDKOukYsP9OA
4CN5ZIFuRy0/dQZ9wBh04qFTl16XGyEznpiLdCttUxkrbhCVcweLOH6++kDhXaAXsC27bHhb
YNKOzVX016MYBaLbBjNsu9piBzfPJ3UkwtTEqY9B1bxgnyoE7T8FLYwgYBCy3PpYCo07O6Iu
N8Z8xCglidqZcQTpT4kYHrfH+gg5TIxZc10bMTkfAp+bJ8VTtzxBBfORwdy45qTlIMFyrXsW
ezxragUjYZQsZatcJ+8H3th0b6ylI2WnhXTEkApJdMG+lhDqoEDnoFHiVh+ARNeeNSDipr+T
aZI1KxYmi+uDHDpwJ0VT9OJp5Dv0UcCYm/uhF4sTUqpj3pEgoGgjFGmaRth2IxfoOS355/VU
FTZpODzdzs9IdioEBXIAPAVuKpKQ4NZ6Bgsmh8wMDQmotiiaQOQDYh+QegBmbNQ6RBK8PzWe
lIYebxYTTw9e0BcrChxoRQUQUw9gvj4wIeziZ+LomOfTLheKDD6zJ54LBH/cjX6DF7MBYymk
7P2lRRtcWhSAw77FAhQdrmvNOImxQaM2DpArXKyKbq9Zs8IKtU6IEF+x+02dg9P1xk12nUQs
iTos2SYnLOHM8/JlSqAXKsSxh33STX1TR4R3DZa6gGjgNcwaeISggmnWGo4MvOGCa4fluq22
MfGI8VNLw7mTJyDgxNPzBEv/tzzENv4RFpv3gVAs7Jz0xL8pEUAuxBGWmYISr424wYfuMRqH
2KCQEQkAJb7cQ0qXais5QmQNlECMtYIE0JkHW3AcxD4bMI3J41LD4ImXFnXgSNHuFQgjCVtq
SoiTpyY39nUcs3dLF8eLY0hyROjiKKEUk2jMCqRI0zd5ywK83H0eo5vz9Gm5W1OyanJ7u566
tYkZOoSaBHtrpcHY4GkStG8EfalT64ZjA67hDKWiGfMEo6ZoXwj64txoUjTjNKIs9KQXUVQg
MznQudrmPGGo0qdzhBRt2F2fq6Odyg5I5bLmvZhaS30KHAnWrQIQWieynAOQBiECtNI/jAvI
Y+FUW83axrKXHPhwMghVNEHbcQXeR9a4efKwMayaa75et+iOWu269ni4Vm3XegLfjYwHFlG6
1NmCA3wDIXLCoe0iK5LqhHV1zMWmvjiIqFDlYnQEwjZizjGMh3GyJNkN6zg6xtXSHCxLd4KJ
Bu+uwYIF28/U+ofNbkDCMMRWRqHBxpwj4+dSit0GiyHbdqFQoZHBLJCIxQki5R/zIlUOahGA
BugacynakixuwZ9qUUD0227bL/aTwDERVZDZX5708qUBOxh7oUJ1U4pNdWlUlkIWDQNkwRQA
JR4gPtMAq0HT5WHSLCAp0nEKW7EU2QK6fBvFlwuYojZ7VOyUHOgJh8HB0HnX9X2XRItt2zRC
JMBWspxQXnCCDN6s6BJOMUC0HMe6vtplNEjxdS2jFzSC4MzAKJZmnyfIGtZvmxwLwdw3LcG2
CElHBoGkc6zEAgnfWWeA5R1FU7BEBD/aGllOVRbzGL+am3h6QlGrzJmBU4a03pmzJGGIVgcA
JwVWc4BS4ntHpPHQH+BZrrtkWVpjBEMtFmP7uZcOxngw2plHTKvtGm0BgZQ6JGWYzLhcHUgQ
uKKv4IUsZpcxMpVNediUO3hRB2ew+/X6WpR19vHadL8Gbpr+u4WRwzaqt+DzoZKPcsEpn0de
GFmLUhl0bvYQQLhsr+cKDWCB8a+z6iBW78wK145wwitMcPmBupgfP3CSRPCpiDgMvhzlDxye
i6EdMkrjNaSHi/K0PpQfRmixFcE1vvQBt8gFRjYow3jJjuU1lkYakKEjsQK/sAuf6pdO8/cD
eM76fFvsNy7FicU2Abv9Ofu4P3rcQ41c6sWPfL9xLXcwHDEvzhM7eKmQRosi4TmwzgRL06fx
hPZ893b/x+fn32/al4e3x68Pz9/fbjbPfz68PD2bB7bT5+2hHNKGgaCXw0zQ5+al2697pK2G
YzcciDFAHjFpZNNAYCpvdsi3EGm4zzOPs/lZdR4/QloXDJeCOEXKMbz/c4FPVXWAW1qsjIPJ
11KOxRlJ87CL+phwBIFzB3bByjHNCSS5sj8i5K4Hhx4EQbK6ahISCKgwn3jELAjKbgV0XyNf
M0psfDQ7+fmfd68Pn+fRk9+9fNbDi+ZVmyMTrOjNF8OiAO2+66qV8fK4W5ksHdiAW1/llYw9
jn49olYqRbW3v5k3UI0B2zsFrB7GQdry6awvFZMN3+tnNs/jp1XeZEjdgGz+pSKwg0kPVh6D
w5eNiuG+z62E53o4KXbrOuswnyj6h+C5+po3O+frH6j5GKVufm/2r+9P92C77XrUHcfrurDe
jQAFu/aX9I4lqPQ4groeCnPL9VUlObOe8iTAMoZnjFd41Wu9y5zBbZ17gg0Dj3TREqAKgoRd
EzmZ8nhJ7tBM62qg2wbGM83x8gJtC7bCqPI7ofq16kTkGDENMKLd5NJY4IIQdRtA+HzYi5BS
S8RXaLVTYZ94XpMNMInwuxCAN1lfyijQ1w3q00U2ck6YYYqhEbFKNC2NKebvDMBtFQuNy3Lo
tO3za5t1Vc5Mmki81UNh162g6c/VgNCZ4eIgk+pDF1PfUJQGmHmzLyyX4AK6LRvrsaMGct42
PLBGgiJGdkKSHAe+IoxmCfZgVvsoRo1QKo+dtpf0FDudnWAeMicxngZuacDGCcmApyl+Gz3j
+AGixPsYP6QewdQuxyg9mWSQLEyKZqAy7eqKMly2znZfI93voQlycA1IdXS0jDC/yaM+Qs/G
JXrL9YchkqTkLZPYlbkj0kt6FSbxZSGIEvA0UeDbKLrbj1yMO2cJgXMv5JNsdYkCe7PIVozM
xNkuSZH3PX5pLnPpG9QVtMQsG3ugCW0paxiLLte+y43rckCVtbRdEzAy4tgN0ZBg3diDxrJ+
BsNnEphmPNIYGn/zoCDzHYLMStI5/kp3Zkj9C7NkoMQ/0aA2orYe03mNI/Lcp2q5+KerZODx
QibKUtw3o11Dcp3qbvICEWusaQjTn+swYIEz7mcY7M8RoeZcE5owBKgbFrmTt89ZxFPfhLdt
34F2uvDIWSHrfb7dZZsMsyqV8o16TGAJPYroNogUNXQHD7JiTUQCZxoD1dsR5waWbfeTxcVa
wKEnZMkAM3Lxu68bWKLgPZY0RX37wfq43zZCeEyIehdgLrYDJmQpfxXmBKhvXRi0UWdV9L6+
k6XOi5SFOC618q5FFmrdc4JPRZh15w0cVekvtyeSHRd7BlSAh9O+7g1Lk5kB3MAclXee7tiY
lpUzF5y/yeO3iQ9pvJldyDsbsUpg+c1iE5IN6Ds8xgRek8fWiTS0iFiK9azGorQez/dy41r+
3tKvNMRSX2YEGbI6OChDi9na6oSJRGiBJhUBQyjxtIHEUN+J87DKdhGLzMVuRj268cygpH78
Y4WdIp87xomx6uqUBcuDBW6/aUIyrAnEqh8zT5eAOJHgF0EWE+5DS2fiCap7mCy69ayGqD3I
B8VJjEGaOoEUCNDIFEUwHkv1sLHIh/E4RMsrodgz4gaN470yDQoIDplyrF3eH6pwyhaS4MF7
Xa3Y6Ds5DYqy5RjVwBPdQMmEeIpO5yZviegTXxO0UUhw4VNn4jzCDdVMJo/0pzN9SFLPI3SN
Syh35L0pBkwe/90mk0cFnZkWXr1rTIMmuNiD7fr4qSQBOgHaE+dB7Ie4ZwJIEDXXnHksdVED
bKVRg4S4g9IddXXGOtq0Gao0mjydbhquQVHDkzhBoVnhdLF6E5EAb9VZInMhkWIQe4QBAXIa
Li++YJ1DxCDDEse0PxOl+OGFySTmJTqfMW3RQgl7b9EZdaf3SuGoUZoI6HX7dch9WlY+n0lo
lN2+r9aVKUTKoDgShQd4VtB7g2fA3Y8HYAgptfD9qjicpFexrqzLvJ+O4B8+P96NcvXb39/0
l6xD8bIGDo7nEhhotsvqvdAsTz4G8GjZCyHaz3HI4F2yB+yKgw8aHSf4cPnCUG+4yX2AU2Wt
Ke6fX5CYIaeqKGVoRqT79vJZRY22fnFazQdARv5GPjL/0+Pnh+ewfnz6/tfN8zfQd17tApzC
WpuNM81UhhU9K0627qMApfc01U6GXdpt9JcKiqM/7nQ/kTKH9Xm3L0qLc3Vcw008Qi3gMmmj
Vxurnqx38fj749vdl5v+5FYb2q8x4qkARQUN1Vmyi6hv1kKorF9JrEPFx10GtwuyvmYYVkCl
e7+ulA52rvW+68CdBjrhgf1Yl9hb2qGGSEX0OWbfa/VwYzq4wXLGtkDmoasPz7tvb9+NEToV
cOi7s5BgsTOCEY45muIvd093X55/h8J7Rv+2vFTHRvS3aMrKHjIDuB+CoBtYc1nZpKJnRMr1
3oL88sff/3x5/GyWx6prfqER9xilKY4uyxLicVCvcZgNpnfa3KVwzzoEsLMGaHZKiG73OtOu
+64w6atjsSl751B4hjyLyPBddkKTa+E+3kJoTodbyta+6sVwb2Q8YG5rsXFQM4O2JzaBWdMU
jHRMUlGsDlVhHLfI1X+avPourPaFKkw8T4BnBo/VoWIQi0Mlf1vg6cssSmJPrAKVjRgnSRDj
sTfGRNZCmfJIJZJDHbN6d2llMat5hpcj8f7561c4+5Lrh2dnEEsutYSOmY7sGpLelM2+tRd/
icDqDftaZW8eKr0mq+u9veFMH3Yb/0i01wE5+8LYQ76etOHeNWA1ne1Ehxa9sQ+L+s3CgLJB
wAwXgU1UmYp/I5eRilqrRoZSOm2uces+NSfMHPW0QGpZKpFaYZr8FzBMuRGpjV4edessqK8M
CH1waitFG1+668eXBwgDePNTVZblDWFp+A/PyrWuDqVqTJc4xUmzBSfd1ZIi3T3dP375cvfy
N2K8oaTEvs/kAiU/yr5/fnwWAtj9M/iT+d+bby/P9w+vr+A+EBz+fX38y3qiPGxdp+zom8UD
R5ElIcPk/QlPuf6mYSCXEFgrciQoSacOe9O1LAwcct4xpiuhIzVi5iOkmV4zij3nHDKvT4wG
WZVT5uyexyITm5ojCZ6Fdqm/JZqpLLWpp5YmXdNenJm33328rvr1VWFT3/9Yn8lOOxTdxGjL
EGJix6PnrSFlg30WhPUkrLYTki088fU2ncKZ2+gAhJ7oDTNHHCzJC8DBQ3yRVxyrnhPMpmNC
I2e9E8TYId52ATGfoA3jr+axKGWMnQlqyydxRqgiX9wU5VFqEmIb0zj12oiEzmCRZPPt5QQk
QbAwEc+U62/YRmqa6u8WNGqM5CHo6B3eOMAvTD0t1sYUDNU7YyQjAzQhiVNTKWmanrusUarl
8vC0kDbWoxLg2HG9NqATpJ0VgF9azxxsoWclnnrmSuQ5hBw5UsZTzPPvgN9yjo62bcepfVdq
NOrUgFqjPn4VS86fD18fnt5uwPU0si4c2yIOA0b8i6riGJYGI0s3+Xmr+kWxCDns24tY8+Ai
0lMCWN6SiG5xd8PLiamIQ8Xh5u37k5DznBxApoCXfE5/j4E9rE/V/vz4ev8gtuanh2fwxf7w
5RuW9NQvCQv8Q6WJqPFUWlEtq7ahHSDyWVsV9r3AKEj4S6WKdff14eVOfPMkNhgtLJSVy7aK
PN7dh6I1orWW1nLJgJ/rzwwRfmM+MyTvZeGxXZkY2HtlYKiho4L3Jxq7Ig1Qo9TtGKDzpeJI
hqUFRTAkHvcpI0MUv8+wnIVg8O9u+5P94H/+LHkvY9TNygyniKi2PyUUfW84wQl1NgxBRbsl
iROMmoRohTiPsCuzEU5j/LM09tixjgyE8QizBBi2zi6OTTeRwwLQp03geSaocXjO5WcOsrit
CI42YO9w9AF6CzPjhDjisSCfAkLQep2CBbUBcKLf6AyL3CFgAUQid1Pc7fe7gEhwqR5Rs69R
TVXCh9+icIcUt4tuY080TY0BPxGZGMIy3ywJwoIlWmX4i7yBo6myFrdhVAxlz8tba/EcA+Wg
C7xc4WtBw9xUjTJHxD3Xp6PQkbBFgag4p8nipiAYeJBcTx6/70b5lL795e71D/8ulRVw/7zU
HWBjFy9VCswxwhgtjpm5kiHayt3pRyHBxqwrk+HgX9Xi++vb89fH/zzA6aeULBy9XvJDWItW
f8uiY0LlJmY4RAvlNF0CdVHcTTchXjTlunsSA5Rnfb4vJej5sulpcPEUCLDYUxOJMS9Gdd3P
woh5M6mjEM4cN2LUmC45DfRn7SYWGbfKJhYGpimaUbBLLT6NPMGYHcbEf7E5sOVh2PHA10Qg
9eoP+t2BQDxVXOdBQDxdLTHqq6JE/Ue1RubeREpoxHfSWOdCxPS3NOeHLhap+N7yaYU5Zqlv
ezanKyURJl7pTFWfEuYZ6gexBLu3rWN/s4Ac1jj6oSEFEe2qH105+EpUNtQVNGwd0heo1wd5
grp+eX56E5+8jrFHpOno65vQ+e9ePt/89Hr3JnSOx7eHf9z8S2MdigEHn12/CnhqSM0DOcYN
HxV6CtJACzg2Ee0rIUGMCUFYY0O4kPeZYtqYJpGSynnRMWKqaFhV72UMlf+5eXt4ETrmGwR8
9Fa6OFxuzczHpTWnhXV5BSNHn4eyUDvOw4Q6ZZVkt6QC+7n7kc7ILzR0btUkkVrXTE3PiJP/
p1p0GcOE5xlNrdpFW2Ic9449SXVvN+OIMFbOiTO101R9jowO+3PY7QLO3K4IAt2WfmSlsTVk
TmVHLqn9/TCXC+IUV0GqlZndeioHzDpIfZrZbnTmHvM1uUITrD+dlGCcoe8jZe6d2NGcT8TE
wJdaOUJWPM6I24qiEsnkix5GZn/z04/Mma7llpX0RMVl6qGuNPEWUaEUGZHsv5Q92XLjuK6/
4joPp2aq7tTYkuXl4T5Qiy22tUWUt35RZdLudKrTSSpJ15w+X38BaiMp0Jn70IsBEKS4gAAJ
AgYQFqyxLBOwllcz6uvUI1t5I3uqxhMX1o9Hrh/XorXKVnAfOzyljv9UfDAaKO4vEWEvh+iC
KLa2D3D7tSuzFNusp5a7YURHwXW57i5G8zV0YPMrCeh8FhngskqclTulgOY4o1w1ZMzncAY7
KTqo5KE6RYNWvFsnJwqClSnGmg5yyEliytNGkC27SlkloM7s+fX924SB2fZwd/v05+759XL7
NKmGxfJnIDedsDpYWwazz5lOR9taXnqWgD8ddmZ2mB+AyWSK1WQbVq475t/CaaNQIVhQ58YN
HobHlOG4NKeGtGf7lec4FKwe3bK28MM8IRjPeqnERfjPxdLaHGBYNavxekdp6EyFVoW+J//7
/1VvFeAjC+O7pQIwd/vMhp1zlMJw8vz0+KvV6P4skkTnCoDRtiT3LPgokNtWUTDQrPvbHxEF
XQ7SzlaefH1+bbSRkT7krk/nT8bcyvxYf+HbQ6mrvhZZmOMhYSNZiy8x5uRrjR5rMmqAxsJF
W3q0lSdbsdom1yY/4K2bLat80DpNIQZyY7Hw/jP6jhMY+h71VKfVXkvYus3ZiCLaNT4kzsu9
cJlBKIK8cgx/ojhKGh+jxiBoPGU4TNLXr7d3l8lvUeZNHWf2+9UMtJ0Mn460t8IhDJGRvSHr
rp6fH98wJyHMr8vj88vk6fK3Vefep+m53hBeoWNPCsl8+3r78u3hjsz1eNgyTMdM9bqafgZ+
yDsZ0JR0XzD0UClAHJ269ND0VEEyGVU+JbfuHi2iZIPuKXrNu1S0mY11eFMG6k9FVVd5kSf5
9lyX0UaYbdz4mND9ekwqpMO02jXYlCH6saSYGNbW3AI9r/XmVJXRY4eSpWTDgZKEb6O0lqFX
CBx2gg13MCoWQRz1+z6+CW3vRCcgtYzDPaVUk+QbFKiFzq1JPpvM9DijHSY7FfLEbL0ixYBJ
5Y0yiNna1ugPZUodjsoOycH6N06yu7tSpZTakpKFkR5UcoDKp5hFRfphAxFLwybr8ghWC06C
A74za2ox/6SmesvKqpnhQ5QvFhST3xpnmuC56JxofocfT18f7n++3qJ3n9lPmAwPC5Id9Y8Y
tlvw28vj7a9J9HT/8HQZVWlUGAajPgFYHYeB6o0t1+8uKrMoqdvQEb039JXaVMZZvj9ETBmY
FoAZc1hwroPqNHbx72gaD3ePBHfR+v7XpdFpasyGDu2zYJfwbVyZo3+A5W0Z8wOsbqPDTCGY
btnW0fY/nLoBKzHAWBymI7kscckhpO6IEH9zSswifh6Y3gdqI3lZYcbCYm/hWDAYyEFla0aw
uH26PBqSRhLCvgM8o1KASNbDUykkYi/qz9MpiPfUK7w6A2vTW5OnBH0ZP4/qmOPTRWe5Dmm+
SFMdZtPZcQ8Dl9B+AAO52YsESXON8QFRlPCQ1bvQ9aqZJYXwQLyJ+Iln9Q6jtPHU8RnpEqXR
nzHY4+YM+q0zD7mzYO401CdMQ8oTXkU7/Ge9Ws0Cuo94luUJbOzFdLn+HJDmTU/7KeR1UkG9
aTT1jKP/gWrHs23IRYFxPnfhdL0MLc5ySs9HLMSmJtUOGMfubL44/vMi0JQ4BHuW9pAYimT5
gWEROb3IW5GBNk94Gp3qJAjxv9kexiinPzcvucCkR3GdV/g0f329D3MR4h8Y7srxVsvac6uR
HtNQwt9M5BkP6sPhNJtupu48o48i+iIlE4UfleUZdLgq38MyD8pIfXujkp5DfI1RpovlTI38
TpKsRjKpJcmDnfz2T/HUW2ZT48xSocv8vC59mDuha5k3gqViDzNbLMLZIrz+oQNt5MbMoapU
SBbup+lp6n5UbbRasSnsYWLuOdGGdB6gizFm+6SI7/J67h4Pmxn5bmKgBL26qJMbmBflTJym
5IC0RGLqLg/L8PgB0dytZklkIeIVDAmHTbNaLvXI9woR+vmy4DR35mxXXG1+Ve6Tcyu3l/Xx
5rRlNM8DF6CZ5yecVGtn/dGShWVXRNDLp6KYel7gmPECDD2i3YXU9plvSZTdocNoG9lgGPqv
D1/uxwppEGaYjohbWx7E0LUVVIBa9hX538lIAGUyZ5rdXoGNCcjCiIorJbUG1IJiXmDk87A4
4QP5bVT7K296cOvN0RyK7Jj0dp61UtTliypz5+QT3aYbUaeuC7FaGAcWOnJuYwDmBvzhKy1U
QoPg66lzMnki2LG81GrwuDu3A2ups4p5hnlXg4UL3TqbOiNzp8pFzH3WejxbHvwQhPQTeoKQ
dhaUhCC2N4WRVsykENnCg4GzhMPq2BThzBFTMmSjVDzlm1wQACw7LYzXByZ+uaLPflSysDA5
oD1IOAirC6DXaMfA1u4erfDx8lQLR1XGDvxgNqUFX4syjd9SBsV2b5ZNT2Lj29c6L0vQXW+i
1KYtNwaKcTAQbk46pJypDhitITCyLLhNtRDswEwhF52aR9/4fj0SlaBEIOguUVbJw5L6Zs/L
nUGVcB+f/4by8WnjyPR6++My+evn169gwYe9yd6W2fh1kIaYmGvgAzD5rv2sgpT/tycw8jxG
KxWq1iX8lgG1D5Eg3pljvRt8lZQkZfNwXUcEeXGGOtgIAQbENvJBT9Yw4ixoXoggeSGC5gX9
H/FtVkdZyPUEa/KTqrjFkFMMSeCfMcWAh/oqkHk9e+MrtMd7CDxsGYyq3rGKKTtAU9hv2mMo
nQXacfiZFc+25LT4dvv65e/bVyJML/a6XDEawyJ1jH4BCAzAJsc9st0e6a8PzqDuOoYposJx
Ftm6lsH+A51Ge83IySEqS70YtB2fUhqdOwu72K4qn+zAQ047YwK25AcrjtvcqHF8ZMZzK1d5
2mX98uo8IwO4NTjto+B3bSwDBHXB9cFCMj5XYq0NQ2w/4egWCFfvVXckCnp5p3JugNbgeAMF
C4KI2gSQghsjykXtqiZNB5t5uoSLclj9PDCatDuX9FtEwLnhhtpVAXPI8zDPZ1oFhwq0JNdg
X4GiE2WWXmTlzlhlercGrEwbQa0tnAYK0p/BFnIgN0uNJtiLSo9xjfPWT2EKVHOPtFfxc5qw
eUaxNEKrJE/pA5ZNcy1ppM3Rxtd+OoNYgdfllFMbItPlTLvIITc6Kev827vvjw/3394n/57A
7O+ihIwiIuDZQZAwITAmCFdTbyCme/o7QPtVYSk14Nu1R6H6WJwjjBkAT8eoUYUGDBG1eEDK
hPRHI7sFQdfGTv+YarWyeDgbVJYHHAPVlThUCqs+jiHViQvV82vAjEMwKaNS6CGwFX4H+P5l
QpnQA5EfLmZq1GilpWVwCrLMwtvs/3b+fjBLu1pAHcBMPmZMAHrz17V1UPxz/VctT8pAc8ho
BFSmelgpmCDZV46juXSO7jO7YiLfZ3qepkzrArlIYx6OV2SsZcHmYZ+YW1RllG2rWMOW7Dj8
3o/KDouwcR94udyhvwJWTDxNwBJsjkdlxCSQyKDcn/QaJKjebAxooTnSS9Ae9FFNmMqPi5Id
p7RGRAYxHhPqbIKYwy8TmO+3rNRhKcPsLCah9NI1YOcCdCShA6Fjt3lWNrmMFAOng8IXWxod
pWLUHRipSt9/JPTzLjpbuGyj1OelOZqbcsRkm2Comj11s4JoqEGeseqMdufI5HNkSZXTr2AQ
feDRUZ7z2tp7LqWFptfDMSeNAaoMwCfml8aIVEeexczgtYsyAcp8ZdaRBDJtlwGMQhOQ5Yfc
gOVbjpOdhuKPQjsw6DHk2CO23Kd+EhUsdLQpgKjtej4dAY9xFCXtdNG6W+ppKQwrdULUECSo
hozLnW2JTxBdRs0MNlYKD8occyiNuOERYWmdo+k+qXg3u7SCWUWlckEMWMTRTq8erHw884B5
rAlMBWx0uFZVEVUsOWe0uiUJQF7g3kK3BzScTJ4yB8L8iKLEmzsrX8Hw4srCtj14N1nKtPSw
mezsXKuI0cnTWyzMF5DokW29Q61Fsh99C+jCVqZbvH0BM5M6t5EsU1ZWn/Jzy7fbzxQoMYEr
fqCNCokEgz8iE45JbAzLPDUkQgz2eJWCGqCudBU6krl73BvrQrXTpJzjPM1NGXTiWZqbn/A5
KnP8OkszP59D2PvMtdTkKazjvU/CG0Ok/WXsj0mbXLh74Ubs1b0Tja459M3G40xEUbrWqFiH
UIG9JiH8Oo8Dbju5QTwRyhHBIHrR5qNjzyHBPil47e/pW2wkgP9mtvjSiJfp12Im6lg36wFn
KdGEDZM9hUT4qYr+08OLb7/eHu6gz5PbX5p/XV9FlheS4SmIOO1fhliZLe5g+8SKxYfcbGw/
GlfaYVTCzChrQw3nIqLPF7BgmcOAiiOvSDUv1T3di2MpohtQalJq52+x/bvJvhiQ1z7mbiRb
IaNB7RkdJhRKtm53SnCpJr5U/Pz2jv43nQNkOB4gLG4LAIc4EcZqdrceVGPstiAAPTBXjYkB
b0SeQwQo1nlc0z2jFEyqTUpxzDcwk5lQl5WOlLuFDVmtZ2Z7emR4DFIRX29Wmy2Q5rHBfy1P
vgeqlCd+xPbWUeQbkHTGBwT+UnV3R9BBRkdNtWw/OIpH8zfVlQD1k3204VESjjDR6ZzlwvxE
vLzh7nK9Cg4O/aixIdq54waYc2cPPcEXsKKMbwpu4vF8icWNravau7cR/7Ta0SN0An2WMpuU
eaBFGx3gLF14cwoRnWAbzTA3bKonowOLpuIBpepk0RHlvbJg8FdzNETBaqmcajo14vwSTwky
WHx1fETv3Wwbja1lPEQYHdbL8oxVM+31dQPN3KnjrZkJFu7CSC3RwDGtOHUa0zQxSBeuev01
QD0TKo+3zNZIoEMB3TFwMXdG7UPwmswy0KOns5PBq4mtPuJVBGztkYEiJNo8JGoqwOxL9D1z
j/esLJPC88hU6j3WoW5gB+yolwC4GPVnsfJUX5IOuFqYwyF7wDO7q4V2HWCiFq5ZwDyv7IHe
eAD7YNz2PvRDZ0W61jUfUrneejyYxNGlNgXMZAMSWgUM45Kb0CTw1rPTaBYN6SBGc9Lz/mOt
eZzGTcJ3Vegs1ubYceHONok7W5u1twjn1D/BGSSBfPzy1+PD0/ffZr9L3anc+pP2uPHnE/py
E3r05LfBzvjdkCU+mmfp6EubbGX2kUuTE4yvrSfQy9rsapmZbFgQo6W+JCWAEaRJ40hEsm/a
vk3dmX5H13dj9fpwfz+WqKjAb41YoCpC5oKmvMY1ohxEepxX5pe32JCLnZV/WtEn9hpRHIEO
CSoIpYFohKQftEYRkJ7EGgkLwKjl8uKR5mFNLah/dpt5XZ9NckAeXt7x7eHb5L0ZlWESZ5f3
rw+P7/ggQbqfT37DwXu/fb2/vP+u6r/6IJUsE5y+fNO/XobGt4xTwTJuLuEOl0VVE0ueLogH
12Np33eoGQW1JWr0cO6ja7DW2xz+zkBPyqijg7IKas1pAAGGJoKgOABt60wDu+usf72+303/
pRIAsgKDWC/VAo1SfXORxGaLIC47gGrVyTQATB46vyHNpEFSnlWbJsu6hZckKMpcM956hPEY
Sm1fedDMLTwlwKaMFK2OuMntddI7QqZk8H3vc6QetwyYKP+8puAnmlOXfEvvScCEwnI5qhIs
52OWDdzMMK5gF0syu0ZLEJ/TlbdwqbKYI31tSZin0Jipj2gah37eqNCM0hyNiGQKmesUwgvc
q9/LRTJzpivqexuU83FpZ0EVPwHm+kcWwWblOZQirlFM6eGQOHfxYfEFMU8lYkUg0vmsMrL6
aBgzA71B5N+4zo6ozshD2i9HKpFLN3QBpgGyZHBqaQTYFOspdZrbUWxAH1ANlJ47rMcZDfdW
dHughEOmZ2sJohSMsCVZ9ACYDyYqZky6NpTCS8etFSHIiD43BAYKswo06f6Z4bk8V+kxuu5Y
EBJiA2yrawsBJpTTxMmlvn0dODYMmMGNViirLR5v30HP/XFdMIMQc9QAKwrc07I4KXCPXEMo
DldevWEpT6i7H4VuOSe+IRTOfEoJYTOHoQKnV7OodrNlxchcj/0KXFXUZyNczfauwvWAoj1G
pAtnfm08/Zv5akoNWuEFU6KLcSyJ5TTOWj3siK6edKyFfz5nN2nRzYfnpz9QXb06G4bjPXPt
V/C/6YyWZk3euut70CgRm9kZS3faR31Ao0s0wRHJ5oYpa5Qn/XlRDx3rT807iJSN/XoxZUOU
bTW/XoT12U9jlmVRInRsrlwbMUw9xWAibJsjsI7sWLMTR2rddU4kdYQtGfcFl08rOCD1h8pF
cqrpEtJPKcYSdbpNFZNpQGgNwsaMk680cIJ9V8I4xRagMxrt6fs3eHy4PL0r/cvEOQvq6lTr
bUmZ8Uq+H4a6ZHwI+ZIyf78ZZ/2QTDdc9RYRRwkdAPumsDFFMDtTmh+i1nObnLUtWfeW3/Jy
siECa7Kg410bbe87ZH9qn8eoLYvD+XxJBvXnKXZiwHnrj9oVqGaLnZ6oDwMYoP+dn8D8pO++
VRLqIFjBd4euXW/qh3vwsw445dGAmAKX9DbKeHmjcYBOi9IBoXFj5BMgxIioDHLhmgUwa0/r
qUTfWgENWJrU2acsXu5VIw9B6cYM/LshTU2UDfWQ90SB6p3UvjdOo2xPtvAQFmSw9jgXVc3z
KlFTX0hg2TimazBkr9UqoZnllq/BHoTtlq3Bo2uHaO9v23ceo+WePty9Pr89f32fxL9eLq9/
HCb3Py9v79oNcx/x/Dpp90HbMjr7mr9AxbZc94gIMGoC7ZdQVgnY8uQuI7zGMmnMVRjVt/fb
+4ene/NCl93dXR4vr88/Lu+d/tZFGtAxDXWTNAzDnrTxfe6en4DdqOw1OpVTh/7r4Y8vD6+X
Ju23wbOTI2G1dM3crXp9H3Fro82/3N4B2ROmA7R+SF/pcuZRUgoQy3lju/VBjj/i2z5OxIb1
8ZHEr6f3b5e3B637rDSSKLu8//38+l1+9K//Xl7/Z8J/vFy+yIoDy1d4a/P1YlvVP2TWzpV3
mDtQ8vJ6/2si5wXOKB7odUXLlTenh8nKoDncubw9P+Jx9Yfz6yPK3puDmPjdCDae4t4QNOrl
cvv95wvyAeaXydvL5XL3TYumTFMYa7funCdl0bfnu/pOD39tLMCnL6/PD19UBSJuDry6/VC/
CcL3XXiiFqVyK7Ysh4anosK0bfNzVtJHxpgG6gh/cPfh5FuBrag3xZbh2y1lG8k4tEYUrDRk
FmY2C5JdfUoy9AneHT9bKk6l/M3TIs+izKJ77MSSjn3cCtDmkFRtQYfA1pY5FcWjo9C8gTug
8YaqB+dbCpgXeHROVS+dLq9Urjkmd8AD90u8ASO/Rz6IDesiHm9Q29u375d3LfpO54CtY7oK
TzxBnV3IB1qa0o6OAlgdfSS6KwLzoVYLsiXJ7dBa4tIOaNyk3yRb+uHHNk/CDafdNhlouDDL
BubwAyNIweDs9soNf0cI6lAEk1bN2tvPWY1JHYtwR1H154w25Hq+8kickb5awQjuufOZFeVZ
UbO5DTO3YvSQpgouCINoOaVithhExnsSFSua2UC9k1BbYSbPRmB1TBbTua1xV7KXK1SHgDpu
Uwh82NhX+vM+BdvmzE0tN1XxURQ8Mx23ml3w8fnu+0Q8/3y9Ix5NyvtAzZhuIEWZ+8pUZGXQ
IHSvHHRAxtAAdcGrxZx2jCPr7/imjCd+rtwl9EkL01hTqTsT388pa6JlU+sWLYfu29es4CbI
SGy7xe3/4W4ikZPi9v4ir/MmYqxGf0Sq7opYUxt8ixyzjqK5ViyYEFVc5vstJU3yTUPe3zpd
fjy/XzAHHnGUFKGjbH+n1CsooxINp5cfb/cEkyJV02jKn9I2NWHynGOLl+92DAK0cyuJb2wz
cs7ojerVGXybgxpBryA9/3z6IjNNDodKDeL/WHuS7bZ1Jff9FTpZvT7n5kWi5sVdQCQlMeJk
gpJlb3gUW4l1nm25PfS9eV/fVQAHDAUl3ac3cVRVGAkUqoAaMr/3D/7z7f341Muee/7D6eU/
UTi6O32HjxcY8s4TSOoA5mf91rgRXQi0LIfS1r2zmI2VDn6v58P93fnJVY7ESyl7n39Zvh6P
b3cHWHFX59foylXJr0jlq/U/k72rAgsnkFcfh0dMBusqReIVkS9DJmIxqP3p8fT8t1FnJw9E
IK3t/K26lqkSrUj8W5++ZTcYAXK3LMKr9r5L/uytzkD4fNYuPSUKTv1dEw0kS4MwYakaIUsh
ysMCeRnTLnQ1AhTGOAgANBrNT0CQ1a09tfLANKJdaE1pM4jAnM9uvFW4A+G2azfcl373dBH+
/Q46Rb2tKHtdSQ66lV99ZaSNYU2x5AzEjr7ZkGGqVQNBRhmMxtMphRgOx9rZ3mGm0xmZYLCm
MN/rGnCZ1rkjdXhRzuZTNfZrDefJeKw+ItTgxm68Q2BWY9X7LVKR8KNabJdL1a6og1X+ggSj
dWWW8m1iFtuIQAbyjlUB15YaIDFQbcn/LjlZxiIVrXJcyy2Jp5Lw686ZuDvbJKIuYK1P646n
VdX3sYwXowN0KV0Ap54FMFMBLhI2cOSaA9TI8fi/SHxYFk4//oB56moO2FDLnZGANqsFPxWA
uQHQn3EUPxPRajWk7GTElJYNBSpJ+qdqcfg4auA3ex7MjZ/mbG32/lcMFEjHlEr8oTekja7Z
dDRWc+NIgFk9gidktCfAzDSvZwDMx+OB9UxSw+kq5vJRtAGI9EEavwDQxCPzGPJyMxuq6doQ
sGB6mNn/0+Vjuz6n/fmgoNoGlKd7BABk0p9U0RL4vgh0FcfkQgS6+Xyvl4zEgxcLqHt8ts+9
/h6RysYB2GxWwzq1A7MS9AeOesJ0F8ZZHsKuL0VkMUWV3U/VzRClzNvvzdrj0vdGUzpLkMCR
eWgFRretxMPCsBhRcfMJGRsq8fPhSI0Vn4RpdTtoZ6GGpmw7lW/G3SOgOEeA2TNH1JciRSOP
mTlvnfwTiPMyyYIL9sSl+H792YCuQ6D5wIi9paETOCn3jo+3W04GfX2ktYi1Z3r03N++MBdh
yHuhFmMc+VERcp/FIVGnUqIWwF8eQTozndoTf2TaVbUieVtAlng4Pgm/K/lkrR4oZQyfLF93
nnvdbhGo8DarccRsLZJwojJ7+Vs/jHyfz7RFz65MvgXazrRP2sNgy1EhLlBXuWrZw3Ou/tzd
zuZaNnRrxPLV/nTfvNrjPbOMRq9FKGjOGXm26ybMBrqTBzqPQ7J+9aMnvK6C17Mk1TGeN+Xa
PnUCu4U0TjW9QhpXT/l/aIkeMN22WHAurjzuOwLwAWrokBwANRpRN1GAGM89tFnm6sUJQof6
wgvGk/nEDCXUiAd5hjFT9Hi6fDTyKPPxZOINh57BE8cDMrUaIGae7nrm56MpaQQGXAS6MB5P
9eSfgncEzCf35MVZb9/87j+enprUAjq7kCkJwt1KjSgrvrLUtATejZHqjHY7ZZFIWZjsvdW3
OvDY8b8+js93P9sHr3+jF0IQ8DpbiHLBJm6GDu/n1y/BCbOLfPtoA6lrF2EOOmkw9nB4O36O
gex434vP55feP6AdTHvS9ONN6Yda9/+2ZBeI6OIItf304+fr+e3u/HKs3420zbRIVgNHgJ3l
nnEP0/y4YlDUTGd1U2Qg+ionc74d9rXMnRJAcgJZmhSLBYqQiqNyNfT6mpTnHqtksMfD4/uD
csw00Nf3XnF4P/aS8/Pp3ZgatgxHoz65f0Gr7WuGYzVECxZFVq8g1R7J/nw8ne5P7z+V79R0
JfG04GLBulTPrnWAkp8mU2q+8UkURCUZVaLknpohRv42VYB1ufVouY9HcEDSEg2izPhOzdjN
cUo2A/vrHR2Hno6Ht4/X49MRhI0PmDdjvUawXt3x3PYZn037boJNsp/QY4nSHS7USb1QaRq5
MGOeTAK+pzmSexjSCUiEXyJ2Igu+wicbOlJcs2C7H1gT2iAxdyZpWxDDOdNX7kRYHvD5UH9w
E7A5qeIt1oOpupHxt26Y7SdDbzCjBHbEqA6Y8NtwjfTRhZJ8XQHEZKwdYqvcY3mf9NWTKBhm
v69cp7TSB4+9eV9N86pjVB9TARl4ykZTVXzVklGB50Wm7byvnA28AWnWmhf9sX6WN32Rjqmk
/lToHpY7+NIjPXgKMJ+RK1+sRGn2t2nGBkNy3rO8hLWhtJbDULy+DuPRYKDa0uJv9eoHlPDh
UL8ogS2z3UWclll8Phypj44CoN4SNXNUwtcxnEIEaEbNG2KmenZRAI3GQ2qpbvl4MPOUE2zn
p7GZxljCho4U4WEST/rkRYtEqTHldjFom1rdtzDzMNEDkqPoHEMakB1+PB/f5Z0GcVpsZnPV
KUf8Vi/nNv35XM9nX1+eJWyVOgRcQA21hKTKFsBiYZklIcaFGWoxQpLEH449R8DSmp2KVsUZ
71C18OuDWjmejYb2sqgR5qHVoIsETbxtjt7Y11EzKecYU+O+PB7/1m46hbK01XQ6jbA+yu4e
T8/W56EO5yj1QY1vp+6ypCXva6siK5vYX8qxQzQp2mw8TnufezLR7+P5+agPCM2ni2Kbl5ry
qH4k9ISjboXb9ulW6hPvGSQh4eRxeP7x8Qj/fzm/nYRJnTo57XL/Nbkm376c3+GMPamGh53G
ZiUHaHWzgeHqouliI9LPBDUveZRoypjBVDqGk8coE15Uu4zOkwODCVXtwuMknw/6tPyrF5HK
yevxDQURgk8s8v6knyjPxYsk9/SLE/xtbq0gXgNHo9ZqkPOhg0c0Mf+6TZA75j/yc8xP74iG
kseDwdjFo/IYeJR+e8zHjvtEQAyVB6uaFxmhCVWorr6U45Gadn6de/2JNku3OQP5h7Yytb5J
Jxo+o4UhuS1MZP11z3+fnlCYxg1zL3J535GanhBuxmQCE0xNVGDoqbDaqTesi4GnX1PkUUo6
1y7RhlW/deXF0pHhh+/nQ1JaBcRYP3OxEtplDU/jYZ+MwrCLx8O4v29XbTvnF2fq/9duVHLe
49ML3hmQm0/ZGmWYqJFj4v28P1ElIglRZekyyWWqvo7XIIT2eC2Be5OfXSC8QJ0kqsvt1Xqp
PHLCjyoKSh0gg1yVobYPEIHrJs9SOkYZEpRZFjuR+BxPdF+UQ497Pez/LgkraQkvPgL8rLNC
2K/qSFqC/Krnf0bokm3s13lR1fnwek89rO+SCAuCejQmC7qf5LEYWgyQ48+vE6u6qLgSeRLt
WLaAQbMuRdSLq6UaTABdq3L4cn6pZA9G76+CVZrLSbkY4BaC+jpYeJvmvGoCmjeCh9mZti85
8zf1l+jkTLQahoPRjzwHg5dGw1A680vSeBhYcYhmvhhGMo7Vh2+JYXs+0O9CJHxR+AmHJSPf
N+iHIEEonclW18627fBrEo5pWKywJZJLr296/OPbmzBv6T5XEy4f0N0oFGCdj0dDL3xMf5ky
NGDw6pLdaoEytScibKmioENRqFR65SqGRyATMlftnMU7ysEHadBRL0r2s+QKO2nWkET7MO5G
5qgj37PKm6VJtebq+tVQOANW/3Kf5XawP7V9lufrLA2rJEgmE1JrRrLMD+MMHyqKINTiROrf
si2CFkG+FgFMtQmBH0awMQDEuRrfgmkbBUYwspaRbeGfBkWmWp3XgGoRpbCnYRdprFjHkrEt
jAoaZ9FP304YF+WPh7/q//z387383yd302pKX9ujoOFITLEibSJ0dOwfAXYgDnldet17fz3c
CZHIDs3JS8pUX+5tNaZ3AzFdNVv4qqQMO1t0wrdksbykPa1aAsvTtrsftQem3HDmK8rzbalm
ooUfIlQcmq2nmRoRGjF1/FYz6JiCWm/p7aOQyGCJdEcqLoNvq5BFWHsGKMDMV0MQYnBjYKt7
wdFNDdy2MAQlHPS71XTu6cHztntXKFNEoSG2Q3e3zFbzpMr0gNQ8Iq2YeRwluu8dAKQZrV8W
sb7WCl+mrlEuRrNtqoXZXZZQesuCQM0yjc4tmsanyxPy3euEvkSCMekSBkMJH6R7UOJzVnDS
kQRwUR3DULXV8yqSTwBmWOnJtmsQsEKOKcJ8+oxtqHjobwv6VQJIRtVSt/wboYgk8lZhnwyU
2qjRo9HvtCVzAbd1fl0E2rmCv52BhaD6ZOEzf636/ocRR/6qDaIFAqm/IeBo+Y0hl7RdqVRV
7VlJZo7+arT01TUfXx1zoREQfEktjldPGJ6Sto3fi65Ql/RL7hnrJfMljHp3KM3ZayDawEyc
mFmxy1aFEcqqpSm2KQgvKaAry0NdozUWhQQyDl+jJJouwiUmNNYymqVRbI966bmmCNtUD0N6
sDKDm747JEQGAK705F5RHFYINlyB0fYZTZluNAoH069A4itucrxydFHg0Mn9teRmnrfABEQS
YATtWzIrQVwNqeOVoVqYRBwzhyoDvtpmJTN+oke3cGcQ/Hdp2GXnBYBrwmtWpPQVh8Qba0IC
yyJU9v7VMimr3cAEeEYpqYB1ktm2zJZ8RC8MidS2w1JwQwXgb7mWrkW4z6sEGXwiTCxq7MEW
irkKIsxtV8Ef6m2IoGTxNRP55OI4u6aaqlAW3JOYFNfV3gxorhAkIcxSltvOif7h7kHLL8gb
9qusSAES3IpmVA3FGphZtiocOQAaKjfzl/hs8RXnI464NhqBxA1Gh7moByIHFXwusuRLsAvE
Kd4d4s0m4dkctBXj833N4sgRreAWSjgcmLbBsjJRTZfobshr6Yx/WbLyS7jHf0GzJDsKOG3d
JRzKaZCdSYK/G3cqTGibYxq30XBK4aMMnZlA2/7z0+ntPJuN558HSghAlXRbLqlARqL7hnjh
aOHj/fus1W/S0tiDAmBwBAErrjVB7dK0yduBt+PH/bn3nZpOIRToH12ANg73WIHEWwidvwgw
zivmGIlK0mpS0PjrKA4K1ZZrExapOmyhjGlXkdZP6tySCCHCKIsjTJZB5RehlmxK/mlmu1O8
7Wlq64m4DGoj/dlVtldgcOuuroalBtYprNj9uHGhOAhpNr22WgGITNdBShmhsZ4EwJQ6rDpD
l/jwddkKGwakrrRvwa/h0A5bTxNFzmvwGKZHSjXOBvk2SZjqNtOWbr61Xe9lDaEl+4WoilTo
7Y9vM2iKmwkJxT01t1q0Ugkr0Dm2A24XkfFRGghmLUZ/sEA2qV3VNCTxLe3k2xLcGjFWCAru
iMMrKRh2t3GDvVyTpSzYJCBXrMMUZHnmFO18OBnJ1cZBQeVrfWk2MClTisPvQklJJSUJspYA
c3jlFSahii9WVBOKG4RLNQkCFBuN4MN2AffktSTmtzTx8a3ygqNAM7KH+9tLdeGqIIuNNnjH
sxBe+LcX5yhMFmEQqOktuu9QsFUC66CqZSao6c+hcnng1OmSKIVtrAmZic0Dc1fxq3Q/MnYb
gCY0yOCLBdGShGH8DPSfu7mQD8WkNIJfu+rL1HtDiQW2I5oh4In+zXKQM8kTG46snTGSrWvK
wsJUBBqIOUEt3OLCLYbkwiZRw4PJGm4jKioDaFvXWbGhz+PUFKJQefSM35qNl4Q4+imQoz+f
DPJRRVtkFJgtPHWc7bJrFtvS8Kh2yaBeoMdSX6ghQqkpjJFIH1sQcbYAvrcNciqhE5BQSxEU
FHQqg5M4U3YwLjzzJ86G1qDpLcK3aaG+O8jf1YpzdRZrqPsuyA/zNb1GfThd1Krwt1TEKJMa
gWWoP4KuKBZbM8GaIoVU1yHbVPk1ZqJa031Cqm2OaSjdeNclmkA2m0gvIqC0GVGHR1+FHNM/
OiKKCMLf6N+lFQjKEXNLrU6hdZ7TXypVLVrhR6MCaaqVgm50s2qkGs5omKkbo1ogapiZnujC
wFGLxiAZXyhO+dToJGqqEgMzcGI8d5MOz0aDiHIrMEguDGtChyQ3iOiw1RrRfPgbNc3H9FO9
URO9Q3Si0W/0aTal7YaQKOIZLsyKNgrSqhl4ZLg9k8b4xiJeqA5q2hyY36NBuJZogx/S9Y1c
9VFm0ip+Qtc3pcFzx2gcvVINjzS4tRw3WTSraCm5RVNJPhCJsXFBUlJzsTVgPwQp3afgaRlu
i4zAFBloMGRdN0UUx1RtKxbGkW8OSWCKkEwz2uAj6KAWOaRFpNuotMFimGTvym2xidRIsYjA
Wyu1W0FMvWNv08jXHnZrQJVi3JI4uhUqnfoAX9NFWXV9pd6qaG+G0uvzePfxinZyVuxgPN3U
i6EbvAu+2oa81h06HKYIj0D0A60CyDD2qnpHhFlEw8Corn5ksODwqwrWoN2HMuOxrnLW4imG
x+XCDqcsIp8yelEEWQOiXW419dVCLIHJmZYSHKPArVkRhCn0fCsC7uY3QqLxzch7FhnVTXxf
8wUFpluX2daVXlBo2aVPX96+nZ6/fLwdX5/O98fPD8fHFzTPsOcKVgXmV3eYXzVECXNlk2xI
yizJbqiX9paC5TmDjhbkJ2uQboHOJnVdxLeUccaCPEqJ71ZjYJ0ts0J/AmppbhgZLLybFLZE
Sy/V4kapH8Tv7DpF77BfoKuQFbGe1whf7gS6VhxEH2E3p7Qk6KBvnz6JQTiKCGyA10DMTv9D
1NYxpvq+3PpIRNsWrfSUbnoGE/YJnWzvz389//Hz8HT44/F8uH85Pf/xdvh+hHpO939grp4f
yJY+SS61Ob4+Hx97D4fX+6Mwi+64lTQeOT6dX3/2Ts8n9MY7/ftQu/W2Y4tK3E0wJzjJCoNE
BEZIwh2sJI+yKZZwUOgEnVkJ3XiDdve9da43eXDT+B42gbhxUJiWDBRfu9JrsCRM/PzGhO7V
2B8SlF+ZEIwlPwGG6mdKuinBofEElm9Wrz9f3s+9u/PrsXd+7UmG002xJIaJXGmh/DSwZ8ND
FpBAm5Rv/Chfq+zRQNhF1lpkdgVokxZqvPAORhK2mpPVcWdPmKvzmzy3qTd5bteAl5o2KUgb
bEXUW8PtAvq7u07d3lcIWwmLarUceLNkG1uIdBvTQLt58Yf45OJyWo9vIzHYFUqBl9g2I4V8
Wvv49ni6+/yv48/enVitP14PLw8/rUVacGb1ILBXSqharLWwYE30MvSLgDOSczYD3xa70BuP
9fRC0tDz4/0B/XjuDu/H+174LPqODlB/nd4feuzt7Xx3Eqjg8H6wBuP7if2lCJi/BqGNef08
i2/QI5QYBQtXEea5cc83D6+iHTn+NQNOubPGthDhFFBEebN7vrDn118ubFhpr1ifWJ+hb5eN
i2sLlhFt5FRn9nqoimZ3hjfXBSMj1NYrf63MsTHDmCig3NpfB1+1ds06Xh/eHlxzljC7n2sK
uKdGtJOUjePZ8e3dbqHwhx7xYRBsN7IneewiZpvQWxCTJzHkTWLbTjnoB9HSXtRkU86pToIR
ASPoIli7wkbdHnSRBANvRgwDEY5AGh2FN6avWzqKIenS1Oy1NRtYPQIgVEuBxwPizFyzoQ1M
CBiaNS0y+wwsV8Vg7hEzcJ2Pdbd3KSScXh40w92Ws9jbFWCV/oTXINLtgvQObvCFb39aEJOu
lxG5FiXCuhtvFhxLwjiO7BPBZzLAvJFSWcGS0Qw69IQoFpjWQTp6Kf66q92s2S0LiHo5izm7
tJoa9k+VpW27W2yRazFI22U0IuoqQ0qlapDXGfmJang32XItnZ9e0HNSk+TbaVzGuhVJze5v
Mws2G9kbQ3uv7WBrmwXUr7HSYfDwfH9+6qUfT9+Or02MoCZ+kLmGeVT5eUGaFzaDKBarJisN
gVkbGbE0nPNVRCHy6aePjsJq92uEOWVDdLZSFQlFdKwo6b5BNAK32ZsW34jq7m61pIWRzcZA
o45wYc3iAxQp+Tcm16pK83j69noABe71/PF+eiYO3ThakBxMwCUzMjuKqF+edUgk92XjB+ao
SRJd+uCCihQxbbrAMZTmKAX5GK0CBpdILve3Iftljw2Z9HK/HWff2pbw0BVmHS3TajrXM3ZT
+OryJgVSViYyYivZkMRKZYFqSOKx8/3RBeaIpG1qLBuFl1F7P7T1LET6vrRKJptP4mwV+dVq
T8Yn5TdJEuI1qrh6LW9y/VqhQebbRVzT8O2iJuueIzvCMk9UKqLJ/bg/r/wQRrpEY6SwdlJR
68s3Pp+hrfYO8Vid05EFSafARTnHJx66qqnQIrEe+uIxWuE9bR5KIyVhAkeYSUmWgfGevgtV
7a33/fzaezv9eJYe1HcPx7t/nZ5/KF5LGEMUbWzEvfafn+6g8NsXLAFkFaip/3w5PrWPrnV2
HuW+XM9iZuP5n5/UG1+JD/dlwdT5dV22ZmnAihuzPZpaVg0MDTO985ImbqyKf2OKmjEtohT7
IKzylw1bjp38WF5T5VpOvAZWLcLUhzPzfyo7lt3GbeB9v2KPLdAumqDYtoccZIm2tZZFRY84
8UVIs0YQbJMGiQPs53celDRDUs72lHhmRJEU50FyHnXsOqfIS5PUPbmHCuGHQctqjhc5GMJY
rk5wwRCiWxr0Ms7lNfqAWuZlhpWQYGYWuQr2qjMV0FqjR1/ZbReqIh5fdSRF2DDW7hvitEbW
ToHfQVEr0NlnTRHuodI+b7teP6V3dPAzcofk4MD9ZnHj7YUEJn6L60iSeje3EJkCZi0qGdPP
yk7Tdn8q7kBBP4Qb11Rk+/J3qlj5qRVqbPwUZWa30YkAO3L0QNVQ9jjUcPQYRGNDm6l71r8e
FKzWSMsIjbUMdmqUGqzXODzeP7BrI+QEjtFf7/tMp3pgSH89UzHdoSlUuoon2HMkeTKT4NXh
kzp2KToh2zUwlN/THmuLpQF0kX4JYF6F1XHw/WovsysIxAIQ51FMsVflWyfE9X6G3s7AxVIf
pIG8ZxzWK+zd+sYWVm1tJRRbldJhka7VD6oe0FIOc+m6R9FTV0nhBTwlTWPTHOTVlYGprxOx
SwD+Qlkla9AhSNWzLbFjVIY3qchK96oJQ1+LpMZ7qjXtQ8SLa+gqtteYtqu4uLCMfZvweJ+B
6OWYQ+s9qrTqIiSIxWpfkc4gqrTlgMDM9pXGjqjK2kKjahNQuwirATPdugEOdzuzF6GrgheF
aO5SqpHCqkM4/D1KtqjXg47YGBdea7e5lsXFvm8T1XheX6LhH7Myt1Wu3PHhx1Kmk8FMAjUe
PrcytqBZebNHN3iZqWQhwQZUhzdr6BVQrqLjFAmWPBtDXzMOhhxBn18eno7fOJHQ4+H1PnSV
IPtl07vwgsn2ZDC6AMb3vMB5lgIyVwVYHcV4sfTHLMVll5v24vdxYp3dG7QwUmAhw6EjmSkk
w2Y3ZQKf1XcmVmDvohHs/IXFjYCpa6BSeeNnp2k8zXn45/Dr8eHR2YGvRHrH8JdwUvn9br8e
wDAusUuNOgsT2EGQmniAhaBsqiKPR1cIomyX1Mu4klplwFJpnVfR6GJT0oXatsOzRB0KvgSB
aygI9eLPs7/OP4jVW4GcxUQYW+3ybpKMWgNk5FVrg5l9MAoT+EReyPE4wOInL6Ft3myTVioB
H0N96m2pnRa4FXYjYOdcQ5Izvgf40a/9QZZ2c+yXHf5+u6faq/nT6/Hl7VFXSt8muJ2FLYnM
YCSA4y09z/3Fb9/PplFIutmKpW6oMgNsQvoO5mYD31tOC/6eCbxpkjI6OT80XN0XduIIPweG
wgV7VOePMLYr5BTKCtggYkEDfarNzSGe9Elso43P2l0pr48JVtm8saUXcq4xoCxdGP5cwxPp
3tQBwxNJbZY+nCNxm3AgDnFK12nCpXeAorFcVPGEkBgI0Yvs3XfVaUfMOjMaF7MUZgrRVE6y
DAJ/PK1rim4xkErPKAR756K0qt0CA7utAK4O52DAnBg9e9Z0qIliRgrIvczRGNgne2Jwsreo
rattX61aYtygK1fxuG3/wdkPwDW/yKUnOgnURwxKX6oI95PINKXObxJY3+F2ksH06MVZ4DE0
cWgwo2vMtOYzNtF/tP8+v/7yEasIvD2zVF3fPt2rFDAV8FqKXksWbOQoywk8JozpzBQwykhc
8rZrATzZVXbZojMSmt+uqtDM90Bkv+6Am9ukiTHE7hKUDKiazCqpQcd0/Iqo5Dw9AezPCtrm
6xuqmIj846Xo2TsM1HYGwQZumfy0Im37Xw7nbWOMnzvTF7Qgbrb6oo+PvtBbYlIIP70+Pzyh
BwWM9/HtePh+gH8Ox7tPnz79LFLEkq8ftku1uqdAo9EMhWUbywvCiDrZcRMlzP5ct4kAJ2SW
uWrYBnWtuZbna24xu6K3PnyGfLdjDIgsu9P+t+5Nu0ZFmTGUeuhthsgN01ShJHGI2cHwhgd6
YOaexpmmKy2nYeLagToFfNJipNOMIprGG0mg9n8WxNBgS/FjIECWRSI9sUkMEVIOiYw9mLe+
K/EiGFiBz8BOrN4N66AZ+fSNzZqvt8fbj2jP3OHRb2DX+9kzHF8geParyFq3DKEcMbk6TGXF
12dJi7twSnTtZc8+2U2/RynsM9hfNsxJB4o8amUxW6XiUEEuAWXSgymACU/n1gbivWcFBq0E
svVHaX1+ptumrz3TrrmUIXBDpls1JI8xL535Xw9HJt5ccUoisC/x3CU2HDz2LNOb1orzj9JW
3E1h6fAKTr1YW2Q5v1ImFRQienWOD39a7AfnqA3ad+IXTywIBdZnKQ2joD0HiAVxLoM5nhRm
gqlDw3Vz+3IXWzdnnzfEokrnaFp5StEeXo8oE1ABplgH9/b+II2ATVdGT9UHnsE9POWk/8L7
PzE92ziRHLZdkrvwfIuxN5uWkxS+07ZLzTJ0LHZywlYXGFepvXLLRWe/rMF4xsuWlpUa+VnE
TqbM1he5J6c3cOrmk6L/AFNx4xoC9QEA

--HcAYCG3uE/tztfnV--
