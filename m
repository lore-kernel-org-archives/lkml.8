Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5A61C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:31:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 27FA620842
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 05:31:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728591AbgG3FbB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 01:31:01 -0400
Received: from mga05.intel.com ([192.55.52.43]:45667 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726287AbgG3FbA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 01:31:00 -0400
IronPort-SDR: 1KuDrCVPH4WUwNcROddcswbqa0lM+1kH6mDvm1ACNPgjg/VHdOXPWKDWB489Er+0I8JtGDIhR3
 9Kjiw75Z3mcQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9697"; a="236389921"
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="gz'50?scan'50,208,50";a="236389921"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Jul 2020 18:49:45 -0700
IronPort-SDR: f14V19GQRPetK9HLIG5n6adCy5MTZpiNJDDuNlpKRRm71yigrSWrDhUtCMIaBVmPV6rHxukEqZ
 YXsgppd7VRTg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,412,1589266800"; 
   d="gz'50?scan'50,208,50";a="286699872"
Received: from lkp-server01.sh.intel.com (HELO bb0aeb05f57a) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 29 Jul 2020 18:49:41 -0700
Received: from kbuild by bb0aeb05f57a with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k0xhU-00000S-OQ; Thu, 30 Jul 2020 01:49:40 +0000
Date:   Thu, 30 Jul 2020 09:48:53 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/net/arcnet/com90xx.c:565:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007300941.OjaCCMMG%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="IS0zKkzwUGydFO0o"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--IS0zKkzwUGydFO0o
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d3590ebf6f91350192737dd1d1b219c05277f067
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: riscv-randconfig-s031-20200729 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-97-gee4aea9a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/net/arcnet/com90xx.c:565:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com90xx.c:565:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com90xx.c:565:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:565:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:572:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com90xx.c:572:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com90xx.c:572:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:572:16: sparse:     got void *
   drivers/net/arcnet/com90xx.c:579:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:579:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:579:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:579:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:594:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:594:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:594:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:594:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:594:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:594:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:594:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:594:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:594:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:594:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:594:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:594:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:599:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:599:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:599:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:599:17: sparse:     got void *
   drivers/net/arcnet/com90xx.c:603:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:603:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:603:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:603:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:604:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:604:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:604:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:604:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:619:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:619:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:619:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:619:9: sparse:     got void *
   drivers/net/arcnet/com90xx.c:161:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:161:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:161:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:161:21: sparse:     got void *
   drivers/net/arcnet/com90xx.c:171:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:171:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:171:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:171:17: sparse:     got void *
   drivers/net/arcnet/com90xx.c:312:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:312:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:312:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:312:26: sparse:     got void *
   drivers/net/arcnet/com90xx.c:324:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:324:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:324:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:324:17: sparse:     got void *
   drivers/net/arcnet/com90xx.c:326:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:326:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:326:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:326:26: sparse:     got void *
   drivers/net/arcnet/com90xx.c:346:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:346:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:346:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:346:25: sparse:     got void *
   drivers/net/arcnet/com90xx.c:348:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:348:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:348:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:348:25: sparse:     got void *
   drivers/net/arcnet/com90xx.c:383:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com90xx.c:383:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com90xx.c:383:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com90xx.c:383:17: sparse:     got void *
--
>> drivers/net/arcnet/com20020.c:344:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020.c:344:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020.c:344:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:344:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:351:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020.c:351:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020.c:351:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:351:16: sparse:     got void *
   drivers/net/arcnet/com20020.c:352:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:352:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:352:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:352:18: sparse:     got void *
   drivers/net/arcnet/com20020.c:337:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:337:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:337:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:337:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:290:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:290:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:290:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:290:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:290:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:290:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:290:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:290:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:290:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:290:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:290:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:290:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:296:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:296:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:296:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:301:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:301:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:301:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:301:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:303:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:303:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:303:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:303:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:309:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:309:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:309:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:309:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:324:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:324:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:324:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:324:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:83:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:83:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:83:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:83:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:84:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:84:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:84:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:84:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:68:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:68:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:68:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:68:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:70:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:70:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:70:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:383:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:383:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:383:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:383:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:390:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:390:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:390:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:390:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:362:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:362:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:362:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:362:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:97:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:97:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:99:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:99:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:99:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:99:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:110:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:110:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:110:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:110:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:114:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:114:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:114:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:114:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:118:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:118:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:118:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:118:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:123:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:123:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:123:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:123:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:124:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:124:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:124:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:124:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:126:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:126:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:126:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:126:18: sparse:     got void *
   drivers/net/arcnet/com20020.c:134:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:134:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:134:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:134:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:136:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:136:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:136:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:136:18: sparse:     got void *
   drivers/net/arcnet/com20020.c:141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:141:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:141:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:141:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:143:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:143:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:143:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:143:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:145:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:145:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:145:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:145:18: sparse:     got void *
   drivers/net/arcnet/com20020.c:162:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:162:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:162:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:162:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:173:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:173:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:173:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:173:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:187:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:187:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:187:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:187:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:223:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:223:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:223:36: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:223:36: sparse:     got void *
   drivers/net/arcnet/com20020.c:226:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:226:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:226:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:226:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:230:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:230:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:230:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:230:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:234:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:234:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:234:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:234:17: sparse:     got void *
   drivers/net/arcnet/com20020.c:239:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:239:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:239:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:239:9: sparse:     got void *
   drivers/net/arcnet/com20020.c:240:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.c:240:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.c:240:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.c:240:9: sparse:     got void *
   drivers/net/arcnet/com20020.c: note: in included file:
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020.h:126:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:126:17: sparse:     got void *
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.h:128:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:128:17: sparse:     got void *
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020.h:126:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:126:17: sparse:     got void *
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.h:128:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:128:17: sparse:     got void *
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020.h:126:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:126:17: sparse:     got void *
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.h:128:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:128:17: sparse:     got void *
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020.h:126:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:126:17: sparse:     got void *
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.h:128:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020.h:128:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020.h:128:17: sparse:     got void *
>> drivers/net/arcnet/com20020.h:126:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020.h:126:17: sparse: sparse: too many warnings
--
>> drivers/net/arcnet/com20020-pci.c:78:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020-pci.c:78:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020-pci.c:78:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:78:9: sparse:     got void *
   drivers/net/arcnet/com20020-pci.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020-pci.c:93:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020-pci.c:93:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:93:9: sparse:     got void *
   drivers/net/arcnet/com20020-pci.c:188:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020-pci.c:188:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020-pci.c:188:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:188:17: sparse:     got void *
   drivers/net/arcnet/com20020-pci.c:189:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/arcnet/com20020-pci.c:189:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/arcnet/com20020-pci.c:189:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:189:17: sparse:     got void *
   drivers/net/arcnet/com20020-pci.c:204:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020-pci.c:204:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020-pci.c:204:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:204:34: sparse:     got void *
   drivers/net/arcnet/com20020-pci.c:212:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020-pci.c:212:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020-pci.c:212:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:212:32: sparse:     got void *
   drivers/net/arcnet/com20020-pci.c:216:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/arcnet/com20020-pci.c:216:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/arcnet/com20020-pci.c:216:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/arcnet/com20020-pci.c:216:21: sparse:     got void *
--
>> drivers/staging/comedi/drivers/comedi_parport.c:78:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/comedi_parport.c:78:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/comedi_parport.c:78:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:78:17: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:80:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/comedi_parport.c:80:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/comedi_parport.c:80:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:80:19: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:97:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:97:16: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:102:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:102:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:102:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:102:9: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:112:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:112:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:112:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:112:19: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:125:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:125:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:125:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:125:24: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:128:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:128:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:128:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:128:17: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:189:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:189:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:189:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:189:16: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:191:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:191:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:191:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:191:9: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:201:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:201:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:201:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:201:16: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:203:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:203:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:203:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:203:9: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:214:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:214:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:214:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:214:16: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:289:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:289:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:289:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:289:9: sparse:     got void *
   drivers/staging/comedi/drivers/comedi_parport.c:290:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/comedi_parport.c:290:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/comedi_parport.c:290:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/comedi_parport.c:290:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/addi_watchdog.c:44:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_watchdog.c:44:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_watchdog.c:44:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_watchdog.c:44:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_watchdog.c:57:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_watchdog.c:57:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_watchdog.c:57:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_watchdog.c:57:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_watchdog.c:71:27: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_watchdog.c:71:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_watchdog.c:71:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_watchdog.c:71:27: sparse:     got void *
   drivers/staging/comedi/drivers/addi_watchdog.c:91:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_watchdog.c:91:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_watchdog.c:91:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_watchdog.c:91:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_watchdog.c:100:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_watchdog.c:100:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_watchdog.c:100:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_watchdog.c:100:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_watchdog.c:101:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_watchdog.c:101:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_watchdog.c:101:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_watchdog.c:101:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/addi_apci_1032.c:93:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_1032.c:93:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_1032.c:93:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:93:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:95:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_1032.c:95:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_1032.c:95:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:95:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:97:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:97:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:97:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:97:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:98:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:236:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:236:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:236:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:236:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:237:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:237:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:237:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:237:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:238:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:238:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:238:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:238:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:257:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:257:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:257:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:257:14: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:262:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:262:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:262:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:262:16: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:267:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:267:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:267:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:267:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:269:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:269:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:269:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:269:20: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:274:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:274:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:274:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:274:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1032.c:284:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1032.c:284:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1032.c:284:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1032.c:284:19: sparse:     got void *
--
>> drivers/staging/comedi/drivers/addi_apci_1564.c:175:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_1564.c:175:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_1564.c:175:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:175:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:176:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_1564.c:176:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_1564.c:176:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:176:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:177:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:177:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:177:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:178:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:178:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:178:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:178:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:181:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:181:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:181:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:181:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:182:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:182:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:182:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:182:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:188:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:188:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:188:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:188:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:189:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:189:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:189:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:189:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:195:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:195:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:195:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:195:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:196:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:196:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:196:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:196:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:197:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:197:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:197:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:197:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:214:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:214:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:214:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:214:18: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:217:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:217:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:217:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:217:28: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:222:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:222:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:222:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:222:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:224:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:224:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:224:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:224:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:227:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:227:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:227:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:227:18: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:232:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:232:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:232:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:232:24: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:233:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:233:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:233:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:233:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:234:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:234:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:234:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:234:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:243:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:243:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:243:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:243:34: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:248:40: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:248:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:248:40: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:248:40: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:249:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:249:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:249:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:249:33: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:250:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:250:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:250:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:250:33: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:268:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:268:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:268:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:268:19: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:278:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:278:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:278:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:278:20: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:281:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:281:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:281:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_1564.c:281:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_1564.c:293:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_1564.c:293:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_1564.c:293:19: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/addi_apci_2032.c:48:20: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_2032.c:48:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_2032.c:48:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:48:20: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:51:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_2032.c:51:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_2032.c:51:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:51:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:63:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:63:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:63:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:63:19: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:74:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:74:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:74:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:74:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:141:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:141:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:141:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:141:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:174:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:174:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:174:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:174:15: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:181:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:181:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:181:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:181:15: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:183:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:183:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:183:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:183:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:218:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:218:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:218:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:218:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2032.c:219:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2032.c:219:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2032.c:219:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2032.c:219:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/addi_apci_2200.c:33:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_2200.c:33:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_2200.c:33:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2200.c:33:19: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2200.c:43:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2200.c:43:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2200.c:43:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2200.c:43:20: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2200.c:46:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_2200.c:46:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_2200.c:46:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2200.c:46:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_2200.c:55:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_2200.c:55:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_2200.c:55:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_2200.c:55:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/addi_apci_3xxx.c:644:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_3xxx.c:644:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_3xxx.c:644:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:644:19: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:654:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:654:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:654:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:654:20: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:657:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/addi_apci_3xxx.c:657:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/addi_apci_3xxx.c:657:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:657:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:692:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:692:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:692:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:692:9: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:708:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:708:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:708:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:708:25: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:710:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:710:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:710:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:710:25: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:713:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:713:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:713:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:713:15: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:714:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:714:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:714:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:714:17: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:716:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:716:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:716:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:716:25: sparse:     got void *
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:718:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:718:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:718:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/addi_apci_3xxx.c:718:25: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adl_pci6208.c:49:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci6208.c:49:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci6208.c:49:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci6208.c:49:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci6208.c:73:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci6208.c:73:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci6208.c:73:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci6208.c:73:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci6208.c:89:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci6208.c:89:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci6208.c:89:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci6208.c:89:15: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci6208.c:103:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci6208.c:103:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci6208.c:103:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci6208.c:103:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci6208.c:162:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci6208.c:162:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci6208.c:162:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci6208.c:162:15: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adl_pci7x3x.c:126:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci7x3x.c:126:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci7x3x.c:126:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci7x3x.c:126:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci7x3x.c:141:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci7x3x.c:141:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci7x3x.c:141:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci7x3x.c:141:19: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adl_pci9111.c:138:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci9111.c:138:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci9111.c:138:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:138:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:158:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci9111.c:158:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci9111.c:158:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:158:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:171:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:171:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:179:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:179:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:179:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:179:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:180:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:180:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:180:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:180:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:181:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:181:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:181:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:181:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:194:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:194:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:194:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:194:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:352:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:352:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:352:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:352:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:355:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:355:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:355:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:355:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:381:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:381:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:381:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:381:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:473:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:473:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:473:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:473:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:486:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:486:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:486:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:486:26: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:492:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:492:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:492:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:492:25: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:507:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:507:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:507:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:507:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:523:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:523:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:523:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:523:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:542:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:542:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:542:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:542:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:544:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:544:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:544:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:544:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:546:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:546:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:546:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:546:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:554:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:554:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:554:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:554:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:562:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:562:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:562:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:562:27: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:580:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:580:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:580:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:580:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:592:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:592:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:592:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:592:19: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:603:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:603:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:603:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:603:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9111.c:619:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9111.c:619:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9111.c:619:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9111.c:619:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adl_pci9118.c:250:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci9118.c:250:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci9118.c:250:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:250:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:251:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:251:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:251:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:251:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:259:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adl_pci9118.c:259:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adl_pci9118.c:259:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:259:16: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:264:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:264:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:264:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:264:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:273:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:273:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:273:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:273:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:278:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:278:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:278:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:278:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:284:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:284:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:284:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:350:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:350:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:350:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:350:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:353:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:353:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:353:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:353:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:354:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:354:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:354:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:354:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:355:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:355:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:355:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:355:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:363:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:363:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:363:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:363:25: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:375:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:375:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:375:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:375:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:383:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:383:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:383:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:383:25: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:386:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:386:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:386:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:386:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:398:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:398:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:398:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:398:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:402:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:402:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:402:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:402:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:521:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:521:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:521:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:521:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:573:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:573:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:573:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:573:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:576:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:576:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:576:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:576:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:577:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:577:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:577:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:577:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:579:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:579:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:579:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:579:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:580:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:584:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:584:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:584:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:584:9: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:626:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:626:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:626:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:626:17: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:689:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:689:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:689:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:689:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:690:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:690:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:690:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adl_pci9118.c:690:18: sparse:     got void *
   drivers/staging/comedi/drivers/adl_pci9118.c:695:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adl_pci9118.c:695:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adl_pci9118.c:695:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/adv_pci1710.c:273:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adv_pci1710.c:273:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adv_pci1710.c:273:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:273:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:274:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:274:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:274:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:274:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:284:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:284:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:284:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:284:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:294:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adv_pci1710.c:294:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adv_pci1710.c:294:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:294:18: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:310:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:310:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:310:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:310:18: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:340:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:340:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:340:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:340:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:342:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:342:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:342:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:343:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:343:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:343:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:343:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:351:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:351:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:351:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:351:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:366:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:366:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:366:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:366:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:368:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:368:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:368:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:368:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:369:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:369:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:369:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:369:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:381:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:381:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:381:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:381:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:387:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:387:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:387:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:387:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:388:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:388:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:388:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:388:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:401:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:401:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:401:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:401:18: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:414:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:414:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:414:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:414:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:416:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:416:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:416:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:416:18: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:432:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:432:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:432:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:432:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:444:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:444:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:444:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:444:18: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:477:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:477:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:477:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:477:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:494:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:494:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:494:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:494:15: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:501:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:501:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:501:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:501:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:503:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:503:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:503:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:503:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:504:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:504:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:504:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:504:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:506:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:506:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:506:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:506:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:507:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:507:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:507:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:507:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:530:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:530:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:530:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1710.c:530:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1710.c:531:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1710.c:531:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1710.c:531:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/adv_pci1720.c:81:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adv_pci1720.c:81:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adv_pci1720.c:81:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1720.c:81:15: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1720.c:84:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adv_pci1720.c:84:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adv_pci1720.c:84:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1720.c:84:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1720.c:90:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1720.c:90:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1720.c:90:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1720.c:90:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1720.c:91:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1720.c:91:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1720.c:91:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1720.c:91:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1720.c:107:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1720.c:107:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1720.c:107:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1720.c:107:19: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1720.c:151:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1720.c:151:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1720.c:151:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1720.c:151:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/adv_pci1723.c:89:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adv_pci1723.c:89:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adv_pci1723.c:89:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:89:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:114:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:114:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:114:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:114:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:125:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:125:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:125:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:125:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:127:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/adv_pci1723.c:127:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/adv_pci1723.c:127:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:127:19: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:163:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:163:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:163:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:163:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:165:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:165:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:165:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:165:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:167:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:167:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:167:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:167:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:169:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:169:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:169:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:169:17: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:172:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:172:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:172:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:175:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:175:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:175:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:175:9: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:187:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:187:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:187:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:187:15: sparse:     got void *
   drivers/staging/comedi/drivers/adv_pci1723.c:192:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/adv_pci1723.c:192:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/adv_pci1723.c:192:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/adv_pci1723.c:192:20: sparse:     got void *
--
>> drivers/staging/comedi/drivers/amplc_pci236.c:62:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pci236.c:62:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pci236.c:62:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci236.c:62:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci236.c:71:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pci236.c:71:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pci236.c:71:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci236.c:71:15: sparse:     got void *
--
>> drivers/staging/comedi/drivers/amplc_pci224.c:395:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pci224.c:395:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pci224.c:395:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:395:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:400:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:400:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:400:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:400:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:413:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:413:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:413:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:413:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:415:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pci224.c:415:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pci224.c:415:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:415:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:452:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:452:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:452:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:452:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:470:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:470:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:470:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:470:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:475:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:475:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:475:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:475:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:498:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:498:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:498:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:498:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:516:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:516:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:516:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:516:19: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:558:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:558:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:558:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:558:25: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:571:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:571:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:571:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:571:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:600:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:600:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:600:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:600:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:817:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:817:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:817:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:817:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:820:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:820:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:820:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:820:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:822:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:822:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:822:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:822:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:825:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:825:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:825:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:825:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:861:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:861:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:861:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:861:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:880:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:880:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:880:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:880:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:894:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:894:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:894:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:894:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:956:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:956:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:956:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:956:19: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:963:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:963:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:963:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:963:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:982:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:982:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:982:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:982:25: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:1045:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:1045:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:1045:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:1045:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:1048:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:1048:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:1048:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:1048:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:1049:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:1049:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:1049:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:1049:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:1050:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:1050:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:1050:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:1050:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci224.c:1053:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci224.c:1053:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci224.c:1053:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci224.c:1053:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/cb_pcidda.c:319:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/cb_pcidda.c:319:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/cb_pcidda.c:319:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_pcidda.c:319:9: sparse:     got void *
   drivers/staging/comedi/drivers/cb_pcidda.c:322:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/cb_pcidda.c:322:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/cb_pcidda.c:322:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/cb_pcidda.c:322:17: sparse:     got void *
   drivers/staging/comedi/drivers/cb_pcidda.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/me4000.c:326:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/me4000.c:326:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/me4000.c:326:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:326:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:329:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/me4000.c:329:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/me4000.c:329:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:329:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:331:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:331:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:331:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:331:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:334:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:334:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:334:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:334:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:338:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:338:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:338:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:338:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:345:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:345:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:345:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:345:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:347:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:347:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:347:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:347:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:357:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:357:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:357:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:357:17: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:361:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:361:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:361:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:361:23: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:370:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:370:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:370:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:370:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:378:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:378:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:378:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:378:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:380:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:380:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:380:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:380:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:390:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:390:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:390:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:390:16: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:392:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:392:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:392:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:392:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:395:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:395:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:395:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:395:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:405:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:405:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:405:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:405:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:408:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:408:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:408:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:408:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:410:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:410:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:410:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:410:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:412:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:412:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:412:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:412:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:416:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:416:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:416:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:416:17: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:423:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:423:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:423:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:423:17: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:426:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:426:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:426:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:426:9: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:433:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:433:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:433:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:433:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:434:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:434:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:434:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:434:17: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:443:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:443:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:443:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:443:15: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:454:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:454:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:454:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/me4000.c:454:18: sparse:     got void *
   drivers/staging/comedi/drivers/me4000.c:497:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/me4000.c:497:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/me4000.c:497:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/amplc_pci230.c:540:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pci230.c:540:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pci230.c:540:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:540:16: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:580:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/amplc_pci230.c:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/amplc_pci230.c:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:580:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:590:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:590:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:590:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:590:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:694:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:694:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:694:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:694:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:716:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:716:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:716:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:716:18: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:791:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:791:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:791:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:791:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:794:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:794:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:794:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:794:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:798:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:798:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:798:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:798:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:838:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:838:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:838:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:838:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1046:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1046:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1046:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1046:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1054:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1054:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1054:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1054:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1105:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1105:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1105:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1105:19: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1163:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1163:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1163:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1163:25: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1166:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1166:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1166:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1166:27: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1200:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1200:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1200:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1200:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1256:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1256:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1256:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1256:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1265:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1265:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1265:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1265:25: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1270:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1270:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1270:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1270:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1281:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1281:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1281:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1281:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1333:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1333:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1333:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1333:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1348:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1348:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1348:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1348:9: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1359:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1359:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1359:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1359:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1732:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1732:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1732:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1732:25: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1741:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1741:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1741:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1741:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1802:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1802:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1802:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1802:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1804:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1804:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1804:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/amplc_pci230.c:1804:17: sparse:     got void *
   drivers/staging/comedi/drivers/amplc_pci230.c:1844:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/amplc_pci230.c:1844:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/amplc_pci230.c:1844:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/contec_pci_dio.c:36:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/contec_pci_dio.c:36:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/contec_pci_dio.c:36:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/contec_pci_dio.c:36:17: sparse:     got void *
   drivers/staging/comedi/drivers/contec_pci_dio.c:47:19: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/contec_pci_dio.c:47:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/contec_pci_dio.c:47:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/contec_pci_dio.c:47:19: sparse:     got void *
--
>> drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/kpc2000/kpc2000_i2c.c:326:25: sparse:     got void *
--
>> drivers/staging/vt6655/srom.c:85:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/vt6655/srom.c:85:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/vt6655/srom.c:85:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/vt6655/srom.c:85:25: sparse:     got void *
--
>> drivers/char/ipmi/ipmi_si_port_io.c:10:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/ipmi/ipmi_si_port_io.c:10:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/ipmi/ipmi_si_port_io.c:10:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/ipmi/ipmi_si_port_io.c:10:16: sparse:     got void *
   drivers/char/ipmi/ipmi_si_port_io.c:18:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/ipmi/ipmi_si_port_io.c:18:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/ipmi/ipmi_si_port_io.c:18:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/ipmi/ipmi_si_port_io.c:18:9: sparse:     got void *
   drivers/char/ipmi/ipmi_si_port_io.c:25:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/ipmi/ipmi_si_port_io.c:25:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/ipmi/ipmi_si_port_io.c:25:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/ipmi/ipmi_si_port_io.c:25:17: sparse:     got void *
   drivers/char/ipmi/ipmi_si_port_io.c:33:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/ipmi/ipmi_si_port_io.c:33:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/ipmi/ipmi_si_port_io.c:33:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/ipmi/ipmi_si_port_io.c:33:9: sparse:     got void *
   drivers/char/ipmi/ipmi_si_port_io.c:40:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/ipmi/ipmi_si_port_io.c:40:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/ipmi/ipmi_si_port_io.c:40:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/ipmi/ipmi_si_port_io.c:40:17: sparse:     got void *
   drivers/char/ipmi/ipmi_si_port_io.c:48:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/ipmi/ipmi_si_port_io.c:48:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/ipmi/ipmi_si_port_io.c:48:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/ipmi/ipmi_si_port_io.c:48:9: sparse:     got void *
--
>> sound/pci/cmipci.c:538:22: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/cmipci.c:538:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/cmipci.c:538:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:538:22: sparse:     got void *
   sound/pci/cmipci.c:542:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/cmipci.c:542:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/cmipci.c:542:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:542:9: sparse:     got void *
   sound/pci/cmipci.c:549:22: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:549:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:549:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:549:22: sparse:     got void *
   sound/pci/cmipci.c:553:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:553:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:553:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:553:9: sparse:     got void *
   sound/pci/cmipci.c:561:22: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:561:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:561:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:561:22: sparse:     got void *
   sound/pci/cmipci.c:565:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:565:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:565:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:565:9: sparse:     got void *
   sound/pci/cmipci.c:572:22: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:572:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:572:22: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:572:22: sparse:     got void *
   sound/pci/cmipci.c:576:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:576:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:576:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:576:9: sparse:     got void *
   sound/pci/cmipci.c:1951:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:1951:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:1951:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:1951:9: sparse:     got void *
   sound/pci/cmipci.c:1952:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:1952:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:1952:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:1952:9: sparse:     got void *
   sound/pci/cmipci.c:1959:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:1959:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:1959:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:1959:9: sparse:     got void *
   sound/pci/cmipci.c:1960:13: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:1960:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:1960:13: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:1960:13: sparse:     got void *
   sound/pci/cmipci.c:2195:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2195:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2195:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2195:16: sparse:     got void *
   sound/pci/cmipci.c:2219:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2219:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2219:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2219:16: sparse:     got void *
   sound/pci/cmipci.c:2232:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2232:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2232:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2232:9: sparse:     got void *
   sound/pci/cmipci.c:2327:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2327:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2327:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2327:23: sparse:     got void *
   sound/pci/cmipci.c:2360:23: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2360:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2360:23: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2360:23: sparse:     got void *
   sound/pci/cmipci.c:2372:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2372:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2372:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2372:25: sparse:     got void *
   sound/pci/cmipci.c:2751:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:2751:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:2751:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:2751:21: sparse:     got void *
   sound/pci/cmipci.c:3155:29: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:3155:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:3155:29: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:3155:29: sparse:     got void *
   sound/pci/cmipci.c:504:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:504:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:504:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:504:9: sparse:     got void *
   sound/pci/cmipci.c:504:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:504:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:504:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:504:9: sparse:     got void *
   sound/pci/cmipci.c:504:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:504:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:504:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:504:9: sparse:     got void *
   sound/pci/cmipci.c:515:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:515:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:515:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:515:9: sparse:     got void *
   sound/pci/cmipci.c:515:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:515:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:515:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:515:9: sparse:     got void *
   sound/pci/cmipci.c:504:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:504:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:504:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/cmipci.c:504:9: sparse:     got void *
   sound/pci/cmipci.c:509:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/cmipci.c:509:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/cmipci.c:509:16: sparse:     expected void const volatile [noderef] __iomem *addr
--
   drivers/char/tpm/tpm_atmel.c: note: in included file:
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:96:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:96:9: sparse:     got void *
   drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/tpm/tpm_atmel.h:97:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/tpm/tpm_atmel.h:97:16: sparse:     got void *
--
>> drivers/net/ethernet/amd/pcnet32.c:1777:31: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/amd/pcnet32.c:1777:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/amd/pcnet32.c:1777:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:1777:31: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:1454:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:1454:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:1454:27: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:1454:27: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:338:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/ethernet/amd/pcnet32.c:338:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/ethernet/amd/pcnet32.c:338:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:338:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:339:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:339:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:339:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:339:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:344:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:344:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:344:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:344:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:345:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:345:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:345:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:345:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:350:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:350:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:350:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:350:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:351:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:351:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:351:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:351:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:356:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:356:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:356:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:356:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:357:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:357:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:357:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:357:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:362:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:362:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:362:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:362:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:367:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:367:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:367:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:367:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:372:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:372:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:372:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:372:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:377:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:377:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:377:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:378:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:378:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:378:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:378:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:393:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:393:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:393:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:393:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:394:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:394:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:394:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:394:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:399:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:399:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:399:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:399:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:400:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:400:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:400:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:400:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:405:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:405:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:405:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:405:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:406:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:406:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:406:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:406:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:411:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:411:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:411:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:411:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:412:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:412:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:412:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:412:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:417:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:417:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:417:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:417:16: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:422:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:422:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:422:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:422:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:427:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:427:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:427:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:427:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:432:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:432:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:432:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/ethernet/amd/pcnet32.c:432:9: sparse:     got void *
   drivers/net/ethernet/amd/pcnet32.c:433:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/ethernet/amd/pcnet32.c:433:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/ethernet/amd/pcnet32.c:433:17: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> drivers/hwmon/w83627hf.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:126:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:127:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:127:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:127:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:127:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:116:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:116:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:116:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:117:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:117:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:117:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:117:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:102:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:102:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:102:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:102:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:103:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:103:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:103:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:103:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:135:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:135:9: sparse:     got void *
   drivers/hwmon/w83627hf.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h):
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
>> drivers/hwmon/w83627hf.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:126:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:127:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:127:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:127:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:127:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:116:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:116:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:116:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:117:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:117:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:117:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:117:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:135:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:135:9: sparse:     got void *
>> drivers/hwmon/w83627hf.c:126:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:126:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:126:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:126:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:127:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:127:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:127:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:127:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:116:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:116:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:116:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:116:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:117:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:117:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:117:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:117:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:109:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:109:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:109:9: sparse:     got void *
   drivers/hwmon/w83627hf.c:110:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/hwmon/w83627hf.c:110:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/hwmon/w83627hf.c:110:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:110:16: sparse:     got void *
   drivers/hwmon/w83627hf.c:135:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/hwmon/w83627hf.c:135:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/hwmon/w83627hf.c:135:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/hwmon/w83627hf.c:135:9: sparse:     got void *
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
   include/asm-generic/io.h:580:9: sparse: sparse: too many warnings
