Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8BF6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:19:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8EA952077D
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 06:19:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727819AbgGJGTK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 02:19:10 -0400
Received: from mga03.intel.com ([134.134.136.65]:25110 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725851AbgGJGTG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 02:19:06 -0400
IronPort-SDR: xTwEzW7XDdFhdUsvlER0ts1vkAlDX3PCxwEmLZsTxtG3orZwa4ND6q9NDags8LYAG8g+fNV1OW
 gqaR/xd8v+MQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9677"; a="148146637"
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="gz'50?scan'50,208,50";a="148146637"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jul 2020 23:18:05 -0700
IronPort-SDR: DzlDVpEAov+DBeqrQCBxHFeZZyJ0V1bj1vc9500WBOTpe86vDTmLZygwX4Bp9LADHcI6Ok2+wq
 nGfFwAf6CAtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,334,1589266800"; 
   d="gz'50?scan'50,208,50";a="284410230"
Received: from lkp-server02.sh.intel.com (HELO 0fc60ea15964) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 09 Jul 2020 23:18:03 -0700
Received: from kbuild by 0fc60ea15964 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jtmME-00003A-C7; Fri, 10 Jul 2020 06:18:02 +0000
Date:   Fri, 10 Jul 2020 14:17:36 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: sound/pci/ctxfi/cthw20k1.c:2103:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007101429.G4ECp2e7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="uAKRQypu60I7Lcqm"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--uAKRQypu60I7Lcqm
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   3 weeks ago
config: riscv-randconfig-s031-20200710 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
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

>> sound/pci/ctxfi/cthw20k1.c:2103:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ctxfi/cthw20k1.c:2103:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ctxfi/cthw20k1.c:2103:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2103:9: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2104:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ctxfi/cthw20k1.c:2104:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ctxfi/cthw20k1.c:2104:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2104:17: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2117:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ctxfi/cthw20k1.c:2117:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ctxfi/cthw20k1.c:2117:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2117:9: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2118:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ctxfi/cthw20k1.c:2118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ctxfi/cthw20k1.c:2118:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2118:9: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2131:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ctxfi/cthw20k1.c:2131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ctxfi/cthw20k1.c:2131:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2131:9: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2132:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ctxfi/cthw20k1.c:2132:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ctxfi/cthw20k1.c:2132:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2132:17: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2145:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ctxfi/cthw20k1.c:2145:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ctxfi/cthw20k1.c:2145:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2145:9: sparse:     got void *
   sound/pci/ctxfi/cthw20k1.c:2146:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ctxfi/cthw20k1.c:2146:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ctxfi/cthw20k1.c:2146:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ctxfi/cthw20k1.c:2146:9: sparse:     got void *
--
   drivers/video/fbdev/imsttfb.c:1513:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/imsttfb.c:1513:27: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected char [noderef] __iomem *screen_base @@     got unsigned char [usertype] * @@
   drivers/video/fbdev/imsttfb.c:1513:27: sparse:     expected char [noderef] __iomem *screen_base
   drivers/video/fbdev/imsttfb.c:1513:27: sparse:     got unsigned char [usertype] *
   drivers/video/fbdev/imsttfb.c:1523:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/imsttfb.c:1538:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char [usertype] *cmap_regs @@
>> drivers/video/fbdev/imsttfb.c:1538:20: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/imsttfb.c:1538:20: sparse:     got unsigned char [usertype] *cmap_regs
   drivers/video/fbdev/imsttfb.c:1360:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/imsttfb.c:1361:16: sparse: sparse: cast removes address space '__iomem' of expression
--
>> sound/pci/ca0106/ca0106_main.c:342:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ca0106/ca0106_main.c:342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ca0106/ca0106_main.c:342:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:342:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:343:15: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ca0106/ca0106_main.c:343:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ca0106/ca0106_main.c:343:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:343:15: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:359:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:359:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:359:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:359:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:360:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:360:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:360:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:459:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:459:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:459:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:459:23: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:460:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:460:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:460:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:460:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:470:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:470:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:470:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:470:23: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:471:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:471:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:471:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:471:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:785:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:785:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:785:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:785:16: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:787:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:787:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:787:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:787:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:887:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:887:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:887:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:887:16: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:889:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:889:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:889:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:889:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1141:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1141:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1141:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1141:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1142:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1142:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1142:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1142:15: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1154:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1154:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1154:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1154:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1155:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1155:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1155:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1155:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1579:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1579:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1579:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1579:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1584:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1584:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1584:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1584:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1219:18: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1219:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1219:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1219:18: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1274:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1274:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1274:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1274:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1402:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1402:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1402:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1402:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1439:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1439:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1439:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1439:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1440:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1440:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1440:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1440:9: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1514:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1514:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1514:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1514:17: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1516:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1516:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1516:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1516:17: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1522:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1522:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1522:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_main.c:1522:17: sparse:     got void *
   sound/pci/ca0106/ca0106_main.c:1524:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_main.c:1524:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_main.c:1524:17: sparse:     expected void volatile [noderef] __iomem *addr
--
>> sound/pci/ca0106/ca0106_mixer.c:73:23: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ca0106/ca0106_mixer.c:73:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ca0106/ca0106_mixer.c:73:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:73:23: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:74:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ca0106/ca0106_mixer.c:74:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ca0106/ca0106_mixer.c:74:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:74:17: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:82:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_mixer.c:82:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_mixer.c:82:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:82:23: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:83:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_mixer.c:83:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_mixer.c:83:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:83:17: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:122:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_mixer.c:122:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_mixer.c:122:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:122:23: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:124:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_mixer.c:124:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_mixer.c:124:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:124:17: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:128:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_mixer.c:128:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_mixer.c:128:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:128:23: sparse:     got void *
   sound/pci/ca0106/ca0106_mixer.c:129:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_mixer.c:129:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_mixer.c:129:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_mixer.c:129:17: sparse:     got void *
--
>> sound/pci/ca0106/ca0106_proc.c:292:25: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ca0106/ca0106_proc.c:292:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ca0106/ca0106_proc.c:292:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_proc.c:292:25: sparse:     got void *
   sound/pci/ca0106/ca0106_proc.c:308:25: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ca0106/ca0106_proc.c:308:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ca0106/ca0106_proc.c:308:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_proc.c:308:25: sparse:     got void *
   sound/pci/ca0106/ca0106_proc.c:324:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_proc.c:324:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_proc.c:324:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_proc.c:324:25: sparse:     got void *
   sound/pci/ca0106/ca0106_proc.c:340:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ca0106/ca0106_proc.c:340:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ca0106/ca0106_proc.c:340:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ca0106/ca0106_proc.c:340:25: sparse:     got void *
--
>> drivers/tty/isicom.c:420:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/isicom.c:420:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/isicom.c:420:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:420:21: sparse:     got void *
   drivers/tty/isicom.c:441:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:441:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:441:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:441:23: sparse:     got void *
   drivers/tty/isicom.c:446:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/isicom.c:446:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/isicom.c:446:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:446:17: sparse:     got void *
   drivers/tty/isicom.c:463:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:463:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:463:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:463:41: sparse:     got void *
   drivers/tty/isicom.c:465:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:465:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:465:41: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:465:41: sparse:     got void *
   drivers/tty/isicom.c:487:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:487:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:487:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:487:17: sparse:     got void *
   drivers/tty/isicom.c:223:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:223:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:223:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:223:18: sparse:     got void *
   drivers/tty/isicom.c:226:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:226:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:226:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:226:18: sparse:     got void *
   drivers/tty/isicom.c:237:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:237:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:237:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:237:29: sparse:     got void *
   drivers/tty/isicom.c:268:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:268:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:268:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:268:9: sparse:     got void *
   drivers/tty/isicom.c:269:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:269:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:269:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:269:9: sparse:     got void *
   drivers/tty/isicom.c:270:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:270:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:270:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:270:9: sparse:     got void *
   drivers/tty/isicom.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:284:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:284:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:284:9: sparse:     got void *
   drivers/tty/isicom.c:285:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:285:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:285:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:285:9: sparse:     got void *
   drivers/tty/isicom.c:286:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:286:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:286:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:286:9: sparse:     got void *
   drivers/tty/isicom.c:335:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:335:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:335:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:335:17: sparse:     got void *
   drivers/tty/isicom.c:336:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:336:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:336:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:336:17: sparse:     got void *
   drivers/tty/isicom.c:337:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:337:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:337:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:337:17: sparse:     got void *
   drivers/tty/isicom.c:340:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:340:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:340:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:340:17: sparse:     got void *
   drivers/tty/isicom.c:341:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:341:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:341:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:341:17: sparse:     got void *
   drivers/tty/isicom.c:342:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:342:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:342:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:342:17: sparse:     got void *
   drivers/tty/isicom.c:358:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:358:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:358:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:358:9: sparse:     got void *
   drivers/tty/isicom.c:359:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:359:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:359:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:359:9: sparse:     got void *
   drivers/tty/isicom.c:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:360:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:360:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:360:9: sparse:     got void *
   drivers/tty/isicom.c:523:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:523:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:523:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:523:15: sparse:     got void *
   drivers/tty/isicom.c:532:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:532:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:532:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:532:9: sparse:     got void *
   drivers/tty/isicom.c:533:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:533:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:533:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/isicom.c:533:9: sparse:     got void *
   drivers/tty/isicom.c:535:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/isicom.c:535:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/isicom.c:535:9: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/tty/mxser.c:293:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/mxser.c:293:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/mxser.c:293:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:293:18: sparse:     got void *
   drivers/tty/mxser.c:294:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/mxser.c:294:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/mxser.c:294:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:294:9: sparse:     got void *
   drivers/tty/mxser.c:296:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:296:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:296:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:296:15: sparse:     got void *
   drivers/tty/mxser.c:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:299:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:299:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:299:9: sparse:     got void *
   drivers/tty/mxser.c:300:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:300:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:300:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:300:9: sparse:     got void *
   drivers/tty/mxser.c:309:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:309:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:309:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:309:18: sparse:     got void *
   drivers/tty/mxser.c:310:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:310:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:310:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:310:9: sparse:     got void *
   drivers/tty/mxser.c:312:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:312:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:312:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:312:15: sparse:     got void *
   drivers/tty/mxser.c:315:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:315:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:315:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:315:9: sparse:     got void *
   drivers/tty/mxser.c:316:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:316:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:316:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:316:9: sparse:     got void *
   drivers/tty/mxser.c:325:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:325:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:325:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:325:18: sparse:     got void *
   drivers/tty/mxser.c:326:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:326:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:326:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:326:9: sparse:     got void *
   drivers/tty/mxser.c:328:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:328:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:328:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:328:15: sparse:     got void *
   drivers/tty/mxser.c:332:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:332:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:332:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:332:9: sparse:     got void *
   drivers/tty/mxser.c:333:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:333:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:333:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:333:9: sparse:     got void *
   drivers/tty/mxser.c:334:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:334:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:334:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:334:9: sparse:     got void *
   drivers/tty/mxser.c:342:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:342:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:342:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:342:18: sparse:     got void *
   drivers/tty/mxser.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:343:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:343:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:343:9: sparse:     got void *
   drivers/tty/mxser.c:345:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:345:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:345:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:345:15: sparse:     got void *
   drivers/tty/mxser.c:349:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:349:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:349:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:349:9: sparse:     got void *
   drivers/tty/mxser.c:350:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:350:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:350:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:350:9: sparse:     got void *
   drivers/tty/mxser.c:351:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:351:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:351:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:351:9: sparse:     got void *
   drivers/tty/mxser.c:359:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:359:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:359:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:359:18: sparse:     got void *
   drivers/tty/mxser.c:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:360:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:360:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:360:9: sparse:     got void *
   drivers/tty/mxser.c:362:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:362:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:362:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:362:15: sparse:     got void *
   drivers/tty/mxser.c:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:366:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:366:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/mxser.c:366:9: sparse:     got void *
   drivers/tty/mxser.c:367:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/mxser.c:367:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/mxser.c:367:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> sound/pci/echoaudio/echoaudio.c:1824:21: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *dsp_registers @@
>> sound/pci/echoaudio/echoaudio.c:1824:21: sparse:     expected void [noderef] __iomem *addr
>> sound/pci/echoaudio/echoaudio.c:1824:21: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *dsp_registers
--
>> drivers/tty/ipwireless/hardware.c:422:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/ipwireless/hardware.c:422:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/ipwireless/hardware.c:422:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:422:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:431:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:431:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:434:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:434:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:434:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:434:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:436:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:436:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:436:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:436:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: cast from restricted __le16
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:445:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:445:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:448:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:448:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:448:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:448:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:528:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:528:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:528:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:528:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:530:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:530:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:530:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:530:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:533:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:533:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:533:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:533:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:845:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:845:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:845:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:845:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:863:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/ipwireless/hardware.c:863:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/ipwireless/hardware.c:863:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:863:23: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:867:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:867:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:867:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:867:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:872:43: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:872:43: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:872:43: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned short [assigned] [usertype] __v @@
   drivers/tty/ipwireless/hardware.c:872:43: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:872:43: sparse:     got unsigned short [assigned] [usertype] __v
   drivers/tty/ipwireless/hardware.c:879:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:879:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:879:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:879:23: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:889:43: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:889:43: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:889:43: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] raw_data @@     got unsigned short [assigned] [usertype] __v @@
   drivers/tty/ipwireless/hardware.c:889:43: sparse:     expected restricted __le16 [usertype] raw_data
   drivers/tty/ipwireless/hardware.c:889:43: sparse:     got unsigned short [assigned] [usertype] __v
   drivers/tty/ipwireless/hardware.c:897:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:897:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:897:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:897:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1051:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1051:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1051:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1051:24: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1062:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1062:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1062:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1062:16: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1086:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1086:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1086:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1086:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1604:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1604:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1604:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1604:17: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1607:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1607:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1607:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1607:24: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1609:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1609:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1609:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1609:25: sparse:     got void *
   drivers/tty/ipwireless/hardware.c:1611:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/ipwireless/hardware.c:1611:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/ipwireless/hardware.c:1611:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/ipwireless/hardware.c:1611:25: sparse:     got void *
