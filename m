Return-Path: <SRS0=w5GM=A4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C5CDC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:26:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC7620737
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jul 2020 17:26:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727863AbgGQR0x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jul 2020 13:26:53 -0400
Received: from mga01.intel.com ([192.55.52.88]:32417 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726205AbgGQR0w (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jul 2020 13:26:52 -0400
IronPort-SDR: 079d8DNNilHA92Nn16nBReklxk0NEaezIGtX8NZYorJxJVW6Jn9LZT2T+0bYET6pKEazOIh07L
 PA9IAsSzAxQQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9685"; a="167783863"
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="gz'50?scan'50,208,50";a="167783863"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Jul 2020 10:18:21 -0700
IronPort-SDR: nD9q1FdBF/WSeQ4pS/T8XQYOeJmbtDtKTW6S9FUsHjWaHCGR3w7driQPU598fI+G9WJgWiQXXe
 Sz07f+nLqX7Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,362,1589266800"; 
   d="gz'50?scan'50,208,50";a="270865793"
Received: from lkp-server02.sh.intel.com (HELO 50058c6ee6fc) ([10.239.97.151])
  by fmsmga008.fm.intel.com with ESMTP; 17 Jul 2020 10:18:19 -0700
Received: from kbuild by 50058c6ee6fc with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jwU03-0000PZ-BA; Fri, 17 Jul 2020 17:18:19 +0000
Date:   Sat, 18 Jul 2020 01:18:07 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/fbdev/riva/fbdev.c:788:29: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202007180155.GyFV5gNh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="/04w6evG8XlLl3ft"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--/04w6evG8XlLl3ft
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   8882572675c1bb1cc544f4e229a11661f1fc52e4
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   4 weeks ago
config: m68k-randconfig-s031-20200717 (attached as .config)
compiler: m68k-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-49-g707c5017-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=m68k 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:493:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
   drivers/video/fbdev/riva/fbdev.c:494:14: sparse: sparse: cast to restricted __le16
>> drivers/video/fbdev/riva/fbdev.c:788:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:795:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:797:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:803:38: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:805:38: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:808:37: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:953:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:954:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:955:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:956:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:957:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:973:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:974:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:982:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:983:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:984:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1421:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1422:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1424:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1425:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1428:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1455:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1456:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1458:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1461:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1524:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1525:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1527:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1530:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1531:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1532:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1534:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1536:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1544:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1549:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1554:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1559:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:1605:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/fbdev.c:2064:42: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN @@
   drivers/video/fbdev/riva/fbdev.c:2064:42: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/riva/fbdev.c:2064:42: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse: sparse: incorrect type in argument 1 (different modifiers) @@     expected void [noderef] __iomem *addr @@     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN @@
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse:     expected void [noderef] __iomem *addr
   drivers/video/fbdev/riva/fbdev.c:2097:34: sparse:     got unsigned int volatile [noderef] [usertype] __iomem *[usertype] PRAMIN
   arch/m68k/include/asm/io_no.h:94:17: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:205:9: sparse: sparse: cast removes address space '__iomem' of expression
--
>> drivers/video/fbdev/riva/riva_hw.c:65:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:66:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:73:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:74:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:81:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:82:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:621:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:628:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:810:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:813:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:816:12: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:820:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1073:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1076:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1079:12: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1083:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1085:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1130:11: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1318:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1372:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1382:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1383:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1400:5: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1401:5: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1408:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1409:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1410:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1411:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1416:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1417:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1422:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1423:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1428:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1429:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1434:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1435:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1436:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1437:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1438:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1439:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1440:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1441:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1442:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1448:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1449:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1450:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1451:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1455:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1456:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1460:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1461:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1466:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1467:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1472:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1473:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1477:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1478:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1479:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1480:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1481:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1482:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1483:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1484:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1495:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1496:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1497:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1501:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1502:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1506:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1507:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1512:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1513:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1518:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1519:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1525:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1526:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1527:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1528:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1529:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1530:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1531:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1532:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1533:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1535:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1536:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1537:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1538:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1539:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1540:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1541:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1542:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1543:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1544:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1546:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1546:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1549:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1550:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/riva_hw.c:1552:13: sparse: sparse: too many warnings
--
>> drivers/video/fbdev/riva/nv_driver.c:60:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:61:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:63:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:65:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:67:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:69:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:70:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:74:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:76:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:76:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:79:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:80:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:139:29: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:145:28: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:166:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:167:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:168:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:172:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:190:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:204:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:205:36: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:208:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:240:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:280:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:281:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:282:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/fbdev/riva/nv_driver.c:301:26: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:153:15: sparse: sparse: cast removes address space '__iomem' of expression
--
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:219:30: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *[assigned] addr @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     expected void *[assigned] addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:221:30: sparse:     got void [noderef] __iomem *
>> drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:241:25: sparse:     got void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:40: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:256:49: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:28: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void const volatile [noderef] __iomem *src @@     got void *[assigned] src @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:28: sparse:     expected void const volatile [noderef] __iomem *src
   drivers/gpu/drm/ttm/ttm_bo_util.c:275:28: sparse:     got void *[assigned] src
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *dst @@     got void *[assigned] dst @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:21: sparse:     expected void volatile [noderef] __iomem *dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:297:21: sparse:     got void *[assigned] dst
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:27: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void *[addressable] new_iomap @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:27: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:344:27: sparse:     got void *[addressable] new_iomap
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:516:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *virtual @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     expected void *virtual
   drivers/gpu/drm/ttm/ttm_bo_util.c:519:38: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *virtual @@
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/ttm/ttm_bo_util.c:608:28: sparse:     got void *virtual
--
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/radeon/radeon_ttm.c:979:21: sparse:     got unsigned int [usertype] *
   arch/m68k/include/asm/io_no.h:94:17: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:94:17: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:96:17: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int volatile @@     got restricted __le32 [usertype] @@
   arch/m68k/include/asm/io_no.h:96:17: sparse:     expected unsigned int volatile
   arch/m68k/include/asm/io_no.h:96:17: sparse:     got restricted __le32 [usertype]
   arch/m68k/include/asm/io_no.h:77:24: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast removes address space '__iomem' of expression
   arch/m68k/include/asm/io_no.h:78:16: sparse: sparse: cast to restricted __le32
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:819:42: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:1094:5: sparse: sparse: symbol 'amdgpu_ttm_gart_bind' was not declared. Should it be static?
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     expected void const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ttm.c:2353:21: sparse: sparse: cast removes address space '__user' of expression
--
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:384:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_ring.c:399:21: sparse:     got unsigned int [usertype] *
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
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:257:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
>> drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     expected void const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:259:29: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:346:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     expected void const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:400:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:457:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     expected void const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:511:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     expected void const [noderef] __user *__pu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:568:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__gu_ptr @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     expected void const [noderef] __user *__gu_ptr
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:622:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __user * @@     got unsigned int [usertype] * @@
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse:     expected void const volatile [noderef] __user *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse:     got unsigned int [usertype] *
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: cast removes address space '__user' of expression
   drivers/gpu/drm/amd/amdgpu/amdgpu_debugfs.c:719:21: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected void const [noderef] __user *__pu_ptr @@     got unsigned int [usertype] * @@
--
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:104:58: sparse:     got void *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got void * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:110:58: sparse:     got void *
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[assigned] emap @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:157:25: sparse:     got void *[assigned] emap
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void *map @@     got void [noderef] __iomem * @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     expected void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:174:19: sparse:     got void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:225:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse: sparse: incorrect type in return expression (different address spaces) @@     expected void [noderef] __iomem * @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     expected void [noderef] __iomem *
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:233:28: sparse:     got void *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *map @@     got void *map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     expected void [noderef] __iomem *map
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:240:21: sparse:     got void *map
>> drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem *addr @@     got void *[assigned] map @@
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     expected void [noderef] __iomem *addr
   drivers/gpu/drm/nouveau/nvkm/subdev/instmem/nv50.c:327:25: sparse:     got void *[assigned] map

vim +/__iomem +788 drivers/video/fbdev/riva/fbdev.c

^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  661  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  662  /**
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  663   * riva_load_video_mode - calculate timings
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  664   * @info: pointer to fb_info object containing info for current riva board
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  665   *
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  666   * DESCRIPTION:
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  667   * Calculate some timings and then send em off to riva_load_state().
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  668   *
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  669   * CALLED FROM:
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  670   * rivafb_set_par()
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  671   */
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  672  static int riva_load_video_mode(struct fb_info *info)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  673  {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  674  	int bpp, width, hDisplaySize, hDisplay, hStart,
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  675  	    hEnd, hTotal, height, vDisplay, vStart, vEnd, vTotal, dotClock;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  676  	int hBlankStart, hBlankEnd, vBlankStart, vBlankEnd;
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  677  	int rc;
f4a41836f1215a drivers/video/riva/fbdev.c       Antonino A. Daplas 2006-01-09  678  	struct riva_par *par = info->par;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  679  	struct riva_regs newmode;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  680  	
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  681  	NVTRACE_ENTER();
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  682  	/* time to calculate */
535a09ad59286b drivers/video/riva/fbdev.c       Guido Guenther     2006-10-03  683  	rivafb_blank(FB_BLANK_NORMAL, info);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  684  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  685  	bpp = info->var.bits_per_pixel;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  686  	if (bpp == 16 && info->var.green.length == 5)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  687  		bpp = 15;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  688  	width = info->var.xres_virtual;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  689  	hDisplaySize = info->var.xres;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  690  	hDisplay = (hDisplaySize / 8) - 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  691  	hStart = (hDisplaySize + info->var.right_margin) / 8 - 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  692  	hEnd = (hDisplaySize + info->var.right_margin +
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  693  		info->var.hsync_len) / 8 - 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  694  	hTotal = (hDisplaySize + info->var.right_margin +
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  695  		  info->var.hsync_len + info->var.left_margin) / 8 - 5;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  696  	hBlankStart = hDisplay;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  697  	hBlankEnd = hTotal + 4;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  698  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  699  	height = info->var.yres_virtual;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  700  	vDisplay = info->var.yres - 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  701  	vStart = info->var.yres + info->var.lower_margin - 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  702  	vEnd = info->var.yres + info->var.lower_margin +
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  703  	       info->var.vsync_len - 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  704  	vTotal = info->var.yres + info->var.lower_margin +
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  705  		 info->var.vsync_len + info->var.upper_margin + 2;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  706  	vBlankStart = vDisplay;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  707  	vBlankEnd = vTotal + 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  708  	dotClock = 1000000000 / info->var.pixclock;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  709  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  710  	memcpy(&newmode, &reg_template, sizeof(struct riva_regs));
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  711  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  712  	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  713  		vTotal |= 1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  714  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  715  	if (par->FlatPanel) {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  716  		vStart = vTotal - 3;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  717  		vEnd = vTotal - 2;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  718  		vBlankStart = vStart;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  719  		hStart = hTotal - 3;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  720  		hEnd = hTotal - 2;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  721  		hBlankEnd = hTotal + 4;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  722  	}
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  723  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  724  	newmode.crtc[0x0] = Set8Bits (hTotal); 
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  725  	newmode.crtc[0x1] = Set8Bits (hDisplay);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  726  	newmode.crtc[0x2] = Set8Bits (hBlankStart);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  727  	newmode.crtc[0x3] = SetBitField (hBlankEnd, 4: 0, 4:0) | SetBit (7);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  728  	newmode.crtc[0x4] = Set8Bits (hStart);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  729  	newmode.crtc[0x5] = SetBitField (hBlankEnd, 5: 5, 7:7)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  730  		| SetBitField (hEnd, 4: 0, 4:0);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  731  	newmode.crtc[0x6] = SetBitField (vTotal, 7: 0, 7:0);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  732  	newmode.crtc[0x7] = SetBitField (vTotal, 8: 8, 0:0)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  733  		| SetBitField (vDisplay, 8: 8, 1:1)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  734  		| SetBitField (vStart, 8: 8, 2:2)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  735  		| SetBitField (vBlankStart, 8: 8, 3:3)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  736  		| SetBit (4)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  737  		| SetBitField (vTotal, 9: 9, 5:5)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  738  		| SetBitField (vDisplay, 9: 9, 6:6)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  739  		| SetBitField (vStart, 9: 9, 7:7);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  740  	newmode.crtc[0x9] = SetBitField (vBlankStart, 9: 9, 5:5)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  741  		| SetBit (6);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  742  	newmode.crtc[0x10] = Set8Bits (vStart);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  743  	newmode.crtc[0x11] = SetBitField (vEnd, 3: 0, 3:0)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  744  		| SetBit (5);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  745  	newmode.crtc[0x12] = Set8Bits (vDisplay);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  746  	newmode.crtc[0x13] = (width / 8) * ((bpp + 1) / 8);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  747  	newmode.crtc[0x15] = Set8Bits (vBlankStart);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  748  	newmode.crtc[0x16] = Set8Bits (vBlankEnd);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  749  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  750  	newmode.ext.screen = SetBitField(hBlankEnd,6:6,4:4)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  751  		| SetBitField(vBlankStart,10:10,3:3)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  752  		| SetBitField(vStart,10:10,2:2)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  753  		| SetBitField(vDisplay,10:10,1:1)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  754  		| SetBitField(vTotal,10:10,0:0);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  755  	newmode.ext.horiz  = SetBitField(hTotal,8:8,0:0) 
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  756  		| SetBitField(hDisplay,8:8,1:1)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  757  		| SetBitField(hBlankStart,8:8,2:2)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  758  		| SetBitField(hStart,8:8,3:3);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  759  	newmode.ext.extra  = SetBitField(vTotal,11:11,0:0)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  760  		| SetBitField(vDisplay,11:11,2:2)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  761  		| SetBitField(vStart,11:11,4:4)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  762  		| SetBitField(vBlankStart,11:11,6:6); 
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  763  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  764  	if ((info->var.vmode & FB_VMODE_MASK) == FB_VMODE_INTERLACED) {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  765  		int tmp = (hTotal >> 1) & ~1;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  766  		newmode.ext.interlace = Set8Bits(tmp);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  767  		newmode.ext.horiz |= SetBitField(tmp, 8:8,4:4);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  768  	} else 
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  769  		newmode.ext.interlace = 0xff; /* interlace off */
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  770  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  771  	if (par->riva.Architecture >= NV_ARCH_10)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  772  		par->riva.CURSOR = (U032 __iomem *)(info->screen_base + par->riva.CursorStart);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  773  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  774  	if (info->var.sync & FB_SYNC_HOR_HIGH_ACT)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  775  		newmode.misc_output &= ~0x40;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  776  	else
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  777  		newmode.misc_output |= 0x40;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  778  	if (info->var.sync & FB_SYNC_VERT_HIGH_ACT)
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  779  		newmode.misc_output &= ~0x80;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  780  	else
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  781  		newmode.misc_output |= 0x80;	
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  782  
e2281080835434 drivers/video/fbdev/riva/fbdev.c Sinan Kaya         2017-12-19  783  	rc = CalcStateExt(&par->riva, &newmode.ext, par->pdev, bpp, width,
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  784  			  hDisplaySize, height, dotClock);
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  785  	if (rc)
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  786  		goto out;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  787  
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16 @788  	newmode.ext.scale = NV_RD32(par->riva.PRAMDAC, 0x00000848) &
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  789  		0xfff000ff;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  790  	if (par->FlatPanel == 1) {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  791  		newmode.ext.pixel |= (1 << 7);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  792  		newmode.ext.scale |= (1 << 8);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  793  	}
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  794  	if (par->SecondCRTC) {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  795  		newmode.ext.head  = NV_RD32(par->riva.PCRTC0, 0x00000860) &
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  796  			~0x00001000;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  797  		newmode.ext.head2 = NV_RD32(par->riva.PCRTC0, 0x00002860) |
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  798  			0x00001000;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  799  		newmode.ext.crtcOwner = 3;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  800  		newmode.ext.pllsel |= 0x20000800;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  801  		newmode.ext.vpll2 = newmode.ext.vpll;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  802  	} else if (par->riva.twoHeads) {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  803  		newmode.ext.head  =  NV_RD32(par->riva.PCRTC0, 0x00000860) |
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  804  			0x00001000;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  805  		newmode.ext.head2 =  NV_RD32(par->riva.PCRTC0, 0x00002860) &
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  806  			~0x00001000;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  807  		newmode.ext.crtcOwner = 0;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  808  		newmode.ext.vpll2 = NV_RD32(par->riva.PRAMDAC0, 0x00000520);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  809  	}
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  810  	if (par->FlatPanel == 1) {
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  811  		newmode.ext.pixel |= (1 << 7);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  812  		newmode.ext.scale |= (1 << 8);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  813  	}
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  814  	newmode.ext.cursorConfig = 0x02000100;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  815  	par->current_state = newmode;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  816  	riva_load_state(par, &par->current_state);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  817  	par->riva.LockUnlock(&par->riva, 0); /* important for HW cursor */
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  818  
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  819  out:
535a09ad59286b drivers/video/riva/fbdev.c       Guido Guenther     2006-10-03  820  	rivafb_blank(FB_BLANK_UNBLANK, info);
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  821  	NVTRACE_LEAVE();
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  822  
fd717689f46436 drivers/video/riva/fbdev.c       Jeff Garzik        2006-12-08  823  	return rc;
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  824  }
^1da177e4c3f41 drivers/video/riva/fbdev.c       Linus Torvalds     2005-04-16  825  

:::::: The code at line 788 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--/04w6evG8XlLl3ft
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
AQA=

--/04w6evG8XlLl3ft--
