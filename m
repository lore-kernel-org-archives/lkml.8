Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9FDBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:10:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A54202075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 10:10:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728423AbgHKKKP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 06:10:15 -0400
Received: from mga18.intel.com ([134.134.136.126]:6713 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728258AbgHKKKO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 06:10:14 -0400
IronPort-SDR: /BAVawLNKkmgL6i+r0s0jtvvBZklPeXd5ZfUxvUGobynMzX1HGjZ7AecHjXwQyHmK7kC8qXlZv
 RAOtLlxSlJ5Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="141315660"
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="gz'50?scan'50,208,50";a="141315660"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 03:03:47 -0700
IronPort-SDR: J0zevpzk9jnYViK7EvS7W9+xlk0ty3cziLVVoLP1xW+nXB5MiGxpFuEnMXes199Aj97S/5AsH5
 LrERA2+yC3mA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,460,1589266800"; 
   d="gz'50?scan'50,208,50";a="294671634"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 11 Aug 2020 03:03:45 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5R8C-0000Vc-OY; Tue, 11 Aug 2020 10:03:44 +0000
Date:   Tue, 11 Aug 2020 18:03:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/mips/sgi-ip22/ip22-mc.c:80:18: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202008111829.1H0oc5ru%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wRRV7LY7NUeQGEoC"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wRRV7LY7NUeQGEoC
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00e4db51259a5f936fec1424b884f029479d3981
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: mips-randconfig-s032-20200811 (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-168-g9554805c-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/mips/sgi-ip22/ip22-mc.c:80:18: sparse: sparse: cast removes address space '__iomem' of expression
--
>> arch/mips/sgi-ip22/ip22-hpc.c:35:19: sparse: sparse: cast removes address space '__iomem' of expression
   arch/mips/sgi-ip22/ip22-hpc.c:37:19: sparse: sparse: cast removes address space '__iomem' of expression
--
>> arch/mips/sgi-ip22/ip22-time.c:48:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
>> arch/mips/sgi-ip22/ip22-time.c:48:64: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-time.c:48:64: sparse:     got unsigned char volatile *
>> arch/mips/sgi-ip22/ip22-time.c:49:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
>> arch/mips/sgi-ip22/ip22-time.c:49:31: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-time.c:49:31: sparse:     got unsigned char volatile *
   arch/mips/sgi-ip22/ip22-time.c:50:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   arch/mips/sgi-ip22/ip22-time.c:50:30: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-time.c:50:30: sparse:     got unsigned char volatile *
   arch/mips/sgi-ip22/ip22-time.c:56:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   arch/mips/sgi-ip22/ip22-time.c:56:17: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-time.c:56:17: sparse:     got unsigned char volatile *
--
>> arch/mips/sgi-ip22/ip22-nvram.c:82:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
>> arch/mips/sgi-ip22/ip22-nvram.c:82:34: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:82:34: sparse:     got unsigned int *ctrl
>> arch/mips/sgi-ip22/ip22-nvram.c:82:57: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
>> arch/mips/sgi-ip22/ip22-nvram.c:82:57: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:82:57: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:83:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:88:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:88:42: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:88:42: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:88:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:88:64: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:88:64: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:90:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:90:42: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:90:42: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:90:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:90:63: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:90:63: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:93:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:93:33: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:93:33: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:97:9: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:64:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:64:50: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:64:50: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:64:71: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:64:71: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:64:71: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:66:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:66:50: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:66:50: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:66:72: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:66:72: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:66:72: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:67:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:67:42: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:67:42: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:67:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:67:64: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:67:64: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:69:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:69:42: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:69:42: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:69:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:69:63: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:69:63: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:74:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:74:34: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:74:34: sparse:     got unsigned int *ctrl
   arch/mips/sgi-ip22/ip22-nvram.c:74:56: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int *ctrl @@
   arch/mips/sgi-ip22/ip22-nvram.c:74:56: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/sgi-ip22/ip22-nvram.c:74:56: sparse:     got unsigned int *ctrl

vim +/__iomem +80 arch/mips/sgi-ip22/ip22-mc.c

^1da177e4c3f41 Linus Torvalds      2005-04-16   74  
^1da177e4c3f41 Linus Torvalds      2005-04-16   75  void __init sgimc_init(void)
^1da177e4c3f41 Linus Torvalds      2005-04-16   76  {
^1da177e4c3f41 Linus Torvalds      2005-04-16   77  	u32 tmp;
^1da177e4c3f41 Linus Torvalds      2005-04-16   78  
^1da177e4c3f41 Linus Torvalds      2005-04-16   79  	/* ioremap can't fail */
^1da177e4c3f41 Linus Torvalds      2005-04-16  @80  	sgimc = (struct sgimc_regs *)
^1da177e4c3f41 Linus Torvalds      2005-04-16   81  		ioremap(SGIMC_BASE, sizeof(struct sgimc_regs));
^1da177e4c3f41 Linus Torvalds      2005-04-16   82  
^1da177e4c3f41 Linus Torvalds      2005-04-16   83  	printk(KERN_INFO "MC: SGI memory controller Revision %d\n",
^1da177e4c3f41 Linus Torvalds      2005-04-16   84  	       (int) sgimc->systemid & SGIMC_SYSID_MASKREV);
^1da177e4c3f41 Linus Torvalds      2005-04-16   85  
^1da177e4c3f41 Linus Torvalds      2005-04-16   86  	/* Place the MC into a known state.  This must be done before
^1da177e4c3f41 Linus Torvalds      2005-04-16   87  	 * interrupts are first enabled etc.
^1da177e4c3f41 Linus Torvalds      2005-04-16   88  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16   89  
^1da177e4c3f41 Linus Torvalds      2005-04-16   90  	/* Step 0: Make sure we turn off the watchdog in case it's
^1da177e4c3f41 Linus Torvalds      2005-04-16   91  	 *	   still running (which might be the case after a
^1da177e4c3f41 Linus Torvalds      2005-04-16   92  	 *	   soft reboot).
^1da177e4c3f41 Linus Torvalds      2005-04-16   93  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16   94  	tmp = sgimc->cpuctrl0;
^1da177e4c3f41 Linus Torvalds      2005-04-16   95  	tmp &= ~SGIMC_CCTRL0_WDOG;
^1da177e4c3f41 Linus Torvalds      2005-04-16   96  	sgimc->cpuctrl0 = tmp;
^1da177e4c3f41 Linus Torvalds      2005-04-16   97  
^1da177e4c3f41 Linus Torvalds      2005-04-16   98  	/* Step 1: The CPU/GIO error status registers will not latch
^1da177e4c3f41 Linus Torvalds      2005-04-16   99  	 *	   up a new error status until the register has been
^1da177e4c3f41 Linus Torvalds      2005-04-16  100  	 *	   cleared by the cpu.	These status registers are
^1da177e4c3f41 Linus Torvalds      2005-04-16  101  	 *	   cleared by writing any value to them.
^1da177e4c3f41 Linus Torvalds      2005-04-16  102  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  103  	sgimc->cstat = sgimc->gstat = 0;
^1da177e4c3f41 Linus Torvalds      2005-04-16  104  
^1da177e4c3f41 Linus Torvalds      2005-04-16  105  	/* Step 2: Enable all parity checking in cpu control register
^1da177e4c3f41 Linus Torvalds      2005-04-16  106  	 *	   zero.
^1da177e4c3f41 Linus Torvalds      2005-04-16  107  	 */
e2defae5a9b4f8 Thomas Bogendoerfer 2007-12-02  108  	/* don't touch parity settings for IP28 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  109  	tmp = sgimc->cpuctrl0;
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  110  #ifndef CONFIG_SGI_IP28
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  111  	tmp |= SGIMC_CCTRL0_EPERRGIO | SGIMC_CCTRL0_EPERRMEM;
e2defae5a9b4f8 Thomas Bogendoerfer 2007-12-02  112  #endif
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  113  	tmp |= SGIMC_CCTRL0_R4KNOCHKPARR;
^1da177e4c3f41 Linus Torvalds      2005-04-16  114  	sgimc->cpuctrl0 = tmp;
^1da177e4c3f41 Linus Torvalds      2005-04-16  115  
^1da177e4c3f41 Linus Torvalds      2005-04-16  116  	/* Step 3: Setup the MC write buffer depth, this is controlled
^1da177e4c3f41 Linus Torvalds      2005-04-16  117  	 *	   in cpu control register 1 in the lower 4 bits.
^1da177e4c3f41 Linus Torvalds      2005-04-16  118  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  119  	tmp = sgimc->cpuctrl1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  120  	tmp &= ~0xf;
^1da177e4c3f41 Linus Torvalds      2005-04-16  121  	tmp |= 0xd;
^1da177e4c3f41 Linus Torvalds      2005-04-16  122  	sgimc->cpuctrl1 = tmp;
^1da177e4c3f41 Linus Torvalds      2005-04-16  123  
^1da177e4c3f41 Linus Torvalds      2005-04-16  124  	/* Step 4: Initialize the RPSS divider register to run as fast
^1da177e4c3f41 Linus Torvalds      2005-04-16  125  	 *	   as it can correctly operate.	 The register is laid
^1da177e4c3f41 Linus Torvalds      2005-04-16  126  	 *	   out as follows:
^1da177e4c3f41 Linus Torvalds      2005-04-16  127  	 *
^1da177e4c3f41 Linus Torvalds      2005-04-16  128  	 *	   ----------------------------------------
^1da177e4c3f41 Linus Torvalds      2005-04-16  129  	 *	   |  RESERVED	|   INCREMENT	| DIVIDER |
^1da177e4c3f41 Linus Torvalds      2005-04-16  130  	 *	   ----------------------------------------
^1da177e4c3f41 Linus Torvalds      2005-04-16  131  	 *	    31	      16 15	       8 7	 0
^1da177e4c3f41 Linus Torvalds      2005-04-16  132  	 *
^1da177e4c3f41 Linus Torvalds      2005-04-16  133  	 *	   DIVIDER determines how often a 'tick' happens,
^1da177e4c3f41 Linus Torvalds      2005-04-16  134  	 *	   INCREMENT determines by how the RPSS increment
^1da177e4c3f41 Linus Torvalds      2005-04-16  135  	 *	   registers value increases at each 'tick'. Thus,
^1da177e4c3f41 Linus Torvalds      2005-04-16  136  	 *	   for IP22 we get INCREMENT=1, DIVIDER=1 == 0x101
^1da177e4c3f41 Linus Torvalds      2005-04-16  137  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  138  	sgimc->divider = 0x101;
^1da177e4c3f41 Linus Torvalds      2005-04-16  139  
^1da177e4c3f41 Linus Torvalds      2005-04-16  140  	/* Step 5: Initialize GIO64 arbitrator configuration register.
^1da177e4c3f41 Linus Torvalds      2005-04-16  141  	 *
^1da177e4c3f41 Linus Torvalds      2005-04-16  142  	 * NOTE: HPC init code in sgihpc_init() must run before us because
^1da177e4c3f41 Linus Torvalds      2005-04-16  143  	 *	 we need to know Guiness vs. FullHouse and the board
^1da177e4c3f41 Linus Torvalds      2005-04-16  144  	 *	 revision on this machine. You have been warned.
^1da177e4c3f41 Linus Torvalds      2005-04-16  145  	 */
^1da177e4c3f41 Linus Torvalds      2005-04-16  146  
^1da177e4c3f41 Linus Torvalds      2005-04-16  147  	/* First the basic invariants across all GIO64 implementations. */
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  148  	tmp = sgimc->giopar & SGIMC_GIOPAR_GFX64; /* keep gfx 64bit settings */
e84de0c6190503 Thomas Bogendoerfer 2011-11-22  149  	tmp |= SGIMC_GIOPAR_HPC64;	/* All 1st HPC's interface at 64bits */
^1da177e4c3f41 Linus Torvalds      2005-04-16  150  	tmp |= SGIMC_GIOPAR_ONEBUS;	/* Only one physical GIO bus exists */
^1da177e4c3f41 Linus Torvalds      2005-04-16  151  
^1da177e4c3f41 Linus Torvalds      2005-04-16  152  	if (ip22_is_fullhouse()) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  153  		/* Fullhouse specific settings. */
^1da177e4c3f41 Linus Torvalds      2005-04-16  154  		if (SGIOC_SYSID_BOARDREV(sgioc->sysid) < 2) {
^1da177e4c3f41 Linus Torvalds      2005-04-16  155  			tmp |= SGIMC_GIOPAR_HPC264;	/* 2nd HPC at 64bits */
^1da177e4c3f41 Linus Torvalds      2005-04-16  156  			tmp |= SGIMC_GIOPAR_PLINEEXP0;	/* exp0 pipelines */
^1da177e4c3f41 Linus Torvalds      2005-04-16  157  			tmp |= SGIMC_GIOPAR_MASTEREXP1; /* exp1 masters */
^1da177e4c3f41 Linus Torvalds      2005-04-16  158  			tmp |= SGIMC_GIOPAR_RTIMEEXP0;	/* exp0 is realtime */
^1da177e4c3f41 Linus Torvalds      2005-04-16  159  		} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16  160  			tmp |= SGIMC_GIOPAR_HPC264;	/* 2nd HPC 64bits */
^1da177e4c3f41 Linus Torvalds      2005-04-16  161  			tmp |= SGIMC_GIOPAR_PLINEEXP0;	/* exp[01] pipelined */
^1da177e4c3f41 Linus Torvalds      2005-04-16  162  			tmp |= SGIMC_GIOPAR_PLINEEXP1;
^1da177e4c3f41 Linus Torvalds      2005-04-16  163  			tmp |= SGIMC_GIOPAR_MASTEREISA; /* EISA masters */
^1da177e4c3f41 Linus Torvalds      2005-04-16  164  		}
^1da177e4c3f41 Linus Torvalds      2005-04-16  165  	} else {
^1da177e4c3f41 Linus Torvalds      2005-04-16  166  		/* Guiness specific settings. */
^1da177e4c3f41 Linus Torvalds      2005-04-16  167  		tmp |= SGIMC_GIOPAR_EISA64;	/* MC talks to EISA at 64bits */
^1da177e4c3f41 Linus Torvalds      2005-04-16  168  		tmp |= SGIMC_GIOPAR_MASTEREISA; /* EISA bus can act as master */
^1da177e4c3f41 Linus Torvalds      2005-04-16  169  	}
^1da177e4c3f41 Linus Torvalds      2005-04-16  170  	sgimc->giopar = tmp;	/* poof */
^1da177e4c3f41 Linus Torvalds      2005-04-16  171  
^1da177e4c3f41 Linus Torvalds      2005-04-16  172  	probe_memory();
^1da177e4c3f41 Linus Torvalds      2005-04-16  173  }
^1da177e4c3f41 Linus Torvalds      2005-04-16  174  

:::::: The code at line 80 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--wRRV7LY7NUeQGEoC
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--wRRV7LY7NUeQGEoC--