--
>> drivers/scsi/gdth.c:2530:30: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/gdth.c:2530:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/gdth.c:2530:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:2530:30: sparse:     got void *
   drivers/scsi/gdth.c:2534:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:2534:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:2534:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:2534:24: sparse:     got void *
   drivers/scsi/gdth.c:2535:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:2535:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:2535:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:2535:27: sparse:     got void *
   drivers/scsi/gdth.c:2536:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:2536:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:2536:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:2536:25: sparse:     got void *
   drivers/scsi/gdth.c:2538:13: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/gdth.c:2538:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/gdth.c:2538:13: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:2538:13: sparse:     got void *
   drivers/scsi/gdth.c:2539:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:2539:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:2539:13: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:2539:13: sparse:     got void *
   drivers/scsi/gdth.c:1940:31: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] last_block_no @@     got restricted __be32 [usertype] @@
   drivers/scsi/gdth.c:1940:31: sparse:     expected unsigned int [assigned] [usertype] last_block_no
   drivers/scsi/gdth.c:1940:31: sparse:     got restricted __be32 [usertype]
   drivers/scsi/gdth.c:1941:27: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [assigned] [usertype] block_length @@     got restricted __be32 [usertype] @@
   drivers/scsi/gdth.c:1941:27: sparse:     expected unsigned int [assigned] [usertype] block_length
   drivers/scsi/gdth.c:1941:27: sparse:     got restricted __be32 [usertype]
   drivers/scsi/gdth.c:1951:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned long long [usertype] last_block_no @@     got restricted __be64 [usertype] @@
   drivers/scsi/gdth.c:1951:33: sparse:     expected unsigned long long [usertype] last_block_no
   drivers/scsi/gdth.c:1951:33: sparse:     got restricted __be64 [usertype]
   drivers/scsi/gdth.c:1952:33: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] block_length @@     got restricted __be32 [usertype] @@
   drivers/scsi/gdth.c:1952:33: sparse:     expected unsigned int [usertype] block_length
   drivers/scsi/gdth.c:1952:33: sparse:     got restricted __be32 [usertype]
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2045:23: sparse: sparse: cast to restricted __be64
   drivers/scsi/gdth.c:2047:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2047:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2047:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2047:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2047:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2047:24: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2050:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2050:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2050:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2050:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2050:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2050:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2052:24: sparse: sparse: cast to restricted __be16
   drivers/scsi/gdth.c:2052:24: sparse: sparse: cast to restricted __be16
   drivers/scsi/gdth.c:2052:24: sparse: sparse: cast to restricted __be16
   drivers/scsi/gdth.c:2052:24: sparse: sparse: cast to restricted __be16
   drivers/scsi/gdth.c:2055:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2055:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2055:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2055:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2055:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:2055:23: sparse: sparse: cast to restricted __be32
   drivers/scsi/gdth.c:899:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:899:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:899:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:899:9: sparse:     got void *
   drivers/scsi/gdth.c:900:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:900:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:900:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:900:9: sparse:     got void *
   drivers/scsi/gdth.c:938:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:938:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:938:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:938:25: sparse:     got void *
   drivers/scsi/gdth.c:1052:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:1052:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:1052:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:1052:9: sparse:     got void *
   drivers/scsi/gdth.c:692:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:692:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:692:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:692:9: sparse:     got void *
   drivers/scsi/gdth.c:693:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:693:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:693:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:693:9: sparse:     got void *
   drivers/scsi/gdth.c:701:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:701:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:701:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:701:9: sparse:     got void *
   drivers/scsi/gdth.c:731:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:731:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:731:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:731:9: sparse:     got void *
   drivers/scsi/gdth.c:921:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:921:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:921:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:921:23: sparse:     got void *
   drivers/scsi/gdth.c:972:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/gdth.c:972:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/gdth.c:972:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/gdth.c:972:9: sparse:     got void *
   drivers/scsi/gdth.c:1816:31: sparse: sparse: context imbalance in 'gdth_next' - unexpected unlock
   drivers/scsi/gdth.c:2504:35: sparse: sparse: context imbalance in '__gdth_interrupt' - unexpected unlock
   drivers/scsi/gdth.c:3911:50: sparse: sparse: cast truncates bits from constant value (508 becomes 8)
