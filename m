Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74D22C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:13:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E93372075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 19:13:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728228AbgFVTNo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 15:13:44 -0400
Received: from mga02.intel.com ([134.134.136.20]:25246 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726854AbgFVTNn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 15:13:43 -0400
IronPort-SDR: I2b5N0ZxLIB2AYYgLTGapII9mcKYbbswAY/ppvQsLmGQpMVaY+LsIhGZnFKEF+kEtrE2SrZkJQ
 NRzgHypCOuLg==
X-IronPort-AV: E=McAfee;i="6000,8403,9660"; a="132285857"
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="gz'50?scan'50,208,50";a="132285857"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2020 12:13:08 -0700
IronPort-SDR: YBHuAmZFl5j37SMp0pMdBJcSclYTHzYwivBYCkSRSoZzcTAIZzhkj+NWhT+iG6NxLCoGWYxbOA
 SjR6+ydLFP6g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,268,1589266800"; 
   d="gz'50?scan'50,208,50";a="292945625"
Received: from lkp-server01.sh.intel.com (HELO f484c95e4fd1) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 22 Jun 2020 12:13:06 -0700
Received: from kbuild by f484c95e4fd1 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jnRsP-0000QC-Ih; Mon, 22 Jun 2020 19:13:05 +0000
Date:   Tue, 23 Jun 2020 03:12:26 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect
 type in argument 2 (different address spaces)
Message-ID: <202006230314.hngC8OCx%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="3V7upXqbjpZ4EhLz"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3V7upXqbjpZ4EhLz
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   625d3449788f85569096780592549d0340e9c0c7
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 days ago
config: s390-randconfig-s032-20200622 (attached as .config)
compiler: s390-linux-gcc (GCC) 9.3.0
reproduce:
        # apt-get install sparse
        # sparse version: v0.6.2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        make W=1 C=1 ARCH=s390 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__'

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char *buf @@
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected void const volatile [noderef] __user *
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got char *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     expected void [noderef] __user *ptr
   drivers/w1/slaves/w1_ds28e04.c:342:13: sparse:     got char *buf
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got char const *buf @@
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const volatile [noderef] __user *
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got char const *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const [noderef] __user *ptr
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got char const *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const [noderef] __user *ptr
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got char const *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const [noderef] __user *ptr
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got char const *buf @@
>> drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     expected void const [noderef] __user *ptr
   drivers/w1/slaves/w1_ds28e04.c:356:13: sparse:     got char const *buf
--
>> drivers/video/fbdev/sstfb.c:337:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/sstfb.c:337:23: sparse:     expected void *s
   drivers/video/fbdev/sstfb.c:337:23: sparse:     got char [noderef] __iomem *screen_base
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
--
>> drivers/video/fbdev/tdfxfb.c:1120:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got unsigned char [noderef] [usertype] __iomem *cursorbase @@
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     expected void *s
   drivers/video/fbdev/tdfxfb.c:1120:27: sparse:     got unsigned char [noderef] [usertype] __iomem *cursorbase
   drivers/video/fbdev/tdfxfb.c:1131:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tdfxfb.c:1134:33: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
--
>> drivers/video/fbdev/tridentfb.c:567:9: sparse: sparse: cast removes address space '__iomem' of expression
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
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:171:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:715:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:715:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:715:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:715:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/tridentfb.c:166:9: sparse: sparse: too many warnings
--
>> drivers/video/fbdev/arkfb.c:135:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:136:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:194:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:216:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/arkfb.c:252:25: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/core/fbmem.c:808:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const *src @@     got unsigned char [noderef] [usertype] __iomem *[assigned] src @@
   drivers/video/fbdev/core/fbmem.c:808:39: sparse:     expected void const *src
   drivers/video/fbdev/core/fbmem.c:808:39: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] src