--
>> drivers/i2c/busses/i2c-amd756.c:124:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/i2c/busses/i2c-amd756.c:124:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/i2c/busses/i2c-amd756.c:124:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-amd756.c:124:16: sparse:     got void *
   drivers/i2c/busses/i2c-amd756.c:174:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i2c/busses/i2c-amd756.c:174:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/i2c/busses/i2c-amd756.c:174:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-amd756.c:174:16: sparse:     got void *
   drivers/i2c/busses/i2c-amd756.c:286:20: sparse: sparse: symbol 'amd756_smbus' was not declared. Should it be static?
   drivers/i2c/busses/i2c-amd756.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:564:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:564:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:564:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:564:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:588:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:588:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:588:9: sparse:     got void *
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
   include/asm-generic/io.h:588:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/i2c/busses/i2c-piix4.c:464:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/i2c/busses/i2c-piix4.c:464:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/i2c/busses/i2c-piix4.c:464:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-piix4.c:464:16: sparse:     got void *
   drivers/i2c/busses/i2c-piix4.c:500:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/i2c/busses/i2c-piix4.c:500:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/i2c/busses/i2c-piix4.c:500:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/i2c/busses/i2c-piix4.c:500:24: sparse:     got void *
   drivers/i2c/busses/i2c-piix4.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
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
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
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
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:556:16: sparse:     expected void const volatile [noderef] __iomem *addr
   include/asm-generic/io.h:556:16: sparse:     got void *
   include/asm-generic/io.h:556:16: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:556:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
