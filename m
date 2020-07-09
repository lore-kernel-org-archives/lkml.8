Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DDCA8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A4B2D20663
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 10:12:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726721AbgGIKMO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 06:12:14 -0400
Received: from mga06.intel.com ([134.134.136.31]:3086 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726302AbgGIKMN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 06:12:13 -0400
IronPort-SDR: MSNRvSugnOO8NxzjPwzxTC7XB2eygXrDYfKfhBaU0SxzHnEo9K+uycpC4d48/iR4A+fDHNuyTz
 RohCL9R6p96g==
X-IronPort-AV: E=McAfee;i="6000,8403,9676"; a="209501709"
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="209501709"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 03:11:00 -0700
IronPort-SDR: jJq21yl1XQHD1ZSjYzZmKF6SMy4oggTvsL1Xxvp9ggT+kkY6um4NVbYWh76Wh9fGa1zpO7AdY2
 83cSRmzWCMKQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,331,1589266800"; 
   d="gz'50?scan'50,208,50";a="268717044"
Received: from lkp-server01.sh.intel.com (HELO 6136dd46483e) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 09 Jul 2020 03:10:58 -0700
Received: from kbuild by 6136dd46483e with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtTW5-0000YW-IC; Thu, 09 Jul 2020 10:10:57 +0000
Date:   Thu, 9 Jul 2020 18:10:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/watchdog/wdt_pci.c:103:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007091832.ZlgoZTeH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="OXfL5xGRrasGEqWY"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--OXfL5xGRrasGEqWY
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: riscv-randconfig-s031-20200709 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/watchdog/wdt_pci.c:103:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/watchdog/wdt_pci.c:103:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/watchdog/wdt_pci.c:103:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:103:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:109:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:111:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/watchdog/wdt_pci.c:131:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/watchdog/wdt_pci.c:131:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:131:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:135:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:135:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:137:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:137:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:137:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:137:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:139:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:139:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:139:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:141:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:141:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:141:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:143:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:143:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:143:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:143:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:145:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:145:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:147:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:147:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:158:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:158:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:177:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:177:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:177:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:197:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:197:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:197:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:197:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:202:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:202:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:202:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:202:9: sparse:     got void *
   drivers/watchdog/wdt_pci.c:244:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:244:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:244:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:244:22: sparse:     got void *
   drivers/watchdog/wdt_pci.c:279:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:279:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:279:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:279:13: sparse:     got void *
   drivers/watchdog/wdt_pci.c:306:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:306:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:306:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:306:18: sparse:     got void *
   drivers/watchdog/wdt_pci.c:313:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/watchdog/wdt_pci.c:313:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/watchdog/wdt_pci.c:313:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/watchdog/wdt_pci.c:313:25: sparse:     got void *

vim +/__iomem +103 drivers/watchdog/wdt_pci.c

^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   69  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   70  static int heartbeat = WD_TIMO;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   71  static int wd_heartbeat;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   72  module_param(heartbeat, int, 0);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   73  MODULE_PARM_DESC(heartbeat,
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   74  		"Watchdog heartbeat in seconds. (0<heartbeat<65536, default="
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   75  				__MODULE_STRING(WD_TIMO) ")");
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   76  
86a1e1896c2710 drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2012-03-05   77  static bool nowayout = WATCHDOG_NOWAYOUT;
86a1e1896c2710 drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2012-03-05   78  module_param(nowayout, bool, 0);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   79  MODULE_PARM_DESC(nowayout,
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   80  		"Watchdog cannot be stopped once started (default="
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   81  				__MODULE_STRING(WATCHDOG_NOWAYOUT) ")");
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   82  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   83  /* Support for the Fan Tachometer on the PCI-WDT501 */
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   84  static int tachometer;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   85  module_param(tachometer, int, 0);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   86  MODULE_PARM_DESC(tachometer,
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04   87  		"PCI-WDT501 Fan Tachometer support (0=disable, default=0)");
9b901ee0cb007e drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2009-06-19   88  
9b901ee0cb007e drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2009-06-19   89  static int type = 500;
9b901ee0cb007e drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2009-06-19   90  module_param(type, int, 0);
9b901ee0cb007e drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2009-06-19   91  MODULE_PARM_DESC(type,
9b901ee0cb007e drivers/watchdog/wdt_pci.c      Wim Van Sebroeck 2009-06-19   92  		"PCI-WDT501 Card type (500 or 501 , default=500)");
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   93  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   94  /*
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   95   *	Programming support
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   96   */
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   97  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   98  static void wdtpci_ctr_mode(int ctr, int mode)
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16   99  {
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  100  	ctr <<= 6;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  101  	ctr |= 0x30;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  102  	ctr |= (mode << 1);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04 @103  	outb(ctr, WDT_CR);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  104  	udelay(8);
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  105  }
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  106  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  107  static void wdtpci_ctr_load(int ctr, int val)
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  108  {
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  109  	outb(val & 0xFF, WDT_COUNT0 + ctr);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  110  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  111  	outb(val >> 8, WDT_COUNT0 + ctr);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  112  	udelay(8);
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  113  }
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  114  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  115  /**
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  116   *	wdtpci_start:
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  117   *
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  118   *	Start the watchdog driver.
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  119   */
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  120  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  121  static int wdtpci_start(void)
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  122  {
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  123  	unsigned long flags;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  124  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  125  	spin_lock_irqsave(&wdtpci_lock, flags);
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  126  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  127  	/*
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  128  	 * "pet" the watchdog, as Access says.
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  129  	 * This resets the clock outputs.
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  130  	 */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04 @131  	inb(WDT_DC);			/* Disable watchdog */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  132  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  133  	wdtpci_ctr_mode(2, 0);		/* Program CTR2 for Mode 0:
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  134  						Pulse on Terminal Count */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  135  	outb(0, WDT_DC);		/* Enable watchdog */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  136  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  137  	inb(WDT_DC);			/* Disable watchdog */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  138  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  139  	outb(0, WDT_CLOCK);		/* 2.0833MHz clock */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  140  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  141  	inb(WDT_BUZZER);		/* disable */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  142  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  143  	inb(WDT_OPTONOTRST);		/* disable */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  144  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  145  	inb(WDT_OPTORST);		/* disable */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  146  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  147  	inb(WDT_PROGOUT);		/* disable */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  148  	udelay(8);
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  149  	wdtpci_ctr_mode(0, 3);		/* Program CTR0 for Mode 3:
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  150  						Square Wave Generator */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  151  	wdtpci_ctr_mode(1, 2);		/* Program CTR1 for Mode 2:
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  152  						Rate Generator */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  153  	wdtpci_ctr_mode(2, 1);		/* Program CTR2 for Mode 1:
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  154  						Retriggerable One-Shot */
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  155  	wdtpci_ctr_load(0, 20833);	/* count at 100Hz */
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  156  	wdtpci_ctr_load(1, wd_heartbeat);/* Heartbeat */
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  157  	/* DO NOT LOAD CTR2 on PCI card! -- JPN */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  158  	outb(0, WDT_DC);		/* Enable watchdog */
9f2d1f0da766f8 drivers/watchdog/wdt_pci.c      Alan Cox         2008-08-04  159  	udelay(8);
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  160  
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  161  	spin_unlock_irqrestore(&wdtpci_lock, flags);
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  162  	return 0;
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  163  }
^1da177e4c3f41 drivers/char/watchdog/wdt_pci.c Linus Torvalds   2005-04-16  164  

:::::: The code at line 103 was first introduced by commit
:::::: 9f2d1f0da766f84fdb96c9bd79ed0f97036635cb wdt: Cleanup and sort out locking and inb_p

:::::: TO: Alan Cox <alan@redhat.com>
:::::: CC: Linus Torvalds <torvalds@linux-foundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--OXfL5xGRrasGEqWY
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--OXfL5xGRrasGEqWY--
