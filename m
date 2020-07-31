Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9082AC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:33:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5228920656
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 13:33:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733222AbgGaNdt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 09:33:49 -0400
Received: from mga01.intel.com ([192.55.52.88]:3996 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731417AbgGaNds (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 09:33:48 -0400
IronPort-SDR: PnVs1yLDmZTkzCM+Y/7vHV4pgwjOE0WpMdi9VySxJx2EivtOVbppORzthuyKuUuygRFiY1hXjY
 m4uu3MY5AQww==
X-IronPort-AV: E=McAfee;i="6000,8403,9698"; a="169883050"
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="gz'50?scan'50,208,50";a="169883050"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Jul 2020 06:18:34 -0700
IronPort-SDR: 4XrzszeOgELn9XI4opERmpTGMR6hztCFtcVQQ2oypyE/23OBB0VwBJ5AIthwy9H63Z4Ctn1e9P
 zb+bOeeQWINw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,418,1589266800"; 
   d="gz'50?scan'50,208,50";a="329241095"
Received: from lkp-server02.sh.intel.com (HELO d4d86dd808e0) ([10.239.97.151])
  by FMSMGA003.fm.intel.com with ESMTP; 31 Jul 2020 06:18:32 -0700
Received: from kbuild by d4d86dd808e0 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k1Uvg-0000YN-1m; Fri, 31 Jul 2020 13:18:32 +0000
Date:   Fri, 31 Jul 2020 21:18:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/char/pcmcia/cm4000_cs.c:312:23: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202007312101.XCe8XQSp%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="KsGdsel6WgEHnImy"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--KsGdsel6WgEHnImy
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   d8b9faec54ae4bc2fff68bcd0befa93ace8256ce
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   6 weeks ago
config: riscv-randconfig-s032-20200731 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-115-g5fc204f2-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/char/pcmcia/cm4000_cs.c:312:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/cm4000_cs.c:312:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/cm4000_cs.c:312:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:312:23: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:313:34: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:313:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:313:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:313:34: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:429:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/cm4000_cs.c:429:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/cm4000_cs.c:429:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:429:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:433:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:433:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:433:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:433:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:444:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:444:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:444:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:444:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:492:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:492:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:492:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:492:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:499:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:499:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:499:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:499:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:507:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:507:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:507:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:507:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:508:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:508:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:508:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:508:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:519:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:519:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:519:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:519:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:522:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:522:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:522:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:522:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:529:21: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:529:21: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:529:21: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:529:21: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:563:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:563:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:563:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:563:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:568:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:568:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:568:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:568:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:569:32: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:569:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:569:32: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:569:32: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:581:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:581:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:581:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:581:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:608:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:608:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:608:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:608:13: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:614:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:614:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:614:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:614:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:615:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:615:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:615:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:615:14: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:621:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:621:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:621:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:621:9: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:694:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:694:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:694:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:694:23: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:738:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:738:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:738:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:738:26: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:745:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:745:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:745:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:745:25: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:762:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:762:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:762:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:762:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:765:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:765:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:765:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:765:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:766:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:766:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:766:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:766:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:767:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:767:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:767:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4000_cs.c:767:17: sparse:     got void *
   drivers/char/pcmcia/cm4000_cs.c:770:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4000_cs.c:770:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4000_cs.c:770:17: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/char/pcmcia/synclink_cs.c:340:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/synclink_cs.c:340:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/synclink_cs.c:340:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:340:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:343:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:350:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:353:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3279:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3262:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3561:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3563:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3575:13: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3577:13: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3580:18: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3594:15: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3606:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3609:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3611:17: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3339:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3340:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3341:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3342:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3347:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3359:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3383:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/synclink_cs.c:3023:9: sparse:     got void *
   drivers/char/pcmcia/synclink_cs.c:3069:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/synclink_cs.c:3069:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/synclink_cs.c:3069:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/char/pcmcia/cm4040_cs.c:110:28: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/cm4040_cs.c:110:28: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/cm4040_cs.c:110:28: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:110:28: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:144:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4040_cs.c:144:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4040_cs.c:144:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:144:22: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:178:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/char/pcmcia/cm4040_cs.c:178:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/char/pcmcia/cm4040_cs.c:178:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:178:9: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:192:22: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4040_cs.c:192:22: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4040_cs.c:192:22: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:192:22: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:252:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4040_cs.c:252:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4040_cs.c:252:33: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:252:33: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:279:35: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4040_cs.c:279:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4040_cs.c:279:35: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:279:35: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:311:14: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4040_cs.c:311:14: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4040_cs.c:311:14: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:311:14: sparse:     got void *
   drivers/char/pcmcia/cm4040_cs.c:399:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/char/pcmcia/cm4040_cs.c:399:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/char/pcmcia/cm4040_cs.c:399:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/char/pcmcia/cm4040_cs.c:399:17: sparse:     got void *
--
>> drivers/rtc/rtc-bq4802.c:32:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-bq4802.c:32:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/rtc/rtc-bq4802.c:32:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/rtc/rtc-bq4802.c:32:16: sparse:     got void *
   drivers/rtc/rtc-bq4802.c:37:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/rtc/rtc-bq4802.c:37:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/rtc/rtc-bq4802.c:37:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/rtc/rtc-bq4802.c:37:9: sparse:     got void *

vim +/__iomem +312 drivers/char/pcmcia/cm4000_cs.c

c1986ee9bea3d8 Harald Welte      2005-11-13  303  
ecb8a8472f6d31 Olof Johansson    2008-02-04  304  static unsigned short io_read_num_rec_bytes(unsigned int iobase,
ecb8a8472f6d31 Olof Johansson    2008-02-04  305  					    unsigned short *s)
c1986ee9bea3d8 Harald Welte      2005-11-13  306  {
c1986ee9bea3d8 Harald Welte      2005-11-13  307  	unsigned short tmp;
c1986ee9bea3d8 Harald Welte      2005-11-13  308  
c1986ee9bea3d8 Harald Welte      2005-11-13  309  	tmp = *s = 0;
c1986ee9bea3d8 Harald Welte      2005-11-13  310  	do {
c1986ee9bea3d8 Harald Welte      2005-11-13  311  		*s = tmp;
c1986ee9bea3d8 Harald Welte      2005-11-13 @312  		tmp = inb(REG_NUM_BYTES(iobase)) |
c1986ee9bea3d8 Harald Welte      2005-11-13  313  				(inb(REG_FLAGS0(iobase)) & 4 ? 0x100 : 0);
c1986ee9bea3d8 Harald Welte      2005-11-13  314  	} while (tmp != *s);
c1986ee9bea3d8 Harald Welte      2005-11-13  315  
c1986ee9bea3d8 Harald Welte      2005-11-13  316  	return *s;
c1986ee9bea3d8 Harald Welte      2005-11-13  317  }
c1986ee9bea3d8 Harald Welte      2005-11-13  318  
c1986ee9bea3d8 Harald Welte      2005-11-13  319  static int parse_atr(struct cm4000_dev *dev)
c1986ee9bea3d8 Harald Welte      2005-11-13  320  {
c1986ee9bea3d8 Harald Welte      2005-11-13  321  	unsigned char any_t1, any_t0;
c1986ee9bea3d8 Harald Welte      2005-11-13  322  	unsigned char ch, ifno;
c1986ee9bea3d8 Harald Welte      2005-11-13  323  	int ix, done;
c1986ee9bea3d8 Harald Welte      2005-11-13  324  
c1986ee9bea3d8 Harald Welte      2005-11-13  325  	DEBUGP(3, dev, "-> parse_atr: dev->atr_len = %i\n", dev->atr_len);
c1986ee9bea3d8 Harald Welte      2005-11-13  326  
c1986ee9bea3d8 Harald Welte      2005-11-13  327  	if (dev->atr_len < 3) {
c1986ee9bea3d8 Harald Welte      2005-11-13  328  		DEBUGP(5, dev, "parse_atr: atr_len < 3\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  329  		return 0;
c1986ee9bea3d8 Harald Welte      2005-11-13  330  	}
c1986ee9bea3d8 Harald Welte      2005-11-13  331  
c1986ee9bea3d8 Harald Welte      2005-11-13  332  	if (dev->atr[0] == 0x3f)
c1986ee9bea3d8 Harald Welte      2005-11-13  333  		set_bit(IS_INVREV, &dev->flags);
c1986ee9bea3d8 Harald Welte      2005-11-13  334  	else
c1986ee9bea3d8 Harald Welte      2005-11-13  335  		clear_bit(IS_INVREV, &dev->flags);
c1986ee9bea3d8 Harald Welte      2005-11-13  336  	ix = 1;
c1986ee9bea3d8 Harald Welte      2005-11-13  337  	ifno = 1;
c1986ee9bea3d8 Harald Welte      2005-11-13  338  	ch = dev->atr[1];
c1986ee9bea3d8 Harald Welte      2005-11-13  339  	dev->proto = 0;		/* XXX PROTO */
c1986ee9bea3d8 Harald Welte      2005-11-13  340  	any_t1 = any_t0 = done = 0;
c1986ee9bea3d8 Harald Welte      2005-11-13  341  	dev->ta1 = 0x11;	/* defaults to 9600 baud */
c1986ee9bea3d8 Harald Welte      2005-11-13  342  	do {
c1986ee9bea3d8 Harald Welte      2005-11-13  343  		if (ifno == 1 && (ch & 0x10)) {
c1986ee9bea3d8 Harald Welte      2005-11-13  344  			/* read first interface byte and TA1 is present */
c1986ee9bea3d8 Harald Welte      2005-11-13  345  			dev->ta1 = dev->atr[2];
c1986ee9bea3d8 Harald Welte      2005-11-13  346  			DEBUGP(5, dev, "Card says FiDi is 0x%.2x\n", dev->ta1);
c1986ee9bea3d8 Harald Welte      2005-11-13  347  			ifno++;
c1986ee9bea3d8 Harald Welte      2005-11-13  348  		} else if ((ifno == 2) && (ch & 0x10)) { /* TA(2) */
c1986ee9bea3d8 Harald Welte      2005-11-13  349  			dev->ta1 = 0x11;
c1986ee9bea3d8 Harald Welte      2005-11-13  350  			ifno++;
c1986ee9bea3d8 Harald Welte      2005-11-13  351  		}
c1986ee9bea3d8 Harald Welte      2005-11-13  352  
c1986ee9bea3d8 Harald Welte      2005-11-13  353  		DEBUGP(5, dev, "Yi=%.2x\n", ch & 0xf0);
c1986ee9bea3d8 Harald Welte      2005-11-13  354  		ix += ((ch & 0x10) >> 4)	/* no of int.face chars */
c1986ee9bea3d8 Harald Welte      2005-11-13  355  		    +((ch & 0x20) >> 5)
c1986ee9bea3d8 Harald Welte      2005-11-13  356  		    + ((ch & 0x40) >> 6)
c1986ee9bea3d8 Harald Welte      2005-11-13  357  		    + ((ch & 0x80) >> 7);
c1986ee9bea3d8 Harald Welte      2005-11-13  358  		/* ATRLENCK(dev,ix); */
c1986ee9bea3d8 Harald Welte      2005-11-13  359  		if (ch & 0x80) {	/* TDi */
c1986ee9bea3d8 Harald Welte      2005-11-13  360  			ch = dev->atr[ix];
c1986ee9bea3d8 Harald Welte      2005-11-13  361  			if ((ch & 0x0f)) {
c1986ee9bea3d8 Harald Welte      2005-11-13  362  				any_t1 = 1;
c1986ee9bea3d8 Harald Welte      2005-11-13  363  				DEBUGP(5, dev, "card is capable of T=1\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  364  			} else {
c1986ee9bea3d8 Harald Welte      2005-11-13  365  				any_t0 = 1;
c1986ee9bea3d8 Harald Welte      2005-11-13  366  				DEBUGP(5, dev, "card is capable of T=0\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  367  			}
c1986ee9bea3d8 Harald Welte      2005-11-13  368  		} else
c1986ee9bea3d8 Harald Welte      2005-11-13  369  			done = 1;
c1986ee9bea3d8 Harald Welte      2005-11-13  370  	} while (!done);
c1986ee9bea3d8 Harald Welte      2005-11-13  371  
c1986ee9bea3d8 Harald Welte      2005-11-13  372  	DEBUGP(5, dev, "ix=%d noHist=%d any_t1=%d\n",
c1986ee9bea3d8 Harald Welte      2005-11-13  373  	      ix, dev->atr[1] & 15, any_t1);
c1986ee9bea3d8 Harald Welte      2005-11-13  374  	if (ix + 1 + (dev->atr[1] & 0x0f) + any_t1 != dev->atr_len) {
c1986ee9bea3d8 Harald Welte      2005-11-13  375  		DEBUGP(5, dev, "length error\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  376  		return 0;
c1986ee9bea3d8 Harald Welte      2005-11-13  377  	}
c1986ee9bea3d8 Harald Welte      2005-11-13  378  	if (any_t0)
c1986ee9bea3d8 Harald Welte      2005-11-13  379  		set_bit(IS_ANY_T0, &dev->flags);
c1986ee9bea3d8 Harald Welte      2005-11-13  380  
c1986ee9bea3d8 Harald Welte      2005-11-13  381  	if (any_t1) {		/* compute csum */
c1986ee9bea3d8 Harald Welte      2005-11-13  382  		dev->atr_csum = 0;
c1986ee9bea3d8 Harald Welte      2005-11-13  383  #ifdef ATR_CSUM
c1986ee9bea3d8 Harald Welte      2005-11-13  384  		for (i = 1; i < dev->atr_len; i++)
c1986ee9bea3d8 Harald Welte      2005-11-13  385  			dev->atr_csum ^= dev->atr[i];
c1986ee9bea3d8 Harald Welte      2005-11-13  386  		if (dev->atr_csum) {
c1986ee9bea3d8 Harald Welte      2005-11-13  387  			set_bit(IS_BAD_CSUM, &dev->flags);
c1986ee9bea3d8 Harald Welte      2005-11-13  388  			DEBUGP(5, dev, "bad checksum\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  389  			goto return_0;
c1986ee9bea3d8 Harald Welte      2005-11-13  390  		}
c1986ee9bea3d8 Harald Welte      2005-11-13  391  #endif
c1986ee9bea3d8 Harald Welte      2005-11-13  392  		if (any_t0 == 0)
c1986ee9bea3d8 Harald Welte      2005-11-13  393  			dev->proto = 1;	/* XXX PROTO */
c1986ee9bea3d8 Harald Welte      2005-11-13  394  		set_bit(IS_ANY_T1, &dev->flags);
c1986ee9bea3d8 Harald Welte      2005-11-13  395  	}
c1986ee9bea3d8 Harald Welte      2005-11-13  396  
c1986ee9bea3d8 Harald Welte      2005-11-13  397  	return 1;
c1986ee9bea3d8 Harald Welte      2005-11-13  398  }
c1986ee9bea3d8 Harald Welte      2005-11-13  399  
c1986ee9bea3d8 Harald Welte      2005-11-13  400  struct card_fixup {
c1986ee9bea3d8 Harald Welte      2005-11-13  401  	char atr[12];
c1986ee9bea3d8 Harald Welte      2005-11-13  402  	u_int8_t atr_len;
c1986ee9bea3d8 Harald Welte      2005-11-13  403  	u_int8_t stopbits;
c1986ee9bea3d8 Harald Welte      2005-11-13  404  };
c1986ee9bea3d8 Harald Welte      2005-11-13  405  
c1986ee9bea3d8 Harald Welte      2005-11-13  406  static struct card_fixup card_fixups[] = {
c1986ee9bea3d8 Harald Welte      2005-11-13  407  	{	/* ACOS */
c1986ee9bea3d8 Harald Welte      2005-11-13  408  		.atr = { 0x3b, 0xb3, 0x11, 0x00, 0x00, 0x41, 0x01 },
c1986ee9bea3d8 Harald Welte      2005-11-13  409  		.atr_len = 7,
c1986ee9bea3d8 Harald Welte      2005-11-13  410  		.stopbits = 0x03,
c1986ee9bea3d8 Harald Welte      2005-11-13  411  	},
c1986ee9bea3d8 Harald Welte      2005-11-13  412  	{	/* Motorola */
c1986ee9bea3d8 Harald Welte      2005-11-13  413  		.atr = {0x3b, 0x76, 0x13, 0x00, 0x00, 0x80, 0x62, 0x07,
c1986ee9bea3d8 Harald Welte      2005-11-13  414  			0x41, 0x81, 0x81 },
c1986ee9bea3d8 Harald Welte      2005-11-13  415  		.atr_len = 11,
c1986ee9bea3d8 Harald Welte      2005-11-13  416  		.stopbits = 0x04,
c1986ee9bea3d8 Harald Welte      2005-11-13  417  	},
c1986ee9bea3d8 Harald Welte      2005-11-13  418  };
c1986ee9bea3d8 Harald Welte      2005-11-13  419  
c1986ee9bea3d8 Harald Welte      2005-11-13  420  static void set_cardparameter(struct cm4000_dev *dev)
c1986ee9bea3d8 Harald Welte      2005-11-13  421  {
c1986ee9bea3d8 Harald Welte      2005-11-13  422  	int i;
9a017a910346af Dominik Brodowski 2010-07-24  423  	unsigned int iobase = dev->p_dev->resource[0]->start;
c1986ee9bea3d8 Harald Welte      2005-11-13  424  	u_int8_t stopbits = 0x02; /* ISO default */
c1986ee9bea3d8 Harald Welte      2005-11-13  425  
c1986ee9bea3d8 Harald Welte      2005-11-13  426  	DEBUGP(3, dev, "-> set_cardparameter\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  427  
c1986ee9bea3d8 Harald Welte      2005-11-13  428  	dev->flags1 = dev->flags1 | (((dev->baudv - 1) & 0x0100) >> 8);
c1986ee9bea3d8 Harald Welte      2005-11-13 @429  	xoutb(dev->flags1, REG_FLAGS1(iobase));
c1986ee9bea3d8 Harald Welte      2005-11-13  430  	DEBUGP(5, dev, "flags1 = 0x%02x\n", dev->flags1);
c1986ee9bea3d8 Harald Welte      2005-11-13  431  
c1986ee9bea3d8 Harald Welte      2005-11-13  432  	/* set baudrate */
c1986ee9bea3d8 Harald Welte      2005-11-13  433  	xoutb((unsigned char)((dev->baudv - 1) & 0xFF), REG_BAUDRATE(iobase));
c1986ee9bea3d8 Harald Welte      2005-11-13  434  
c1986ee9bea3d8 Harald Welte      2005-11-13  435  	DEBUGP(5, dev, "baudv = %i -> write 0x%02x\n", dev->baudv,
c1986ee9bea3d8 Harald Welte      2005-11-13  436  	      ((dev->baudv - 1) & 0xFF));
c1986ee9bea3d8 Harald Welte      2005-11-13  437  
c1986ee9bea3d8 Harald Welte      2005-11-13  438  	/* set stopbits */
c1986ee9bea3d8 Harald Welte      2005-11-13  439  	for (i = 0; i < ARRAY_SIZE(card_fixups); i++) {
c1986ee9bea3d8 Harald Welte      2005-11-13  440  		if (!memcmp(dev->atr, card_fixups[i].atr,
c1986ee9bea3d8 Harald Welte      2005-11-13  441  			    card_fixups[i].atr_len))
c1986ee9bea3d8 Harald Welte      2005-11-13  442  			stopbits = card_fixups[i].stopbits;
c1986ee9bea3d8 Harald Welte      2005-11-13  443  	}
c1986ee9bea3d8 Harald Welte      2005-11-13  444  	xoutb(stopbits, REG_STOPBITS(iobase));
c1986ee9bea3d8 Harald Welte      2005-11-13  445  
c1986ee9bea3d8 Harald Welte      2005-11-13  446  	DEBUGP(3, dev, "<- set_cardparameter\n");
c1986ee9bea3d8 Harald Welte      2005-11-13  447  }
c1986ee9bea3d8 Harald Welte      2005-11-13  448  

:::::: The code at line 312 was first introduced by commit
:::::: c1986ee9bea3d880bcf0d3f1a31e055778f306c7 [PATCH] New Omnikey Cardman 4000 driver

:::::: TO: Harald Welte <laforge@gnumonks.org>
:::::: CC: Linus Torvalds <torvalds@g5.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--KsGdsel6WgEHnImy
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
i8zxSlCXov8H+vp5HsK3AQA=

--KsGdsel6WgEHnImy--