--
>> drivers/scsi/initio.c:1132:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/initio.c:1132:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/initio.c:1132:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1132:21: sparse:     got void *
   drivers/scsi/initio.c:1306:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/initio.c:1306:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/initio.c:1306:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1306:9: sparse:     got void *
   drivers/scsi/initio.c:1309:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1309:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1309:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1309:17: sparse:     got void *
   drivers/scsi/initio.c:1310:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1310:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1310:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1310:17: sparse:     got void *
   drivers/scsi/initio.c:1313:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1313:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1313:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1313:25: sparse:     got void *
   drivers/scsi/initio.c:1314:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1314:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1314:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1314:25: sparse:     got void *
   drivers/scsi/initio.c:1318:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1318:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1318:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1318:25: sparse:     got void *
   drivers/scsi/initio.c:1319:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1319:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1319:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1319:25: sparse:     got void *
   drivers/scsi/initio.c:1320:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1320:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1320:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1320:25: sparse:     got void *
   drivers/scsi/initio.c:1321:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1321:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1321:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1321:25: sparse:     got void *
   drivers/scsi/initio.c:1324:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1324:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1324:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1324:25: sparse:     got void *
   drivers/scsi/initio.c:1325:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1325:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1325:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1325:25: sparse:     got void *
   drivers/scsi/initio.c:1326:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1326:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1326:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1326:25: sparse:     got void *
   drivers/scsi/initio.c:1327:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1327:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1327:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1327:25: sparse:     got void *
   drivers/scsi/initio.c:1328:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1328:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1328:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1328:25: sparse:     got void *
   drivers/scsi/initio.c:1330:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1330:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1330:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1330:17: sparse:     got void *
   drivers/scsi/initio.c:1334:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1334:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1334:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1334:9: sparse:     got void *
   drivers/scsi/initio.c:1335:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1335:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1335:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1335:9: sparse:     got void *
   drivers/scsi/initio.c:1335:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1335:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1335:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1335:9: sparse:     got void *
   drivers/scsi/initio.c:1360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1360:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1360:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1360:9: sparse:     got void *
   drivers/scsi/initio.c:1365:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1365:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1365:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1365:9: sparse:     got void *
   drivers/scsi/initio.c:1366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1366:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1366:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1366:9: sparse:     got void *
   drivers/scsi/initio.c:1366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1366:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1366:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1366:9: sparse:     got void *
   drivers/scsi/initio.c:1391:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1391:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1391:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1391:33: sparse:     got void *
   drivers/scsi/initio.c:1392:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1392:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1392:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1392:25: sparse:     got void *
   drivers/scsi/initio.c:1412:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1412:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1412:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/initio.c:1412:33: sparse:     got void *
   drivers/scsi/initio.c:1413:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/initio.c:1413:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/initio.c:1413:33: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/scsi/a100u2w.c:144:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/a100u2w.c:144:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/a100u2w.c:144:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:144:21: sparse:     got void *
   drivers/scsi/a100u2w.c:156:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:156:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:156:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:156:21: sparse:     got void *
   drivers/scsi/a100u2w.c:169:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:169:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:169:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:169:23: sparse:     got void *
   drivers/scsi/a100u2w.c:182:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:182:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:182:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:182:23: sparse:     got void *
   drivers/scsi/a100u2w.c:195:30: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:195:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:195:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:195:30: sparse:     got void *
   drivers/scsi/a100u2w.c:208:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/a100u2w.c:208:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/a100u2w.c:208:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:208:9: sparse:     got void *
   drivers/scsi/a100u2w.c:209:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:209:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:209:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:209:9: sparse:     got void *
   drivers/scsi/a100u2w.c:215:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:215:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:215:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:215:19: sparse:     got void *
   drivers/scsi/a100u2w.c:216:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:216:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:216:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:216:9: sparse:     got void *
   drivers/scsi/a100u2w.c:220:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:220:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:220:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:220:20: sparse:     got void *
   drivers/scsi/a100u2w.c:221:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:221:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:221:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:221:9: sparse:     got void *
   drivers/scsi/a100u2w.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:229:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:229:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:229:9: sparse:     got void *
   drivers/scsi/a100u2w.c:230:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:230:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:230:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:230:9: sparse:     got void *
   drivers/scsi/a100u2w.c:234:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:234:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:234:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:234:9: sparse:     got void *
   drivers/scsi/a100u2w.c:235:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:235:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:235:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:235:9: sparse:     got void *
   drivers/scsi/a100u2w.c:239:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:239:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:239:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:239:9: sparse:     got void *
   drivers/scsi/a100u2w.c:240:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:240:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:240:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:240:9: sparse:     got void *
   drivers/scsi/a100u2w.c:252:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:252:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:252:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:252:9: sparse:     got void *
   drivers/scsi/a100u2w.c:253:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:253:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:253:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:253:9: sparse:     got void *
   drivers/scsi/a100u2w.c:257:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:257:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:257:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:257:9: sparse:     got void *
   drivers/scsi/a100u2w.c:258:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:258:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:258:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:258:9: sparse:     got void *
   drivers/scsi/a100u2w.c:264:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:264:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:264:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:264:16: sparse:     got void *
   drivers/scsi/a100u2w.c:265:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:265:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:265:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:265:9: sparse:     got void *
   drivers/scsi/a100u2w.c:280:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:280:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:280:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:280:9: sparse:     got void *
   drivers/scsi/a100u2w.c:375:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:375:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:375:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:375:16: sparse:     got void *
   drivers/scsi/a100u2w.c:376:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:376:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:376:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:376:9: sparse:     got void *
   drivers/scsi/a100u2w.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:377:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:377:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:377:9: sparse:     got void *
   drivers/scsi/a100u2w.c:378:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:378:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:378:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:378:9: sparse:     got void *
   drivers/scsi/a100u2w.c:379:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:379:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:379:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:379:13: sparse:     got void *
   drivers/scsi/a100u2w.c:380:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:380:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:380:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/a100u2w.c:380:17: sparse:     got void *
   drivers/scsi/a100u2w.c:383:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/a100u2w.c:383:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/a100u2w.c:383:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/ata/pata_artop.c:405:21: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_artop.c:405:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/pata_artop.c:405:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_artop.c:405:21: sparse:     got void *
