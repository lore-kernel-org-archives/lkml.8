Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 41909C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:15:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B2AA52063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 02:15:41 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726500AbgGXCPk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Jul 2020 22:15:40 -0400
Received: from mga06.intel.com ([134.134.136.31]:35573 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726430AbgGXCPj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jul 2020 22:15:39 -0400
IronPort-SDR: X1k2PWC/Y5MIwd037JqZ6VgVjfb1twcsuc2APTsy6Bo3TTDkraW5uML8E8BEcyG3W1XjXC1dhh
 hl9WRblhZ1Tw==
X-IronPort-AV: E=McAfee;i="6000,8403,9691"; a="212182611"
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="gz'50?scan'50,208,50";a="212182611"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jul 2020 19:04:48 -0700
IronPort-SDR: D39Ow/1PT9EtIdL3VIou5bNMxQw2NvA75DZ8Jy8SJprmUB0GOWZdoGdbautyZsGSpewHXpky/9
 ToWzaufak3uw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,388,1589266800"; 
   d="gz'50?scan'50,208,50";a="288844390"
Received: from lkp-server01.sh.intel.com (HELO bd1a4a62506a) ([10.239.97.150])
  by orsmga006.jf.intel.com with ESMTP; 23 Jul 2020 19:04:42 -0700
Received: from kbuild by bd1a4a62506a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jyn4i-0000gg-V8; Fri, 24 Jul 2020 02:04:40 +0000
Date:   Fri, 24 Jul 2020 10:03:50 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/staging/speakup/serialio.c:139:9: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202007241040.ujLnmvm0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="17pEHd4RhPHOinZp"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--17pEHd4RhPHOinZp
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d15be546031cf65a0fc34879beca02fd90fe7ac7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   5 weeks ago
config: riscv-randconfig-s031-20200723 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-93-g4c6cbe55-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/staging/speakup/serialio.c:139:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/speakup/serialio.c:139:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/speakup/serialio.c:139:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:139:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:142:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:142:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:142:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:142:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:144:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/speakup/serialio.c:144:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/speakup/serialio.c:144:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:144:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:145:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:145:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:145:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:145:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:146:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:146:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:146:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:146:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:147:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:147:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:147:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:148:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:148:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:148:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:155:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:155:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:155:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:155:16: sparse:     got void *
   drivers/staging/speakup/serialio.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:160:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:165:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:165:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:165:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:165:19: sparse:     got void *
   drivers/staging/speakup/serialio.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:167:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:87:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:88:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:88:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:88:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:88:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:89:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:89:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:89:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:89:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:90:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:90:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:90:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:90:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:93:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:93:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:93:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:94:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:94:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:94:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:94:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:97:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:97:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:97:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:97:13: sparse:     got void *
   drivers/staging/speakup/serialio.c:208:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:208:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:208:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:208:9: sparse:     got void *
   drivers/staging/speakup/serialio.c:230:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:230:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:230:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:230:16: sparse:     got void *
   drivers/staging/speakup/serialio.c:299:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/speakup/serialio.c:299:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/speakup/serialio.c:299:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/speakup/serialio.c:299:25: sparse:     got void *
   drivers/staging/speakup/serialio.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
--
   drivers/video/fbdev/arkfb.c:135:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:136:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:194:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:216:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:252:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:813:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/fbdev/arkfb.c:813:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/fbdev/arkfb.c:813:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:813:25: sparse:     got void *
   drivers/video/fbdev/arkfb.c:814:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:814:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:814:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:814:25: sparse:     got void *
   drivers/video/fbdev/arkfb.c:816:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:816:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:816:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:816:25: sparse:     got void *
   drivers/video/fbdev/arkfb.c:817:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:817:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:817:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:817:25: sparse:     got void *
   drivers/video/fbdev/arkfb.c:819:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:819:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:819:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:819:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:820:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:820:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:820:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:820:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:821:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:821:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:821:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:821:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:827:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:827:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:827:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:827:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:828:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:828:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:828:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:828:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:829:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:829:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:829:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:829:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:830:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:830:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:830:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:830:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c:831:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:831:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/fbdev/arkfb.c:831:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/fbdev/arkfb.c:831:17: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through include/linux/svga.h):
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through include/linux/svga.h):
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through include/linux/svga.h):
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through include/linux/svga.h):
   include/video/vga.h:215:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/video/vga.h:215:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/video/vga.h:215:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/video/vga.h:215:9: sparse:     got void *
   drivers/video/fbdev/arkfb.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/fb.h):
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
--
>> drivers/staging/comedi/drivers/pcl812.c:578:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl812.c:578:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl812.c:578:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:578:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:579:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:592:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:598:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:606:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl812.c:606:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl812.c:606:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:606:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:607:16: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:620:26: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:624:26: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:754:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:902:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:918:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:933:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:951:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:952:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:964:19: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:965:20: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:976:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:977:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:992:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1005:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1006:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1011:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl812.c:1012:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adq12b.c:100:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adq12b.c:100:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adq12b.c:100:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:100:18: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:121:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adq12b.c:121:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adq12b.c:121:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:121:17: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:126:15: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:133:23: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:134:24: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:147:20: sparse:     got void *
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adq12b.c:166:33: sparse:     got void *
--
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:100:16: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:114:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:127:16: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_dio200_common.c:141:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/aio_iiro_16.c:50:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/aio_iiro_16.c:50:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/aio_iiro_16.c:50:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:50:15: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:51:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:51:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:51:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:51:16: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:63:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:63:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:63:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:63:18: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:79:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:79:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:79:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:79:17: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:81:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/aio_iiro_16.c:81:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/aio_iiro_16.c:81:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:81:17: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:145:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:145:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:145:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:145:17: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:146:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:146:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:146:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:146:17: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:202:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:202:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:202:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:202:20: sparse:     got void *
   drivers/staging/comedi/drivers/aio_iiro_16.c:203:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/aio_iiro_16.c:203:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/aio_iiro_16.c:203:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/aio_iiro_16.c:203:21: sparse:     got void *
