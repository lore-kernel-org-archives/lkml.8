Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3812C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:16:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 91E7A20781
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 07:16:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgHKHQE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 03:16:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:61141 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726397AbgHKHQE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 03:16:04 -0400
IronPort-SDR: C6DlCK6UEbn/+z+Kx9PgB5lOHUyRQGJNvIXeJCJ8i2Fk99dpgbA8YFZvGypS2KaD/frW0Fb0Uy
 XdW3/BMvl41w==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="152894378"
X-IronPort-AV: E=Sophos;i="5.75,459,1589266800"; 
   d="gz'50?scan'50,208,50";a="152894378"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 22:57:00 -0700
IronPort-SDR: UpHxaByG38zBmbu7hEnJzOTTMte1cSLCZfS3YvDes1/Ndx3oYNgq8fmWsgRj7ADbhUVmu1nH1J
 t1Ttwf1L9FZA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,459,1589266800"; 
   d="gz'50?scan'50,208,50";a="494568685"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by fmsmga006.fm.intel.com with ESMTP; 10 Aug 2020 22:56:58 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5NHN-0000OA-It; Tue, 11 Aug 2020 05:56:57 +0000
Date:   Tue, 11 Aug 2020 13:56:38 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/tridentfb.c:736:9: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202008111326.yi3LhmgS%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="dDRMvlgZJXvWKvBx"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--dDRMvlgZJXvWKvBx
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   086ba2ec163b638abd2a90ef3e8bab0238d02e56
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: riscv-randconfig-s032-20200810 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-141-g19506bc2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/video/fbdev/tridentfb.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:736:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tridentfb.c:736:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tridentfb.c:736:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tridentfb.c:736:9: sparse:     got void *
   drivers/video/fbdev/tridentfb.c:737:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/tridentfb.c:737:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/tridentfb.c:737:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/video/fbdev/tridentfb.c:737:9: sparse:     got void *
   drivers/video/fbdev/tridentfb.c:737:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:737:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/tridentfb.c:737:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/tridentfb.c:737:9: sparse:     got void *
   drivers/video/fbdev/tridentfb.c:1323:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:181:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:171:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:181:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/tty/serial/jsm/jsm_driver.c:170:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/jsm/jsm_driver.c:170:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/serial/jsm/jsm_driver.c:170:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/jsm/jsm_driver.c:170:17: sparse:     got void *
   drivers/tty/serial/jsm/jsm_driver.c:273:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/jsm/jsm_driver.c:273:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/jsm/jsm_driver.c:273:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/tty/serial/jsm/jsm_driver.c:273:17: sparse:     got void *