--
>> drivers/ata/pata_hpt3x2n.c:417:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_hpt3x2n.c:417:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/pata_hpt3x2n.c:417:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_hpt3x2n.c:417:16: sparse:     got void *
   drivers/ata/pata_hpt3x2n.c:601:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_hpt3x2n.c:601:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_hpt3x2n.c:601:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_hpt3x2n.c:601:17: sparse:     got void *
   drivers/ata/pata_hpt3x2n.c:601:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_hpt3x2n.c:601:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/pata_hpt3x2n.c:601:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_hpt3x2n.c:601:17: sparse:     got void *
--
>> drivers/ata/pata_legacy.c:274:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_legacy.c:274:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/pata_legacy.c:274:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:274:17: sparse:     got void *
   drivers/ata/pata_legacy.c:266:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:266:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:266:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:266:17: sparse:     got void *
   drivers/ata/pata_legacy.c:267:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:267:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:267:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:267:17: sparse:     got void *
   drivers/ata/pata_legacy.c:267:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/ata/pata_legacy.c:267:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/ata/pata_legacy.c:267:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:267:17: sparse:     got void *
   drivers/ata/pata_legacy.c:268:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:268:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:268:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:268:17: sparse:     got void *
   drivers/ata/pata_legacy.c:269:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:269:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:269:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:269:17: sparse:     got void *
   drivers/ata/pata_legacy.c:270:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:270:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:270:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:270:17: sparse:     got void *
   drivers/ata/pata_legacy.c:271:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:271:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:271:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:271:17: sparse:     got void *
   drivers/ata/pata_legacy.c:272:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:272:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:272:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:272:17: sparse:     got void *
   drivers/ata/pata_legacy.c:278:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:278:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:278:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:278:9: sparse:     got void *
   drivers/ata/pata_legacy.c:278:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:278:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:278:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:278:9: sparse:     got void *
   drivers/ata/pata_legacy.c:280:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:280:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:280:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:280:14: sparse:     got void *
   drivers/ata/pata_legacy.c:286:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:286:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:286:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:286:9: sparse:     got void *
   drivers/ata/pata_legacy.c:286:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:286:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:286:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:286:9: sparse:     got void *
   drivers/ata/pata_legacy.c:288:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:288:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:288:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:288:9: sparse:     got void *
   drivers/ata/pata_legacy.c:359:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:359:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:359:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:359:9: sparse:     got void *
   drivers/ata/pata_legacy.c:360:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:360:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:360:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:360:9: sparse:     got void *
   drivers/ata/pata_legacy.c:361:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:361:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:361:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:361:9: sparse:     got void *
   drivers/ata/pata_legacy.c:362:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:362:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:362:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:362:9: sparse:     got void *
   drivers/ata/pata_legacy.c:393:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:393:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:393:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:393:9: sparse:     got void *
   drivers/ata/pata_legacy.c:394:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:394:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:394:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:394:9: sparse:     got void *
   drivers/ata/pata_legacy.c:395:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:395:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:395:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:395:9: sparse:     got void *
   drivers/ata/pata_legacy.c:396:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:396:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:396:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:396:9: sparse:     got void *
   drivers/ata/pata_legacy.c:401:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:401:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:401:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:401:28: sparse:     got void *
   drivers/ata/pata_legacy.c:404:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:404:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:404:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:404:25: sparse:     got void *
   drivers/ata/pata_legacy.c:433:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:433:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:433:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:433:9: sparse:     got void *
   drivers/ata/pata_legacy.c:434:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:434:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:434:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:434:13: sparse:     got void *
   drivers/ata/pata_legacy.c:659:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:659:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:659:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/ata/pata_legacy.c:659:17: sparse:     got void *
   drivers/ata/pata_legacy.c:661:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/ata/pata_legacy.c:661:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/ata/pata_legacy.c:661:17: sparse:     expected void volatile [noderef] __iomem *addr