--
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
--
>> sound/pci/pcxhr/pcxhr_core.c:120:25: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_core.c:120:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_core.c:120:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:120:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_core.c:174:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:174:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:186:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:190:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:229:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:235:28: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:241:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:250:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:252:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:256:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:278:18: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:290:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:302:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:304:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:311:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:356:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:357:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:358:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:379:13: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:383:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:385:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:390:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:412:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:418:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_core.c:558:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_core.c:559:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_core.c:559:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_core.c:559:25: sparse:     expected void const volatile [noderef] __iomem *addr
--
>> sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:210:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:213:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:218:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:259:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:262:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:265:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:677:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:278:15: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:285:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:291:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:372:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:373:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:377:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:429:14: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:436:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:446:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:449:31: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:451:32: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:499:37: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:517:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:529:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:618:9: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:632:17: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:634:21: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:654:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/pcxhr/pcxhr_mix22.c:656:25: sparse:     got void *
   sound/pci/pcxhr/pcxhr_mix22.c:689:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/pcxhr/pcxhr_mix22.c:689:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/pcxhr/pcxhr_mix22.c:689:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/net/fddi/defxx.c:740:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/fddi/defxx.c:740:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/fddi/defxx.c:740:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:740:17: sparse:     got void *
   drivers/net/fddi/defxx.c:743:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/net/fddi/defxx.c:743:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/net/fddi/defxx.c:743:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:743:23: sparse:     got void *
   drivers/net/fddi/defxx.c:778:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:778:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:778:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:778:17: sparse:     got void *
   drivers/net/fddi/defxx.c:780:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:780:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:780:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:780:17: sparse:     got void *
   drivers/net/fddi/defxx.c:783:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:783:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:783:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:783:17: sparse:     got void *
   drivers/net/fddi/defxx.c:785:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:785:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:785:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:785:17: sparse:     got void *
   drivers/net/fddi/defxx.c:788:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:788:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:788:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:788:17: sparse:     got void *
   drivers/net/fddi/defxx.c:790:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:790:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:790:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:790:17: sparse:     got void *
   drivers/net/fddi/defxx.c:793:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:793:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:793:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:793:17: sparse:     got void *
   drivers/net/fddi/defxx.c:795:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:795:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:795:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:795:17: sparse:     got void *
   drivers/net/fddi/defxx.c:803:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:803:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:803:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:803:17: sparse:     got void *
   drivers/net/fddi/defxx.c:810:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:810:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:810:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:810:17: sparse:     got void *
   drivers/net/fddi/defxx.c:816:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:816:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:816:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:816:23: sparse:     got void *
   drivers/net/fddi/defxx.c:821:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:821:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:821:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:821:17: sparse:     got void *
   drivers/net/fddi/defxx.c:824:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:824:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:824:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:824:23: sparse:     got void *
   drivers/net/fddi/defxx.c:826:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:826:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:826:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:826:17: sparse:     got void *
   drivers/net/fddi/defxx.c:893:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:893:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:893:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:893:23: sparse:     got void *
   drivers/net/fddi/defxx.c:895:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:895:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:895:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:895:17: sparse:     got void *
   drivers/net/fddi/defxx.c:898:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:898:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:898:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:898:17: sparse:     got void *
   drivers/net/fddi/defxx.c:901:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:901:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:901:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:901:17: sparse:     got void *
   drivers/net/fddi/defxx.c:1985:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:1985:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:1985:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:1985:26: sparse:     got void *
   drivers/net/fddi/defxx.c:1993:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:1993:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:1993:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:1993:17: sparse:     got void *
   drivers/net/fddi/defxx.c:1999:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:1999:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:1999:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:1999:26: sparse:     got void *
   drivers/net/fddi/defxx.c:2001:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:2001:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:2001:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:2001:17: sparse:     got void *
   drivers/net/fddi/defxx.c:456:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:456:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:456:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:456:34: sparse:     got void *
   drivers/net/fddi/defxx.c:458:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:458:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:458:35: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/net/fddi/defxx.c:458:35: sparse:     got void *
   drivers/net/fddi/defxx.c:460:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/net/fddi/defxx.c:460:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/net/fddi/defxx.c:460:35: sparse:     expected void const volatile [noderef] __iomem *addr