--
>> drivers/net/wan/farsync.c:1506:30: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/wan/farsync.c:1506:30: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/wan/farsync.c:1506:30: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:1506:30: sparse:     got void *
   drivers/net/wan/farsync.c:1512:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/wan/farsync.c:1512:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/wan/farsync.c:1512:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:1512:25: sparse:     got void *
   drivers/net/wan/farsync.c:1524:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:1524:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:1524:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:1524:25: sparse:     got void *
   drivers/net/wan/farsync.c:2214:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:2214:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:2214:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:2214:23: sparse:     got void *
   drivers/net/wan/farsync.c:2215:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:2215:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:2215:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:2215:23: sparse:     got void *
   drivers/net/wan/farsync.c:892:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:892:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:892:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:892:9: sparse:     got void *
   drivers/net/wan/farsync.c:893:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:893:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:893:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:893:9: sparse:     got void *
   drivers/net/wan/farsync.c:894:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:894:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:894:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:894:9: sparse:     got void *
   drivers/net/wan/farsync.c:895:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:895:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:895:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:895:9: sparse:     got void *
   drivers/net/wan/farsync.c:901:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:901:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:901:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:901:9: sparse:     got void *
   drivers/net/wan/farsync.c:919:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:919:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:919:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:919:9: sparse:     got void *
   drivers/net/wan/farsync.c:920:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:920:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:920:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:920:9: sparse:     got void *
   drivers/net/wan/farsync.c:921:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:921:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:921:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:921:9: sparse:     got void *
   drivers/net/wan/farsync.c:922:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:922:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:922:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:922:9: sparse:     got void *
   drivers/net/wan/farsync.c:928:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:928:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:928:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:928:9: sparse:     got void *
   drivers/net/wan/farsync.c:749:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:749:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:749:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:749:17: sparse:     got void *
   drivers/net/wan/farsync.c:749:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:749:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:749:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:749:17: sparse:     got void *
   drivers/net/wan/farsync.c:690:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:690:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:690:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:690:17: sparse:     got void *
   drivers/net/wan/farsync.c:691:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:691:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:691:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:691:17: sparse:     got void *
   drivers/net/wan/farsync.c:696:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:696:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:696:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:696:17: sparse:     got void *
   drivers/net/wan/farsync.c:701:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:701:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:701:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:701:17: sparse:     got void *
   drivers/net/wan/farsync.c:710:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:710:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:710:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:710:26: sparse:     got void *
   drivers/net/wan/farsync.c:712:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:712:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:712:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:712:17: sparse:     got void *
   drivers/net/wan/farsync.c:713:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:713:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:713:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:713:17: sparse:     got void *
   drivers/net/wan/farsync.c:732:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:732:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:732:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:732:17: sparse:     got void *
   drivers/net/wan/farsync.c:733:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:733:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:733:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wan/farsync.c:733:17: sparse:     got void *
   drivers/net/wan/farsync.c:759:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wan/farsync.c:759:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wan/farsync.c:759:17: sparse:     expected void volatile [noderef] __iomem *addr
--
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
   sound/pci/cs46xx/cs46xx_lib.c:534:5: sparse: sparse: symbol 'snd_cs46xx_download_image' was not declared. Should it be static?
>> sound/pci/cs46xx/cs46xx_lib.c:3585:26: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/cs46xx/cs46xx_lib.c:3585:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/cs46xx/cs46xx_lib.c:3585:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cs46xx/cs46xx_lib.c:3585:26: sparse:     got void *
   sound/pci/cs46xx/cs46xx_lib.c:3593:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/cs46xx/cs46xx_lib.c:3593:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/cs46xx/cs46xx_lib.c:3593:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cs46xx/cs46xx_lib.c:3593:17: sparse:     got void *
--
>> sound/pci/ice1712/ice1724.c:128:27: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/ice1724.c:128:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/ice1724.c:128:27: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:128:27: sparse:     got void *
   sound/pci/ice1712/ice1724.c:143:22: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:143:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:143:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:143:22: sparse:     got void *
   sound/pci/ice1712/ice1724.c:159:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/ice1724.c:159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/ice1724.c:159:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:159:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:160:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:161:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:161:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:161:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:161:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:173:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:173:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:173:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:173:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:174:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:174:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:174:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:174:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:177:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:177:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:177:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:177:16: sparse:     got void *
   sound/pci/ice1712/ice1724.c:188:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:188:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:188:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:188:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:189:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:189:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:189:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:189:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:195:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:195:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:195:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:195:16: sparse:     got void *
   sound/pci/ice1712/ice1724.c:201:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:201:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:201:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:201:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:203:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:203:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:203:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:203:17: sparse:     got void *
   sound/pci/ice1712/ice1724.c:204:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:204:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:204:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:204:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:211:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:211:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:211:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:211:38: sparse:     got void *
   sound/pci/ice1712/ice1724.c:214:31: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:214:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:214:31: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:214:31: sparse:     got void *
   sound/pci/ice1712/ice1724.c:220:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:220:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:220:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:220:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:222:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:222:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:222:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:222:17: sparse:     got void *
   sound/pci/ice1712/ice1724.c:223:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:223:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:223:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:223:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:230:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:230:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:230:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:230:38: sparse:     got void *
   sound/pci/ice1712/ice1724.c:233:31: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:233:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:233:31: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:233:31: sparse:     got void *
   sound/pci/ice1712/ice1724.c:245:22: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:245:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:245:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:245:22: sparse:     got void *
   sound/pci/ice1712/ice1724.c:246:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:246:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:246:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:246:17: sparse:     got void *
   sound/pci/ice1712/ice1724.c:297:19: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:297:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:297:19: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:297:19: sparse:     got void *
   sound/pci/ice1712/ice1724.c:302:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:302:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:302:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:302:9: sparse:     got void *
   sound/pci/ice1712/ice1724.c:265:22: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:265:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:265:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:265:22: sparse:     got void *
   sound/pci/ice1712/ice1724.c:269:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:269:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:269:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/ice1724.c:269:25: sparse:     got void *
   sound/pci/ice1712/ice1724.c:285:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/ice1724.c:285:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/ice1724.c:285:17: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pci/ice1712/revo.c:30:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/revo.c:30:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/revo.c:30:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/revo.c:30:9: sparse:     got void *