--
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse: sparse: invalid assignment: |=
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    left side has type unsigned int
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1536:25: sparse:    right side has type restricted __le32
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1541:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sgptr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     expected unsigned int [usertype] sgptr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1551:34: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:406:21: sparse:     got void *
   drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:418:17: sparse:     got void *
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] addr @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     expected unsigned int [usertype] addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:480:18: sparse:     got restricted __le32 [usertype]
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] len @@     got restricted __le32 [usertype] @@
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     expected unsigned int [usertype] len
   drivers/scsi/aic7xxx/aic7xxx_osm.c:487:17: sparse:     got restricted __le32 [usertype]
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr @@
>> drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse:     expected void [noderef] __iomem *addr
   drivers/scsi/aic7xxx/aic7xxx_osm.c:1241:41: sparse:     got unsigned char volatile [noderef] [usertype] __iomem *[usertype] maddr
--
>> drivers/scsi/aacraid/nark.c:35:28: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got void volatile [noderef] __iomem *base @@
>> drivers/scsi/aacraid/nark.c:35:28: sparse:     expected void [noderef] __iomem *addr
>> drivers/scsi/aacraid/nark.c:35:28: sparse:     got void volatile [noderef] __iomem *base
--
>> drivers/scsi/aic94xx/aic94xx_reg.c:21:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/aic94xx/aic94xx_reg.c:21:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/aic94xx/aic94xx_reg.c:21:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic94xx/aic94xx_reg.c:21:17: sparse:     got void *
   drivers/scsi/aic94xx/aic94xx_reg.c:32:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic94xx/aic94xx_reg.c:32:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic94xx/aic94xx_reg.c:32:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic94xx/aic94xx_reg.c:32:17: sparse:     got void *
   drivers/scsi/aic94xx/aic94xx_reg.c:43:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic94xx/aic94xx_reg.c:43:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic94xx/aic94xx_reg.c:43:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/scsi/aic94xx/aic94xx_reg.c:43:17: sparse:     got void *
   drivers/scsi/aic94xx/aic94xx_reg.c:56:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/scsi/aic94xx/aic94xx_reg.c:56:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/scsi/aic94xx/aic94xx_reg.c:56:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/aic94xx/aic94xx_reg.c:56:23: sparse:     got void *
   drivers/scsi/aic94xx/aic94xx_reg.c:69:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic94xx/aic94xx_reg.c:69:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic94xx/aic94xx_reg.c:69:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/aic94xx/aic94xx_reg.c:69:23: sparse:     got void *
   drivers/scsi/aic94xx/aic94xx_reg.c:82:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/scsi/aic94xx/aic94xx_reg.c:82:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/scsi/aic94xx/aic94xx_reg.c:82:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/scsi/aic94xx/aic94xx_reg.c:82:23: sparse:     got void *
