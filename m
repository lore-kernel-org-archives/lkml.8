Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0FB36C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 19:53:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C2B7D206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 19:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726396AbgHHTxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 15:53:14 -0400
Received: from mga01.intel.com ([192.55.52.88]:33662 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726242AbgHHTxO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 15:53:14 -0400
IronPort-SDR: 11h2/kLuP2UB9Kx3RK8JtXLvKQ4s8dMocf0HMnRUAnn6SGg6BPHPXnBkpNZiGNB/tRRDcnVFNM
 mJUX5DKqW71A==
X-IronPort-AV: E=McAfee;i="6000,8403,9707"; a="171388992"
X-IronPort-AV: E=Sophos;i="5.75,450,1589266800"; 
   d="gz'50?scan'50,208,50";a="171388992"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2020 12:53:09 -0700
IronPort-SDR: XokUAUYrUMNLrptyKt2m172MRuUR8jqiflIGT9bjsuIatqPo/eX70iU2tCWyJhDAqNxAht6WSD
 TcD8AXmKYzow==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,450,1589266800"; 
   d="gz'50?scan'50,208,50";a="316897647"
Received: from lkp-server02.sh.intel.com (HELO 65e25449d42f) ([10.239.97.151])
  by fmsmga004.fm.intel.com with ESMTP; 08 Aug 2020 12:53:07 -0700
Received: from kbuild by 65e25449d42f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4Utv-0000HC-5G; Sat, 08 Aug 2020 19:53:07 +0000
Date:   Sun, 9 Aug 2020 03:52:37 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/ethernet/aeroflex/greth.c:362:9: sparse: sparse:
 incorrect type in argument 2 (different address spaces)
Message-ID: <202008090326.eU1UU4Xs%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="+HP7ph2BbKc20aGI"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--+HP7ph2BbKc20aGI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11030fe96b57ad843518b0e9430f3cd4b3610ce2
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: sparc64-randconfig-s032-20200809 (attached as .config)
compiler: sparc64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     got restricted __be32 [usertype]
>> drivers/net/ethernet/aeroflex/greth.c:362:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
>> drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:362:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:406:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:406:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:406:24: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:406:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:409:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:752:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:869:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:627:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:692:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:594:18: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:600:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1029:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1030:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1066:15: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1074:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1075:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1077:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1083:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1091:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:328:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:329:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:991:24: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:994:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:999:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1003:21: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1004:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1056:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1057:9: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:1128:52: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int [usertype] *bd @@     got unsigned int [noderef] [usertype] __iomem * @@
   drivers/net/ethernet/aeroflex/greth.c:1128:52: sparse:     expected unsigned int [usertype] *bd
>> drivers/net/ethernet/aeroflex/greth.c:1128:52: sparse:     got unsigned int [noderef] [usertype] __iomem *
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1168:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1173:15: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1174:25: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1189:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1211:32: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1222:25: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:1367:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct greth_regs *regs @@     got void [noderef] __iomem * @@
   drivers/net/ethernet/aeroflex/greth.c:1367:21: sparse:     expected struct greth_regs *regs
>> drivers/net/ethernet/aeroflex/greth.c:1367:21: sparse:     got void [noderef] __iomem *
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1388:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1392:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1402:27: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1405:15: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1416:17: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1478:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1479:9: sparse:     got unsigned int *
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int * @@
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:1483:9: sparse:     got unsigned int *
>> drivers/net/ethernet/aeroflex/greth.c:1521:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct greth_regs *regs @@
>> drivers/net/ethernet/aeroflex/greth.c:1521:46: sparse:     expected void [noderef] __iomem *base
   drivers/net/ethernet/aeroflex/greth.c:1521:46: sparse:     got struct greth_regs *regs
   drivers/net/ethernet/aeroflex/greth.c:1544:47: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem *base @@     got struct greth_regs *regs @@
   drivers/net/ethernet/aeroflex/greth.c:1544:47: sparse:     expected void [noderef] __iomem *base
   drivers/net/ethernet/aeroflex/greth.c:1544:47: sparse:     got struct greth_regs *regs
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
>> drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:162:16: sparse: sparse: cast to restricted __be32
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got unsigned int [usertype] *bd @@
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse:     got unsigned int [usertype] *bd
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] l @@     got restricted __be32 [usertype] @@
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     expected unsigned int [usertype] l
   drivers/net/ethernet/aeroflex/greth.c:157:22: sparse:     got restricted __be32 [usertype]
   drivers/net/ethernet/aeroflex/greth.c:157:40: sparse: sparse: too many warnings

vim +362 drivers/net/ethernet/aeroflex/greth.c

d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  337  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  338  static int greth_open(struct net_device *dev)
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  339  {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  340  	struct greth_private *greth = netdev_priv(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  341  	int err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  342  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  343  	err = greth_init_rings(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  344  	if (err) {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  345  		if (netif_msg_ifup(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  346  			dev_err(&dev->dev, "Could not allocate memory for DMA rings\n");
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  347  		return err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  348  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  349  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  350  	err = request_irq(greth->irq, greth_interrupt, 0, "eth", (void *) dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  351  	if (err) {
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  352  		if (netif_msg_ifup(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  353  			dev_err(&dev->dev, "Could not allocate interrupt %d\n", dev->irq);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  354  		greth_clean_rings(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  355  		return err;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  356  	}
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  357  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  358  	if (netif_msg_ifup(greth))
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  359  		dev_dbg(&dev->dev, " starting queue\n");
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  360  	netif_start_queue(dev);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  361  
bbe9e637330abe drivers/net/greth.c Daniel Hellstrom  2011-01-14 @362  	GRETH_REGSAVE(greth->regs->status, 0xFF);
bbe9e637330abe drivers/net/greth.c Daniel Hellstrom  2011-01-14  363  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  364  	napi_enable(&greth->napi);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  365  
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  366  	greth_enable_irqs(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  367  	greth_enable_tx(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  368  	greth_enable_rx(greth);
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  369  	return 0;
d4c41139df6e74 drivers/net/greth.c Kristoffer Glembo 2010-02-15  370  

:::::: The code at line 362 was first introduced by commit
:::::: bbe9e637330abe55442aebe799425e224086959f GRETH: fix opening/closing

:::::: TO: Daniel Hellstrom <daniel@gaisler.com>
:::::: CC: David S. Miller <davem@davemloft.net>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--+HP7ph2BbKc20aGI
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
tv5/aMMV0yHHAQA=

--+HP7ph2BbKc20aGI--