>> sound/pci/ice1712/revo.c:30:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/revo.c:30:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/revo.c:30:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/revo.c:30:9: sparse:     got void *
   sound/pci/ice1712/revo.c:33:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/revo.c:33:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/revo.c:33:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/revo.c:33:9: sparse:     got void *
   sound/pci/ice1712/revo.c:33:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/revo.c:33:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/revo.c:33:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/revo.c:33:9: sparse:     got void *
--
>> sound/pci/ice1712/pontis.c:764:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/pontis.c:764:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/pontis.c:764:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/pontis.c:764:9: sparse:     got void *
>> sound/pci/ice1712/pontis.c:764:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/pontis.c:764:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/pontis.c:764:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/pontis.c:764:9: sparse:     got void *
   sound/pci/ice1712/pontis.c:767:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/pontis.c:767:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/pontis.c:767:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/pontis.c:767:9: sparse:     got void *
   sound/pci/ice1712/pontis.c:767:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/pontis.c:767:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/pontis.c:767:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/pontis.c:767:9: sparse:     got void *
--
>> sound/pci/ice1712/juli.c:238:15: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/juli.c:238:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/juli.c:238:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/juli.c:238:15: sparse:     got void *
   sound/pci/ice1712/juli.c:239:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/juli.c:239:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/juli.c:239:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/juli.c:239:9: sparse:     got void *
   sound/pci/ice1712/juli.c:241:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/juli.c:241:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/juli.c:241:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/juli.c:241:9: sparse:     got void *
   sound/pci/ice1712/juli.c:529:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/juli.c:529:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/juli.c:529:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/juli.c:529:15: sparse:     got void *
   sound/pci/ice1712/juli.c:530:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/juli.c:530:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/juli.c:530:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/juli.c:530:9: sparse:     got void *
--
>> sound/pci/ice1712/quartet.c:851:15: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/quartet.c:851:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/quartet.c:851:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/quartet.c:851:15: sparse:     got void *
   sound/pci/ice1712/quartet.c:852:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/ice1712/quartet.c:852:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/ice1712/quartet.c:852:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/quartet.c:852:9: sparse:     got void *
   sound/pci/ice1712/quartet.c:988:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/quartet.c:988:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/quartet.c:988:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/ice1712/quartet.c:988:15: sparse:     got void *
   sound/pci/ice1712/quartet.c:989:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/ice1712/quartet.c:989:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/ice1712/quartet.c:989:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/ice1712/quartet.c:989:9: sparse:     got void *