--
>> drivers/net/hamradio/baycom_ser_fdx.c:258:20: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/hamradio/baycom_ser_fdx.c:258:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/hamradio/baycom_ser_fdx.c:258:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:258:20: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:262:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:262:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:262:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:262:15: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:269:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:269:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:269:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:269:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:273:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:273:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:273:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:273:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:282:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/hamradio/baycom_ser_fdx.c:282:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/hamradio/baycom_ser_fdx.c:282:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:282:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:290:33: sparse: sparse: dubious: x | !y
   drivers/net/hamradio/baycom_ser_fdx.c:290:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:290:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:290:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:290:33: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:292:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:292:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:292:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:292:33: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:296:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:296:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:296:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:296:31: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:302:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:302:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:302:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:302:23: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:348:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:348:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:348:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:348:14: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:349:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:349:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:349:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:349:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:350:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:350:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:350:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:350:14: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:351:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:351:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:351:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:351:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:352:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:352:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:352:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:352:14: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:353:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:353:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:353:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:353:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:354:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:354:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:354:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:354:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:357:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:357:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:357:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:357:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:358:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:358:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:358:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:358:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:359:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:359:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:359:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:359:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:360:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:360:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:360:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:360:23: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:362:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:362:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:362:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:362:17: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:363:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:363:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:363:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:363:22: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:364:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:364:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:364:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:364:17: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:365:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:365:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:365:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:365:22: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:406:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:406:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:406:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:406:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:407:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:407:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:407:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:407:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:408:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:408:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:408:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:408:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:425:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:425:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:425:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:425:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:431:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:431:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_fdx.c:431:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_fdx.c:431:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_fdx.c:449:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_fdx.c:449:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
