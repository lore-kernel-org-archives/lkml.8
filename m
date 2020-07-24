Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E9AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:05:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A836C20709
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 04:05:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725942AbgGXEFu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 00:05:50 -0400
Received: from mga06.intel.com ([134.134.136.31]:45267 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725813AbgGXEFt (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 00:05:49 -0400
IronPort-SDR: TyBxvwmy2m/QHQpVKaFafeN6+GPbcJp1eayS4GNQffmJay+0nhA4wHHAvA8e1kynQaJv00XFEd
 DU5GbL0noNHQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212191447"
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="gz'50?scan'50,208,50";a="212191447"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 21:00:34 -0700
IronPort-SDR: EM2CylgdLAtvToM9fCIfb8Sh4uVEt20RFv2lQr65+XOF6zHmn3F59Pb5a8Tx2zyW/zC44GrtPh
 9dnwxpJf2nAQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,389,1589266800"; 
   d="gz'50?scan'50,208,50";a="272478416"
Received: from lkp-server01.sh.intel.com (HELO df0563f96c37) ([10.239.97.150])
  by fmsmga008.fm.intel.com with ESMTP; 23 Jul 2020 21:00:32 -0700
Received: from kbuild by df0563f96c37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyosp-00002j-Bu; Fri, 24 Jul 2020 04:00:31 +0000
Date:   Fri, 24 Jul 2020 12:00:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/watchdog/ar7_wdt.c:193:29: sparse: sparse: incorrect type in
 initializer (different address spaces)
Message-ID: <202007241211.yQLaEaXs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="jRHKVT23PllUwdXP"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jRHKVT23PllUwdXP
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: mips-randconfig-s032-20200723 (attached as .config)
compiler: mipsel-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/watchdog/ar7_wdt.c:193:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected char const [noderef] __user *__gu_ptr @@     got char const * @@
>> drivers/watchdog/ar7_wdt.c:193:29: sparse:     expected char const [noderef] __user *__gu_ptr
   drivers/watchdog/ar7_wdt.c:193:29: sparse:     got char const *
>> drivers/watchdog/ar7_wdt.c:216:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __user *to @@     got struct watchdog_info * @@
>> drivers/watchdog/ar7_wdt.c:216:35: sparse:     expected void [noderef] __user *to
   drivers/watchdog/ar7_wdt.c:216:35: sparse:     got struct watchdog_info *
>> drivers/watchdog/ar7_wdt.c:222:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__pu_addr @@     got int * @@
>> drivers/watchdog/ar7_wdt.c:222:21: sparse:     expected int [noderef] __user *__pu_addr
   drivers/watchdog/ar7_wdt.c:222:21: sparse:     got int *
>> drivers/watchdog/ar7_wdt.c:229:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int const [noderef] __user *__gu_ptr @@     got int * @@
>> drivers/watchdog/ar7_wdt.c:229:21: sparse:     expected int const [noderef] __user *__gu_ptr
   drivers/watchdog/ar7_wdt.c:229:21: sparse:     got int *
   drivers/watchdog/ar7_wdt.c:241:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected int [noderef] __user *__pu_addr @@     got int * @@
   drivers/watchdog/ar7_wdt.c:241:21: sparse:     expected int [noderef] __user *__pu_addr
   drivers/watchdog/ar7_wdt.c:241:21: sparse:     got int *
   drivers/watchdog/ar7_wdt.c:251:27: sparse: sparse: incorrect type in initializer (incompatible argument 2 (different address spaces)) @@     expected int ( *write )( ... ) @@     got int ( * )( ... ) @@
   drivers/watchdog/ar7_wdt.c:251:27: sparse:     expected int ( *write )( ... )
   drivers/watchdog/ar7_wdt.c:251:27: sparse:     got int ( * )( ... )
>> drivers/watchdog/ar7_wdt.c:271:17: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ar7_wdt *static [toplevel] ar7_wdt @@     got void [noderef] __iomem * @@
   drivers/watchdog/ar7_wdt.c:271:17: sparse:     expected struct ar7_wdt *static [toplevel] ar7_wdt
>> drivers/watchdog/ar7_wdt.c:271:17: sparse:     got void [noderef] __iomem *
   drivers/watchdog/ar7_wdt.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> drivers/vlynq/vlynq.c:101:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
>> drivers/vlynq/vlynq.c:101:31: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:101:31: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:111:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:111:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:111:26: sparse:     got unsigned int *
>> drivers/vlynq/vlynq.c:112:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
>> drivers/vlynq/vlynq.c:112:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:112:29: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:118:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:118:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:118:26: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:119:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:119:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:119:29: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:133:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:133:45: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:133:45: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:135:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:135:45: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:135:45: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:146:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:146:45: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:146:45: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:148:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:148:45: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:148:45: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:159:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:159:45: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:159:45: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:178:45: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:178:45: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:178:45: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:185:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:185:32: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:185:32: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:189:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:189:28: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:189:28: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:195:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:195:32: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:195:32: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:199:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:199:28: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:199:28: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:208:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:208:28: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:208:28: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:209:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:209:28: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:209:28: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:258:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:258:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:258:26: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:258:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:258:48: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:258:48: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:259:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:259:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:259:26: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:259:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:259:49: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:259:49: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:265:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:265:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:265:26: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:266:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:266:38: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:266:38: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:267:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:267:25: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:267:25: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:271:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:271:26: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:271:26: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:272:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:272:38: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:272:38: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:273:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:273:25: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:273:25: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:274:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:274:25: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:274:25: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:290:59: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:290:59: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:290:59: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:389:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:389:35: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:389:35: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:393:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:393:37: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:393:37: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:394:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:394:35: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:394:35: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:398:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:398:37: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:398:37: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:431:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:431:35: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:431:35: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:435:37: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:435:37: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:435:37: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:463:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:463:27: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:463:27: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:465:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:465:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:465:29: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:467:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:467:27: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:467:27: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:469:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:469:29: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:469:29: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:497:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:497:52: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:497:52: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:520:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:520:43: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:520:43: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:521:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:521:31: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:521:31: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:538:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:538:31: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:538:31: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:541:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:541:43: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:541:43: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:593:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:593:31: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:593:31: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:595:66: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:595:66: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:595:66: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:596:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:596:64: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:596:64: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:610:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:610:31: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:610:31: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:612:67: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:612:67: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:612:67: sparse:     got unsigned int *
   drivers/vlynq/vlynq.c:613:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:613:65: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:613:65: sparse:     got unsigned int *
>> drivers/vlynq/vlynq.c:700:20: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct vlynq_regs *local @@     got void [noderef] __iomem * @@
   drivers/vlynq/vlynq.c:700:20: sparse:     expected struct vlynq_regs *local
>> drivers/vlynq/vlynq.c:700:20: sparse:     got void [noderef] __iomem *
   drivers/vlynq/vlynq.c:729:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   drivers/vlynq/vlynq.c:729:41: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/vlynq/vlynq.c:729:41: sparse:     got unsigned int *
>> drivers/vlynq/vlynq.c:738:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct vlynq_regs *local @@
>> drivers/vlynq/vlynq.c:738:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/vlynq/vlynq.c:738:20: sparse:     got struct vlynq_regs *local
   drivers/vlynq/vlynq.c:751:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct vlynq_regs *local @@
   drivers/vlynq/vlynq.c:751:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/vlynq/vlynq.c:751:20: sparse:     got struct vlynq_regs *local
   drivers/vlynq/vlynq.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: too many warnings
--
>> arch/mips/ar7/prom.c:151:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *src @@     got void *psp_env_base @@
>> arch/mips/ar7/prom.c:151:31: sparse:     expected void const volatile [noderef] __iomem *src
   arch/mips/ar7/prom.c:151:31: sparse:     got void *psp_env_base
>> arch/mips/ar7/prom.c:243:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/ar7/prom.c:243:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/prom.c:243:23: sparse:     got void *
   arch/mips/ar7/prom.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
>> arch/mips/ar7/prom.c:248:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/ar7/prom.c:248:24: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/prom.c:248:24: sparse:     got void *
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> arch/mips/ar7/setup.c:17:28: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [usertype] *softres_reg @@     got void [noderef] __iomem * @@
   arch/mips/ar7/setup.c:17:28: sparse:     expected unsigned int [usertype] *softres_reg
>> arch/mips/ar7/setup.c:17:28: sparse:     got void [noderef] __iomem *
>> arch/mips/ar7/setup.c:19:19: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] *softres_reg @@
>> arch/mips/ar7/setup.c:19:19: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/setup.c:19:19: sparse:     got unsigned int [usertype] *softres_reg
>> arch/mips/ar7/setup.c:30:27: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/mips/ar7/setup.c:31:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] *power_reg @@
>> arch/mips/ar7/setup.c:31:33: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/setup.c:31:33: sparse:     got unsigned int [usertype] *power_reg
>> arch/mips/ar7/setup.c:33:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] *power_reg @@
   arch/mips/ar7/setup.c:33:29: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/setup.c:33:29: sparse:     got unsigned int [usertype] *power_reg
   arch/mips/ar7/setup.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/setup.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/setup.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/setup.c: note: in included file:
   arch/mips/include/asm/mach-ar7/ar7.h:123:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:123:35: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:123:35: sparse:     got void *
   arch/mips/ar7/setup.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/setup.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/setup.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/setup.c: note: in included file:
   arch/mips/include/asm/mach-ar7/ar7.h:130:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:130:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:130:24: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/setup.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> arch/mips/ar7/memory.c:40:31: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] ** @@