>> drivers/video/fbdev/core/fbmem.c:885:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *dest @@     got unsigned char [noderef] [usertype] __iomem *[assigned] dst @@
   drivers/video/fbdev/core/fbmem.c:885:32: sparse:     expected void *dest
   drivers/video/fbdev/core/fbmem.c:885:32: sparse:     got unsigned char [noderef] [usertype] __iomem *[assigned] dst
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:819:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1094:5: sparse: sparse: symbol 'amdgpu_ttm_gart_bind' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __poll_t ( *poll )( ... ) @@     got unsigned int ( * )( ... ) @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     expected restricted __poll_t ( *poll )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:138:17: sparse:     got unsigned int ( * )( ... )
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
--
>> drivers/video/fbdev/kyro/fbdev.c:725:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void *s @@     got char [noderef] __iomem *screen_base @@
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     expected void *s
   drivers/video/fbdev/kyro/fbdev.c:725:23: sparse:     got char [noderef] __iomem *screen_base
--
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __user *ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected void [noderef] __user *ptr
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:225:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int [usertype] val @@     got restricted __le32 [usertype] @@
   include/asm-generic/io.h:225:22: sparse:     expected unsigned int [usertype] val
   include/asm-generic/io.h:225:22: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32
   include/asm-generic/io.h:179:15: sparse: sparse: cast to restricted __le32

vim +342 drivers/w1/slaves/w1_ds28e04.c

fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  338  
fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  339  static ssize_t crccheck_show(struct device *dev, struct device_attribute *attr,
fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  340  			     char *buf)
fbf7f7b4e2ae40 Markus Franke      2012-05-26  341  {
fbf7f7b4e2ae40 Markus Franke      2012-05-26 @342  	if (put_user(w1_enable_crccheck + 0x30, buf))
fbf7f7b4e2ae40 Markus Franke      2012-05-26  343  		return -EFAULT;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  344  
fbf7f7b4e2ae40 Markus Franke      2012-05-26  345  	return sizeof(w1_enable_crccheck);
fbf7f7b4e2ae40 Markus Franke      2012-05-26  346  }
fbf7f7b4e2ae40 Markus Franke      2012-05-26  347  
fa33a65a9cf7e2 Greg Kroah-Hartman 2013-08-21  348  static ssize_t crccheck_store(struct device *dev, struct device_attribute *attr,
fbf7f7b4e2ae40 Markus Franke      2012-05-26  349  			      const char *buf, size_t count)
fbf7f7b4e2ae40 Markus Franke      2012-05-26  350  {
fbf7f7b4e2ae40 Markus Franke      2012-05-26  351  	char val;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  352  
fbf7f7b4e2ae40 Markus Franke      2012-05-26  353  	if (count != 1 || !buf)
fbf7f7b4e2ae40 Markus Franke      2012-05-26  354  		return -EINVAL;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  355  
fbf7f7b4e2ae40 Markus Franke      2012-05-26 @356  	if (get_user(val, buf))
fbf7f7b4e2ae40 Markus Franke      2012-05-26  357  		return -EFAULT;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  358  
fbf7f7b4e2ae40 Markus Franke      2012-05-26  359  	/* convert to decimal */
fbf7f7b4e2ae40 Markus Franke      2012-05-26  360  	val = val - 0x30;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  361  	if (val != 0 && val != 1)
fbf7f7b4e2ae40 Markus Franke      2012-05-26  362  		return -EINVAL;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  363  
fbf7f7b4e2ae40 Markus Franke      2012-05-26  364  	/* set the new value */
fbf7f7b4e2ae40 Markus Franke      2012-05-26  365  	w1_enable_crccheck = val;
fbf7f7b4e2ae40 Markus Franke      2012-05-26  366  
fbf7f7b4e2ae40 Markus Franke      2012-05-26  367  	return sizeof(w1_enable_crccheck);
fbf7f7b4e2ae40 Markus Franke      2012-05-26  368  }
fbf7f7b4e2ae40 Markus Franke      2012-05-26  369  

:::::: The code at line 342 was first introduced by commit
:::::: fbf7f7b4e2ae40f790828c86d31beff2d49e9ac8 w1: Add 1-wire slave device driver for DS28E04-100

:::::: TO: Markus Franke <franm@hrz.tu-chemnitz.de>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--3V7upXqbjpZ4EhLz
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
h26QDC+Ig0ga/Sz2PzpLNSr9rAEA

--3V7upXqbjpZ4EhLz--