--
>> sound/pci/riptide/riptide.c:855:40: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/riptide/riptide.c:855:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/riptide/riptide.c:855:40: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:855:40: sparse:     got void *
   sound/pci/riptide/riptide.c:865:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:865:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:865:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:865:21: sparse:     got void *
   sound/pci/riptide/riptide.c:866:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:866:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:866:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:866:25: sparse:     got void *
   sound/pci/riptide/riptide.c:867:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:867:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:867:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:867:25: sparse:     got void *
   sound/pci/riptide/riptide.c:869:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:869:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:869:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:869:21: sparse:     got void *
   sound/pci/riptide/riptide.c:871:33: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/riptide/riptide.c:871:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/riptide/riptide.c:871:33: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:871:33: sparse:     got void *
   sound/pci/riptide/riptide.c:872:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:872:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:872:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:872:25: sparse:     got void *
   sound/pci/riptide/riptide.c:874:41: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:874:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:874:41: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:874:41: sparse:     got void *
   sound/pci/riptide/riptide.c:881:45: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:881:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:881:45: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:881:45: sparse:     got void *
   sound/pci/riptide/riptide.c:883:45: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:883:45: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:883:45: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:883:45: sparse:     got void *
   sound/pci/riptide/riptide.c:919:42: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:919:42: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:919:42: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:919:42: sparse:     got void *
   sound/pci/riptide/riptide.c:919:60: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:919:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:919:60: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:919:60: sparse:     got void *
   sound/pci/riptide/riptide.c:1788:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1788:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1788:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1788:17: sparse:     got void *
   sound/pci/riptide/riptide.c:1788:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1788:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1788:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1788:17: sparse:     got void *
   sound/pci/riptide/riptide.c:1295:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1295:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1295:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1295:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1295:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1295:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1295:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1295:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1296:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1296:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1296:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1296:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1296:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1296:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1296:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1297:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1297:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1297:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1297:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1297:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1297:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1297:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1297:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1122:38: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1122:38: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1122:38: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1122:38: sparse:     got void *
   sound/pci/riptide/riptide.c:1175:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1175:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1175:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1175:17: sparse:     got void *
   sound/pci/riptide/riptide.c:1176:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1176:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1176:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1176:17: sparse:     got void *
   sound/pci/riptide/riptide.c:1178:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1178:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1178:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1178:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1178:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1178:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1178:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1178:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1180:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1180:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1180:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1180:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1180:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1180:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1180:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1180:9: sparse:     got void *
   sound/pci/riptide/riptide.c:1184:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1184:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1184:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1184:21: sparse:     got void *
   sound/pci/riptide/riptide.c:1184:47: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1184:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1184:47: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1184:47: sparse:     got void *
   sound/pci/riptide/riptide.c:1188:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1188:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1188:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/riptide/riptide.c:1188:17: sparse:     got void *
   sound/pci/riptide/riptide.c:1188:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/riptide/riptide.c:1188:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/riptide/riptide.c:1188:17: sparse:     expected void const volatile [noderef] __iomem *addr

vim +736 drivers/video/fbdev/tridentfb.c