>> arch/mips/ar7/memory.c:40:31: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/memory.c:40:31: sparse:     got unsigned int [usertype] **
   arch/mips/ar7/memory.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/mmzone.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> arch/mips/ar7/irq.c:42:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
>> arch/mips/ar7/irq.c:42:16: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:42:16: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:48:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:48:16: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:48:16: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:54:16: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:54:16: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:54:16: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:59:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:59:51: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:59:51: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:64:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:64:51: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:64:51: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:69:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:69:51: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:69:51: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:92:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:92:28: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:92:28: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:93:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:93:22: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:93:22: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:94:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:94:28: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:94:28: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:95:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:95:28: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:95:28: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:96:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:96:22: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:96:22: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:97:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:97:28: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:97:28: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:102:27: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:102:27: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:102:27: sparse:     got unsigned int [usertype] *
>> arch/mips/ar7/irq.c:136:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
>> arch/mips/ar7/irq.c:136:21: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:136:21: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:143:19: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:143:19: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:143:19: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c:144:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int [usertype] * @@
   arch/mips/ar7/irq.c:144:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/irq.c:144:24: sparse:     got unsigned int [usertype] *
   arch/mips/ar7/irq.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/irq.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     got void *reset_reg
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *reset_reg @@
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     got void *reset_reg
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
   arch/mips/include/asm/mach-ar7/ar7.h:158:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:158:22: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:158:22: sparse:     got void *reset_reg
   arch/mips/include/asm/mach-ar7/ar7.h:158:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:158:47: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:158:47: sparse:     got void *reset_reg
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     got void *reset_reg
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *reset_reg @@
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     got void *reset_reg
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     got void *reset_reg
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *reset_reg @@
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     got void *reset_reg
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     got void *reset_reg
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *reset_reg @@
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     got void *reset_reg
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void *reset_reg @@
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:22: sparse:     got void *reset_reg
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got void *reset_reg @@
>> arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:166:48: sparse:     got void *reset_reg
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/platform.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/platform.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/wait.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> arch/mips/ar7/clock.c:147:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/ar7/clock.c:147:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:147:24: sparse:     got void *
   arch/mips/ar7/clock.c:148:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/ar7/clock.c:148:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:148:24: sparse:     got void *