--
   drivers/input/joystick/adi.c: note: in included file:
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
--
   drivers/input/joystick/a3d.c: note: in included file:
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
--
   drivers/input/joystick/analog.c: note: in included file:
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
--
   drivers/input/joystick/guillemot.c: note: in included file:
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
--
   drivers/input/joystick/interact.c: note: in included file:
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
--
   drivers/input/joystick/joydump.c: note: in included file:
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
   include/linux/gameport.h:171:17: sparse: sparse: cast removes address space '__iomem' of expression
>> include/linux/gameport.h:171:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> include/linux/gameport.h:171:17: sparse:     expected void volatile [noderef] __iomem *addr
   include/linux/gameport.h:171:17: sparse:     got void *
   include/linux/gameport.h:179:24: sparse: sparse: cast removes address space '__iomem' of expression
   include/linux/gameport.h:179:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   include/linux/gameport.h:179:24: sparse:     expected void const volatile [noderef] __iomem *addr
   include/linux/gameport.h:179:24: sparse:     got void *
--
>> drivers/input/touchscreen/mk712.c:87:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/input/touchscreen/mk712.c:87:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/input/touchscreen/mk712.c:87:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:87:18: sparse:     got void *
   drivers/input/touchscreen/mk712.c:110:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:110:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:110:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:110:18: sparse:     got void *
   drivers/input/touchscreen/mk712.c:111:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:111:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:111:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:111:18: sparse:     got void *
   drivers/input/touchscreen/mk712.c:123:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/input/touchscreen/mk712.c:123:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/input/touchscreen/mk712.c:123:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:123:9: sparse:     got void *
   drivers/input/touchscreen/mk712.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:125:9: sparse:     got void *
   drivers/input/touchscreen/mk712.c:130:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:130:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:130:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:130:9: sparse:     got void *
   drivers/input/touchscreen/mk712.c:143:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:143:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:143:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:143:9: sparse:     got void *
   drivers/input/touchscreen/mk712.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:157:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:157:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:157:9: sparse:     got void *
   drivers/input/touchscreen/mk712.c:159:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:159:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:159:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:159:14: sparse:     got void *
   drivers/input/touchscreen/mk712.c:160:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:160:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:160:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:160:14: sparse:     got void *
   drivers/input/touchscreen/mk712.c:161:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/input/touchscreen/mk712.c:161:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/input/touchscreen/mk712.c:161:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/input/touchscreen/mk712.c:161:14: sparse:     got void *