--
>> drivers/bluetooth/dtl1_cs.c:115:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/dtl1_cs.c:115:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/dtl1_cs.c:115:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:115:15: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:121:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/dtl1_cs.c:121:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/dtl1_cs.c:121:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:121:17: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:285:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:285:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:285:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:285:18: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:229:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:229:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:229:42: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:229:42: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:306:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:306:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:306:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:306:15: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:311:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:311:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:311:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:311:23: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:336:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:336:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:336:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:336:23: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:340:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:340:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:340:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:340:15: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:472:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:472:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:472:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:472:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:475:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:475:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:475:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:475:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:478:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:478:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:478:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:478:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:479:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:479:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:479:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:479:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:481:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:481:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:481:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:481:26: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:485:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:485:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:485:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:485:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:518:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:518:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:518:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:518:9: sparse:     got void *
   drivers/bluetooth/dtl1_cs.c:521:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/dtl1_cs.c:521:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/dtl1_cs.c:521:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/dtl1_cs.c:521:9: sparse:     got void *
--
>> drivers/bluetooth/bt3c_cs.c:249:58: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/bt3c_cs.c:249:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/bt3c_cs.c:249:58: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:249:58: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:250:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:250:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:250:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:250:25: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:283:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:283:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:283:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:283:34: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:286:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:286:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:286:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:286:25: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:349:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:349:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:349:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:349:15: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:370:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/bluetooth/bt3c_cs.c:370:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/bluetooth/bt3c_cs.c:370:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:370:25: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:524:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:524:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:125:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:126:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:119:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:119:9: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:139:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:139:32: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:141:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/bluetooth/bt3c_cs.c:141:18: sparse:     got void *
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/bluetooth/bt3c_cs.c:118:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/bluetooth/bt3c_cs.c:118:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/net/ethernet/sis/sis190.c:1649:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/sis/sis190.c:1649:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/sis/sis190.c:1649:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/sis/sis190.c:1649:17: sparse:     got void *
   drivers/net/ethernet/sis/sis190.c:1650:36: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/sis/sis190.c:1650:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/sis/sis190.c:1650:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/sis/sis190.c:1650:36: sparse:     got void *
   drivers/net/ethernet/sis/sis190.c:1653:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/sis/sis190.c:1653:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/sis/sis190.c:1653:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/sis/sis190.c:1653:9: sparse:     got void *
   drivers/net/ethernet/sis/sis190.c:1654:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/sis/sis190.c:1654:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/sis/sis190.c:1654:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/sis/sis190.c:1654:15: sparse:     got void *