>> arch/mips/ar7/clock.c:164:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:164:27: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:164:27: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:165:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:165:26: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:165:26: sparse:     got unsigned int *
>> arch/mips/ar7/clock.c:228:65: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
>> arch/mips/ar7/clock.c:228:65: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:228:65: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:230:20: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:230:20: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:230:20: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:231:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:231:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:231:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:233:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:233:64: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:233:64: sparse:     got unsigned int *
>> arch/mips/ar7/clock.c:239:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/mips/ar7/clock.c:241:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tnetd7300_clocks *clocks @@     got void [noderef] __iomem * @@
   arch/mips/ar7/clock.c:241:41: sparse:     expected struct tnetd7300_clocks *clocks
>> arch/mips/ar7/clock.c:241:41: sparse:     got void [noderef] __iomem *
>> arch/mips/ar7/clock.c:257:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct tnetd7300_clocks *clocks @@
>> arch/mips/ar7/clock.c:257:17: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/mips/ar7/clock.c:257:17: sparse:     got struct tnetd7300_clocks *clocks
>> arch/mips/ar7/clock.c:258:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bootcr @@
   arch/mips/ar7/clock.c:258:17: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/mips/ar7/clock.c:258:17: sparse:     got unsigned int [usertype] *bootcr
   arch/mips/ar7/clock.c:269:20: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:269:20: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:269:20: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:270:62: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:270:62: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:270:62: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:271:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:271:34: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:271:34: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:273:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:273:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:273:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:276:63: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:276:63: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:276:63: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:278:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:278:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:278:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:278:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:278:43: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:278:43: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:279:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:279:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:279:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:279:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:279:41: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:279:41: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:281:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:281:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:281:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:284:64: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:284:64: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:284:64: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:286:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:286:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:286:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:286:43: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:286:43: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:286:43: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:287:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:287:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:287:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:287:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:287:41: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:287:41: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:289:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:289:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:289:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:292:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:292:23: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:292:23: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:292:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned int * @@
   arch/mips/ar7/clock.c:292:42: sparse:     expected void volatile [noderef] __iomem *mem
   arch/mips/ar7/clock.c:292:42: sparse:     got unsigned int *
   arch/mips/ar7/clock.c:323:24: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/mips/ar7/clock.c:325:41: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct tnetd7200_clocks *clocks @@     got void [noderef] __iomem * @@
   arch/mips/ar7/clock.c:325:41: sparse:     expected struct tnetd7200_clocks *clocks
   arch/mips/ar7/clock.c:325:41: sparse:     got void [noderef] __iomem *