--
>> sound/pci/vx222/vx222_ops.c:87:16: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/vx222/vx222_ops.c:87:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/vx222/vx222_ops.c:87:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:87:16: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:98:9: sparse: sparse: cast removes address space '__iomem' of expression
>> sound/pci/vx222/vx222_ops.c:98:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> sound/pci/vx222/vx222_ops.c:98:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:98:9: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:111:16: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/vx222/vx222_ops.c:111:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/vx222/vx222_ops.c:111:16: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:111:16: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:125:9: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/vx222/vx222_ops.c:125:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/vx222/vx222_ops.c:125:9: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:125:9: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:265:25: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/vx222/vx222_ops.c:265:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/vx222/vx222_ops.c:265:25: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:265:25: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:275:17: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/vx222/vx222_ops.c:275:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/vx222/vx222_ops.c:275:17: sparse:     expected void volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:275:17: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:303:35: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/vx222/vx222_ops.c:303:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/vx222/vx222_ops.c:303:35: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:303:35: sparse:     got void *
   sound/pci/vx222/vx222_ops.c:311:27: sparse: sparse: cast removes address space '__iomem' of expression
   sound/pci/vx222/vx222_ops.c:311:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   sound/pci/vx222/vx222_ops.c:311:27: sparse:     expected void const volatile [noderef] __iomem *addr
   sound/pci/vx222/vx222_ops.c:311:27: sparse:     got void *
