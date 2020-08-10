Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 87BDBC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30938206B5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 09:57:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726550AbgHJJ5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 05:57:04 -0400
Received: from mga18.intel.com ([134.134.136.126]:64891 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726473AbgHJJ5D (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 05:57:03 -0400
IronPort-SDR: YLXE2nvvIw2DjU8mz/VKgeP+oBE1lKsF6Ju4Qb9Fq3tjNpjS1FYf8Gefy0+NN3vNwaKPQ2x1gB
 dCHGpuxgqgZA==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="141109127"
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="gz'50?scan'50,208,50";a="141109127"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Aug 2020 02:40:48 -0700
IronPort-SDR: Gvjz1ObYHknRsWUofy2MRJ5ctFocaGAO1w5l19dMYtQcVyqt4iKWDOOuwpjagtla2ABC16q5kz
 bGD1IsiThOsw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,457,1589266800"; 
   d="gz'50?scan'50,208,50";a="308023133"
Received: from lkp-server02.sh.intel.com (HELO 5ad9e2f13e37) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 10 Aug 2020 02:40:46 -0700
Received: from kbuild by 5ad9e2f13e37 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k54IP-0000UV-8J; Mon, 10 Aug 2020 09:40:45 +0000
Date:   Mon, 10 Aug 2020 17:40:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/arcnet/com90io.c:251:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202008101739.waoA1Ki4%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="yrj/dFKFPuw6o+aM"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--yrj/dFKFPuw6o+aM
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   fc80c51fd4b23ec007e88d4c688f2cac1b8648e7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: riscv-randconfig-s031-20200810 (attached as .config)
compiler: riscv64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-118-ge1578773-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/arcnet/com90io.c:251:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com90io.c:251:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com90io.c:251:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:251:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:259:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com90io.c:259:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com90io.c:259:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:259:17: sparse:     got void *
   drivers/net/arcnet/com90io.c:259:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:259:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:259:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:259:17: sparse:     got void *
   drivers/net/arcnet/com90io.c:315:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:315:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:315:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:315:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:322:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:322:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:322:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:322:16: sparse:     got void *
   drivers/net/arcnet/com90io.c:329:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:329:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:329:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:329:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:284:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:284:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:284:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:284:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:284:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:284:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:284:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:284:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:284:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:289:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:289:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:289:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:289:17: sparse:     got void *
   drivers/net/arcnet/com90io.c:294:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:294:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:294:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:294:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:296:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:296:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:296:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:298:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:298:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:298:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:298:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:306:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:306:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:306:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:306:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:75:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:75:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:75:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:75:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:76:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:76:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:76:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:76:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:78:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:78:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:78:16: sparse:     got void *
   drivers/net/arcnet/com90io.c:100:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:100:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:100:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:100:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:101:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:101:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:101:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:101:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:107:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:107:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:107:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:107:29: sparse:     got void *
   drivers/net/arcnet/com90io.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:116:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:116:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:116:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:117:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:117:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:117:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:117:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:123:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:123:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:123:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:123:17: sparse:     got void *
   drivers/net/arcnet/com90io.c:149:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:149:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:149:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:149:13: sparse:     got void *
   drivers/net/arcnet/com90io.c:154:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:154:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:154:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:154:9: sparse:     got void *
   drivers/net/arcnet/com90io.c:157:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:157:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:157:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90io.c:157:18: sparse:     got void *
   drivers/net/arcnet/com90io.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90io.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90io.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/net/wireless/wl3501_cs.c:204:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/wireless/wl3501_cs.c:204:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/wireless/wl3501_cs.c:204:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:204:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:205:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:205:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:205:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:206:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:206:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:206:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:206:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:210:29: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/wireless/wl3501_cs.c:210:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/wireless/wl3501_cs.c:210:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:210:29: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:212:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:212:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:212:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:212:29: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:214:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:214:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:214:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:214:29: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:216:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:216:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:216:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:216:29: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:218:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:218:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:218:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:218:29: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:220:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:220:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:220:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:220:29: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:222:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:222:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:222:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:222:28: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:224:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:224:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:224:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:224:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:225:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:225:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:225:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:225:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:226:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:226:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:226:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:226:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:228:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:228:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:228:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:228:28: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:230:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:230:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:230:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:230:28: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:253:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:253:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:253:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:253:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:254:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:254:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:254:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:254:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:275:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:275:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:275:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:275:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:276:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:276:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:276:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:276:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:730:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:730:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:730:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:730:18: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:734:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:734:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:734:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:734:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:747:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:747:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:747:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:747:18: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:751:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:751:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:751:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:751:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:190:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:190:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:190:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:190:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:190:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:190:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:190:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:190:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:190:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c:1108:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/wl3501_cs.c:1108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/wl3501_cs.c:1108:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/wl3501_cs.c:1108:9: sparse:     got void *
   drivers/net/wireless/wl3501_cs.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
--
>> sound/pcmcia/vx/vxp_ops.c:50:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/vx/vxp_ops.c:50:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/vx/vxp_ops.c:50:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:50:16: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:60:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/vx/vxp_ops.c:60:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/vx/vxp_ops.c:60:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:60:9: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:365:25: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:375:17: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:407:35: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:415:27: sparse:     got void *
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/vx/vxp_ops.c:420:17: sparse:     got void *
--
>> sound/pcmcia/pdaudiocf/pdaudiocf_core.c:58:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf_core.c:58:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf_core.c:58:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:58:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:66:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf_core.c:66:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf_core.c:66:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:66:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:239:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:239:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:239:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:239:15: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:241:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:241:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:241:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:241:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:253:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:253:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:253:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:253:15: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:255:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:255:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:255:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c:255:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_core.c: note: in included file:
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
--
>> sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:27:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:27:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:27:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:27:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:258:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:258:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:258:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:258:15: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:259:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:259:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:259:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:259:15: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:129:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:129:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:129:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:129:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:130:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:130:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:130:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:130:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:131:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:131:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:131:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:131:17: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:161:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:161:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:161:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:161:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:162:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:162:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:162:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:162:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:163:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:163:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:163:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:163:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:145:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:145:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:145:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:145:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:146:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:146:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:146:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:146:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:147:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:147:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:147:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:147:17: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:181:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:181:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:181:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:181:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:182:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:182:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:182:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:182:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:183:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:183:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:183:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:183:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:44:26: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:44:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:44:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:44:26: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:45:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:45:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:45:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:45:17: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:54:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:54:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:54:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:54:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:55:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:55:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:55:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:55:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:56:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:56:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:56:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:56:17: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:64:26: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:64:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:64:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:64:26: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:65:26: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:65:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:65:26: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:65:26: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:74:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:74:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:74:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:74:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:75:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:75:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:75:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:75:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:76:24: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:76:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:76:24: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:76:24: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:85:26: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:85:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_irq.c:85:26: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:55: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:55: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:23:55: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:26:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:26:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:26:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c:26:17: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf_pcm.c: note: in included file:
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:113:16: sparse:     got void *
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pcmcia/pdaudiocf/pdaudiocf.h:108:9: sparse:     got void *
--
>> drivers/net/wireless/cisco/airo.c:3551:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/wireless/cisco/airo.c:3551:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/wireless/cisco/airo.c:3551:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/cisco/airo.c:3551:17: sparse:     got void *
   drivers/net/wireless/cisco/airo.c:3553:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/cisco/airo.c:3553:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/cisco/airo.c:3553:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/cisco/airo.c:3553:17: sparse:     got void *
   drivers/net/wireless/cisco/airo.c:3554:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/cisco/airo.c:3554:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/cisco/airo.c:3554:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/wireless/cisco/airo.c:3554:17: sparse:     got void *
   drivers/net/wireless/cisco/airo.c:3564:22: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/wireless/cisco/airo.c:3564:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/wireless/cisco/airo.c:3564:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/cisco/airo.c:3564:22: sparse:     got void *
   drivers/net/wireless/cisco/airo.c:3566:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/cisco/airo.c:3566:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/cisco/airo.c:3566:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/cisco/airo.c:3566:22: sparse:     got void *
   drivers/net/wireless/cisco/airo.c:3567:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/wireless/cisco/airo.c:3567:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/wireless/cisco/airo.c:3567:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/wireless/cisco/airo.c:3567:29: sparse:     got void *
   drivers/net/wireless/cisco/airo.c:3879:35: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:3879:35: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:3879:35: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:2050:24: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] status @@     got unsigned short [usertype] status @@
   drivers/net/wireless/cisco/airo.c:2050:24: sparse:     expected restricted __le16 [usertype] status
   drivers/net/wireless/cisco/airo.c:2050:24: sparse:     got unsigned short [usertype] status
   drivers/net/wireless/cisco/airo.c:3250:18: sparse: sparse: cast to restricted __le16
   drivers/net/wireless/cisco/airo.c:4889:51: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:4889:51: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:4889:51: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:4892:51: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:4892:51: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:4892:51: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:4895:51: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:4895:51: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:4895:51: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6363:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6363:46: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6363:46: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6383:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6383:38: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6383:38: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6385:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6385:38: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6385:38: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6387:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6387:38: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6387:38: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6543:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6543:38: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6543:38: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6545:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6545:38: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6545:38: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6547:38: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6547:38: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6547:38: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6652:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6652:54: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6652:54: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6654:46: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6654:46: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6654:46: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:6664:54: sparse: sparse: incorrect type in argument 2 (different base types) @@     expected int auth_type @@     got restricted __le16 [usertype] @@
   drivers/net/wireless/cisco/airo.c:6664:54: sparse:     expected int auth_type
   drivers/net/wireless/cisco/airo.c:6664:54: sparse:     got restricted __le16 [usertype]
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3797:32: sparse: sparse: incorrect type in assignment (different base types) @@     expected restricted __le16 [usertype] authType @@     got int auth_type @@
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     expected restricted __le16 [usertype] authType
   drivers/net/wireless/cisco/airo.c:3797:32: sparse:     got int auth_type
   drivers/net/wireless/cisco/airo.c:3801:26: sparse: sparse: restricted __le16 degrades to integer
   drivers/net/wireless/cisco/airo.c:3801:52: sparse: sparse: restricted __le16 degrades to integer

vim +/__iomem +251 drivers/net/arcnet/com90io.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  217  
^1da177e4c3f41 Linus Torvalds  2005-04-16  218  /* Set up the struct net_device associated with this card.  Called after
^1da177e4c3f41 Linus Torvalds  2005-04-16  219   * probing succeeds.
^1da177e4c3f41 Linus Torvalds  2005-04-16  220   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  221  static int __init com90io_found(struct net_device *dev)
^1da177e4c3f41 Linus Torvalds  2005-04-16  222  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  223  	struct arcnet_local *lp;
^1da177e4c3f41 Linus Torvalds  2005-04-16  224  	int ioaddr = dev->base_addr;
^1da177e4c3f41 Linus Torvalds  2005-04-16  225  	int err;
^1da177e4c3f41 Linus Torvalds  2005-04-16  226  
^1da177e4c3f41 Linus Torvalds  2005-04-16  227  	/* Reserve the irq */
d6d7d3ed56e3bf Joe Perches     2015-05-05  228  	if (request_irq(dev->irq, arcnet_interrupt, 0,
d6d7d3ed56e3bf Joe Perches     2015-05-05  229  			"arcnet (COM90xx-IO)", dev)) {
a34c0932c3b2f2 Joe Perches     2015-05-05  230  		arc_printk(D_NORMAL, dev, "Can't get IRQ %d!\n", dev->irq);
^1da177e4c3f41 Linus Torvalds  2005-04-16  231  		return -ENODEV;
^1da177e4c3f41 Linus Torvalds  2005-04-16  232  	}
fb911ee849756f Peter Osterlund 2005-09-13  233  	/* Reserve the I/O region */
d6d7d3ed56e3bf Joe Perches     2015-05-05  234  	if (!request_region(dev->base_addr, ARCNET_TOTAL_SIZE,
d6d7d3ed56e3bf Joe Perches     2015-05-05  235  			    "arcnet (COM90xx-IO)")) {
^1da177e4c3f41 Linus Torvalds  2005-04-16  236  		free_irq(dev->irq, dev);
^1da177e4c3f41 Linus Torvalds  2005-04-16  237  		return -EBUSY;
^1da177e4c3f41 Linus Torvalds  2005-04-16  238  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  239  
454d7c9b14e20f Wang Chen       2008-11-12  240  	lp = netdev_priv(dev);
^1da177e4c3f41 Linus Torvalds  2005-04-16  241  	lp->card_name = "COM90xx I/O";
^1da177e4c3f41 Linus Torvalds  2005-04-16  242  	lp->hw.command = com90io_command;
^1da177e4c3f41 Linus Torvalds  2005-04-16  243  	lp->hw.status = com90io_status;
^1da177e4c3f41 Linus Torvalds  2005-04-16  244  	lp->hw.intmask = com90io_setmask;
^1da177e4c3f41 Linus Torvalds  2005-04-16  245  	lp->hw.reset = com90io_reset;
^1da177e4c3f41 Linus Torvalds  2005-04-16  246  	lp->hw.owner = THIS_MODULE;
^1da177e4c3f41 Linus Torvalds  2005-04-16  247  	lp->hw.copy_to_card = com90io_copy_to_card;
^1da177e4c3f41 Linus Torvalds  2005-04-16  248  	lp->hw.copy_from_card = com90io_copy_from_card;
^1da177e4c3f41 Linus Torvalds  2005-04-16  249  
^1da177e4c3f41 Linus Torvalds  2005-04-16  250  	lp->config = (0x16 | IOMAPflag) & ~ENABLE16flag;
f0b9c27c0c933a Joe Perches     2015-05-05 @251  	arcnet_outb(lp->config, ioaddr, COM9026_REG_RW_CONFIG);
^1da177e4c3f41 Linus Torvalds  2005-04-16  252  
^1da177e4c3f41 Linus Torvalds  2005-04-16  253  	/* get and check the station ID from offset 1 in shmem */
^1da177e4c3f41 Linus Torvalds  2005-04-16  254  
^1da177e4c3f41 Linus Torvalds  2005-04-16  255  	dev->dev_addr[0] = get_buffer_byte(dev, 1);
^1da177e4c3f41 Linus Torvalds  2005-04-16  256  
^1da177e4c3f41 Linus Torvalds  2005-04-16  257  	err = register_netdev(dev);
^1da177e4c3f41 Linus Torvalds  2005-04-16  258  	if (err) {
f0b9c27c0c933a Joe Perches     2015-05-05 @259  		arcnet_outb(arcnet_inb(ioaddr, COM9026_REG_RW_CONFIG) & ~IOMAPflag,
f0b9c27c0c933a Joe Perches     2015-05-05  260  			    ioaddr, COM9026_REG_RW_CONFIG);
^1da177e4c3f41 Linus Torvalds  2005-04-16  261  		free_irq(dev->irq, dev);
^1da177e4c3f41 Linus Torvalds  2005-04-16  262  		release_region(dev->base_addr, ARCNET_TOTAL_SIZE);
^1da177e4c3f41 Linus Torvalds  2005-04-16  263  		return err;
^1da177e4c3f41 Linus Torvalds  2005-04-16  264  	}
^1da177e4c3f41 Linus Torvalds  2005-04-16  265  
a34c0932c3b2f2 Joe Perches     2015-05-05  266  	arc_printk(D_NORMAL, dev, "COM90IO: station %02Xh found at %03lXh, IRQ %d.\n",
^1da177e4c3f41 Linus Torvalds  2005-04-16  267  		   dev->dev_addr[0], dev->base_addr, dev->irq);
^1da177e4c3f41 Linus Torvalds  2005-04-16  268  
^1da177e4c3f41 Linus Torvalds  2005-04-16  269  	return 0;
^1da177e4c3f41 Linus Torvalds  2005-04-16  270  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  271  

:::::: The code at line 251 was first introduced by commit
:::::: f0b9c27c0c933a6545ea57d4edbc56a4db435c84 arcnet: com90io: Use arcnet_<I/O> routines

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--yrj/dFKFPuw6o+aM
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--yrj/dFKFPuw6o+aM--