>> arch/mips/ar7/clock.c:400:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got struct tnetd7200_clocks *clocks @@
   arch/mips/ar7/clock.c:400:17: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/mips/ar7/clock.c:400:17: sparse:     got struct tnetd7200_clocks *clocks
   arch/mips/ar7/clock.c:401:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bootcr @@
   arch/mips/ar7/clock.c:401:17: sparse:     expected void const volatile [noderef] __iomem *addr
   arch/mips/ar7/clock.c:401:17: sparse:     got unsigned int [usertype] *bootcr
   arch/mips/ar7/clock.c: note: in included file:
   arch/mips/include/asm/mach-ar7/ar7.h:130:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:130:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:130:24: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/clock.c: note: in included file (through include/linux/io.h):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/ar7/clock.c: note: in included file:
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
>> arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:117:58: sparse:     got void *
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got void * @@
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     expected void const volatile [noderef] __iomem *mem
   arch/mips/include/asm/mach-ar7/ar7.h:111:24: sparse:     got void *
   arch/mips/ar7/clock.c: note: in included file (through include/linux/io.h):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32

vim +193 drivers/watchdog/ar7_wdt.c

c283cf2c09ca1b7 Matteo Croce        2007-09-20  178  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  179  static ssize_t ar7_wdt_write(struct file *file, const char *data,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  180  			     size_t len, loff_t *ppos)
c283cf2c09ca1b7 Matteo Croce        2007-09-20  181  {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  182  	/* check for a magic close character */
c283cf2c09ca1b7 Matteo Croce        2007-09-20  183  	if (len) {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  184  		size_t i;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  185  
670d59c0ae31a87 Alan Cox            2008-08-04  186  		spin_lock(&wdt_lock);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  187  		ar7_wdt_kick(1);
670d59c0ae31a87 Alan Cox            2008-08-04  188  		spin_unlock(&wdt_lock);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  189  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  190  		expect_close = 0;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  191  		for (i = 0; i < len; ++i) {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  192  			char c;
c283cf2c09ca1b7 Matteo Croce        2007-09-20 @193  			if (get_user(c, data + i))
c283cf2c09ca1b7 Matteo Croce        2007-09-20  194  				return -EFAULT;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  195  			if (c == 'V')
c283cf2c09ca1b7 Matteo Croce        2007-09-20  196  				expect_close = 1;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  197  		}
c283cf2c09ca1b7 Matteo Croce        2007-09-20  198  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  199  	}
c283cf2c09ca1b7 Matteo Croce        2007-09-20  200  	return len;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  201  }
c283cf2c09ca1b7 Matteo Croce        2007-09-20  202  
670d59c0ae31a87 Alan Cox            2008-08-04  203  static long ar7_wdt_ioctl(struct file *file,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  204  					unsigned int cmd, unsigned long arg)
c283cf2c09ca1b7 Matteo Croce        2007-09-20  205  {
42747d712de56cf Wim Van Sebroeck    2009-12-26  206  	static const struct watchdog_info ident = {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  207  		.identity = LONGNAME,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  208  		.firmware_version = 1,
e73a780272a46e8 Wim Van Sebroeck    2009-05-11  209  		.options = (WDIOF_SETTIMEOUT | WDIOF_KEEPALIVEPING |
e73a780272a46e8 Wim Van Sebroeck    2009-05-11  210  						WDIOF_MAGICCLOSE),
c283cf2c09ca1b7 Matteo Croce        2007-09-20  211  	};
c283cf2c09ca1b7 Matteo Croce        2007-09-20  212  	int new_margin;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  213  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  214  	switch (cmd) {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  215  	case WDIOC_GETSUPPORT:
c283cf2c09ca1b7 Matteo Croce        2007-09-20 @216  		if (copy_to_user((struct watchdog_info *)arg, &ident,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  217  				sizeof(ident)))
c283cf2c09ca1b7 Matteo Croce        2007-09-20  218  			return -EFAULT;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  219  		return 0;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  220  	case WDIOC_GETSTATUS:
c283cf2c09ca1b7 Matteo Croce        2007-09-20  221  	case WDIOC_GETBOOTSTATUS:
c283cf2c09ca1b7 Matteo Croce        2007-09-20 @222  		if (put_user(0, (int *)arg))
c283cf2c09ca1b7 Matteo Croce        2007-09-20  223  			return -EFAULT;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  224  		return 0;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  225  	case WDIOC_KEEPALIVE:
c283cf2c09ca1b7 Matteo Croce        2007-09-20  226  		ar7_wdt_kick(1);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  227  		return 0;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  228  	case WDIOC_SETTIMEOUT:
c283cf2c09ca1b7 Matteo Croce        2007-09-20 @229  		if (get_user(new_margin, (int *)arg))
c283cf2c09ca1b7 Matteo Croce        2007-09-20  230  			return -EFAULT;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  231  		if (new_margin < 1)
c283cf2c09ca1b7 Matteo Croce        2007-09-20  232  			return -EINVAL;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  233  
670d59c0ae31a87 Alan Cox            2008-08-04  234  		spin_lock(&wdt_lock);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  235  		ar7_wdt_update_margin(new_margin);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  236  		ar7_wdt_kick(1);
670d59c0ae31a87 Alan Cox            2008-08-04  237  		spin_unlock(&wdt_lock);
d259f94f7265065 Gustavo A. R. Silva 2019-07-29  238  		/* Fall through */
c283cf2c09ca1b7 Matteo Croce        2007-09-20  239  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  240  	case WDIOC_GETTIMEOUT:
c283cf2c09ca1b7 Matteo Croce        2007-09-20  241  		if (put_user(margin, (int *)arg))
c283cf2c09ca1b7 Matteo Croce        2007-09-20  242  			return -EFAULT;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  243  		return 0;
0c06090c9472db0 Wim Van Sebroeck    2008-07-18  244  	default:
0c06090c9472db0 Wim Van Sebroeck    2008-07-18  245  		return -ENOTTY;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  246  	}
c283cf2c09ca1b7 Matteo Croce        2007-09-20  247  }
c283cf2c09ca1b7 Matteo Croce        2007-09-20  248  
b47a166ed0baaaa Jan Engelhardt      2008-01-22  249  static const struct file_operations ar7_wdt_fops = {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  250  	.owner		= THIS_MODULE,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  251  	.write		= ar7_wdt_write,
670d59c0ae31a87 Alan Cox            2008-08-04  252  	.unlocked_ioctl	= ar7_wdt_ioctl,
b6dfb2477fb0bf4 Arnd Bergmann       2019-06-03  253  	.compat_ioctl	= compat_ptr_ioctl,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  254  	.open		= ar7_wdt_open,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  255  	.release	= ar7_wdt_release,
6038f373a3dc1f1 Arnd Bergmann       2010-08-15  256  	.llseek		= no_llseek,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  257  };
c283cf2c09ca1b7 Matteo Croce        2007-09-20  258  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  259  static struct miscdevice ar7_wdt_miscdev = {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  260  	.minor		= WATCHDOG_MINOR,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  261  	.name		= "watchdog",
c283cf2c09ca1b7 Matteo Croce        2007-09-20  262  	.fops		= &ar7_wdt_fops,
c283cf2c09ca1b7 Matteo Croce        2007-09-20  263  };
c283cf2c09ca1b7 Matteo Croce        2007-09-20  264  
2d991a164a61858 Bill Pemberton      2012-11-19  265  static int ar7_wdt_probe(struct platform_device *pdev)
c283cf2c09ca1b7 Matteo Croce        2007-09-20  266  {
c283cf2c09ca1b7 Matteo Croce        2007-09-20  267  	int rc;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  268  
64d4062a3813e48 Florian Fainelli    2009-07-21  269  	ar7_regs_wdt =
64d4062a3813e48 Florian Fainelli    2009-07-21  270  		platform_get_resource_byname(pdev, IORESOURCE_MEM, "regs");
4c271bb67c04253 Thierry Reding      2013-01-21 @271  	ar7_wdt = devm_ioremap_resource(&pdev->dev, ar7_regs_wdt);
4c271bb67c04253 Thierry Reding      2013-01-21  272  	if (IS_ERR(ar7_wdt))
4c271bb67c04253 Thierry Reding      2013-01-21  273  		return PTR_ERR(ar7_wdt);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  274  
780019ddf02f214 Florian Fainelli    2010-01-27  275  	vbus_clk = clk_get(NULL, "vbus");
780019ddf02f214 Florian Fainelli    2010-01-27  276  	if (IS_ERR(vbus_clk)) {
27c766aaacb265d Joe Perches         2012-02-15  277  		pr_err("could not get vbus clock\n");
ae21cc20a604b45 Julia Lawall        2012-04-15  278  		return PTR_ERR(vbus_clk);
780019ddf02f214 Florian Fainelli    2010-01-27  279  	}
780019ddf02f214 Florian Fainelli    2010-01-27  280  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  281  	ar7_wdt_disable_wdt();
c283cf2c09ca1b7 Matteo Croce        2007-09-20  282  	ar7_wdt_prescale(prescale_value);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  283  	ar7_wdt_update_margin(margin);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  284  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  285  	rc = misc_register(&ar7_wdt_miscdev);
c283cf2c09ca1b7 Matteo Croce        2007-09-20  286  	if (rc) {
27c766aaacb265d Joe Perches         2012-02-15  287  		pr_err("unable to register misc device\n");
c283cf2c09ca1b7 Matteo Croce        2007-09-20  288  		goto out;
ae21cc20a604b45 Julia Lawall        2012-04-15  289  	}
ae21cc20a604b45 Julia Lawall        2012-04-15  290  	return 0;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  291  
c283cf2c09ca1b7 Matteo Croce        2007-09-20  292  out:
ae21cc20a604b45 Julia Lawall        2012-04-15  293  	clk_put(vbus_clk);
ae21cc20a604b45 Julia Lawall        2012-04-15  294  	vbus_clk = NULL;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  295  	return rc;
c283cf2c09ca1b7 Matteo Croce        2007-09-20  296  }
c283cf2c09ca1b7 Matteo Croce        2007-09-20  297  

:::::: The code at line 193 was first introduced by commit
:::::: c283cf2c09ca1b7f1e7677bde384a8f92b1b7584 [WATCHDOG] AR7: watchdog timer

:::::: TO: Matteo Croce <technoboy85@gmail.com>
:::::: CC: Wim Van Sebroeck <wim@iguana.be>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--jRHKVT23PllUwdXP
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
r3BI+R9J4qdL9IMBAA==

--jRHKVT23PllUwdXP--