--
>> drivers/media/rc/serial_ir.c:147:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/media/rc/serial_ir.c:147:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/media/rc/serial_ir.c:147:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/media/rc/serial_ir.c:147:16: sparse:     got void *
   drivers/media/rc/serial_ir.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/media/rc/serial_ir.c:157:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/media/rc/serial_ir.c:157:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/media/rc/serial_ir.c:157:9: sparse:     got void *

vim +/__iomem +565 drivers/net/arcnet/com90xx.c

^1da177e4c3f415 Linus Torvalds 2005-04-16  560  
^1da177e4c3f415 Linus Torvalds 2005-04-16  561  static void com90xx_command(struct net_device *dev, int cmd)
^1da177e4c3f415 Linus Torvalds 2005-04-16  562  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  563  	short ioaddr = dev->base_addr;
^1da177e4c3f415 Linus Torvalds 2005-04-16  564  
09dfbcd5d178f8e Joe Perches    2015-05-05 @565  	arcnet_outb(cmd, ioaddr, COM9026_REG_W_COMMAND);
^1da177e4c3f415 Linus Torvalds 2005-04-16  566  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  567  
^1da177e4c3f415 Linus Torvalds 2005-04-16  568  static int com90xx_status(struct net_device *dev)
^1da177e4c3f415 Linus Torvalds 2005-04-16  569  {
^1da177e4c3f415 Linus Torvalds 2005-04-16  570  	short ioaddr = dev->base_addr;
^1da177e4c3f415 Linus Torvalds 2005-04-16  571  
09dfbcd5d178f8e Joe Perches    2015-05-05 @572  	return arcnet_inb(ioaddr, COM9026_REG_R_STATUS);
^1da177e4c3f415 Linus Torvalds 2005-04-16  573  }
^1da177e4c3f415 Linus Torvalds 2005-04-16  574  