--
>> drivers/staging/comedi/drivers/mpc624.c:122:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/mpc624.c:122:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/mpc624.c:122:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:122:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:127:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:131:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:136:29: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/mpc624.c:136:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/mpc624.c:136:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:136:29: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:195:18: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:213:9: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:217:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:219:17: sparse:     got void *
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/mpc624.c:221:17: sparse:     got void *
--
>> drivers/staging/comedi/drivers/ni_at_a2150.c:150:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_at_a2150.c:150:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_at_a2150.c:150:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:150:18: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:217:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_at_a2150.c:217:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_at_a2150.c:217:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:217:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:230:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:230:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:230:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:230:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:236:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:236:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:236:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:236:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:480:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:480:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:480:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:480:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:501:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:501:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:501:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:501:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:524:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:524:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:524:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:524:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:528:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:528:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:528:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:528:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:556:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:556:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:556:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:556:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:560:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:560:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:560:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:560:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:572:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:572:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:572:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:572:18: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:586:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:586:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:586:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:586:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:597:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:597:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:597:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:597:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:601:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:601:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:601:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:601:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:604:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:604:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:604:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:604:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:607:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:607:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:607:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:607:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:618:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:618:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:618:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:618:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:627:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:627:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:627:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:627:27: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:632:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:632:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:632:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:632:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:678:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:678:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:678:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:678:18: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:739:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:739:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:739:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:739:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:746:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:746:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:746:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:746:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:749:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:749:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:749:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:749:33: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:759:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:759:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:759:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:759:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c:767:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_a2150.c:767:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_a2150.c:767:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_a2150.c:767:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_a2150.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
--
>> drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:123:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:142:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:159:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:161:19: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:194:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:250:25: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:251:25: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:256:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:257:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:272:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:279:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:282:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:284:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:287:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:288:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_at_ao.c:289:9: sparse:     got void *
--
>> sound/drivers/serial-u16550.c:203:26: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/drivers/serial-u16550.c:203:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/drivers/serial-u16550.c:203:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:203:26: sparse:     got void *
   sound/drivers/serial-u16550.c:205:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:205:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:205:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:205:21: sparse:     got void *
   sound/drivers/serial-u16550.c:245:26: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:245:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:245:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:245:26: sparse:     got void *
   sound/drivers/serial-u16550.c:249:33: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:249:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:249:33: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:249:33: sparse:     got void *
   sound/drivers/serial-u16550.c:292:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:292:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:292:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:292:9: sparse:     got void *
   sound/drivers/serial-u16550.c:336:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/drivers/serial-u16550.c:336:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/drivers/serial-u16550.c:336:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:336:9: sparse:     got void *
   sound/drivers/serial-u16550.c:337:13: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:337:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:337:13: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:337:13: sparse:     got void *
   sound/drivers/serial-u16550.c:342:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:342:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:342:9: sparse:     got void *
   sound/drivers/serial-u16550.c:344:13: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:344:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:344:13: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:344:13: sparse:     got void *
   sound/drivers/serial-u16550.c:349:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:349:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:349:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:349:9: sparse:     got void *
   sound/drivers/serial-u16550.c:351:13: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:351:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:351:13: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:351:13: sparse:     got void *
   sound/drivers/serial-u16550.c:371:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:371:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:371:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:371:9: sparse:     got void *
   sound/drivers/serial-u16550.c:380:14: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:380:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:380:14: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:380:14: sparse:     got void *
   sound/drivers/serial-u16550.c:383:43: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:383:43: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:383:43: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:383:43: sparse:     got void *
   sound/drivers/serial-u16550.c:384:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:384:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:384:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:384:17: sparse:     got void *
   sound/drivers/serial-u16550.c:386:41: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:386:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:386:41: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:386:41: sparse:     got void *
   sound/drivers/serial-u16550.c:387:41: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:387:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:387:41: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:387:41: sparse:     got void *
   sound/drivers/serial-u16550.c:389:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:389:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:389:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:389:17: sparse:     got void *
   sound/drivers/serial-u16550.c:391:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:391:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:391:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:391:17: sparse:     got void *
   sound/drivers/serial-u16550.c:396:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:396:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:396:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:396:9: sparse:     got void *
   sound/drivers/serial-u16550.c:404:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:404:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:404:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:404:17: sparse:     got void *
   sound/drivers/serial-u16550.c:415:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:415:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:415:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:415:17: sparse:     got void *
   sound/drivers/serial-u16550.c:421:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:421:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:421:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:421:17: sparse:     got void *
   sound/drivers/serial-u16550.c:444:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:444:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:444:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:444:9: sparse:     got void *
   sound/drivers/serial-u16550.c:446:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:446:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:446:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:446:9: sparse:     got void *
   sound/drivers/serial-u16550.c:447:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:447:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:447:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:447:9: sparse:     got void *
   sound/drivers/serial-u16550.c:448:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:448:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:448:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:448:9: sparse:     got void *
   sound/drivers/serial-u16550.c:460:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:460:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:460:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:460:9: sparse:     got void *
   sound/drivers/serial-u16550.c:466:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:466:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:466:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:466:17: sparse:     got void *
   sound/drivers/serial-u16550.c:475:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:475:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:475:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/drivers/serial-u16550.c:475:17: sparse:     got void *
   sound/drivers/serial-u16550.c:481:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/drivers/serial-u16550.c:481:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/drivers/serial-u16550.c:481:17: sparse:     expected void volatile [noderef] __iomem *addr

