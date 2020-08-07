Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D62C5C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:34:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 95E32221E2
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 00:34:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726346AbgHHAe3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 20:34:29 -0400
Received: from mga06.intel.com ([134.134.136.31]:17313 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726066AbgHHAe2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 20:34:28 -0400
IronPort-SDR: sgrcz20sccchX0NxpI2H0gGOQWDY2das+ojCsr/GSn3P9wCDOO3vmiQKxUSC73eApdRU46Urfh
 PO5m7g3ZIPwQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9706"; a="214763255"
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="gz'50?scan'50,208,50";a="214763255"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Aug 2020 16:59:47 -0700
IronPort-SDR: 6AV6fE47+HNedHDlPOPKpxBYQ/7a42tBWbfD2nGBKqdA34s6k8ZKgXwAy8yYC4nZSKEIhpKM7H
 jCsQffZpsOfw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,447,1589266800"; 
   d="gz'50?scan'50,208,50";a="438060031"
Received: from lkp-server02.sh.intel.com (HELO 090e49ab5480) ([10.239.97.151])
  by orsmga004.jf.intel.com with ESMTP; 07 Aug 2020 16:59:44 -0700
Received: from kbuild by 090e49ab5480 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4CH2-0000Z3-7f; Fri, 07 Aug 2020 23:59:44 +0000
Date:   Sat, 8 Aug 2020 07:59:33 +0800
From:   kernel test robot <lkp@intel.com>
To:     Finn Thain <fthain@telegraphics.com.au>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: got unsigned
 short COPYING CREDITS Documentation Kbuild Kconfig LICENSES MAINTAINERS
 Makefile README arch block certs crypto drivers fs include init ipc kernel
 lib mm net samples scripts security sound tools usr virt
Message-ID: <202008080731.uxGr5Bi9%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="u3/rZRmxL6MmkK24"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--u3/rZRmxL6MmkK24
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
commit: e3885f576196ddfc670b3d53e745de96ffcb49ab net/sonic: Use MMIO accessors
date:   7 months ago
config: xtensa-randconfig-s031-20200808 (attached as .config)
compiler: xtensa-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout e3885f576196ddfc670b3d53e745de96ffcb49ab
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=xtensa 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/natsemi/xtsonic.c: note: in included file (through arch/xtensa/include/uapi/asm/unistd.h, arch/xtensa/include/asm/unistd.h, include/uapi/linux/unistd.h, ...):
   ./arch/xtensa/include/generated/uapi/asm/unistd_32.h:391:41: sparse: sparse: no newline at end of file
   drivers/net/ethernet/natsemi/xtsonic.c:234:5: sparse: sparse: symbol 'xtsonic_probe' was not declared. Should it be static?
   drivers/net/ethernet/natsemi/xtsonic.c: note: in included file:
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:366:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     expected void const volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:371:56: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     expected void volatile [noderef] <asn:2> *addr
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] <asn:2> *addr @@     got unsigned short [usertype] * @@
   drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     expected void volatile [noderef] <asn:2> *addr
>> drivers/net/ethernet/natsemi/sonic.h:353:55: sparse:     got unsigned short [usertype] *
   drivers/net/ethernet/natsemi/sonic.h:358:55: sparse: sparse: too many warnings

vim +353 drivers/net/ethernet/natsemi/sonic.h

   342	
   343	/* Internal inlines for reading/writing DMA buffers.  Note that bus
   344	   size and endianness matter here, whereas they don't for registers,
   345	   as far as we can tell. */
   346	/* OpenBSD calls this "SWO".  I'd like to think that sonic_buf_put()
   347	   is a much better name. */
   348	static inline void sonic_buf_put(u16 *base, int bitmode,
   349					 int offset, __u16 val)
   350	{
   351		if (bitmode)
   352	#ifdef __BIG_ENDIAN
 > 353			__raw_writew(val, base + (offset * 2) + 1);
   354	#else
   355			__raw_writew(val, base + (offset * 2) + 0);
   356	#endif
   357		else
   358			__raw_writew(val, base + (offset * 1) + 0);
   359	}
   360	

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--u3/rZRmxL6MmkK24
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--u3/rZRmxL6MmkK24--