^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  538  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  539  /*
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  540   * TGUI 9440/96XX acceleration
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  541   */
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  542  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  543  static void tgui_init_accel(struct tridentfb_par *par, int pitch, int bpp)
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  544  {
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  545  	unsigned char x = bpp == 24 ? 3 : (bpp >> 4);
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  546  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  547  	/* disable clipping */
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  548  	writemmr(par, 0x2148, 0);
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  549  	writemmr(par, 0x214C, point(4095, 2047));
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  550  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  551  	switch ((pitch * bpp) / 8) {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  552  	case 8192:
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  553  	case 512:
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  554  		x |= 0x00;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  555  		break;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  556  	case 1024:
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  557  		x |= 0x04;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  558  		break;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  559  	case 2048:
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  560  		x |= 0x08;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  561  		break;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  562  	case 4096:
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  563  		x |= 0x0C;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  564  		break;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  565  	}
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  566  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23 @567  	fb_writew(x, par->io_virt + 0x2122);
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  568  }
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  569  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  570  static void tgui_fill_rect(struct tridentfb_par *par,
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  571  			   u32 x, u32 y, u32 w, u32 h, u32 c, u32 rop)
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  572  {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  573  	t_outb(par, ROP_P, 0x2127);
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  574  	writemmr(par, OLDCLR, c);
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  575  	writemmr(par, DRAWFL, 0x4020);
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  576  	writemmr(par, OLDDIM, point(w - 1, h - 1));
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  577  	writemmr(par, OLDDST, point(x, y));
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  578  	t_outb(par, 1, OLDCMD);
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  579  }
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  580  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  581  static void tgui_copy_rect(struct tridentfb_par *par,
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  582  			   u32 x1, u32 y1, u32 x2, u32 y2, u32 w, u32 h)
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  583  {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  584  	int flags = 0;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  585  	u16 x1_tmp, x2_tmp, y1_tmp, y2_tmp;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  586  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  587  	if ((x1 < x2) && (y1 == y2)) {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  588  		flags |= 0x0200;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  589  		x1_tmp = x1 + w - 1;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  590  		x2_tmp = x2 + w - 1;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  591  	} else {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  592  		x1_tmp = x1;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  593  		x2_tmp = x2;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  594  	}
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  595  
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  596  	if (y1 < y2) {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  597  		flags |= 0x0100;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  598  		y1_tmp = y1 + h - 1;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  599  		y2_tmp = y2 + h - 1;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  600  	} else {
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  601  		y1_tmp = y1;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  602  		y2_tmp = y2;
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  603  	}
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  604  
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  605  	writemmr(par, DRAWFL, 0x4 | flags);
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  606  	t_outb(par, ROP_S, 0x2127);
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  607  	writemmr(par, OLDSRC, point(x1_tmp, y1_tmp));
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  608  	writemmr(par, OLDDST, point(x2_tmp, y2_tmp));
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  609  	writemmr(par, OLDDIM, point(w - 1, h - 1));
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  610  	t_outb(par, 1, OLDCMD);
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  611  }
bcac2d5fe36238 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  612  
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  613  /*
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  614   * Accel functions called by the upper layers
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  615   */
245a2c2c69fee3 drivers/video/tridentfb.c Krzysztof Helt     2007-10-16  616  static void tridentfb_fillrect(struct fb_info *info,
245a2c2c69fee3 drivers/video/tridentfb.c Krzysztof Helt     2007-10-16  617  			       const struct fb_fillrect *fr)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  618  {
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  619  	struct tridentfb_par *par = info->par;
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  620  	int col;
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  621  
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  622  	if (info->flags & FBINFO_HWACCEL_DISABLED) {
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  623  		cfb_fillrect(info, fr);
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  624  		return;
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  625  	}
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  626  	if (info->var.bits_per_pixel == 8) {
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  627  		col = fr->color;
8dad46cf38c029 drivers/video/tridentfb.c Antonino A. Daplas 2005-08-01  628  		col |= col << 8;
8dad46cf38c029 drivers/video/tridentfb.c Antonino A. Daplas 2005-08-01  629  		col |= col << 16;
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  630  	} else
245a2c2c69fee3 drivers/video/tridentfb.c Krzysztof Helt     2007-10-16  631  		col = ((u32 *)(info->pseudo_palette))[fr->color];
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  632  
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  633  	par->wait_engine(par);
d9cad04bcde004 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  634  	par->fill_rect(par, fr->dx, fr->dy, fr->width,
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  635  		       fr->height, col, fr->rop);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  636  }
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  637  
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  638  static void tridentfb_imageblit(struct fb_info *info,
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  639  				const struct fb_image *img)
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  640  {
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  641  	struct tridentfb_par *par = info->par;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  642  	int col, bgcol;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  643  
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  644  	if ((info->flags & FBINFO_HWACCEL_DISABLED) || img->depth != 1) {
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  645  		cfb_imageblit(info, img);
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  646  		return;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  647  	}
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  648  	if (info->var.bits_per_pixel == 8) {
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  649  		col = img->fg_color;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  650  		col |= col << 8;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  651  		col |= col << 16;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  652  		bgcol = img->bg_color;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  653  		bgcol |= bgcol << 8;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  654  		bgcol |= bgcol << 16;
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  655  	} else {
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  656  		col = ((u32 *)(info->pseudo_palette))[img->fg_color];
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  657  		bgcol = ((u32 *)(info->pseudo_palette))[img->bg_color];
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  658  	}
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  659  
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  660  	par->wait_engine(par);
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  661  	if (par->image_blit)
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  662  		par->image_blit(par, img->data, img->dx, img->dy,
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  663  				img->width, img->height, col, bgcol);
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  664  	else
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  665  		cfb_imageblit(info, img);
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  666  }
0292be4a382957 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  667  
245a2c2c69fee3 drivers/video/tridentfb.c Krzysztof Helt     2007-10-16  668  static void tridentfb_copyarea(struct fb_info *info,
245a2c2c69fee3 drivers/video/tridentfb.c Krzysztof Helt     2007-10-16  669  			       const struct fb_copyarea *ca)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  670  {
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  671  	struct tridentfb_par *par = info->par;
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  672  
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  673  	if (info->flags & FBINFO_HWACCEL_DISABLED) {
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  674  		cfb_copyarea(info, ca);
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  675  		return;
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  676  	}
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  677  	par->wait_engine(par);
d9cad04bcde004 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  678  	par->copy_rect(par, ca->sx, ca->sy, ca->dx, ca->dy,
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  679  		       ca->width, ca->height);
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  680  }
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  681  
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  682  static int tridentfb_sync(struct fb_info *info)
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  683  {
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  684  	struct tridentfb_par *par = info->par;
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  685  
01a2d9ed85c945 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  686  	if (!(info->flags & FBINFO_HWACCEL_DISABLED))
d9cad04bcde004 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  687  		par->wait_engine(par);
49b1f4b44bcdc4 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  688  	return 0;
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  689  }
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  690  
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  691  /*
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  692   * Hardware access functions
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  693   */
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  694  
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  695  static inline unsigned char read3X4(struct tridentfb_par *par, int reg)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  696  {
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  697  	return vga_mm_rcrt(par->io_virt, reg);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  698  }
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  699  
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  700  static inline void write3X4(struct tridentfb_par *par, int reg,
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  701  			    unsigned char val)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  702  {
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  703  	vga_mm_wcrt(par->io_virt, reg, val);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  704  }
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  705  
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  706  static inline unsigned char read3CE(struct tridentfb_par *par,
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  707  				    unsigned char reg)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  708  {
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  709  	return vga_mm_rgfx(par->io_virt, reg);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  710  }
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  711  
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  712  static inline void writeAttr(struct tridentfb_par *par, int reg,
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  713  			     unsigned char val)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  714  {
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  715  	fb_readb(par->io_virt + VGA_IS1_RC);	/* flip-flop to index */
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  716  	vga_mm_wattr(par->io_virt, reg, val);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  717  }
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  718  
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  719  static inline void write3CE(struct tridentfb_par *par, int reg,
306fa6f60a2870 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  720  			    unsigned char val)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  721  {
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  722  	vga_mm_wgfx(par->io_virt, reg, val);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  723  }
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  724  
13b0de49f52ec8 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  725  static void enable_mmio(struct tridentfb_par *par)
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  726  {
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  727  	/* Goto New Mode */
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  728  	vga_io_rseq(0x0B);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  729  
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  730  	/* Unprotect registers */
10172ed6dc4d40 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  731  	vga_io_wseq(NewMode1, 0x80);
13b0de49f52ec8 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  732  	if (!is_oldprotect(par->chip_id))
13b0de49f52ec8 drivers/video/tridentfb.c Krzysztof Helt     2008-07-23  733  		vga_io_wseq(Protection, 0x92);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  734  
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16  735  	/* Enable MMIO */
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16 @736  	outb(PCIReg, 0x3D4);
^1da177e4c3f41 drivers/video/tridentfb.c Linus Torvalds     2005-04-16 @737  	outb(inb(0x3D5) | 0x01, 0x3D5);
e8ed857c64e3ae drivers/video/tridentfb.c Krzysztof Helt     2008-03-04  738  }
e8ed857c64e3ae drivers/video/tridentfb.c Krzysztof Helt     2008-03-04  739  

:::::: The code at line 736 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--dDRMvlgZJXvWKvBx
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--dDRMvlgZJXvWKvBx--
