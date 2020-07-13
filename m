Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2D622C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:45:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BF0FC20738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:45:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729457AbgGMLpT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:45:19 -0400
Received: from mga09.intel.com ([134.134.136.24]:18690 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727890AbgGMLpT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:45:19 -0400
IronPort-SDR: szHM24RTGgcH8oCQR7GW2Mj6A2aD0qOKVArv1yZXJDqsW13awLwTFzdtObU0T+qORLlq5Tvwae
 3wPBE0kgrxUA==
X-IronPort-AV: E=McAfee;i="6000,8403,9680"; a="150052397"
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="gz'50?scan'50,208,50";a="150052397"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jul 2020 04:44:39 -0700
IronPort-SDR: 5vP28DaLNWQoI57UzYnj15ZCT5+fsdTDhEsIGNonWxKoKIbb/rxnRmERDyRTHP/DDo5dQC1cWk
 yHrWLMeL8dRg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,347,1589266800"; 
   d="gz'50?scan'50,208,50";a="317351029"
Received: from lkp-server02.sh.intel.com (HELO fb03a464a2e3) ([10.239.97.151])
  by fmsmga002.fm.intel.com with ESMTP; 13 Jul 2020 04:44:37 -0700
Received: from kbuild by fb03a464a2e3 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1juwsu-0000oI-Dp; Mon, 13 Jul 2020 11:44:36 +0000
Date:   Mon, 13 Jul 2020 19:44:20 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse: sparse: incorrect
 type in argument 1 (different base types)
Message-ID: <202007131911.dCzN7j0T%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="wac7ysb48OaltWcw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--wac7ysb48OaltWcw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   11ba468877bb23f28956a35e896356252d63c983
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: powerpc-randconfig-s031-20200713 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-37-gc9676a3b-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:310:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:312:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:315:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:317:17: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:328:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     got restricted __be32 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:330:25: sparse:     got restricted __be32 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     got restricted __be16 [noderef] __iomem *
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
>> arch/powerpc/platforms/8xx/cpm1.c:350:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:352:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:355:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:357:17: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:361:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:363:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:367:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:369:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:371:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     got restricted __be16 [noderef] __iomem *
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   arch/powerpc/platforms/8xx/cpm1.c:373:25: sparse:     got restricted __be16 [noderef] __iomem *
--
>> drivers/dma/fsldma.h:209:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
>> drivers/dma/fsldma.h:209:41: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/dma/fsldma.h:209:41: sparse:     got unsigned int [usertype] *
   drivers/dma/fsldma.h:211:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/dma/fsldma.h:211:39: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/dma/fsldma.h:211:39: sparse:     got unsigned int [usertype] *
   drivers/dma/fsldma.h:223:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/dma/fsldma.h:223:41: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/dma/fsldma.h:223:41: sparse:     got unsigned int [usertype] *
   drivers/dma/fsldma.h:225:39: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got unsigned int [usertype] * @@
   drivers/dma/fsldma.h:225:39: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/dma/fsldma.h:225:39: sparse:     got unsigned int [usertype] *
--
>> drivers/soc/fsl/qe/usb.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/soc/fsl/qe/usb.c:46:9: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> drivers/soc/fsl/qe/usb.c:46:9: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/soc/fsl/qe/usb.c:46:9: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/soc/fsl/qe/usb.c:46:9: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> drivers/soc/fsl/qe/usb.c:46:9: sparse:     got restricted __be32 [noderef] __iomem *
--
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:78:16: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [usertype] *dp_mem @@     got void [noderef] __iomem * @@
   drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:78:16: sparse:     expected unsigned char [usertype] *dp_mem
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:78:16: sparse:     got void [noderef] __iomem *
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:85:29: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:86:48: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] mem_addr @@
>> drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:86:48: sparse:     expected void [noderef] __iomem *addr
   drivers/tty/serial/cpm_uart/cpm_uart_cpm1.c:86:48: sparse:     got unsigned char [usertype] *[assigned] mem_addr
--
>> drivers/watchdog/mpc8xxx_wdt.c:76:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/watchdog/mpc8xxx_wdt.c:76:24: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
>> drivers/watchdog/mpc8xxx_wdt.c:76:24: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/watchdog/mpc8xxx_wdt.c:77:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/watchdog/mpc8xxx_wdt.c:77:24: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:77:24: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/watchdog/mpc8xxx_wdt.c:85:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/watchdog/mpc8xxx_wdt.c:85:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
>> drivers/watchdog/mpc8xxx_wdt.c:85:33: sparse:     got restricted __be32 [noderef] __iomem *
>> drivers/watchdog/mpc8xxx_wdt.c:94:24: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/watchdog/mpc8xxx_wdt.c:94:24: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:94:24: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/watchdog/mpc8xxx_wdt.c:96:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/watchdog/mpc8xxx_wdt.c:96:29: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:96:29: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/watchdog/mpc8xxx_wdt.c:152:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/watchdog/mpc8xxx_wdt.c:152:33: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/watchdog/mpc8xxx_wdt.c:152:33: sparse:     got restricted __be32 [noderef] __iomem *
--
   drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse: sparse: incorrect type in initializer (different base types) @@     expected restricted __le16 [usertype] wMaxPacketSize @@     got int @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse:     expected restricted __le16 [usertype] wMaxPacketSize
   drivers/usb/gadget/udc/fsl_qe_udc.c:67:33: sparse:     got int
>> drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
>> drivers/usb/gadget/udc/fsl_qe_udc.c:148:52: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:155:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:165:52: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:172:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:193:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:197:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:210:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:214:30: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:216:17: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
>> drivers/usb/gadget/udc/fsl_qe_udc.c:302:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:317:51: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:334:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:387:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:391:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:396:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:400:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:456:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:461:19: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:506:42: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:770:25: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:771:30: sparse:     got restricted __be16 [noderef] __iomem *
>> drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
>> drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:836:68: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:964:68: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1074:33: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1075:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1089:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1114:30: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1124:30: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1367:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     expected unsigned int volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1431:27: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1490:60: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2287:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2288:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:1960:56: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned short [usertype] @@     got restricted __le16 [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     expected unsigned short [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:1978:30: sparse:     got restricted __le16 [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2174:62: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned int const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be32 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     expected unsigned int const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2199:62: sparse:     got restricted __be32 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2220:31: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short const volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     expected unsigned short const volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2221:29: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2223:22: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] offset @@     got restricted __be32 const [usertype] @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     expected unsigned int [usertype] offset
   drivers/usb/gadget/udc/fsl_qe_udc.c:2343:16: sparse:     got restricted __be32 const [usertype]
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2390:19: sparse:     got restricted __be16 [noderef] __iomem *
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse: sparse: incorrect type in argument 1 (different base types) @@     expected unsigned short volatile [noderef] [usertype] __iomem *addr @@     got restricted __be16 [noderef] __iomem * @@
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     expected unsigned short volatile [noderef] [usertype] __iomem *addr
   drivers/usb/gadget/udc/fsl_qe_udc.c:2392:19: sparse:     got restricted __be16 [noderef] __iomem *
   include/linux/spinlock.h:393:9: sparse: sparse: context imbalance in 'setup_received_handle' - unexpected unlock

vim +310 arch/powerpc/platforms/8xx/cpm1.c

663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  296  
132f92fdc42782 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  297  static void __init cpm1_set_pin32(int port, int pin, int flags)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  298  {
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  299  	struct cpm_ioport32e __iomem *iop;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  300  	pin = 1 << (31 - pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  301  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  302  	if (port == CPM_PORTB)
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  303  		iop = (struct cpm_ioport32e __iomem *)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  304  		      &mpc8xx_immr->im_cpm.cp_pbdir;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  305  	else
dc2380ec8572fc arch/powerpc/sysdev/cpm1.c        Jochen Friedrich 2008-07-03  306  		iop = (struct cpm_ioport32e __iomem *)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  307  		      &mpc8xx_immr->im_cpm.cp_pedir;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  308  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  309  	if (flags & CPM_PIN_OUTPUT)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @310  		setbits32(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  311  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  312  		clrbits32(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  313  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  314  	if (!(flags & CPM_PIN_GPIO))
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  315  		setbits32(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  316  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  317  		clrbits32(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  318  
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  319  	if (port == CPM_PORTB) {
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  320  		if (flags & CPM_PIN_OPENDRAIN)
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  321  			setbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  322  		else
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  323  			clrbits16(&mpc8xx_immr->im_cpm.cp_pbodr, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  324  	}
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  325  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  326  	if (port == CPM_PORTE) {
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  327  		if (flags & CPM_PIN_SECONDARY)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  328  			setbits32(&iop->sor, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  329  		else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  330  			clrbits32(&iop->sor, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  331  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  332  		if (flags & CPM_PIN_OPENDRAIN)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  333  			setbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  334  		else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  335  			clrbits32(&mpc8xx_immr->im_cpm.cp_peodr, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  336  	}
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  337  }
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  338  
132f92fdc42782 arch/powerpc/platforms/8xx/cpm1.c Christophe Leroy 2019-09-12  339  static void __init cpm1_set_pin16(int port, int pin, int flags)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  340  {
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  341  	struct cpm_ioport16 __iomem *iop =
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  342  		(struct cpm_ioport16 __iomem *)&mpc8xx_immr->im_ioport;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  343  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  344  	pin = 1 << (15 - pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  345  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  346  	if (port != 0)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  347  		iop += port - 1;
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  348  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  349  	if (flags & CPM_PIN_OUTPUT)
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16 @350  		setbits16(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  351  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  352  		clrbits16(&iop->dir, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  353  
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  354  	if (!(flags & CPM_PIN_GPIO))
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  355  		setbits16(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  356  	else
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  357  		clrbits16(&iop->par, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  358  
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  359  	if (port == CPM_PORTA) {
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  360  		if (flags & CPM_PIN_OPENDRAIN)
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  361  			setbits16(&iop->odr_sor, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  362  		else
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  363  			clrbits16(&iop->odr_sor, pin);
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  364  	}
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  365  	if (port == CPM_PORTC) {
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  366  		if (flags & CPM_PIN_SECONDARY)
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  367  			setbits16(&iop->odr_sor, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  368  		else
721c0c8af1a279 arch/powerpc/sysdev/commproc.c    Jochen Friedrich 2007-11-22  369  			clrbits16(&iop->odr_sor, pin);
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  370  		if (flags & CPM_PIN_FALLEDGE)
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  371  			setbits16(&iop->intr, pin);
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  372  		else
726bd223105c04 arch/powerpc/sysdev/cpm1.c        Christophe Leroy 2017-05-01  373  			clrbits16(&iop->intr, pin);
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  374  	}
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  375  }
663edbd2640447 arch/powerpc/sysdev/commproc.c    Scott Wood       2007-07-16  376  

:::::: The code at line 310 was first introduced by commit
:::::: 663edbd2640447dc43840568cd5701e6c9878d63 [POWERPC] 8xx: Add pin and clock setting functions.

:::::: TO: Scott Wood <scottwood@freescale.com>
:::::: CC: Kumar Gala <galak@kernel.crashing.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--wac7ysb48OaltWcw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

H4sICKE2DF8AAy5jb25maWcAjDxLd9u20vv+Cp10c++iuX7Fdc93vABBUEJFEjBASrI3PK6i
tD517Fxb7k3+/TcDvgBwpKSLRpwZAIPBYF4A/PNPP8/Y2/758/3+YXv/+Pht9ufuafdyv999
nH16eNz93yxVs1JVM5HK6j0Q5w9Pb1//8+X5f7uXL9vZh/dX709+edmezpa7l6fd44w/P316
+PMNOnh4fvrp55+4KjM5bzhvVsJYqcqmEpvq+l3XwS+P2N0vf263s3/NOf/37Lf35+9P3nnN
pG0Acf2tB83Hrq5/Ozk/OekReTrAz84vTtx/Qz85K+cD+sTrfsFsw2zRzFWlxkE8hCxzWQoP
pUpbmZpXytgRKs1Ns1ZmOUKSWuZpJQvRVCzJRWOVqUZstTCCpdB5puB/QGKxKcjr59ncyf9x
9rrbv30ZJZgYtRRlAwK0hfYGLmXViHLVMAMikIWsrs/PoJeB20JLGL0Stpo9vM6envfY8SAz
xVnei+XdOwrcsNqXjJtWY1leefQLthLNUphS5M38TnrskcBUZKzOK8e710sPXihblawQ1+/+
9fT8tPv3u3E6ds00MQ17a1dSe0rSAfBfXuUAH3rQyspNU9zUohZET2tW8UXjsN6SG2VtU4hC
mduGVRXjixFZW5HLxB+C1bBViL6dlJiB/h0F8sbyvF920KDZ69sfr99e97vP47LPRSmM5E7B
7EKtvY0QYZpcrERO42X5u+AVLnKgsakqmIxgmTJcpJ2CynLuCVUzYwUS0YOkIqnnmXWi2D19
nD1/iiYVN3K7YzXKIUJzUMMlzKmsLIEslG1qnbJK9BKsHj7vXl4pIS7uGg2tVCq5v1ClQoxM
80ATQjSJWcj5ojHCuhkYG9J0U59w0zOjjRCFrqB7Z1ZGzezgK5XXZcXMLTl0R0WoV9+eK2je
y4Tr+j/V/evfsz2wM7sH1l739/vX2f12+/z2tH94+nOU0koaaK3rhnHXR7v4w8iV5MsITXBB
dNKUrJKrYK6JTYFfxQXsKyCkpoMm0VassgEPAAQ9y9ntpFlIszmI1laS6/UDknISNbye2amK
wURvG8D53MJnIzagedT8bEvsN7d9+46lcKhhky7bH962XQ4qoLgPXsAWFr6byhVa8Azshcyq
67OTUXdkWS3BrGciojk9b6dtt3/tPr497l5mn3b3+7eX3asDd5wS2MF4zo2qtceDZnPRKqkw
vrTAvvI5uWRJvuy6IeTYIhrLFyIdB8mYNA2J4ZltElama5lWnhkHrQ3JRxfawrVM7eHhTVow
olEGe/JOmMPtFvVcVHlCNE3FSnLaMHUUoLEH9k7PsjAZ0XOis2PdOjNOKaziy4GGVWyUHTpr
cA6wm/3R6so2JSUydMylpxDgQU0LGDepTKO2o1UWFd0trBtfagWKjKYZwjPPg7tFdZGM498f
CtwPaEQqwHxycCYpOahBk0OMiZoJC+UiGeMpmftmBXRsVQ3+1ItyTBpFQwBIAHAWQPK7ggWA
zV2EV9H3RWBflUJHgL8pSfFGaXBd8k6gu3d6okzBSh4Y6ZjMwo9DYQ3EhCkGtFylwmlHIzAY
RcvvBx1DPBZ8g5HkQlcuOTCMe+sGqupzdNCYFhA3StQjr2vYWAW6gkl80a74BJwtwCrk3uBt
qNi6eA/qTGX83ZSF9INkzzqLPAOx+NqYMAijsjoYvIa0KPqEXeD1olUwBzkvWZ55Kuf49AEu
cvIBdgEmdvxk0lMhqZraBNEeS1cS2OzE5AkAOkmYMdIX9hJJbotgD/ewBv4llmxAO2ngBuuC
hHHpp2uES+ySBH9eLqTGdG3krMFmCeNLj2+IXW8CZSoSkabhhvdVGndFM4Sfztt1Oa7evXx6
fvl8/7TdzcQ/uyeIEhj4QY5xAsR8Y1AQdjF4yx/sZgipiraP3ml6c7J5nbQG209QC80qyBeX
gZnLWUIZdejA744lIEUDDrpLxiIc+rNcWrCwsFdUEQ8w4hfMpBCpU8K1izrLICV1cQAsE+Sa
YKz9DaUymffBZyeyMCkeSDU/Pwv8huaXF/6Ybtn0y/N29/r6/ALR+Jcvzy/7NjQemqC5XJ7b
5vLrVzpk9EhOTg+SXH0I2/uor199Ni9O6IEuLmi4ODs5IXq+ujzBIMCzAQyWrg2/gd+cQly/
g1bvfN7a5L0WOhKkgx2YT9eGEW3IBB1RRVFDzgP71Iu6Qnhz7jlBDWBnqb04wzm1hTBuM0AW
LnwVma7ysIFSq/yunXxQrGUqmeedzs8S6Wk8MBYZmaJgEOqV4LAhfW8Ktrk+/fUYAeTWp6c0
Qb9Lv9dRQBf0VxrMuu31h9OzYWtVYPKcC21srXVYcXJgaJHlbG6neEy2IQqaIvqMe7EWkPZW
weJ53oaZ/HbqHFnZ5fmqhlziakg42oBMFbICmwHhY+MCN9+luBqJE8aUlcDeteZfJsK00Qb6
bSsT35M7km5itrWXzvw463OIrAZDlAjf88/bSp6rs9jrs864PN7v0YxTtsXC6vVlESoO08Vp
kAFpfrXZZCylI19EX26OYa8+HMLiRhP66mrDD6IZOENz9esHKhe/KYCx3gviSGDpgPuZ+oJl
XvR4Y+nyYdtTjNhhIAA3cy0VMUgJIYgLHzXW4IJMwiYQR2c+mpyFPOON1fKH6WzBT79LDESH
aNzEcKL3H/9BL/5xqNkORonC9jhCjkNwBD5/XkMW4weATEOozgzDEotX35llL7v/vu2ett9m
r9v7x6Ckg5YOfPJNaPsQ0szVCmuZENaL6gAatLfwo/cBiXWZIFPoEX0JF1t7WQWdbpKN1BoC
HPAu5HYhGmBE6HLP7/KjylQAN3SCR7YAHPS+coHpMX6i2ZKc/PDk4klR+H4qB9dt5NtXlE+x
osw+vjz8E0SsQNaKIdSJDtZoiNIh3/XdLq2B/Zjy4+OuG6U3EtgAwb5ZQPandVhvhLaBB/E7
9uxp4CsaU/EgQohNtR/UPw/Gqk8CwNu1CdNY971rTsNIzEedfaCCNECcn5xMe6Fpr70DrYJV
C8hS6rxPokdbH2BcKkklxSHVYt3UpSx0LgqIn0ScQInSObfulGOhKp1PvOyExsCvVexoIcCo
gKSjDvLu0bt2hS8/vJN5LuYs70OBZsXyWoyHdeijLpbOb4e1IoCfXnaIA7GnyzW6guYQLXVn
cB34oge76kVM605FMFBr7lQpFCQ3BkOxUYGLFI8JXdhN7e4W7ZWBxAYCsi4utwgf51PQfkhw
jAXJHRKpsFPr5O11qtOZzbGO5xUaAJAnwS7xG7qe2NS79cudrtDgpa5OpMKqnKNLd5/u3x4d
ACvorzPYfqM/3Ppnxf2Ys/uX3eztdfdx5DpXa9QnrD9dn3w9PwnPdt3aqixDP3bydRthuwNI
8FiGQuvFrZWcjQQnEYE7TehGvupxg6wi0YySQR9ds1zeub03kUufzt6/bP962O+2WDL/5ePu
C3S7e9pP1021SbG3mVwG5oHHsksbtpI69Htd6AbydEHpqOtRZJnkEvOrugT25yWWTTme00Sb
HFyUOwuuZNkkeCwbsSYV2AbIYYCbKkIt48C6hRpR0YgWiiffWVQedPisLt3RZiOMUYY66nRk
QYFuPIp1PS4guZ9mGRaEhU6pMxREwQmsQiWz277IGxK4bBIVs4kFgNcKCpV2B+zxfI2A9Ayc
e5vNddJvmI7Z7+pZPghMfAKstlXwCOdqUdg3BXcl+Ha8tC7itXTTGXUnyJCbOXgZaNymRlj/
IdF4FPYdktZG406LBd2uXns6xQu94YvYMa1h0lhDFFhLZPymlibuZs1AqaXzBXiK3V96IGba
WdoGdlaQkToKJyRUasGDqlV3YyRET854Q/ShTUgfxAa7y9y0p+cHKUC/utlowWUmPZsPqDqH
DYVbGIvTWHsl+hcbVN+yvV+AfBMbwDV3pcBg3UZZBgWRY9UUr7DhWnOlb3sPXeWx0rr25cqw
Amygh+S5QicMzK6ZST2Ewksrcm5rEIcfN3dwFlmMrurSbmEUNDX+CvmPJEPBHHHrIcHRdA7J
rDeEPG0FhqcKaTzliZCE/gw9oWNrKtVE55JY5fGryVOXPedq9csf9+CAZ3+3YcWXl+dPD11e
OXSEZB0rx9hwZJ2XatpS/ljTPTJSIG288oXRqAwPCT0wGRX9oJPth4I9V+Cxi++A3NmELZDx
k2j7BPG4A3VBYq4YnWN2VHV5jKJ3Csd6sIYPl7PCyH9CKekT9Q6Nam7AuxyjwRrZuimkte1V
ju6ot4FMAgN5smldgm2BjXVbJCqnSUCXi55uiedAVALTGSpIM1Csall7nilBVfY/IUzjVoI1
uwkLJ/0ZbWLnJLC9vRXBMQOZG1ndHkE11WmQ1/UEmCFQBx/uGkOXJzgnZOLW64S+s9L2jFXL
jJamm72Lwxm1HRHd3mOEpIybWx1aOxLdZN0RWl9B0Pcv+wcXqVffvuz8Uy6InKVr0ucD/rwY
V6YcaUj2mdzQFL2VttmI98xmAZabREAwLwOElzrzo0MVNlWWboqXllJpl5MAeuxcljATWyfH
p2tVDvzZZnN1eZQXSNc34MfEOGpgytPiaGs7l5Rs6hy23obC2LqkwEtmClLKIjsgY7x9eXl1
lDlvH3jt+zpNpGm+nhY3LjxyZ9ftvUk13j7ylBLopGpPGfBiQneHd1ypEb28TcgbOj0+yW58
5sLxBo2z5alXyWg3k9WQHKG5B58b3Jrs8C64afHHcGTbNVggcaixjwxbh0ccrILAjTemWF9P
YxGIXRsFfiZnWqPpZ2mKvqLpC5NO+uLrbvu2v//jcedui8/cgfbeW4dElllRYaDoKU6edRci
vHvKqOaYYvQFWAwtu/trlEVru7XcSB2UojsE+CtOqR0M0yU4w4IemkJ71rH7/PzybVbcP93/
uftM5uZducurqQAApJe6QhkYnDidypitmrnvy5zMl0Jod4UhXFKrc4hBdeXWEpICe33hiw3i
VH7Q0LiUyghcbPq2JhhQM6kuJhAYcqpG7fISiCmTOrzoYQuCuF9HF+WDYXT6c31x8ttlT1EK
2F0aL2tAqrP0BMghjyvH893BZDBimDsdHHTfJbUX3d+dZxDge98ulPPrXz1kONwrWm0nKLpD
jz747IoE7blnV+3w2XWVA7cAWGJYRvIfl0gYnL676UoSzPHGHrjlRcHM8mjEX4k22WM5sZux
3qpTX+8Pq/a4QP79j2WCRUtR9jULtz/K3f5/zy9/41nC8/S0D3RzKaj7WujZPJfkvCYvIkgq
mbcOQRIIH90FSV/kCK0UpbmbzHi94xcWZjAOj6Asnyu/SwfE6siBTl00aLLo/MlhIAxotMol
py4OOop294mIBVQFaSvJbYSQGrf7CMSbkEtx6w/cgfqeDw0s0DNV3Otrk2p3wVOE9609sFsO
yk0GWiJ1exePMxtCh1KxUXV08VdiqSXBjEAc2Qd9zzrvXtQcJHMjdMSsOnAE3JOBg0uUpSQF
JLrUwSTgu0kXXEfcIxhvXOpDQyGBYYa6GYMrJrWMllXqOfpDUdSbGNFUdVn6RbiBnuoiMaDj
3WIEonSzJ5/SlOBV1FKGGW7b46qSB6ZQpx5jQatM1Qfv8QJunBF5VRipmHcDxAFAfaeQ6Ybu
MZGqy3Yu4V5yQLc3YvE6DAkM7VNLxzUFRukQYMPWPXhcm75nWH1bGUUZDxwFfs7JfGtAJpKK
gAY0r5PwNcyAWcPAa6WoFHagWQQiHcH2APw2yRk52ErM2YEKQU9Sro7j8Y4oGoRj/OYUVytR
KpKpW8EWx3qTOYTZSlqyccrh51HJp3OCmSTxqsl98DRZpOGNXDTGlAAlfpQCZ3+UAPg8igeO
j+JNNECE7md+/W779sfD9p0vkSL9YIMXLnp1GX51fgRfPWUUxj2tjBDtbXZ0rU0aG4rLiZm5
nNqZy8OG5tK3NMFuvuyMzQHnAHwVUl8eMH6XU9ODLcAQRxArIxPfwppLQ+1jhy5TSJJcolLd
ahH1NzXmDgw+5cg8fsg/I+HE+0SMi/llk69bHr5DBnExZedaTdD50E2Q/Wt6i4LA8REvngBh
tB06VF1pfEdsrcxuA4xrohe37qAAAphCRy/ngKY9S6Jrd3qKHB11yie+C0G932hP2QEw41ym
r5Pn177Pd+2Q7Gz6xoekOyfL6gdHG3np7iMs7rd/R8cGffcEA373UQeePCyvwuc78N2kybxR
ye+8pMunLU1v1Vxw49QGzQwVAh0itwt2Oh2bIMRjv8Oc/CAHxMi+FrSDR9GDId+oVcHbaPxq
CgFNMS4JXBhiXP2XdgwOfyANYJX/tKQqYKv4QW0PwVuekhcRJmf+C3uEFFqxEJKYs8ur4JHT
CAXFOLiH8rPKGw2/vIfKPnR1HlRXESRpo+1woqJChMIEEk2MTOcHH025zWxZZCoQRBVfQEjN
1cnZafCIZYQ28xWZYHgUxcoEr/B5m7p5jpu7sNR5VkqUuadG8HHmrxDLl37fq4ZpcAUhWOo0
jZInAOChA/lqYHP2IVgSpqknLHqhghT0Mldr7V/r7wDB+/QIVS5IHyKEQMl9uPCmMMCaMu9+
uGdpEm/VsdBjjrRtEk1b3JGqY4e8y8cHTgJlcTVqOgzjlLTS0uLzSIV/3iHQVNhNzJ3gkJ0p
LcqVXcvoBnSvY2PpIIJMLNSAyJXSeLxEDteW+AfiA7VIj2K8q+xLB6L05SGDVWi/oISiREgz
t0FK4GC4Iej6afsY1QscF9ZMVshJDXbEwTQ4P4f1tRjNRlQdzY2pgl7xu7EFFdg5FAQ84cxK
br14Eb8aJQo8hGnwWRAol1d8bV/4uojH+E8EPUQbBqXhIGaDheHbJnyomNwEWwJf9f0e/nUM
v4442+9e91HI4DhZVnNRkvHCpGWE8EuTo/UtDEvHMyQNccZuPzP3Hx+e8RLC/nn7/OiV+Flk
ifAbUoiC4au31YG/HiEge6cK40bZ4fiEbd6ffZg9dVP4uPvnYbubXsoultK/f3ep21NZT6g3
Aq9QUeck7BbfoOD1riz1akkefJFuQkPgMJod6U7owIrfsoJcmqOzG9TKN9XwgVWREJD4lWEE
zCOC309/O/+tFykAZmk7VDq53Q7Eq8mAq80EZPMJqL/27oE4yzleXsKskjQPSJTlYtr/3ExA
fCoJB3J37vFpwWR0/uuv9F10xMpM4r8ZZSQQX3TDBY2KYMBjLSFLZ+XF5sNm0oXlpANzUv2d
4cX3uIkobKN5wSVdr3As4f2+79B0vTeSDJ98Ck+iPlZl8Z888cANn16VwplC0j97wPe6n+63
u0jVFvL89HQqIa7PPpxuyB1D9DiMVNvk4EhXGHABQTgjFOwUaFMEnkUK2VMGrC5XDC2EG5nW
BZ6w6RButSbQulc4b67RnMLR2xsv7TEPfcOL2OuDpQpPhfE9tEgPJODggakY3cH9S4QAKGzm
/n6ZDyPiSoBakWfxX93y8ZlgVe2K/FEm3N7ef3zb7Z+f938ddApJ5c6e8oAVE/6xK4AsuEwq
egF7rE19N99Ca2YqCoYeo7WEU9TiggQn3OopUw7FqsU5dabpkeQ52en5Orjh62F6oVDjgSc5
PhopP4e54bTl8Wczv9xsvkdUmBVd0epWgxdnJ+fHekk0GDHq6meHzoKN1wLTKj+NYUl1/v+c
XVlz47iu/it+OjVTdfq0LS+xH+4DTUm22toiyrbSLyp34plOTTpJJek7M//+EqQWggLtueeh
FwMgxZ0gCHzkA1q8Dzgr/GEbHOQfV6EuVSkpdzC86OJKZjPO+uAT17jvVLFQKpqFac9oKa2R
uNfSOoYKCZAnDoenYyfogr4pqh3y/w/rnamTiLIIWNL79DVkGKKxjpzo17VwA+e4yXAvaRnP
5/PD++jjZfTtLBsF3FIeVNRMcwKcGGphQ4FL01rFz0N8ko5V6b94jCSVrHYR7iIycAw07pV1
I7nKe78rTG7hJ4y1O3IADAX5to4jai1KQ6NH5Q95attE1nEayCknbyAlRw5QW1hs/ZgPWjo9
n95G4eP5CaA2fvz4+fx4rwOQfpFpfm3GnbHQQk5lEd6sbsYMl1FEif1JcLWZkLF9ipvOp1Oc
hyLhzbInRx4fkr0aL86qJOVqvg3NifQPa9mXPhcMYgNdV9ShsdpSJvWWZqNLNWxf9IgNDUke
J+WIQNAyCmLqwOIIYP3qKjHRGNRRGviJQKMtZFEMbmrER+WhqMyyuLUEGKd0FWHQnEXbg4Pr
0JDzZknsfoMaahZBU5Tjd82joZ6Y80/3p7eH0be3x4ffz4Noef1FI1q+yXav/fS3QZybywoi
Q1D6FmFoHsokx8pIS6sT8Pin7dIlS30WW2brtnqF/mIYFYlyR1UYoG2zhY9vP/6EmL2nl9OD
ivJtO+aoWsQsekdSjlE+wMz1TB0R2X7EqFOfSoUpde3RDwFKoPNfJmrUJ2g94M2pY9eoW88h
gggUbcOLsN0RlJM8zbOoRrco9baIDo6LoU7/LRx3aVoAlMwmm1rH49LGexBj4i7lrbCKqyNa
p4PYhAikfZkpOTRJGw/Adh8JNsjJUf/Gi1dDE3GUEGnBU5agJUPicTIgJYm5KbUfN51eW5qp
8PhgvNnKgaZGYYgHFDDDIOXad4+OSnfM3i72drCPJFlVYns7BN8mqjHJHku20ZBnBOl2a3i7
vWZyAeY2lhI3AajaHk4FGW9RIs1P/lSjhljQOgft19PbO7ZVlRB3dqMcu4Wdm+n17aizlMrC
oYDBll2m4O3aLxAsX2pe0BB3TZTIp4kzAxXnqjCogkHlsSB4ZGdpfEf2x7BFVEPt5X9HyQs4
i2twr/Lt9Pz+pHfi+PT3oOnW8U5OeKtalkdwaCLopYNfdWGYxyLML0IfJxci9E3c5ASzVXeg
CDugdE77cvJow3W7GRQs+Vxkyefw6fT+fXT//fGVsGbCQAgjnOWXwA+4tdAAHVAcWjIeSmEE
lxVU5LkhBdN+zdJdrdA+6wnO3OJ6F7kzzIXvRxOC5lElVYdSucE5iqkqk0gdaTAEgSM3Z8qi
1bL3ZWT1mOwFi5BZBLYWQYoOXhd6TjvCn15fDcQQdSRRUqd7QN2yujcDVbJqnakH6wAEJyaM
vlxtqwUwVcynzusqh4ES1lNrlmbpnVR23EsMWAALh9X6Wk01HO756bdP9y/PH6fHZ3lAk3kO
DTXoi4AqIaskyEtjGG18m3vTnTdf4J4SovTmVv+KWPew1aZWhczMS98eExA6W2YlIB/AgdH0
y2+4QaGCH4E78ZaD9cjTu4VWnR/f//iUPX/i0EwDPRq3Q8Y3tF/J9SY1y5AyBY5WWOuFXJNS
DYyDtxRNBm9fiNdX8THu/acRbvSgq3Iux19TxqtgGdu4u0hJBVwe5Y5wPZWgGASHAGBT2TP/
WFP1NxOvCRCr4vTnZ7lxnZ6ezk8jEB79ptcB2R1vL09PgwVcZegHgBFBFFMzEIhQxwOlJ9CQ
IxQrCjlZ+KSKqCv6jg+gYkSWQ1N/P3jkASDlAcFhcuQrW7Ve+R7f74nKw1+WAaCvfyR2Wcq3
EeXVoGZwHrX9pL4R575fjP6l//XkgTEZ/dDhGeT2qcRwwW/VUxL9VtlMqusZ4+KrgmX0eQT4
+zVlfwHO9k4eupBu75dGJ2cIyBfA3NKodLxKIbkQQ1UipAhJ1LE2JGuXrb8ggn+XsiRCBWgj
2BANHRTkb+RKkgE4AkBpgaJjhnhpBjhRIJoOlzO8AzXOAcAmNmAbKvgU4yv2hN6goElSnDqO
N0xWLZc3qwWVTq7XswspAUfTtKA2gcvI6tvEMqf7OIYf5ID4OthCrdTg43FRwC/WtPNK9/0r
fFcJuF/AJfau5P6BzgFQnqC/bEcu2wfFVfmuBLiE2sR4SIKRGOJBAr0O6R1F8TQeFO3nYObZ
LUzDY6ZU7ERWiDqOxDQ+jD3Tbu3PvXlV+3mGRptBhkM75dxnSKCjur9PkrtmDvUOTVyspp6Y
YajchimX3DgTcPEF8yqyMONZ7ovVcuwxOhpExN5qPEZ+eprm0RfhbVuUUmhOorO1Euvt5OZm
bByEGroq0GqMLnG3CV9M5x5tkhGTxdIjPgSLlqyt3ITzaYPMbnwNaWcVoB9XtfDDwJik+SEH
MFVkaPdgOg9GXxDk4HnS45G2Ta/ocuB7yIusJ8/JKjV8wGbj9JskjUTCqgWNH9oIrKa8MtTb
jlpVswVRInnsqperbR4I6rqrEQqCyXg8M7c8q/r6aZjzX6f3UfT8/vH284dC2n7/fnqTWuYH
nMdBbvQktc7Rg5xSj6/wX3PalnAGIyflf5EvNU/xpEIcbUXrJwh4uTI4EubxoOOj5w+pvsld
T274b+cn9YbXYBQcshyb7yTBbL5LmXRtz7fYSw4CCYpSVLarQH+oMtcqZIaPfDP0wO9co/Kn
8+n9LHORR4mXe9W6ymzy+fHhDH/+8/b+oc5m389Pr58fn397Gb08j2QGWrMxb8pb4A5fLjr6
4Yp++ZC0jQuso0nEBbUzAuPy3iQlZDc5whz8QEPLRRkvHSEOADkL9rtwaICDasKZVBLazvn8
7efvvz3+dUYnrrYolEuPPsdyEbXHrMFQUXgqSYZOEwWLfIUbSy3QAvkZquS++Y6FovS3Mf06
DXRXXVURm7KNPv5+PY9+kdPpj3+PPk6v53+PuP9JTvdfh90t8Csu20JTLyGsSDb5VkubdkPm
SLrEqip1m92gshxekWMpaeRUAnG22eDXt4AKzlXaiN9OE9U6ZbvavFudB+q86iwrn5CT5Ej9
TXEEvIbnoMfRWv5DJmCDigMdHngDdD1X3UWRdx/rzQNWRa3WOravnxmaAXDoQB/NU8ZdC2Ne
Mfah2HKfJBInypYrlc5UXOL7Ry7Lc0kCYRTJdsWHYUXIXJElMNlcT/cAs7u+x2naprvkXqcz
35IrO7WCdHqj+UoQLL2q69F+JmlNCLbGb6S0TymjoLVQ2YGa4zGkV77eZDH68/Hju+Q+fxJh
OHqW28f/nnt3M2OqQF5syyOiaxSZBwc0khXxNiuiW6qxVXlFbFcTykAeq8lA2+bBBmTgKrlU
itrLgF47kVSAV4scQTuSnatOcnHh0pTWZlsfffJcYn6ejJ7Q80+lNGwVjEdpmYltcwspEAvg
isFwG6xLwxf2GKV+yMxekXtI4xeIaLUNK7POUt+FvKHOLiQHHHc2e1bQ23twq4BdHZe2Kgo8
cJxKZQ0hHIfe7nMn61C5OGCidNz3rlkR7H36+L1xWSwZF4HjeBqUsGdljrcSyz1dQEmvD6pn
1BuajtSHK2fw1DH20jhxIN+ouBAXkxU8JWFJIKKsH5bG7E0ujBbgWrtMaxT/eHv89hMUaCFX
ovvvI2YgEaKLgjb28R8m6fRw8PpHFito6kOQ+llRTzl+oKe5HJny+c2MrEgvsFw53ICarFnM
OJjQ8TMNzdmkJNE0zNQJ+5qlZJlZ4hNFThMek07lZko5K9MyYnS2Bafpe7nj4JVdUep0vVzS
Xlx9Yg2tgdt4PaObds0TmKoO55s7UQaJfZQffrA3WJsTlvSmMxMdon1C1p4rWChU/U0AEHbd
uKLXTXruGBkHX8H0jU70ilKnOTx2k7KNgqCv7RYZ5gRgwQDvgCot9SRnW8IVQpg4Vktg5rdy
w3VslcCvNjos1yGyiVgakqExZqn3X6JS7ImRHCaHL5MlZc4wkm+ybBMHZJdt9+wYRCQrWnrz
qqJZ2E/c4CSskKofjo0/LGbTqnKaRZOD3ThEtjJPlmbIapbElTiqDZrONq7C45VcI15gFX8n
lssZrboAa06/1aVZ8osu31fje9lgJKfcW35Z0PZGyay8meReWTpUziJI6J5MWenmQVRZmiX0
8EixC2wkR3Pw/5twy+lqTIxbVrkmXCOQ2ztq3yblNqPUQ+OjeZAKAJEm6wTaFgR3mqW65ewG
AnlUqAzxzZYPjrIOATAdWsgRvY0judpOhWxKdOg1eRCSWpAswRKxxzFGotqsA0c0uZkyMNHe
TQaAiYbyDz0kRCI40aEi4asJX9FzB9KsJpMry5TUsMAFqKK1D1GqQY5qWiZKxb9a1bs0y+Wm
aKaFo3MVb2isDyPtATuFyJ+SI09MUUkBKRkJj9FXKxpeU+rj3PXkSycwvTbftUXfzLyx8cMQ
jF2+CI0MqyL3UG1k4lgeOq42ThUVtE4IDC93uMvI1f7SY8T59s5y6TfMwrBgw3q7Ws0T2rSQ
xw6QhTyn6SImb9XhjTAFnjBU34HFWUk3IDB3clN17HbAzgGiyuFMBPyijJeTOT1Gej491YAv
t8qbpSNyCPjyj2txBXaUb+kpdYzNgFL41em9flIGOwevxEp9uXWalXCyxNQxTJahKBNcHgme
0SxLb7FZhYiQNgC2JRJHwkzYazwUE1BRnC1TMBxFgHgBnH5cTNMqbjJMjESTXjrkv9755p5j
stTxJ0hTKjChYHdE9GqggotGx0eID/plGC3/KwQhwfXLx/dWivBtO5IHMwPTgpiQBjdkuyCm
Vw9DipXLRRF6U3qOGYKJlJp9mV2V49ybO+6M0WcH11mEkB/eeA4l1PwiW3qT6+XnhTemF0pD
ansUEW1g0naxC1wyXMYwmfvkMfuA45wOSZ1bbhHN/ePrzw/nbVKU5nsTExR+WgG2mhaG4GwT
I08dzQFoCRR9qslCRd7tUBCC5iQMwM4bTueR/XR6fsCh1H0L6GRggnQhdmiRL9kdDdah2cGB
KGdw0JFyRmO5go50gl1wt86seMyWJgcevaMZAvncNcqx0HL5T4Qoo1AvUu7WdDlvy8nYsTsi
GQeYgSHjTRznrk7GbxBfisWSdmboJOPdzuFa1InY75TSEmpQOiB4OsGSs8VssrgqtJxNrnSF
HtFX6pYsp970usz0ioxc8m+m89UVIU5rRr1AXkw8x0m8lUmDY+kw1nYyAEEE5oMrn2uOWFc6
Lov9MBLbJjbmSo5ldmRHRlt/e6l9enVERbdi4V3pvEwuVrQR0RgoUzkbr+RTJl5dZnu+lZQr
ksd4NnbsrZ1QVV6tHWe5PDReKZYVgk8Ml3JX5+B+4l571fLsXHrlygwQn4Yu1lJqlrI421CM
KVq7erpPGxg6AZ6tCyo4oxPYhB5Vkk2BzUqIUZNX473IHl7KTLATX8dVmjHjlP2ikxGRH8Cl
mmml6JhlYkYE9fm2V7A0A4cw20xv6pGFPbKiiBzuxp1QwjbKnnixRvAoRVZQRVCsNTN1/p4H
0C449q9vh2PkfyHxlzuRr9sg3e4ZkbG/XlG9zpKAY5Sy/nP7Yg0BAiE9gfohKebjCb2cdjKg
nOwvD6IqZ/SQB0btuKrGQqC7XfpELpQY8m0jmPJjZEHyqqAXgU4iFBFbOBR0tRQoHFoH6p4W
gAVS8CKwwcXwekM/JlIk0cy6oVcky2VP0SxLJWIlayuDcDwdUsBfFgW6At3zG29BW34yGVA8
mzIdDygzmzKft/rq9vT2oKKio8/ZyPY1wkUjvN4tCfWzjpbjmWcT5d/YP16TpYqvFUxEjaN1
LgZZIAQxTWrsZFUuaiJBc3NJcCQJUI0HCQreSPd2Kc3IoUC04UoJaJVRUC7Ce6uRYLWwIwNa
Wp0KqZETmXQCMXKKpXqv9/gkjm36UPT99Ha6l+ekoZt5aT6NdjBfC9deAhA5nQr99LTpbFq2
Aj1texzSpFxPhkd9fOQMB++DrJZ1Xt6ZKK7KQ9lJ1A8e/o837wLdYgWADSHuDZ53E9r39nh6
GgbeQO+wWAehcPRulmYsvfmYJNZ+kBeBijBuw1XtgdNKThbz+ZjVByZJLr3UlA9ht6cQDkyh
QeOisuH3IVE60jnREEgLdcMCLxIR3ALeJU2CToT8hnpRxiefyzPFmMjhsaADRj5B9Tiid/xQ
I4nYlYamF6W3XFYDHsSl9/5hOtDj5fkTJJHlVoNG+ai+DwM/mhzkgWpKo8MggYroEai5fVOA
JfBOZBCdA4DnCfElSW1TuD8mojA6DHPUZOcHBedplTvIF1JNFpG4qSq6ih37QkJrSx7w6e25
EWt2hy8l23RwVRclrjdfk4AczgYPxoN6qW0ww0yhNdv76h2hyWTujceu0v2zkkVhtagWY6KS
zRYqd1DntWr7wYJSlxqmenE+J2ves5xjQYlEKYBqOvrCkrheYw6XmAraJdpEXG4FBTUpBkL/
YI7k2HJnkKnERiA02oDsJYKXRdyGu9p5p9qt3Hf5LuZSFQtylhf19lCv78CDy+VZ2FpISvrm
tN4I06sIwgSRSqCAU/rHnhBVYDCmQ4tIgy5zJHXvr0lvZl1X9XyrGchi0FUbyfJYkZaFOhwb
ygGx6OQ5stw2HogDsShPIqndpn5sZqiosEmoeH9056E4EMGlbU70cQOE9F1r/7AYZegAORFZ
34WXKSzSkQH0dLaxS5gdgyILsfR68GWkoulnvgmSevZCKq4oQLbn2qhxPYfLXko7e3jjfn7v
Vjkh7EHZd82X0QCbC4DLZxpYdkCdmToZL7xZhXulBekjZ6KzTG2OssVQteXvHSKoN8qNQxW8
+NSO9YYGoH2KDrgvoJ12pSu5/JNTiAFyLY7v0OBvKW2gdYuQOix6fzBtuq/Yi1LFQmhMrOG1
jseJ2xwT3Un+qJX1rnl0p29fydBvqVOjGJhbhvFEgahfPdMxrj+fPh5fn85/yRpAORTCBFUY
uems9eFKZhnHQboJBpkOVs2eLv92lBD4ccln0/GCSppztprPaHsMlvnrwgfyKIUli/pAETge
avG4fiCuTXwh+ySueB7j1x8vNayZvkFTg1MSblCBkbxUH8SbbG2C9rVE2QJtj8LHutMowFj1
vdmPtr/fP84/Rt8A5KpBYfnlx8v7x9Pfo/OPb+eHh/PD6HMj9Umq4BAK9yseDhzmAtXfnJxQ
ujVFtEkVwh1WNC2mwnx3cim4bhAJkuBAnfqBR5VTjWX9tIzGLyVjY0ByFyS5+cqp6vXcmp6Z
ujrBNNkrzuIWu6lrRogoKQMr+87DqXkVWK44z1KHkazPcpzIfjw9nF7VMjR0IVANGGXgzLAn
w89VWW3YBFXIbJ2V4f7r1zrTex/Ks2SZkJutq7vLKL3DVmugHiKAsWguXVUps4/veo40NTFG
pem77xzXuFCi3FMe24rVjCssD8Qm2PnCOgBAgE7f2l4E5uIVERfinLkLdKU2EfVU9Juk9JBg
7aZ4JMnaLtxrsPmF+DXJI5I3mBzaaiNPcMnpHYZYHwE2vFdXAZHqPGR/G9zs4F+5c0QkDCYw
5eK2ZigqE4j7EhSm+M7OsnHYd+TVrxmDZjiCWcaV7NgiHqI0cICGM4/jJCslMEIOUOLkZlzH
5tOIyhyvDlDrIVGbCywijlxviAHRt5mecY7Cgc+s7WoNdHlEX0ZiMaZWTsW37RAwKioT9wUo
VeNAbJLaBcugfb1Lb5O83twSxWfJEOZDjTljH6UMP1AerFt0SfPmoZFm3FqjVP6xMFlUl3UR
eTR0DsiUcbDwqjGum7VpdSSlvQ9aXXF0XAocfcoio9SLBqGzP7MJauzlOTJ3yp/OeZ6WeSOu
jwS5GN0/PWpchWHbQk7yQACO7Tt1BqE/3sooa695zus4FAJPz7XdQLqi/Q4IoKePl7eBDpOX
uSz4y/0fQ1UVXhGczJdLmbuO4zR98RpfWnBPcr0raDrlnR4eFOak3GjV197/4/oOYGksvdwE
nx4K8MRUEId16FJ2ympDaAFjG0atHgoydA1JRw8ZG/KgnYb7lFvXBJCT/B/9Cc3oukpvW24l
uC0VE9Mbz8PfUPQq98arIR3e6ZiK8RIfdQZctADa3CFHyD5E5oaWXk3m2PDbccrEcSfcSuQs
ThhlrG8Fit1yPB9+M+NBjL0IWo4cEtuUbchAp66OcFhkw1y5mN3ES+NzMIHQhtIQpHYrSsCv
ltsNQH3PJ14rkYXWdtUmiYpbe5vQ/e901lJ6tAryp27LgNmMLfwx7fw07g+iGjXtx+n1VR4+
1NcIVValvJlVldqj3eXRKoibT2gOWMA/0o/h6VNDCf+MJ2OrSt0kInR+LVDYzWhyt/HRHySJ
s03ED5TWrltxvVyIm8oqiGAJm/ueHDLZem/zomwgfie4eeGmiEfur6YzW3QYaaHbO/HrkNMA
Bhd6tjuQKur5r1e5MlM9TjhRYnaaD9v6KPuBuvcyRt94kOr/GLuS5shtZP1XdHo3RxAE14nw
gUWyqmhxU4FVRfWFIXfLdse0W45ue8bz7x8S4IIlQfnQaim/JPYlE0hkCrqPaWbyYhlOGqjZ
KDPV9NM1Y8ckjJ0JDn2V+wnx1J0BaRA5RY7FP2ooH7sAk/Cl+tAZL1KBfihikvjO9j0UaRiT
5n4z6l1kqRf6BnHVlo1x3NM0oK4c6j6Jwyi0lojCUCRkk7qWY9mi0njPSGroWRR6SWQlJgCf
OOsu8CSyh7wAUuJs6xk3m2c2BrSpkXaUKqjX/EACz6Tem4QSs36cmKaaRQIyWlbJ2BpFxvJK
osBerSlJid0MciJhnugknFOaJGYV+op17GIuLZeM15aaGW9e3ZfrG7sC0vKcHfYrph09rMkh
n+lz5nS6lKds0K+t5rLlj1f0QYwWxvhOQMa3RFzyw38/z0cZloLCP1kiVjI/0J+M6liCG8Oo
TOSOHdFsHLoksNHZqVIbCimvWg/25eU/uq0/T2lWgc4lGu1uZWDamf5Khvp5oVF3BcJNuTUe
gi05eiqRI2ef4oAm6mlfqNNaB4gLcOTBgSm/5M6q0/erHqJBrFSOOHGUN04c5U1KL3CVKSlJ
jO7/+vhQZGG4JJuyG26FI1HwDoup4RJl177XT4VU+k4Qdo3tfDf8mCxMRSYZtXk/i3hZkUNI
Xz5NsBMXvigmqR+uny/NJVbuCc4Xrr1FtvISEUUEFckCLnZO0H58x/ciNfqYLNWUc6mkR8h3
3yPanFoQ6HjH+w+VJcF2PI0BKYyg+za9Lk/dVN6ojbCDegk5V1Yjynf3BnH5/PDkx+M4OgFd
6TTBc/GEtdACF8N07SGEEoO3WnvNwQUk6qGNLUQntLGXynIWgvpUVdIgqkmcULRHc9ABNUmm
47Wsp1N2Va/tloT4cCWxFD+sgs4Ydj6osfiqSLJUoWI9fGwDYoLojmYXaO+1xMID4qIf78wK
fUvbchUjxgbqgUYhselFOYiLIVHFIFJjB6xp9n7kpzadj5WAhEibCCD1cMAPYxyIaYgCXNRF
kmLNgQax3dGi/+G21U8DgvX2YpWyuwpchtCj2L66ZH8Z0iAMsc695ox46GHzWqciTVM1ILxY
no0/uSinaRiSON/SGF7hpR2h9E2HnCisjoiLmBLMqbfCEBClXBo9wegN8XytlXUIf0Cn80S7
BQKO1JGzKnKoAIljR5FSP8AtJxeOIR6Jh6U68KZzAIEbQAvIgcjHC8ghxxNGnQdzkLxyMIp6
oWZ5HDn6aqymI0SDdp/Sr4mADS2axjD2mIa04MJiBVxU2SUrWOQjBQY32D7SgHJbAekEK8cx
Dmkc4lbHkuOknuAvxCYnNE7onKqZ5sB1hesAm6ENnuqQJKzBysIh32PY5rlycGkkQz/lfbX3
nbzYb+3inKtzRCjSnNWhyVQNRKH35YjQ4bROX5cW6Kc8QMcv35UvxEePZjZ/1G2ZnUrsa/S8
2OYSC/ve+JccsV3sGdDFIhM0r+1UON2t2ZDzzRCdXwD5ZH8tFDy+69WHwvNe3QPftLxVob0p
CgIAIWgNAIq8aC9rwUJS59cRdvykcqTooi0OZeJ3GkYy0b3uAcfyjuVPQBR/oqzxoBKixhGi
TS+gFJPl9Aqk+Nd5Tz1/r+OGPAoD9NOyPfrk0OS2AohsLPmIadPr+Gkiio6rJt6dFk1MkdnW
xKEjsb1m4nCCf4ZqbArsKLrjhb/CsF+cFFloOdVHqWg7pKFPEYlLAAGy+0kgtIF2yOUhVMW0
8I0rng9cr0VKBkDqoeOn7fMm3h0V4ug/VcrZN4Y99cw3k1EZ0N+VZw7gV/qIbhl875ry47Hf
2+6rlvVXrqb1rEcLUF1o6Dt8Cyg8iRfhL+o3np6FeLySlYXVUcLlDHws+qEX7cnCYguKESl8
BsDK81pnaOdzFpoQZNTMCzsyAuWi7SFDkCO+F1PXUsex8J1thq91CV4YGgSBK+EkQq/H1iE2
lnwDQibk0LOAa/fI0OdISKMY0S+ueZFq1uAq4GPAWPQlwTL5UPNSIR+w80DQRZADu8s9x+nf
jg/z/YFccjk38DC9VuHwiYcsVRyI4FwNqUjD8iBuSIoKhWwYWOzworml0ES7wgXfnIifFAmu
hLI48dF9QUDxXltmvFYJpmVUbaZZdKj0EROX24z6WEJDHqNr63Bu8t1wQkPTE2y9FnSkgwQd
bQaOGAsTyrIvYzR9SJBc7wmNY3rCsgUoIfizzI0jJQWeauq7AEcxUnQ2SQSUJYdtj8JY82Vp
QHcJCUYOnzArlzjlRvIQG3OmmDvNBAjCM1TgiYDZWNmUl1PZwsvj+a3NVJR19jw17EfPZF5U
te1kfQa6o7s8Iogl+DeYhkvVI0UoSmk9fuog6knZT/eKlVguKuMxqy4yLjbaWNgnIua6cLKx
+4k7dYRxt7zAAFa44sc7CW2FU04hhcGb1a1FeTteyid3f5fNVb5ntyE9Brl6CWOlZj/JWihW
9IIVaLt79txd8UdjK5d8jSajmpQtDA1s/q7s4E9JmBbyhH/0kPQsoylxLnl/+fPjb5/efn3o
v73++fn317e//nw4vf3n9dvXN9Mz4JxOfynnbKBL3Am6A8ey7jis6aGNMB8sYTwKR0TV5tcv
y3c+3VQxpPPk5ZgNzM9lbeBDVV3gTtJGBJn1aBlni7DdGt6xNNtwiEiCIPNFBpobaL3gBHy3
zXm3XvfKwwbw40SQrKUNznRXA8Qmf//990zZisFHaOYTIFvD5soOP/z88v310zaA8pdvnxQj
Bc7R53bmDFy6doxVB92tPGOYQd0hbzKVXSGrHws2GdcI9XYtcPnybxIe5vOmtb5fcJcpo2Qy
b423d3K//PX1o4gsb4WiXtrzWFiLDNCyfEjSIMQNEgUDozHBRIwF1AxrG7H2CUuvjSo4s8FP
Yg8vAziQFU8YcsdLl43rXOcO54fAw5spTD1U9RWwbS0mUha3kxhNP3QEum34tVEdITQVBuOY
UnQK2Mw6ThlXnGJS9oomIZpoil9JbDh2LiZ6UFwOj0a3riZ1Wkrz6ou/PVEYDDcMK+KuuFi1
sSKuINW7Zr101pOpW1cip2wowdLeuFwQ/ZUTql3SK0Td7lsF7NFiXMEC7VxFXGYXbaqW9Qzh
wTJW5bhnRoB58rjdKCQrHQzqWZnPA4GWJH2TeB5GtIaRIEceboIuh/VIgjCO9xjiOHJ4It0Y
UI1qg3XjyI2e4m21MiTBLkOSetg54Yr6VoMIcrpbXY5jxx0CHSIaGS0PtDQ2aIvQoWZffhCv
idGw4jCjdZsaIGlGhQodNm+zYn1+DPmEwo4YZlNP42GsSEjctptJXfJwCBMsJYE+JurbCEGS
copOZGWO7hWsCuJotB48qhxN6BHrMyBa26vK8Pic8KFsrW9wSoJ2d3YYw7lVnMOBcfXbWUzD
sh1oAzw2ozQcp4Hl2p0moNJO2SwgGJygB2xzgnVz1ZORNsqadtWziHghPs2lebLDf7UEURty
kT1i2rzRd/an2fTZPdGgYrzi6ENlBdcMt5WEE4QqLalNako8lOrjVHsLWBFk7+cYX4opJl0t
Iro96xYkuxaq5jnbaaOT5l4TP6b7Y7VuaIjOf5Hnarmul/+pGRPs8FskuFwMG4LVauhvE+3W
WwCX4ORjdjGiyk0oj+H0huBUx1CWsLm6m6AxcDgtMPdS0wh+o9nVm+lI7QAJvR2JcjWrV1fS
7tzIFxOj1VcLxoUx12qxfe6bq7HU50xiczTrab7MWfTadVSqPihcSsv6sX0zspKkMoQBx2oE
f3FdPRgWCxsLOKa5StdO7Iq/Ht2Y4RxJHCOt7FiuXFQ6aSuIBs0SF1IU0L8S9BBd4SlCqo48
BZFaFQrNM6cuOuLIeubgPQv2xvtFMBQ9BTGUpw3ZRhKS+TxKdzNF1LUNNAQeZWAYyouOhGgl
THVCQ3yCNrBACDoCszakoW5muKFOHX9jkSrCbttIlltI0bJVrE6p+hhAgyI/JhleOL4LROim
qrDY67oCchklRhtFIGjjC5NZtMPEFu5oxnl73y+q3LfQpDkUxREGgVITJi4oiQI0QQFFaG8g
yoQBhpiKqvEsWhCOaRYCJubj3806q+HFWMNj3QBDBxP0/EDl6QmX8vCC9WFAIkfafZKEWMAJ
nQVfa5v+KU59vBe4pkUcSyFgPib86CyqorYhtkCtYMfrh9IVRUxhuyWJF2FKsMGToFUTUOrY
YUTAO/DX8E4ZhGb2Ho9U1XbLCVIEXhLbOhthYn7TZ6g9hs7D8LWXhU0SRzFegEXJe68I9Qki
v73XabNQtF9SnqEXORZbDiZ+sL/agq0DiXQf+hoa+fSdgSO1Ld8xlTEVzsmGCvsGE6HolFc0
L1fyRlu42PjU/yds+ANYiwkvrPkUVpEdTW9tG2TfI+NMAeoHWGNZXswuWO468ci3cxKF0nZD
daz0N1siwplAQdrrHH5cJRfCIe4aTt9e/vjt88fvtnOTQo3Rzv/gUiV4LDpUGJUZ1KLn2uyo
eATcLvcAFY8nGvxmYGNgZX10uMYBpseGzQ7tzPSPB/Abul7xOrMBH4kTb56CqxiX5o5fZc/V
yVUvaUA7gTsduChaimAUzYXBd+zc8J8ruromeP368e3T67eHt28Pv71++YP/Bt7wtOtTSEI6
W4w9D5u8CwOrau1p9UIH51IDF3XTZDTbTYPNME+KwwBXMUU5s0tju/sUjdLxoZipOqPKqnLe
TqUx9m68Rc3SXgvMigSQS55d4Ab1XDTGuBRIfVPjlInkpWPYU3/V6X3WiqCFSwz4P768/O+h
f/n6+sWom2Dk+hdPiuuWfNTp15EKC7uy6YPnDdPQhH04tQPXK1I8mNT21aEruX4AgqUfp9h9
gc463IhH7tdmausIqRDSAJLOqqZ3FbysqyKbHgsaDsSx5W/Mx7Iaq3Z65MWYqsY/ZOgzLI3/
GYxAjs9e7PlBUflRRr0CK2MFjtMf+X8pVdVXhKFKk4TkKEvbdjU42/Ti9EOeYSw/FRXXKHhp
mtILPV3X37geq/ZUVKwHY6DHwkvjwsOOr5SWL7MCSlcPjzzZMyVBdMeTVjh5/ueCK964ZbzS
fTJa1lQXqYc+r1JS51wHj4ZPHtqGAJ+CMKZ42VrYkOrEC5Jzjd4kK6zdDYJwynFOHM2oMKWe
I7Laxt3VVVOOU50X8Gt75SMNuwNQPrhUDB5XnqdugHObNMOL0bEC/vFBO/hhEk8hHTCD5u0D
/jNjHbiBvt1G4h09GrSuoXLJWH8oL5dncOr2TqQa9avnouIT+dJEMUn3m1rhTTTLWIWlyx9F
Q/x09sKYlzV18bWHbroc+PgvqKNCy2hjUUGiYn+4bbwlPWf+ewmWEf3JG1HzWAd7g1ZDYUmS
zJv4n1xXKI+q8SzOnWWuWpfVYzcF9H47EtRuZ+Pksk8/1U98OF0IG/UbLIuNeTS+xcXdYR6K
8Ad0IHX5Pn8FQearkSs3cYxqYQ7eJL2hrdS1z1OWj4EfZI+9o04zTxiF2aNbypPMQ99xgcPz
k4GPzP3yzawBbYYyc7Sn4OlPrksBhfFyrZ/n/Tee7k/jCfPSufHfKsZlyW6E+ZX6aYo1Dl+K
+pIPobHvvTDM/dhXxR1DgFA/P1yqQn0tr+znC6LJINUS8PTh8O3zp19fLRFROHAtUB+OAj7z
jh548iBGqo5BhLQ772ic1Ion6WZLg/zA0aLEL1KFWgChes5VD3bnRT/CudSpnA5J6N3odLw7
v2vv9apSOMoOEmo/tDSIkDl6yYpy6lkS+W6JY+UJrAS40Mz/VUmEPp6UHFXqqYebC1E+HzJS
A3lq7kJHesO5asFrTR5R3qyESz9mKkPHztUhk1d2ceQSMAy2+J1k8IMhwcg3qGMfoMr2jLM2
CnkHJYZ0CV/2BfGZ4fUDMBmuka8tWTtGFH08abLFyWi084oW/Y+WYpMVtzgkxAms96uWzrMw
5CV2NyemBKZMzMQpOx/Mu1sVrny2B0vF0lok7Bmul7sc2uxW4VGNRVNd8v50dc/PkR0xE0mh
oTbEv1L1zBWc/QJyHhMaxoUNgLTt+yEOUPX9nAoE6gBagKbiewF90mxHF+wC8U7Q272Fg+9c
oW6eoCAxDfFHzWJRE8HF3hMky3YQZwrT07W6PK7ebY/fXn5/ffj5r19+AUfVpvZ7PEx5A+GM
Nd3qaEQ7nAcAmpTI5PDy8d9fPv/6258P//fApV9ncG6QjPM6Y2wOArK1MSB1cPT4KuMPuksU
ATWMN/3p6GGzUzAMNxp6Tzc9Rdn5o02UY0jLYig6P8Be4gN4O538gPpZoCeluLhUqFxao1F6
PKk+teZKhB551OIuAl2OXbM8XCPgemSIbf3gOqkWgQ/xxtxwy+noBpl3lzqi3l1uyHa7ZEHi
6P9elwUGmnYKG7IZ8K6V18AkcTpj0rjQF8YKj3l5vUHiGjLFC9BD7BI08u7Go1hz2c2vOeBR
8rzxOsd1j+d6KCKCWgsq9bnkY962+PezIcRuAnWpuf97ZwIv39+qouwaLl7NJ4TKWc28CUlp
7+3r97cvrw+f5h1DGlsgB7nXpnm2gx5pZP5/fW1a9mPi4filu0NAm60u7+W+8FkHzEv6rLu2
6sMy4w8ZiUgn9XljEaayLmxiVeZpmOj0oslkPAA7HVY+WdMb6Jfs3lRFpRN/ytR41AtlDi9r
unlv4UiBwVE0MlCW0i5V1T4rntsMrLSbqu0ujuiRUHR5sD91NV8S8XgBkAvX/KcjM/O4gTkp
KwV8dOexsVXt8Ohkc0Z8gCSskA+y2a/wEMYmy9Fnk6E3ZMwtHNOpWc41O6GnWI0rXmfYD6LO
xQ/ZX58+v6nBQFaamvQZHPZdyqyuOzhq/1D+GAV6Fn2PBs5rC8u1CSdd0fcq8/jIq8zquLHv
8kfUXaH4qBACZ340WqnLLYJsJN1XwIwsT9/2Jg5Eguj6jkvlZm9B0g30QY8D+Qe+BcY+SZsx
hZ2Zb3v52cl6GcIoCBcerS3kMxL8qQ7gh7wR759ADr+fKzbUyGTbYv5wNmtYsLf8QYyBh1/e
vnEJ7fX1+8cXvvjl/fX7Eicgf/v997evCuvbH2AK9x355F/ae7i5ohBrI2N4tEWFhWXW4Fmg
5gn1v6Cmf+X7x2g3skiYVQ6gLyp7IM2xQTLHR3zlOlY1VtKqGUU50CBdYvDCI1sIMy1Gq9H+
8y5iNCrMtZ/f4MXYv9SZu9ttapYwNM5V5BOwz0RmQtWcUKL4sGrxakrU9dJT5YMjiboGBeMf
MIvu4JnudPXGBs9B0YL3fB7AAU0nIwS28A44Q1aHZnicDkN+Y4WNse4Ik7/m63GNo90RaxpA
5kAPl+5Q7g1aJlKQY2BoPn/89vb65fXjn9/evoJIwUB4f4CZ/6IODm0I/POvzLznR5/ogJgx
scpOoJsId4VOvmUKWU0xDsf+lJlrzsz0YeTqErLgiiOLdR+Z1xI4jLPDXKtr/LIRmhjfK6br
UNWWdLCgBD831llGgidN4mgHMXyAmagekEhBY0/zyKAihCRuZDrfd0C8MI8BMbzyKAhqOqUw
BKYUOtPD0JVkRPDbVZUFd4C1MoRUPwJREDzQ/MpQ52Gk2xUt0KHwkwi1qFs5uJaWd3ZtF7te
K8mc0bCme1WRHGh5JORwBaTxOFxLaTyov5+VI/DrABluAgiR0T0D+HiSoI/XCSD8/lPjiff6
ATjUVzIqXXNIqdKJqzwxcTxZMJjQqQrYOCIzYAacLUR114kKELhKSgPMxHRjCGmNpgl+knxE
JhLCKXXQU4TeVEhd5BEvpoIAWrKYvDOGOYsf7C2/JUsoieycge4jTS/peMvPGNqXp6HRvVAt
u1HbdhBh0qNIIVbT8olhwkXGRX8vQQopEK4UZA4oVB09a0gUO4DUdyE0RrpZIoYnQC0j1GfQ
wsGaJCURPJ+ZLy2QHBQeiEQ+ZIgUxTUuEiVIswMQJ8g4nAG8gwWoP/syoHdm+8L1/5RdWXPj
tpP/Kqo8JQ/ZiKSoY7fyAJGUxL95maAOzwvL8SgTV2zLZXtqM99+uwEeOBpy9mXG6l8TNxoN
oNFN7GF7eDm3EnHyOSIcjlzBdE52QQd9XlrBRQ5oBKFtrb21iv2L9AWbK4PQ8/9xpI/Q58kL
Lkdjw6QLyKdfA0MGKzYxdnAzTYkMpLv4Z8SKwrdNFure2Xok3eYs5sTWv0fQOjZnJIO4NGXw
b2/xanHUm071dui0ji0r57mvPaJRgTmlUXaAqwd6+Ho3AtcspOQSbMECaulBeki1Kl69MmI7
0jDuh7ROIaC5w22rwrOgvYeOHOazXxVakM62NA6fqA8AoMqSinADy+zMu7aiNxu2Wi4IAdhk
h8CfsjTyCbGugLSEVBnIWT0wBN6J6LsR9k/EGqXBpg8NmsmQkVe4aUt1gy+OTh7tfL3n4wHz
/UVCFJ5Lvc2BhER99zHzgoAAxMPSIKSq3705vVLEY740jAlV5OouRTBQ5QH6khijQF94hExE
OqVeIT0gdVSBkG5sFYaZIytKHAg6uTlCxOW/XmW5tu1BhiUhEoG+pPfDEvlEGHZM5NTCZxJT
YtIKOt1nqzndMKs5XfTVwpGO4dBYQZakQ8yO4UuGHmnJofhFnA+t5pXLabaiTS5Ch9vrnqeZ
By7fnSoLbdWjsMyvqq0F2y/DGVkbhJakTZDG4RPNLgFKGFYMfeQzzUpOP8rSPpGaQcTqeDiw
omGzAlJZ2Nas2gmcqIVyDSJvgtLYvkrdpcoxKPwYIwg1dVJsG+1uAvCa0ZZue0zdLgOmONoS
yFPP1/PD4/2TKI51vIf8bIYGvUa+UJtoL6yMyewlR02ewAusqtSb4oGU1lY+fE+dXApoj9dj
5gfrJLtJaatnCTdl1W4oV5kCTrfrpADcTDbaoWm146tol8KvO71CUVlzltYmcS+fQWuJ5yxi
WXbnLHRVl3F6k9y5WiIST7CMnKBxmhQtCNZTY8YJ+K6qE07fyCIOI2tbFmjX7sgzyTnRTEnG
qHsDCSVRmdsfUKb1AvkCNdbrtE3ydVobM2S7UQ13BCUr67RULxyRuiuzJlHu1eVvog7bZr4M
KBMwBKFMYtibH93cuRpqH4mot3phjiyDcajTDmlyFMb+VoHuavczM2RI0d+jI/u0MSbaf9ha
90aHxOaYFjvmzuEmKTAWdUPGlkOGLDIidQliEpuEojyUZubYPihjnLnnDBowhx51VTKH5qy1
wEqCeLfJGLe6qk7k4HZnl0Z1iV5EXbmhZXNtDs58nzUpOTaKhjqDkEidbvVkylofpTj9WYGO
YWFUa+uOQjYEmi48kgKarnBVpkoalt0VJyNLEGhZFJPE0fyIhp3fwXAw5mQF4kK8CIhMoMbH
aHbPAbNzpNdlFDGjTCCBrebsnmEYRCm/x0UdXxg4lwkRHClLCzPlJmG5RUoyDgtuws3aQCGq
zLm61aoxsJAC+JqHcd1UYyBeGwE8Z3Xzn/LuSm6wUpR6diCeeGLOX7Ql31oyvNnVe95I+xtn
Ifaoq7QVd/gqRA5/8yWpXcvBkcnVQyWlaV42iVmcUwoD3pEKZoDNoH7T09zd/eUuBm1G97ot
GlZ4A293e8q2RqgoWWUM7DwCbb2LTtPfIBMa2BADmNQSAbA1xUqPItfxxIlhwa0EClbTHl4I
kxnihfAu1UwNLd7BmklNVSlMuYvSNkubBlTopAB9RRHXiHd2ZjoR+tzwdo5UECTox5wyBUN4
n1WpbnAkkyoKw5ITyayOdu2O8Xanii1AzExZUYAYjZK2SI6dLZ9tx5M/vj+cn57uX86X7++i
kTsjHdUgB1PrfaKj9WXKaaMMwfe5kZ5o3GaLpkdNkl1LDAWwaDgRvZCvzQf7am1BuwfVGxaP
WPqi/91XYdkp4yi9vH+gwebH2+XpCa3Kba/cogvmi9N0ii3tLOIJR4nBoMBJB+t9KKg1ejKH
qdg2jdl1Am8a7DkOijyd+6nictJEcWdVca0MG56RueDXVRXRzvh1LsvoXHTkae97011lVxLD
j3rzUwdoOW+g+9G06FrDipArvneVp7ze+Hsv8O1y8WzpeVSpBgCKTruvGrkiamFCuF6y+Rzf
z1n5YsKmY+2eLoIN54aqMIzWznV89HT//m7vecXoj4xuEYapqnqLxGOcm5k3eWRlWcAa9d8T
UdemBM0zmXw9v4KwfJ+gNV/E08kf3z8m6+wGpUrL48nz/Y/e5u/+6f0y+eM8eTmfv56//g8k
etZS2p2fXoXt2fPl7Tx5fPnzYs65npNqiPT5/tvjyzfbm4IYMHGkOf0VNNSMNYUKqGlleZCU
1AMxnAwWdIJO9zx+v1f9mUqa4cNPSJW44AFBarcs3ibmgiIQzNbsulwMnpi0jxSS+BgF5jdI
E8uNW34jh1lLm0MW9UrObYzeB2tpYC86sHq6/4Cef55sn773cRAmXDFQM1MoN90J1rWiUMYy
ot12KSgYiTXbejrod66GG1i6VqegnOcOJM1PDsR6FNNLycV8ShG9dq9HElX4pTd+bF5HJXo+
2VF9R5BJDT1FzjlhXEoKnT3nC/0JjZi/UEeWkUnpygaZZpKn6jl1R1LduwlxF++bvdHMPDnw
ZGuWBkOcN44g7gK3l4HupAn+X0Rz0lu0YBKhT4xui8WeXyduGjTQz5ilFIoDxO5lMXX8inCb
bzAALm9kgGajxikoPOvDljnIqEFa7eFaK5uaga54SNe17o1U1Ks8srpO9WfP4iPaF5FUGzgM
O7GubdJTs68Tc4jjhnxz1Kl3wHcyc0m+iHY8uaY66lDwvx96J0sJ3nHQReGPICSdJ6gss7l6
oyIaCzbMLfQOxkVPbFHASi5P/PRubXJy8Fd//Xh/fIBtU3b/AwQfOfqrnZZcUVZSx4wSx7tW
REV8l8Oa3Co3bHcozc3BQJRCZH3XK/fOLFBSBKZjBWVj5qibWrVhbdPLLqWT9U7GyQSDKSPt
o21GYzvVgdhQeFh81PcHHdopH22xz2FDttngU7ORr5NtysuxsXfPb4+vf53foA3GbYW5quEz
AByojuJvcJyaGkyvKpuqRbutbVqvfBq64In5C0Na5gf7a6QFprJcVIbvtZ4Kn4stgZEG5u+b
3byOoyvrLTbLrbU6FUnj+wtXW3X9Jfc9lmYktg7TK1nKp3z9HkAdyWQ/6kJhDZv8quTaQbWo
h62GgwbD22ytE/txZFITXFJMovFOvkuU+H7TluvkZNIKu0SJTap2ZWEqnpDLfs1tal3AmmUS
c3wO3E0eE9sz1av2SOvelxOQbyWvPWSTNO08qasGtenZtI1ZYfmnKSB6Ktm6A2h18YDYzT9A
shd0LaPHoDtcOobCQnbGwND3iSOH5NMchgFAp6B272dJbWC8w6h3prVpNy75rfDYg8YAydGj
8/hO0B5PCrizzyUVtBtjzsVKYW0iWhPY3n/9dv6YvL6dHy7PrxcM8vVwefnz8dv3t/v+7E1J
EY97LSUDpYJL82p2et2AQI8QBNyDY2sLDyl1N1ZCm30R4YWf48WslMmfDqFOpjeo6RojfUtO
SvH2ldo0bxVRoPdOjK5EO+ntrnd5kzIzRZj4bW7qFPISzdJqJFk2ujMXyRPZWzxxPO78LF5v
K7MUSOveItuJCdDelalqAzuq+pmyHH4+VAdN867SLfoFAeZARbu7kvAuDjgPfNK3UJeAcGEr
PHMOE6j58Xr+NZIBFl6fzv+c336Lz8qvCf/fx4+Hv+xrAZlkjo4O00BoW2Hgm3X+/6ZuFos9
fZzfXu4/zpP88pUIUycLgf5gswaP/OxGKw4peqjtcKfWfT0/rYPRYQE/po36njjXgy9Vxxrf
jCd5TilNHWr7wwT2do0hR2k7K7Qy2jOXI1741txCyluJPPqNx7/h1//mqB7TcT21R4zHuyjV
Ki5JsLFFuyDY7JeqS4kRX8MvefXTBv46xb1Sgw0Je3NVzRg/qLJmk5vNI6ES1MOacYfNgs4n
rmuvVUZwNWp0ew1K8C8HtsuOsQOKj1HO6Q+7AJ0UtMH/1YdEI5Sn2Tph6otbxLZlFm9SvjO+
qIwuOuy73ZDWSHsooLMF95BtOofR7oh/AyzRLRTM0bQ7fmtmlzu8O4x1PCWFwzRDadtcD2pG
sLB8HpKBfpIcgzArJ9g9ZThallPm/Hx5+8E/Hh/+VkTOmFH/0b7gbJO0dYJhXqj8eFWXckZr
bcHtWW7l656qXSp4E6kbVYgbPuFNSM1tpLbCIoYop2BZ13iIVOBp3e6IJzLFVlgAiJJhgGBL
+IrPWBFM/XDFjGIwDCIfWOUQ3hLIVyUjrL5plYXXQ7dIWj2dejPPm1lZJJkX+tNgSjpNFxwi
dNXU+lCQqT1yj85nPvXRfOVTt4UCloEijLJDdVZhYKfV0d0RXwTXdVQEfaPf/A04GT2kQ8NQ
xPjoLt5NzPfsBkAydRw4oOoZdEdcGiH3ejL97G1snPBENWV4Mq72B2genKxs+hhaDWvIYz7B
NDjW0r+VXrXcH0WeP+PTZWgUhQhMJYd77C+nxJhqgtARqlLOLelvy83QxWJxlbOJGIZwMArT
ZFG40h6dDLMi/Mcq4xBz0l2KlAfeJgu8lXN2dBzyzYchZ8TF5h9Pjy9//+z9IlS0eruedIHK
v7+gg3jCdmby82ip9Isqs2V74yE06R4OUTPCoqxndqqTrUHEEF8GiaPVyZ1ujySbVYRU7KaU
JfGxPs3b47dvtmDtTDVM+d5bcBgOrDSsBCm+Kxu7LB0OO6kb5+DoePImdqS+S0AHBVXEnf5g
I/hZJpHqEl9DGOyBD2lz54CJ+T5UrjOuGY1UHl8/7v94Or9PPmRLjyOoOH/8+Ygqf7cTm/yM
HfJx/wYbNXv4DE1fs4Kjr8ZPq8dyI/izBlesSK/Mn56tSBrDkItODN8KmMN3aE795FMq6uka
vdkrTcw87w70AJZmWaIczA/FSuHfIl2zgtKnExB/oEeXaLDEo3qvHNQKyDLxqpsID4B1Qq++
KKRd1JQwN0li71ftp7ePh+lPKgOATanq3wrR/ZUZJbDBDWQu4kWI4QCEyWPvO1WZsciYFs0G
c9CPdAYEvaARzTbghm83ld7u06R1eHkTpa4P/aXaYMqHJSV0155dBhkkYwl1HGy9Dr8kqnHF
iCTllxVFPy210H493QwG2NFj7gXqMqTT2whm2L6+o3H1oZVOb49xQ2LzBVGG3V2+DOdEJXN2
mmv+6xXAis42QiLuGjmneyYrbpaJ8zAKqKKmPPN8NRiyDvg+VaQOI+MwdSwnYAjtVKtog48d
HcCUajOBBE5kHlAlFBCprAzNOvOa5ZRscIFgj1/5fH0b+Dd2keyYTX2B7Phs/SdEOCmKZeWR
pcVI13Py1XHPwWEHspoyu0ybXPdZMiQJM86R2QlalQw2pnzqE/2e5LChI2ZlfQD6kswKw8ld
60Ae5nZ6PIZJvuxFFj5D/kRkYWevPhsnK4dcmJKzQyBkTEiFYUaMZ0FfuJJ0RKrWRIt3bUrW
q4XqDGXsslm4JOlzz6NGB4qSGdlnUrw5ItuNM9P3fHojMqQTVYuVqwUJV2LYz/cvX4klympH
2DiTiwbS291R26HqRSY7RozflW7jptvSfTL+oryk9otKx/u6DwMFCclANipDSI+y+TJsNyxP
M3odnC/JhUgg9JtfhWXhL2nvVSrP7F/wLP9NOmT0z4HBn+mvvgfE2nGTLKRt2SBpmhtv0TB6
HsyWDR2lUGEI6NUeEDrwaM/A87k/I8bw+namR2Dth2gVRvrBSI/g2L0uVOxgggbDl7viNq/6
eXh5+RU2X9enoGVjOcwE8wB7WKYa+GtKiaIufCzZjiJS6jVpuAgoadgfCw4Pqvn55f3y9kmd
rPPyOGfdgw6KNuwIhmIr2MG6KJFhVHJme+ln/K6I2ubUJgVb4/ZqxwoRzca4SYKPW+kPV6eV
iscZlsFWD+1mt7FuAh8fW3ZKkZ/aaqBtkPGBcLOK5aWGVipiuKQAz+kTReEvfocMbb7N6Xup
kYeEocRmaccLL9g0Gd8N7Rs9PZ5fPqj2lTUcW063Nhybt4V97nC+DeT1fqO81+mLgIlujHh7
/Cjo9PV8lxJZVwG1eXlIZMRN+tF3x9bHpySDhEmWXcIqbozNgS42u4lxYdyHAdGrO7Th/tTZ
0I4Ntotns4WufaOHV8ajNEWLX+p+k9XCaXjVxTccyDKqmQB/nxrkuhTNHOpkeQ3R5gnnmjVU
1UUjLJsB++mnsYRo4Sseq2Ywb+jOUFmod80K3j8kVvMef3aMI2Gvh4GBnzCMpThN61vKbAA4
YgzZKTm0lOQMzdZRu9XcY1sQHhOdQk+NYSByrvfqeQqGouzdk49UTGiHOmEBDVnr3HplulCW
eVLsiYoc4kqZe/gLL7kVirCRTctGteKTxDpVH+Ue9NcCkgUz1coiqAX5ckJi+L7GTOXAjdu4
jgyFJceJhPFNOO+vr+1YLt3zv4e3y/vlz4/J7sfr+e3Xw+Tb9/P7B+U3+DPWvsjbOrnT3jJ2
hDbhujuuhoFIo67s7fWup7RVWqneATDgRJQpG2X4gWdPWVne7CubER3Uw2RWIwmLM24jkYE2
BhAZ5yBQdzymb4WVL6lzFZJrNVPvXhRMHLpoWY8YT8OA9IFp8Ki+WHXIm7mQmRNRfaUqSBRH
yUINOmNgWuQWFeP+dDpto8pVSRkCnaoloM0xm09ndIkGJ5skOhyW2NAhCh2FWccLb3mi/Ykp
bJv0lMRtnjvuO3dH2EwW5EV69HR5+HvCL9/fHs7kDT4+ZcO3RDAJmvmMDpVEJqKkwdJsXVIa
dwpV2Cvn3TIU9vnl/Pb4MBHgpLr/dhaXEtqjrT6oySesej5CB90MnoXq8/Pl4/z6dnkglOAE
n8zjQfTvip0W8YVM6fX5/RuRSAV6p6KN40+xCJo0ZfXoc9JSVMQXBms5prX9aAqE9eRn/uP9
4/w8KV8m0V+Pr79M3vHe709ooNEmQsaGfn66fAMyOuZXO72PB03A8jtI8PzV+ZmNynhZb5f7
rw+XZ9d3JC7fhJ6q38ZwAbeXt/TWSqTXnvdpFHUKKzHSbpPuPYqykG/3DVcb/bPc5BXZf+Un
V0UsTIC33++foHbO6pP4oFaje67hTOj0+PT48o+RUMfZubg/RHu1TtQXg0eFfzVkBmUOw8Ef
NnVyO2wF5M/J9gKMLxe1MB0ES+ih9wdWFnECepNm5ayyVUktHPjDdplW9lVefFvHYXmlNH6F
D6+fecXUDbiWDOMcFDyzPpYB0Vh1M+ZNcmqi8fo0+efj4fLSP5y2kpHMLYsjI3ZRD9Tpl7Jg
Fn3DGSzXU4uuX+12RHyFEoShRbfP6nugKUAZpqxJOoa6Wa4WgV0snoehejbTkfvHYSMACnup
3k7h3Es3ymlJqnLDj+4RFEVrozVJ1vayOt08I1BQNN8qC7RJMzK72aQbwaWTu0tiWGupEso/
1QceyjcWq8iV47AfWHyVhR+tUFgdmUxxLFo/RKXEfng4P53fLs/nD20sMti+enNfPS3qSSuV
dMqCmaacdCSHd8ke1cwqBVG9p+sIJJfuDXadM08d+fDb9/Xfs6n120wjgvEtbvIzmurm14sY
M18tTMwCT49+nLM6nlLKt0TUWMVIUI//bk48Xhk/TXfHkujy6X1ziv5z400dYSvyKPADapbn
OVvMVIHREUynuD3Z5QYX8bkjfCFgyxlpDgbIKgw947VfRzWyB5KjbqcIep0+WQds7oeO2BMR
c1g/8uYGtmCqD00grFk4VddWY27J+fZyD7rT5OMy+fr47fHj/gntZWAZMGef9L+NPmMaps6B
xXTl1caEW3g+faqI0Io+8gfIn1MjEYGVNuvht2/8Xmq/Z4u59ns+nRsFBApIdFhnhxBKdM4j
nzGyAVu4igv72VYvsHHKhpQVtWETQKB9ulwutN8rPcoKUsj4FQjo/vpZvJrNqcN4kKPibJnp
b2zYqfKnJ6RS3wC4XJqfRJEHw9MzvxlxPNd3pBizFUqxbcXUB7dJcUiyskpg4DV9SPEO2qXL
WaCIgd1J87ecNZE/08OTCJLjQktgK6pHJaJdPILO4k19qi0R8TxVwkvK0vycjs2BiGZlgScf
c7VaeVQFvmqKg4SZaoODhJX2SeXP/ZXZVwXbw7CkRJzUvMyeEKf9ByZfhmk3tALhFUasNvIY
kQPd6SMD4KrFQoH2FNb44rFQRvMylka3RIqNSGq69JSi9zT10rmnzfjU90yy53vB0iJOl9zT
jQ167iWnbYc7fO79H2XP1ty2zuP79ysyfdqdaffY8iX2Qx9kSbbV6FZJdpy8aNzETTynsbO2
M9/p9+uXIHUBSNDn7EzTRABEUryAAIlLMXbGWnmirP5Ih91ORz2jgmIyGHI+DzVyPJmYryhr
ZXamA0EsRG7b0oZk7JE3HNGEObVNjZiQ/EtwzDTolm93yDof93tWhrAOM0gRCoGZbSS1mrgx
8M2mdm0Dw1vc/HQ8XG6CwzNRw0EUzQOxserxc2jx6OX6QOL9l9A6tU1yMhijYV7G3rC2JmvP
Kdq3VBted28yIIS638RllZEL/sZ1LEK0BUhE8JgamFkcjKnoCc+6qChhREj0vGKC2UXofqfC
TRYXtz0SXh2ixuaQzLxYZNTdosgKVmhbP07q3ag5gtM/Xd317p+bu14xMHVqTJJTlSXAekVc
1D1T1J+uTpuKrHmvLRQrKUXWvqXYm6YUdQTL1Qx/h1kwea3UGsPjyHhouHoslMJfz3Ax2bdq
XvLC2qg3RqfT4nmAQyfB84Q+D50+fR5qEpOA8FLGaDR1wCy8CLQXAG57Y5CT2kbUQERAxs4w
t+T4AeyEyHfwbMpno/F0bFU9BPp2xNk2SQSRJkckD6F8pn17e9ujn3OriauDniayTSZsXkQ/
S8s6mWanoRXDocMxfyGV9Md4VEFMGeMdLh47A/LsbkZ9XYwZTRxWDvGy4S2+jwDA1NE3P9HY
3sQBtxh+HxH40YjKYAp6O2AvLGrkuE8qUluIr5sSNBfe19aEspkWjOL54+2tyTWus//6vE8G
O2GrMAqQJcxPu//92B2eft8Uvw+X1915/x9wU/H94o8sipqTa3XVIM/9t5fj6Q9/f76c9j8+
4HoeN0RI5yPdII/cVliKUHZur9vz7kskyHbPN9Hx+H7zX6IJ/33zs23iGTURc4r5kCQMkoBb
Esb2/1t2897fdA/hZy+/T8fz0/F9Jz5c3wjlIU+P8isAEaPZBqRxLXk+ZFHxXX+TF8MRj5zF
iz7rsDbfuIUj5HvMzDsYZfIITr12s9Wgh3u9BrBbxOIhT6uBUM/0DalGgSHmFTQ4LzXobtKX
C6FD9K4uJ3NI1Aa92/66vCJ5pYGeLje5cq4/7C9HetXhzoPhkDUjVpghYVKDnq4/AYTEH2Dr
Q0jcRNXAj7f98/7ym5lfsTPok/MLf1n2+YwpS1ACevzl5rIsHJaVLssV3lyLUMhSI/rskFMa
o62KiYnVfwGXuLfd9vxx2r3thDz6Ib7dWCvkfLEGjXvmwhje8hugxFFBMuyPjWddsJQwMs/n
m7SY3OLWNBD9qK6F287q7uLNmOvcMFnD6hnL1UMO5TGCVoZRvIhRL6CoiMd+sTEWVg1nl2uD
4yS69r0BuaS9MrK4ABgY6lSFod35vnI+3L+8XtBkR0P/za+KgWWCu/4KDjY4xudGA2L9KZ4h
KRgCZH4xJXHZJGRKp95s2b9l724AQU/JvHjg9Fk/B8BQJ2sBGbCuygIxxssNnsfY3GOROW5G
kkIriPi2Xo/kEAm/Cy2+Lz6czTveSPlF5Ex7JJM0weDMXxLSx1LWt8LtO/gUN8/y3sghp1r5
CN+BRGsxKkOcZkHwS8FStYgQCsZJ8Enq9klqwzQrxSiiKjLRJul1T7hYv6+lVxaQoeXUurwb
DPgMUGW1WocF7oIWpGXZa8FkZZVeMRhiGx0JwFc3TfeXorM1NyUJYt2TAHN762jEw9GAm42r
YtSfOMhKcO0l0ZBkt1QQamu+DmJ5ZMIpyxKFzYjW0bhPV8ejGCcxLHywSbr8lQnb9uWwu6ij
f2YXvKMJzuTzCD/3plN6d1TfOsXuIrGqWZiGZ7UCNehTN6c49gYjh800WDNSWR4v9DTNuYbG
MpE2S5axN5oM6cSmKFuWOo2KpqmrkXk8IKINhWsTnuIa9baxMuRGU41zF4HpTM844hU5gCGE
tYjx9Gt/MKYI2qgYvCRo/NxvvtycL9vDs1DDDjtdzVrm0rG9ufjl7dIFnYxIlq+ykqNEdCW4
oUdpmvH3y9JdF6Haz+AbW2+bByFZSi+m7eHl45f4+/143oOixW2mckcYVllaWFbh35dG1KD3
40Xs/Xvm7nvkYJ7mF4IZ0EuC0VBX9YfYnUwB0E0S6PNkmwJAf0AvGoDhaRREBiizSJfMLZ/C
fqbofSy9RnE27Tcbl6U49YrSeU+7M4hLDDObZb1xL0aWbLM4c6hEC8+6BCth9P48WgpGTC2A
soLfy5YZHpLQy/q1HtMxtizq9w1DBB1t4ZNZJPgkPpApRvReSD4bd+AKailTIAe3Bo+UYb15
KCvyKgzdlkdD3BnLzOmN0YuPmSvkt7EBoMU3QI31GePeCbwHSHrACb3FYDoY2XdK8l49uY5/
7d9ACYPV+7wHRvHETDUpwukRb0LfzSEjTlCt+bvueNZ32HBEGTGVz+f+7e2Q3jgV+bzH360X
m6lFyNqIFuJdRxSBFj7IJoOeQ4SN0SDqbdq51Hb81T6pTVTPx18Q4sVmT4BUDaeYsoqGQPQd
ygb+pli1B+3e3uGAjLIEyqt7LsRajzOmWjg+nU4oUw3jSoavT710RRJbxtFm2htjuVNBqFJS
xkKx4G6UJQItvFLsVVi6ls8OYTtwCtKfjMbsJOY+vXs1uzfjq4K3ytPr/p1JCZV/B+tpclwQ
VfOQE3rAXS53K+XY0okJetlt0Znr3dEETnWk8DBLvRKHLRUsJSjB6KzM0yjCW7vCzHIvLspZ
fXOnY5V32+Ief4TCQB50GQvI6JFs+XBTfPw4S+vSrjtqR8k65HyzVXhxdZcmroxSTlHiofGh
rMo0z5VlWzcWCO1DlQwPQCRFKCQh11ZA4UZrLrot0EiTxXgzib/rYe0BG4cb0UFxKARhvRWE
Ltu4lTNJYhn8/++pLEHbZZul5QexaJYNcTMZU7mK/Xg8xlwKsKkXRCnchOU+TbMHSGk6oBIT
WFuGaNgJDDSlwAulm/AbOhlaajDiVY6pyEptZk6l3QmcziV3fFPHk5yn0DUyNG9dMxuZe3g+
HffPhJ0mfp6GPsseGvJWqnHRmVYTAwc/mqFuajAYahS+y8XZysF3qMiqAJwQ2qA6y/uby2n7
JPdXndMUJapXPICjYJnCVWLocQiICUQWE6CMSxuEK9JV7rHRjhC2DXnFni4CH8FxohtItWCh
BQuNixUDzcqQgXY+yc1psNmD6Nw0W/CubfOCFfgglLLYyDbdQSEO2GtY6EMEYNdf3E4ddM5X
A4v+kLpdAVwPYIhQ4OtjUT8NH4IsrtIM+aUVYUos2eAZ9hFbfUUUxnSbEQDFDLwyj2i35+Lv
JPDIzPIgsSqreMZNhqlGQaGm8+picP9L7MOSdxARZO2CaCjEQogk7+YFW4HAhRAHtWtksCmd
aq5bwgOo2rhlyRUi8AOS2aMGgKoaiuHzIq00iSwCb5WHJbecBMlQL3CoF6ihmuI0jBaH69vM
d+iTTgGB9Wee6y1xVIIgFN0H4eNpNJ8GLIgtoZZbEvCVgrBnvAcaqsDay9+M+r/hHmHL/Wbp
Z0JgC9IsXy7dMoQYtWgwNk1D0PP3VYoNdTe2wQcEmy0SEGkSgTu9FvMNYcBPFOdCB9S9myd6
DbYvWswLhzQ99WyQKnU8Isi0COgSXgZQJCrRTewWd1HKNQJT0fGclWoKsIUnYaQawHNgx3iz
m89kB7atInAxpEtOQVSEYcEhsZt3GAXgznlHFEjwXgIzyQcdj/aJSoiS+UNmzUMuKNaBhSvM
CxXrAB2Y6IBQAZq4ml2xrhkmoUZpM1c+gi+4TDMlOfacOEjJgP41Gcw97RMVwjYBFbbMA1Tg
93lcVuu+DnC0NnklGi7IqzovKI9UMG1KzUVP8PMiFf0cuQ908rcwSG8e5mKfqvyQ9CRH4kb3
rpCW5kJ3Su/5ldG9FSZ+wPm6IpI4EJ+bZg+N1OBtn153ZG+bF5JD8/YrilqR+1+EePiHv/bl
Ntntks18KdKpUAR0vppGYcAHIXkUb/CZUvx5U0rTDr5udTaZFn/M3fKPYAP/JyXfOoEjwxMX
4j0CWesk8NzELfVSX/DLRfB1OLjl8GEKzraQv+bT/nycTEbTL/1PHOGqnE8wY9ArVRCm2I/L
z0lbYlIas1OC7GnGJDq/Z0f5ag8qvei8+3g+3vzkelbuxrQtEnQH5o+c5gZIUOXxIpRA6GDI
YxwSZwGJ8pZh5AuVvAPfBXmCO65RfOrHMs6MR45ZK4SUE9Cp52ohmNYMF1CDZBvRLAriuV95
uVBCSMgF+NWNUKM1mp2IZPCwUDFtVIAYblkIRnqf5neYCml/miABz5jvyeeB/kz7QsKG+jN2
iKkhqNxMViz3KPchxYkQFEaoLBj7ppddSQu+OEhAOEqTKvQrXwjRYfL105+702H363+Op5dP
xltxuMjlC0SGhMgzthQ98CowcBUnRGx3bBfXRDC5hFbnJ1qP+mEh40St/MwMnSsIfPqkehw3
wa873dZEgedMRsXHgsOT2M1THABaSAX6ozGAojK2qYYvSLFK8szTn6sFvlGoYRBKug6VRZQ7
hbUzIS/IlvwO6oVi8r4hyrCRDrljKYl1YYcUW6CUyZtxJaogUN0H7l2V3UM++SXfJqBaZZ4o
zo636RESaQQj66D8JUKHh0OQTMy2B37OKkK2fS2r8V2N+bo26XWaEQ4hH3nNQqGuKJVJhBdG
VDQbFrf7AbrZPqvhgJgxE9zt4JZfFoSINX0jJBNsoKlhHCtmZMXYWzyxGKhqRLzFlkbEzXON
ZGBr4nh4pYl/31/Y80XDTK0FTwd8RGVKxBqMaeXYxmQ6nNrahQ1eACMkSZh11cTyQt+hzlk6
0j5CMqSa5RuaWvt60Q3CNqYNfmB7kdsDMH5ke5G7s8L4W77fpjy4P7DALd3f1xbRXRpOqpyB
rfT2x64ntu/YkjuqofCCqGRvAzoCoWSu8pRWKTF5KuQFmqO6xT3kYRRdLXjhBhE+227hQv28
M8GhB/mwfQaRrMLSBMtPt7SuXOV3IZshCChqfaIzcojYbIdJ6KlEbBRQJRAGJQoflfDVRDdE
hwBpdU+uCMkJqfLP2j19nOBu2YjTCPsaFtgfQM/9voKM2c2hYKcyBHkRCpk2KYEQAs9xW9is
K7U7A1WnIIFv30cFovKXVSoqkR/KFQ008mAj9BQNkWzqrRAiAhbyRrLMQ49Xa69smw2KKBZw
+yKUPD9IxCfAYQuo61K68ersNG3RBhl/7iNEPTi4UdckFrtO8Y2eLAYS8C2DKGOPtBs9tPt+
Fy2CqIi/fgIPl+fjvw+ff2/ftp9/HbfP7/vD5/P2506Us3/+DIkZXmB+fP7x/vOTmjJ3UrK/
ed2ennfSgqObOv/qUm7d7A97sK7e/2dbu9w0k1JoiPAJ3p0YsURLhhFCkhHVfSjrCHtFpEjn
YgnT/CTdTQffjgZt/4zWxVBfG63cBlM2bQ9lTr/fL8ebp+Npd3M83bzufr1LXydCLL5p4RLv
Twx2THjg+izQJC3uvDAjqZk1hPnKkkTfRECTNMcHmx2MJWwFSaPh1pa4tsbfZZlJfYdvp5oS
IGGqSWpE3qRw8wWagYhSt6qjjB5rUC3mfWcSryIDkawiHmhWL38xQ74ql4JHEgVFYfTMlBTb
xjJSJ0AfP37tn778uft98yRn68tp+/7625ikeeEyNfnc9tXU43lGmwPPN2dX4OU+W7rgTevA
GY1oFgd13/5xeQXzw6ftZfd8Exxk28GK89/7y+uNez4fn/YS5W8vW+NjPBzctRkpBiZ0YfHP
6WVp9EBN8ttltwghEr25wILv4Zr50qUr2NO66fyZdCN8Oz7j2NVN3TOz+7z5zISV5tz0mJkY
eOa7UX7PdHs6n9lHNePatWHqE/vufU4tM5pOg7iu5YrPrtu0FqKqGaO+3J5fbd0Vu2a7lhxw
w33BWlE2RrG788WsIfcGDjMmADYr2bCMdBa5d4EzYzpFYdgjlLaest/zw7k5c9mqrHM29ocM
jKMbVVnG8Zc4FPNYWitxonXDMGK/TzOYIIRFv+4oHN2uzqAYsD5RzfJbun2magDDN119UVRt
LuelO+oz++vSHZjAmIHBddYsNffLcpH3p2bB95mqTkkR+/dXYgTSMh9z1QlYVTKyRLKaUYfT
BpF7vO1qOy3T+3loO2KrZ6YbB0LNcq/MXRdUA+1cEuHMyQdQcxh85ovn8rfJfpbuIyMnFW5U
uNiyVuP0DCMPmFKCPCMxHNuhN5dWGbgm7D6lYaIpvOsqNf7Ht3ewsCayctsj84jeUdSc/TFl
RnsytBxcNi9x5xMdcmlyv8eibMP659vD8/HtJvl4+7E7Nc7xmk99Ox+LsPKynI2i3XxaPls0
YcgZDMvbFYZjhxLD7ZWAMIDfQsjvF4Cta/ZgYEEerFwa3UJDGefSFjIkoVuL0nrJSgc6wDVC
wygD6yi/9j9OW6ETnY4fl/2B2WDBo5XjOBIuuEh3BYQQ9a5mJjcxaVicWpZXX1ckPKqVH6+X
0JKxaI7pALzZYIVoHD4GX/vXSK5Vb92ou6+7IoECkWXTWt4zDHQt7ZA9141tDBnTcCI/LuLK
lRBD/Y33MEOkpRuFJZv4CRG5ZdzG2+QKUXihfvyTYqDvekNWtxE0Kqr29XIgK/mGxAVFSM8j
diy4+jhKF6FXLTaR7Ts6iisd7RYPcRzAsZU86iofMjOwtwfu7D+lsnSWqX7P+5eDck54et09
/bk/vGAmrS6hYWFCZtmiPbnjTUn+Qdm1P5CNw4DdmptXOWQfQWsNfBOI8dQsFGIUJNNAPdp4
AwgJK/Gyh2qeS/tyrLBjkihILNgkACOOEF+AeWnu40Wb5WEcCCU9npGEHurs0SUTwBMjL/YQ
AuqPKYUpzntVWK4q+pbmVQ+A9jzXspwkSRR6weyBy31JCIZM6W5+L2SKK4WLgbBhLcmLPE3O
7MA4M3Y4M5UsDynXrVaFbPETP40tXVLTPAKPDBNNUHpUvF2DCrkJ+KLmcAdQP+DgQiZi6Ycs
PUhLDLkEc/SbRwDrz9UGB9uqYdITIjNpQxfHxqqBbh5zsHIppraBKDKxvRvQmfcNj0MNtYxA
923V4jFEB3UIMRMIh8VEjyTJVIfYPFroUwsc9USz7PF5fMNmcIYwtyhSLxQrfB2ILspJsiZX
GoZjXw0FkvmYiME4wEl48USoFVWhMmQJnkR8FyROpvlyMym0acnJxCdFbg5eFMsgJ2qIGKil
rEtm0gLaeZobIcB5KpIdvCUBLKSeYSoDVJImDQKiK2cU26KyNI0oKg8M6tpQssF0N18CB+Kt
zV60WERqFFFx31F1iyglBy7wfI1dJBE1Gmtnisy2jVeTFz0KiQWHf8m/gziHKo+zkASIEQ9z
nDE5DX3xxQuxyZLo9qnoNMO4R0Inf+FtRILAqFV8j3KYaDtF6/R2RDNwGyL3DS1KYGTvSxbl
gs1quEgYupXKaF7No1Wx1NwA5PWNH2QpbozYL8hwwy1bssDXksj7V5MS6MVSI6tI6Ptpf7j8
qXxf33bnF/OmUhoi31UQ5QBPgRoMtjfs9Zin/JMqIX9FQuCI2tuLWyvF91UYlF+H7birPGlm
CUM0sR8SF/K32yY2wTdBJ5GQFs9SsYdXQZ4LOj6NBbwoftYQ0bUOB1n3s7Xv2iOH/a/dl8v+
rRbjzpL0ScFPZk+rusB5A/PeBgZ20Csv0BJ3tNiGRQe8/oooiyyyyB6IyL938zkvhyz8GfhO
hBmb6a/OFhmv4LgK/FXQSstFHytHikl/6uArV1Ga2CbARS/mr6lzoZjLggUVS7AMwG0X7L7F
8mHtwdTXFWKNw31+HBaxSxJZ6hjZUnAJeTC7XHB7L6gN6ALJ+HnB/p/OgX/hjEv1SvV3Pz5e
XuDuNDycL6ePN5o/MnZBsRF6Bk7Ah4Dtva0aka+9v/oclfJV5kuo/ZgLMEyA9KmfPtG+NO7q
JXu7ExME9xg8M8PRscJZ4SZCYk7CMnwMYB/Cb0ss27n/qLtog5Xtqr66wL64OYCrr7XbwhAf
BF4UbEqIEkxta1UpgJd7KDs95dvpfWKJECPRWRoWaWIoiaSWdPZNTFN+jRTRataQ8cZCksI4
w8IjWPeT2MYiMbnNr2wwV5qorA9WwLv5Rgi24NdUQeKbXm2GACWLXcdVtijlVDZateZ5gv7i
P6gkzMuVGzE1KISVrajkOtJwwnx5GS6WccAZH6E+lx0C3inzKL03yyBoW0lq/bmFm7ALExBw
TUclPc+THaCwximbVppO1a1yiUhX4NDEdbTCh9LBTi9Oflt3+qe3s60DBB2FZRmCsXaNPlxq
+UzVXSXQ36TH9/PnGwgI+/GumPRye3jBcpBgUB4YxaTER42AwRl2BeeY3WRP5+X/VXYtvXHC
QPiv5NheIlRFVS89sGAC3eURY8LmhKJkU/XQNmo2an5+5wG7thk7ak8pM2uwPZ7H5xkbk8+H
7nTXQ0BUkTiVA/h0Ju3l9TXegE0Cy5SLBX80Ovwu20uJd4/T1MA0Pb6iPRL0Hi/XVSI3PRZq
FJfsHqFJfzrQpdwq1Xkaj5Eu3NU/q/QPL88/fuFOP3Ti5+vx8HaAPw7Hh8vLy48WCIYVhNT2
NfnGJ+/frr65PZUMimNMbWC/IhoFQ9PBqL2S9fAsbMJdjx7L+42MIzOB5m5HiCfkTcT5q8Ze
BbwnZqCurUyUw8IBGrwNpmWtg+Zx410X6bZndxRB1g2WHwRhtnPvRDBuCWf+QxScEMpop6KS
3Dno/jQ0uCMJQs3Il2Dk2MoGNAXX3lw83h/vL9DReECgduXGI+grOAn4OCY0MdvPKZjg5ErZ
n2T0pzw1iBnQQXOVm7AX/Xj/VRkEG6oxlXcsKO9RZoOjJ84+ejbQ9YHhCUeOd6WCmHDqglR1
I5bzLccqOd+3WlE3s/OuBbfdDfpIiMHjQ/RH/lQEPpvszrTS2UtkeIuh4aiCeqQ9s3yiXuu0
K2WeJYQtPHHmBujhVNPRDhAkIdzusWA5IUo9cYKL2Rjfa8/mH3IrZyK3ne1aO4gj1MG/ds96
ONce9aMNVmBLAY1chKe6T7H+TZJ2y2ujI1yqueTJjY45EXnmWYnx8++/hz/PD6Krj5Vac07i
qLR2Sy6xLpu911x1pvz6+cr+narxEh92cI2bLoJJ5R3abxu4kdOUjcbLhIcuzlb31cS4UAyM
w69CVA1dETovYG3M93UgYNjkoOnHCr450LBK9e7OP9vCI8A6c5SsT4bZyeTEc6GhKc1zDcHs
01OSfEqSL26zncGqsaD72ZdpDsLZFgXWDSdvh4T/WZjOSips8MwcXo5og9B/yvC61fvvzoGg
26EJQCuL7p5InMAP/sZogzz9XOAs8fgLYJu1tytXHroKj+f1a29ouNz4vwWvIbhSY/zZewwI
qOgBq1Dn0NwhglylWqUT7d8nb1c0motWAG2Cu30olyjycyLKWXtucyMHbuzK4rZp32p5QIml
rhoEfrowR/D3m8VBoKUTsUYbzDuL0GkXot21eAl4kIsOeIDgYIo3BtYTbFJoC2hBz13Q1+5t
qfa+/HvDwagxFzVIK27h6rPubtX8FghGvEGcyKQarc1YenjCrd2m4DEsh50MVhLHMPgHf9nU
PW0khelSpOxyaNwHXcEC3niGKmOJWuXyMVUsvduIaEPvIVoM0+fYNzI4mLAUrHLhd3RFhIh5
CSWi72AdZR1UNTl+57QBD6esUy1BNNRWUekafGvlTfzpGAPvy3O1i03cXH4TrFdiQazbiGyg
PUlBHMPiTVkR1Xr9wC+rkAYHWjBEiZqHVUkMb8D8A7Hn1fGe7AEA

--wac7ysb48OaltWcw--
