Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4CDF0C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:00:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F176520678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 06:00:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727972AbgHCGAp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 02:00:45 -0400
Received: from mga02.intel.com ([134.134.136.20]:9715 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726057AbgHCGAo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 02:00:44 -0400
IronPort-SDR: q9dF1MpMcrZVHm3VHbWQ524e8rFI4a+LuMyVj/yd+9+8tTvtf2XWjUhedSGYfWssvAN0ncUWjH
 1DVPpcdHQ1Pw==
X-IronPort-AV: E=McAfee;i="6000,8403,9701"; a="140000917"
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="gz'50?scan'50,208,50";a="140000917"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 22:57:02 -0700
IronPort-SDR: jKrF+l4o/r0Arlj9US4eNp6Sw4+a9gn1RC4eRldLrK5msdKE9m9D/3RQ5NO/keejFqs2/79GNB
 2FAGHpz2zlKA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,429,1589266800"; 
   d="gz'50?scan'50,208,50";a="273829867"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by fmsmga007.fm.intel.com with ESMTP; 02 Aug 2020 22:57:00 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2TT1-0001rG-Mm; Mon, 03 Aug 2020 05:56:59 +0000
Date:   Mon, 3 Aug 2020 13:56:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/hamradio/baycom_ser_hdx.c:371:20: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202008031314.W0w1rjxV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="PNTmBPCT7hxwcZjr"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--PNTmBPCT7hxwcZjr
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bcf876870b95592b52519ed4aafcf9d95999bc9c
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: riscv-randconfig-s031-20200803 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-117-g8c7aee71-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/hamradio/baycom_ser_hdx.c:371:20: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/hamradio/baycom_ser_hdx.c:371:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/hamradio/baycom_ser_hdx.c:371:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:371:20: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:377:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:377:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:377:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:377:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:381:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:381:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:381:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:381:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:394:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/hamradio/baycom_ser_hdx.c:394:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/hamradio/baycom_ser_hdx.c:394:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:394:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:398:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:398:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:398:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:398:25: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:401:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:401:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:401:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:401:23: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:430:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:430:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:430:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:430:14: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:431:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:431:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:431:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:431:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:432:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:432:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:432:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:432:14: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:433:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:433:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:433:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:433:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:434:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:434:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:434:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:434:14: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:435:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:435:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:435:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:435:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:436:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:436:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:436:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:436:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:439:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:439:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:439:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:439:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:440:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:440:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:440:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:440:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:441:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:441:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:441:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:441:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:442:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:442:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:442:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:442:23: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:444:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:444:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:444:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:444:17: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:445:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:445:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:445:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:445:22: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:446:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:446:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:446:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:446:17: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:447:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:447:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:447:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:447:22: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:474:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:474:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:474:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:474:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:475:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:475:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:475:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:475:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:476:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:476:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:476:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:476:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:485:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:485:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:485:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:485:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:508:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:508:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:508:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:508:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:509:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:509:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:509:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:509:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:193:9: sparse: sparse: dubious: x | !y
   drivers/net/hamradio/baycom_ser_hdx.c:193:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:193:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/hamradio/baycom_ser_hdx.c:193:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/hamradio/baycom_ser_hdx.c:193:9: sparse:     got void *
   drivers/net/hamradio/baycom_ser_hdx.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/hamradio/baycom_ser_hdx.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
--
   drivers/hwmon/w83627ehf.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
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
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
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
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:121:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:122:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:122:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:111:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:112:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:112:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:111:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:111:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:111:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:112:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:112:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:112:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:97:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:97:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:98:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:97:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:97:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:98:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:130:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:131:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:131:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:132:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:132:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:132:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:132:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:121:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:121:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:121:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:122:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:122:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:122:9: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:104:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:104:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:104:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627ehf.c:105:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627ehf.c:105:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:105:16: sparse:     got void *
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:130:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627ehf.c:131:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627ehf.c:131:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627ehf.c:131:9: sparse:     got void *
   drivers/hwmon/w83627ehf.c:132:9: sparse: sparse: too many warnings

vim +/__iomem +371 drivers/net/hamradio/baycom_ser_hdx.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  361  
7d12e780e003f93 David Howells  2006-10-05  362  static irqreturn_t ser12_interrupt(int irq, void *dev_id)
^1da177e4c3f415 Linus Torvalds 2005-04-16  363  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  364  	struct net_device *dev = (struct net_device *)dev_id;
^1da177e4c3f415 Linus Torvalds 2005-04-16  365  	struct baycom_state *bc = netdev_priv(dev);
^1da177e4c3f415 Linus Torvalds 2005-04-16  366  	unsigned char iir;
^1da177e4c3f415 Linus Torvalds 2005-04-16  367  
^1da177e4c3f415 Linus Torvalds 2005-04-16  368  	if (!dev || !bc || bc->hdrv.magic != HDLCDRV_MAGIC)
^1da177e4c3f415 Linus Torvalds 2005-04-16  369  		return IRQ_NONE;
^1da177e4c3f415 Linus Torvalds 2005-04-16  370  	/* fast way out */
^1da177e4c3f415 Linus Torvalds 2005-04-16 @371  	if ((iir = inb(IIR(dev->base_addr))) & 1)
^1da177e4c3f415 Linus Torvalds 2005-04-16  372  		return IRQ_NONE;
^1da177e4c3f415 Linus Torvalds 2005-04-16  373  	baycom_int_freq(bc);
^1da177e4c3f415 Linus Torvalds 2005-04-16  374  	do {
^1da177e4c3f415 Linus Torvalds 2005-04-16  375  		switch (iir & 6) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  376  		case 6:
^1da177e4c3f415 Linus Torvalds 2005-04-16  377  			inb(LSR(dev->base_addr));
^1da177e4c3f415 Linus Torvalds 2005-04-16  378  			break;
^1da177e4c3f415 Linus Torvalds 2005-04-16  379  			
^1da177e4c3f415 Linus Torvalds 2005-04-16  380  		case 4:
^1da177e4c3f415 Linus Torvalds 2005-04-16  381  			inb(RBR(dev->base_addr));
^1da177e4c3f415 Linus Torvalds 2005-04-16  382  			break;
^1da177e4c3f415 Linus Torvalds 2005-04-16  383  			
^1da177e4c3f415 Linus Torvalds 2005-04-16  384  		case 2:
^1da177e4c3f415 Linus Torvalds 2005-04-16  385  			/*
^1da177e4c3f415 Linus Torvalds 2005-04-16  386  			 * check if transmitter active
^1da177e4c3f415 Linus Torvalds 2005-04-16  387  			 */
^1da177e4c3f415 Linus Torvalds 2005-04-16  388  			if (hdlcdrv_ptt(&bc->hdrv))
^1da177e4c3f415 Linus Torvalds 2005-04-16  389  				ser12_tx(dev, bc);
^1da177e4c3f415 Linus Torvalds 2005-04-16  390  			else {
^1da177e4c3f415 Linus Torvalds 2005-04-16  391  				ser12_rx(dev, bc);
^1da177e4c3f415 Linus Torvalds 2005-04-16  392  				bc->modem.arb_divider--;
^1da177e4c3f415 Linus Torvalds 2005-04-16  393  			}
^1da177e4c3f415 Linus Torvalds 2005-04-16 @394  			outb(0x00, THR(dev->base_addr));
^1da177e4c3f415 Linus Torvalds 2005-04-16  395  			break;
^1da177e4c3f415 Linus Torvalds 2005-04-16  396  			
^1da177e4c3f415 Linus Torvalds 2005-04-16  397  		default:
^1da177e4c3f415 Linus Torvalds 2005-04-16  398  			inb(MSR(dev->base_addr));
^1da177e4c3f415 Linus Torvalds 2005-04-16  399  			break;
^1da177e4c3f415 Linus Torvalds 2005-04-16  400  		}
^1da177e4c3f415 Linus Torvalds 2005-04-16  401  		iir = inb(IIR(dev->base_addr));
^1da177e4c3f415 Linus Torvalds 2005-04-16  402  	} while (!(iir & 1));
^1da177e4c3f415 Linus Torvalds 2005-04-16  403  	if (bc->modem.arb_divider <= 0) {
^1da177e4c3f415 Linus Torvalds 2005-04-16  404  		bc->modem.arb_divider = SER12_ARB_DIVIDER(bc);
^1da177e4c3f415 Linus Torvalds 2005-04-16  405  		local_irq_enable();
^1da177e4c3f415 Linus Torvalds 2005-04-16  406  		hdlcdrv_arbitrate(dev, &bc->hdrv);
^1da177e4c3f415 Linus Torvalds 2005-04-16  407  	}
^1da177e4c3f415 Linus Torvalds 2005-04-16  408  	local_irq_enable();
^1da177e4c3f415 Linus Torvalds 2005-04-16  409  	hdlcdrv_transmitter(dev, &bc->hdrv);
^1da177e4c3f415 Linus Torvalds 2005-04-16  410  	hdlcdrv_receiver(dev, &bc->hdrv);
^1da177e4c3f415 Linus Torvalds 2005-04-16  411  	local_irq_disable();
^1da177e4c3f415 Linus Torvalds 2005-04-16  412  	return IRQ_HANDLED;
^1da177e4c3f415 Linus Torvalds 2005-04-16  413  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  414  

:::::: The code at line 371 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--PNTmBPCT7hxwcZjr
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
RAreQ+mLuf8DiEP1Qq7QAQA=

--PNTmBPCT7hxwcZjr--
