Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95575C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DCB020663
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgG0MG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:06:28 -0400
Received: from mga18.intel.com ([134.134.136.126]:26523 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726555AbgG0MG1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:06:27 -0400
IronPort-SDR: uKZ5x463+aTKQEd0s5AHoR0Qh4FS8+8XIdUFoo5rX5x0pfbcULEq/h21M2njBu/2Wm7+xt6sI/
 q+O/jyWp5dbQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9694"; a="138509039"
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="gz'50?scan'50,208,50";a="138509039"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga007.jf.intel.com ([10.7.209.58])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 27 Jul 2020 05:05:29 -0700
IronPort-SDR: 6A+TKlD1n0c51bAuP5JJrbNfHqnDb2S4BJ3fgR5g4vhFA6B/cQE2Dp8MteOGlTfw4QA4FzV0FL
 7g02s7qbJmEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,402,1589266800"; 
   d="gz'50?scan'50,208,50";a="329658067"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by orsmga007.jf.intel.com with ESMTP; 27 Jul 2020 05:05:27 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k01sk-0001uo-Ka; Mon, 27 Jul 2020 12:05:26 +0000
Date:   Mon, 27 Jul 2020 20:05:08 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/uio/uio_fsl_elbc_gpcm.c:86:53: sparse: sparse: incorrect
 type in initializer (different address spaces)
Message-ID: <202007272001.sFfX5mtz%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   92ed301919932f777713b9172e525674157e983d
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: powerpc64-randconfig-s032-20200727 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-94-geb6779f6-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/uio/uio_fsl_elbc_gpcm.c:86:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_lbc_bank *bank @@     got struct fsl_lbc_bank [noderef] __iomem * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:86:53: sparse:     expected struct fsl_lbc_bank *bank
>> drivers/uio/uio_fsl_elbc_gpcm.c:86:53: sparse:     got struct fsl_lbc_bank [noderef] __iomem *
>> drivers/uio/uio_fsl_elbc_gpcm.c:90:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 * @@
>> drivers/uio/uio_fsl_elbc_gpcm.c:90:43: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:90:43: sparse:     got restricted __be32 *
   drivers/uio/uio_fsl_elbc_gpcm.c:94:43: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:94:43: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:94:43: sparse:     got restricted __be32 *
   drivers/uio/uio_fsl_elbc_gpcm.c:105:53: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct fsl_lbc_bank *bank @@     got struct fsl_lbc_bank [noderef] __iomem * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:105:53: sparse:     expected struct fsl_lbc_bank *bank
   drivers/uio/uio_fsl_elbc_gpcm.c:105:53: sparse:     got struct fsl_lbc_bank [noderef] __iomem *
   drivers/uio/uio_fsl_elbc_gpcm.c:117:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:117:31: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:117:31: sparse:     got restricted __be32 *
   drivers/uio/uio_fsl_elbc_gpcm.c:118:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:118:31: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:118:31: sparse:     got restricted __be32 *
>> drivers/uio/uio_fsl_elbc_gpcm.c:132:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 * @@
>> drivers/uio/uio_fsl_elbc_gpcm.c:132:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:132:27: sparse:     got restricted __be32 *
   drivers/uio/uio_fsl_elbc_gpcm.c:140:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:140:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:140:27: sparse:     got restricted __be32 *
>> drivers/uio/uio_fsl_elbc_gpcm.c:347:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:347:46: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> drivers/uio/uio_fsl_elbc_gpcm.c:347:46: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/uio/uio_fsl_elbc_gpcm.c:348:46: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:348:46: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:348:46: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/uio/uio_fsl_elbc_gpcm.c:378:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:378:34: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:378:34: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/uio/uio_fsl_elbc_gpcm.c:379:34: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/uio/uio_fsl_elbc_gpcm.c:379:34: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/uio/uio_fsl_elbc_gpcm.c:379:34: sparse:     got restricted __be32 [noderef] __iomem *
--
>> arch/powerpc/platforms/powermac/nvram.c:304:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *s @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:304:24: sparse:     expected void const *s
>> arch/powerpc/platforms/powermac/nvram.c:304:24: sparse:     got unsigned char [noderef] [usertype] __iomem *base
>> arch/powerpc/platforms/powermac/nvram.c:338:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse:     expected void const *
   arch/powerpc/platforms/powermac/nvram.c:338:20: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const *s @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse:     expected void const *s
   arch/powerpc/platforms/powermac/nvram.c:384:24: sparse:     got unsigned char [noderef] [usertype] __iomem *base
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const * @@     got unsigned char [noderef] [usertype] __iomem *base @@
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse:     expected void const *
   arch/powerpc/platforms/powermac/nvram.c:429:20: sparse:     got unsigned char [noderef] [usertype] __iomem *base
>> arch/powerpc/platforms/powermac/nvram.c:480:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:526:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:527:35: sparse: sparse: cast removes address space '__iomem' of expression
   arch/powerpc/platforms/powermac/nvram.c:534:44: sparse: sparse: dereference of noderef expression

vim +86 drivers/uio/uio_fsl_elbc_gpcm.c

0682e005d1705a Greg Kroah-Hartman 2019-07-31   80  
fbc4a8a85777e0 John Ogness        2014-12-09   81  static ssize_t reg_show(struct device *dev, struct device_attribute *attr,
fbc4a8a85777e0 John Ogness        2014-12-09   82  			char *buf)
fbc4a8a85777e0 John Ogness        2014-12-09   83  {
24438e46268c72 Wolfram Sang       2018-10-21   84  	struct uio_info *info = dev_get_drvdata(dev);
fbc4a8a85777e0 John Ogness        2014-12-09   85  	struct fsl_elbc_gpcm *priv = info->priv;
fbc4a8a85777e0 John Ogness        2014-12-09  @86  	struct fsl_lbc_bank *bank = &priv->lbc->bank[priv->bank];
fbc4a8a85777e0 John Ogness        2014-12-09   87  
fbc4a8a85777e0 John Ogness        2014-12-09   88  	if (attr == &dev_attr_reg_br) {
fbc4a8a85777e0 John Ogness        2014-12-09   89  		return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
fbc4a8a85777e0 John Ogness        2014-12-09  @90  				 in_be32(&bank->br));
fbc4a8a85777e0 John Ogness        2014-12-09   91  
fbc4a8a85777e0 John Ogness        2014-12-09   92  	} else if (attr == &dev_attr_reg_or) {
fbc4a8a85777e0 John Ogness        2014-12-09   93  		return scnprintf(buf, PAGE_SIZE, "0x%08x\n",
fbc4a8a85777e0 John Ogness        2014-12-09   94  				 in_be32(&bank->or));
fbc4a8a85777e0 John Ogness        2014-12-09   95  	}
fbc4a8a85777e0 John Ogness        2014-12-09   96  
fbc4a8a85777e0 John Ogness        2014-12-09   97  	return 0;
fbc4a8a85777e0 John Ogness        2014-12-09   98  }
fbc4a8a85777e0 John Ogness        2014-12-09   99  
fbc4a8a85777e0 John Ogness        2014-12-09  100  static ssize_t reg_store(struct device *dev, struct device_attribute *attr,
fbc4a8a85777e0 John Ogness        2014-12-09  101  			 const char *buf, size_t count)
fbc4a8a85777e0 John Ogness        2014-12-09  102  {
24438e46268c72 Wolfram Sang       2018-10-21  103  	struct uio_info *info = dev_get_drvdata(dev);
fbc4a8a85777e0 John Ogness        2014-12-09  104  	struct fsl_elbc_gpcm *priv = info->priv;
fbc4a8a85777e0 John Ogness        2014-12-09 @105  	struct fsl_lbc_bank *bank = &priv->lbc->bank[priv->bank];
fbc4a8a85777e0 John Ogness        2014-12-09  106  	unsigned long val;
fbc4a8a85777e0 John Ogness        2014-12-09  107  	u32 reg_br_cur;
fbc4a8a85777e0 John Ogness        2014-12-09  108  	u32 reg_or_cur;
fbc4a8a85777e0 John Ogness        2014-12-09  109  	u32 reg_new;
fbc4a8a85777e0 John Ogness        2014-12-09  110  
fbc4a8a85777e0 John Ogness        2014-12-09  111  	/* parse use input */
fbc4a8a85777e0 John Ogness        2014-12-09  112  	if (kstrtoul(buf, 0, &val) != 0)
fbc4a8a85777e0 John Ogness        2014-12-09  113  		return -EINVAL;
fbc4a8a85777e0 John Ogness        2014-12-09  114  	reg_new = (u32)val;
fbc4a8a85777e0 John Ogness        2014-12-09  115  
fbc4a8a85777e0 John Ogness        2014-12-09  116  	/* read current values */
fbc4a8a85777e0 John Ogness        2014-12-09  117  	reg_br_cur = in_be32(&bank->br);
fbc4a8a85777e0 John Ogness        2014-12-09 @118  	reg_or_cur = in_be32(&bank->or);
fbc4a8a85777e0 John Ogness        2014-12-09  119  
fbc4a8a85777e0 John Ogness        2014-12-09  120  	if (attr == &dev_attr_reg_br) {
fbc4a8a85777e0 John Ogness        2014-12-09  121  		/* not allowed to change effective base address */
fbc4a8a85777e0 John Ogness        2014-12-09  122  		if ((reg_br_cur & reg_or_cur & BR_BA) !=
fbc4a8a85777e0 John Ogness        2014-12-09  123  		    (reg_new & reg_or_cur & BR_BA)) {
fbc4a8a85777e0 John Ogness        2014-12-09  124  			return -EINVAL;
fbc4a8a85777e0 John Ogness        2014-12-09  125  		}
fbc4a8a85777e0 John Ogness        2014-12-09  126  
fbc4a8a85777e0 John Ogness        2014-12-09  127  		/* not allowed to change mode */
fbc4a8a85777e0 John Ogness        2014-12-09  128  		if ((reg_new & BR_MSEL) != BR_MS_GPCM)
fbc4a8a85777e0 John Ogness        2014-12-09  129  			return -EINVAL;
fbc4a8a85777e0 John Ogness        2014-12-09  130  
fbc4a8a85777e0 John Ogness        2014-12-09  131  		/* write new value (force valid) */
fbc4a8a85777e0 John Ogness        2014-12-09 @132  		out_be32(&bank->br, reg_new | BR_V);
fbc4a8a85777e0 John Ogness        2014-12-09  133  
fbc4a8a85777e0 John Ogness        2014-12-09  134  	} else if (attr == &dev_attr_reg_or) {
fbc4a8a85777e0 John Ogness        2014-12-09  135  		/* not allowed to change access mask */
fbc4a8a85777e0 John Ogness        2014-12-09  136  		if ((reg_or_cur & OR_GPCM_AM) != (reg_new & OR_GPCM_AM))
fbc4a8a85777e0 John Ogness        2014-12-09  137  			return -EINVAL;
fbc4a8a85777e0 John Ogness        2014-12-09  138  
fbc4a8a85777e0 John Ogness        2014-12-09  139  		/* write new value */
fbc4a8a85777e0 John Ogness        2014-12-09 @140  		out_be32(&bank->or, reg_new);
fbc4a8a85777e0 John Ogness        2014-12-09  141  
fbc4a8a85777e0 John Ogness        2014-12-09  142  	} else {
fbc4a8a85777e0 John Ogness        2014-12-09  143  		return -EINVAL;
fbc4a8a85777e0 John Ogness        2014-12-09  144  	}
fbc4a8a85777e0 John Ogness        2014-12-09  145  
fbc4a8a85777e0 John Ogness        2014-12-09  146  	return count;
fbc4a8a85777e0 John Ogness        2014-12-09  147  }
fbc4a8a85777e0 John Ogness        2014-12-09  148  

:::::: The code at line 86 was first introduced by commit
:::::: fbc4a8a85777e065f7a195ddc58b3245808f1e87 uio: uio_fsl_elbc_gpcm: new driver

:::::: TO: John Ogness <john.ogness@linutronix.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
3Yi/fZMzPt/1AQA=

--gKMricLos+KVdGMg--