vim +/__iomem +139 drivers/staging/speakup/serialio.c

c6e3fd22cd53836 William Hubbs          2010-10-07  125  
c6e3fd22cd53836 William Hubbs          2010-10-07  126  static void start_serial_interrupt(int irq)
c6e3fd22cd53836 William Hubbs          2010-10-07  127  {
c6e3fd22cd53836 William Hubbs          2010-10-07  128  	int rv;
c6e3fd22cd53836 William Hubbs          2010-10-07  129  
114885e08c0e7d5 Shraddha Barke         2015-09-11  130  	if (!synth->read_buff_add)
c6e3fd22cd53836 William Hubbs          2010-10-07  131  		return;
c6e3fd22cd53836 William Hubbs          2010-10-07  132  
c6e3fd22cd53836 William Hubbs          2010-10-07  133  	rv = request_irq(irq, synth_readbuf_handler, IRQF_SHARED,
c6e3fd22cd53836 William Hubbs          2010-10-07  134  			 "serial", (void *)synth_readbuf_handler);
c6e3fd22cd53836 William Hubbs          2010-10-07  135  
c6e3fd22cd53836 William Hubbs          2010-10-07  136  	if (rv)
3a046c19158e897 Keerthimai Janarthanan 2014-03-18  137  		pr_err("Unable to request Speakup serial I R Q\n");
c6e3fd22cd53836 William Hubbs          2010-10-07  138  	/* Set MCR */
c6e3fd22cd53836 William Hubbs          2010-10-07 @139  	outb(UART_MCR_DTR | UART_MCR_RTS | UART_MCR_OUT2,
c6e3fd22cd53836 William Hubbs          2010-10-07  140  	     speakup_info.port_tts + UART_MCR);
c6e3fd22cd53836 William Hubbs          2010-10-07  141  	/* Turn on Interrupts */
c6e3fd22cd53836 William Hubbs          2010-10-07  142  	outb(UART_IER_MSI | UART_IER_RLSI | UART_IER_RDI,
c6e3fd22cd53836 William Hubbs          2010-10-07  143  	     speakup_info.port_tts + UART_IER);
c6e3fd22cd53836 William Hubbs          2010-10-07 @144  	inb(speakup_info.port_tts + UART_LSR);
c6e3fd22cd53836 William Hubbs          2010-10-07  145  	inb(speakup_info.port_tts + UART_RX);
c6e3fd22cd53836 William Hubbs          2010-10-07  146  	inb(speakup_info.port_tts + UART_IIR);
c6e3fd22cd53836 William Hubbs          2010-10-07  147  	inb(speakup_info.port_tts + UART_MSR);
c6e3fd22cd53836 William Hubbs          2010-10-07  148  	outb(1, speakup_info.port_tts + UART_FCR);	/* Turn FIFO On */
c6e3fd22cd53836 William Hubbs          2010-10-07  149  }
c6e3fd22cd53836 William Hubbs          2010-10-07  150  

:::::: The code at line 139 was first introduced by commit
:::::: c6e3fd22cd538365bfeb82997d5b89562e077d42 Staging: add speakup to the staging directory

:::::: TO: William Hubbs <w.d.hubbs@gmail.com>
:::::: CC: Greg Kroah-Hartman <gregkh@suse.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--17pEHd4RhPHOinZp
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
5pu29w5rEFdh7Nn/C2685Lj+0wEA

--17pEHd4RhPHOinZp--