:::::: The code at line 565 was first introduced by commit
:::::: 09dfbcd5d178f8e03b5a29c9f3411687ec388c91 arcnet: com90xx: Use arcnet_<I/O> routines

:::::: TO: Joe Perches <joe@perches.com>
:::::: CC: Michael Grzeschik <m.grzeschik@pengutronix.de>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--IS0zKkzwUGydFO0o
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICDoPIl8AAy5jb25maWcAjDzZcuS2ru/5ii7n5ZyHJF4mvsm95QeKolpMazNJtZcXlcfT
M3HFyxy7nZP8/QVILSQF9SRVSdwACJIgiI2kvv/u+xV737883e0f7u8eH/9efdk9717v9rtP
q88Pj7v/W6X1qqrNSqTS/AjExcPz+18/vT683f+5+vnHX348/uH1/mS12b0+7x5X/OX588OX
d2j+8PL83fff8brK5LrjvNsKpWVddUZcm4sj2/zs9IdHZPbDl/v71b/WnP979euPZz8eH3nN
pO4AcfH3AFpPrC5+PT47Ph4QRTrCT88+HNt/Rj4Fq9Yj+thjnzPdMV1269rUUyceQlaFrISH
qittVMtNrfQEleqyu6rVZoKYXAmWQvOshv90hmlEgkS+X62tfB9Xb7v9+9dJRrKSphPVtmMK
ZiNLaS7OToF87LhsZCFAftqsHt5Wzy975DBOv+asGGZ4dESBO9b6k0xaCTLTrDAefSoy1hbG
DoYA57U2FSvFxdG/nl+ed/8+msanb/RWNtwf2ohrai2vu/KyFa0gCa6Y4Xk3ww9TV7XWXSnK
Wt10zBjGc5jG2LjVopAJ0Y61oLLThHO2FSBc6MgiYMAgm2LCR1C7VrCwq7f3j29/v+13T9Na
rUUllOR23XVeX3n66WFKuVbM4IKQaJ7LJlShtC6ZrEKYliVF1OVSKJzMzZx5qSVSLiJm/eSs
SkG1es5BU90wpUUPG0XuTyMVSbvOdLiuu+dPq5fPkfhIGYFayX4AylsLXCYO2rvRdau4cAo5
m5ClEFtRGT2smHl42r2+UYtmJN90dSVgwTxWVd3lt7i7SrtO4xQB2EAfdSo5oVqulYRB+20s
lFTwXK7zTgkNgyhhN5LCmo186KxRQpSNAfZV0N0A39ZFWxmmbujN56iISQzteQ3NB/nxpv3J
3L39sdrDcFZ3MLS3/d3+bXV3f//y/rx/eP4SSRQadIxbHrJa++PTPBcpWEKhSlZgb1q3ijYA
iU6BoOZAgswMSYRGVBtmND1PLUmx/oMJeVYWJiN1Xdht67OzslG8XWlCsUCOHeD8ucPPTlyD
BlGC147Ybx6BcKaWR6/pBGoGalNBwY1iPEIgYxBkUUx672EqAaumxZonhdTGTqoXZTj/0Sht
3B+emdqMGlZzH5yDTwT1v3ia/BM6ogyMqMzMxemxD8e1KNm1hz85nVRXVmYD3isTEY+Ts9hI
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
xeMBAA==

--IS0zKkzwUGydFO0o--