--
>> drivers/net/ethernet/sis/sis900.c:308:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/sis/sis900.c:308:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/sis/sis900.c:308:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/sis/sis900.c:308:17: sparse:     got void *
   drivers/net/ethernet/sis/sis900.c:309:50: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/sis/sis900.c:309:50: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/sis/sis900.c:309:50: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/sis/sis900.c:309:50: sparse:     got void *
--
>> drivers/net/ethernet/ti/tlan.c:688:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/ti/tlan.c:688:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/ti/tlan.c:688:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:688:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:690:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:690:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:690:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:690:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:700:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:700:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:700:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:700:21: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:705:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:705:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:705:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:705:29: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:712:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:712:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:712:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:712:21: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:722:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:722:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:722:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:722:25: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1108:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/ti/tlan.c:1108:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/ti/tlan.c:1108:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1108:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1109:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1109:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1109:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1109:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1162:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1162:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1162:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1162:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1168:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1168:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1168:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1168:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1173:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1173:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1173:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1173:25: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:534:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:534:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:534:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:534:29: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1419:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1419:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1419:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1419:25: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1572:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1572:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1572:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1572:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1662:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1662:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1662:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1662:25: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1709:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1709:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1709:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1709:25: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1712:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1712:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1712:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1712:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:1787:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:1787:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:1787:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:1787:17: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2101:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2101:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2101:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2101:9: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2102:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2102:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2102:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2102:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2103:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2103:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2103:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2103:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2104:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2104:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2104:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2104:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2105:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2105:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2105:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2105:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2107:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2107:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2107:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2107:9: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2108:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2108:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2108:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2108:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2109:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2109:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2109:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2109:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2110:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2110:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2110:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2110:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2111:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2111:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2111:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2111:20: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2113:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2113:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2113:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2113:9: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2114:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2114:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2114:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2114:19: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2115:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2115:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2115:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/ti/tlan.c:2115:19: sparse:     got void *
   drivers/net/ethernet/ti/tlan.c:2116:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/ti/tlan.c:2116:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/ti/tlan.c:2116:19: sparse:     expected void const volatile [noderef] __iomem *addr

vim +/__iomem +2103 sound/pci/ctxfi/cthw20k1.c

29959a09cc1aab Wai Yew CHAY 2009-06-22  2095  
8cc72361481f00 Wai Yew CHAY 2009-05-14  2096  static u32 hw_read_20kx(struct hw *hw, u32 reg)
8cc72361481f00 Wai Yew CHAY 2009-05-14  2097  {
8cc72361481f00 Wai Yew CHAY 2009-05-14  2098  	u32 value;
8cc72361481f00 Wai Yew CHAY 2009-05-14  2099  	unsigned long flags;
8cc72361481f00 Wai Yew CHAY 2009-05-14  2100  
8cc72361481f00 Wai Yew CHAY 2009-05-14  2101  	spin_lock_irqsave(
8cc72361481f00 Wai Yew CHAY 2009-05-14  2102  		&container_of(hw, struct hw20k1, hw)->reg_20k1_lock, flags);
8cc72361481f00 Wai Yew CHAY 2009-05-14 @2103  	outl(reg, hw->io_base + 0x0);
8cc72361481f00 Wai Yew CHAY 2009-05-14 @2104  	value = inl(hw->io_base + 0x4);
8cc72361481f00 Wai Yew CHAY 2009-05-14  2105  	spin_unlock_irqrestore(
8cc72361481f00 Wai Yew CHAY 2009-05-14  2106  		&container_of(hw, struct hw20k1, hw)->reg_20k1_lock, flags);
8cc72361481f00 Wai Yew CHAY 2009-05-14  2107  
8cc72361481f00 Wai Yew CHAY 2009-05-14  2108  	return value;
8cc72361481f00 Wai Yew CHAY 2009-05-14  2109  }
8cc72361481f00 Wai Yew CHAY 2009-05-14  2110  

:::::: The code at line 2103 was first introduced by commit
:::::: 8cc72361481f00253f1e468ade5795427386d593 ALSA: SB X-Fi driver merge

:::::: TO: Wai Yew CHAY <wychay@ctl.creative.com>
:::::: CC: Takashi Iwai <tiwai@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--uAKRQypu60I7Lcqm
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--uAKRQypu60I7Lcqm--
