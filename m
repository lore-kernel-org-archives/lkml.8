Return-Path: <SRS0=yO2T=B2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2AD76C433E1
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:17:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E345F207D3
	for <linux-kernel@archiver.kernel.org>; Sun, 16 Aug 2020 11:17:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728727AbgHPLQq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 16 Aug 2020 07:16:46 -0400
Received: from mga03.intel.com ([134.134.136.65]:49079 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728517AbgHPLLu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 16 Aug 2020 07:11:50 -0400
IronPort-SDR: ZS579R7XczpUcX43e4ifMXe4ZhqewjJvFub+e5tEaoB2M+iMXdoB7k7Q0TOrVDR/pmXwqroKRX
 efIq71Wp2M1A==
X-IronPort-AV: E=McAfee;i="6000,8403,9714"; a="154554850"
X-IronPort-AV: E=Sophos;i="5.76,320,1592895600"; 
   d="gz'50?scan'50,208,50";a="154554850"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Aug 2020 04:04:32 -0700
IronPort-SDR: Ad2xselRMxYS4WdlTtZSMaXkSHGIOdTW7QOGDsHDTyDKXHIYN01BLrYw5YGcDu8DVF6Cs5L2YB
 Ayxsy2BI/Fyw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,320,1592895600"; 
   d="gz'50?scan'50,208,50";a="496184916"
Received: from lkp-server02.sh.intel.com (HELO 2f0d8b563e65) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 16 Aug 2020 04:04:28 -0700
Received: from kbuild by 2f0d8b563e65 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k7GSh-00003z-E0; Sun, 16 Aug 2020 11:04:27 +0000
Date:   Sun, 16 Aug 2020 19:03:49 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/video/console/vgacon.c:158:9: sparse: sparse: cast removes
 address space '__iomem' of expression
Message-ID: <202008161942.3q5giJ0k%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="mP3DRpeJDSE+ciuQ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--mP3DRpeJDSE+ciuQ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   4b6c093e21d36bede0fd88fd0aeb3b03647260e4
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: riscv-randconfig-s031-20200816 (attached as .config)
compiler: riscv32-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-180-g49f7e13a-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=riscv 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

>> drivers/video/console/vgacon.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/console/vgacon.c:158:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:158:9: sparse:     got void *
   drivers/video/console/vgacon.c:159:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/console/vgacon.c:159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/console/vgacon.c:159:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:159:9: sparse:     got void *
   drivers/video/console/vgacon.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/video/vga.h):
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
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/console/vgacon.c:158:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:158:9: sparse:     got void *
   drivers/video/console/vgacon.c:159:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/console/vgacon.c:159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/console/vgacon.c:159:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:159:9: sparse:     got void *
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
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/console/vgacon.c:158:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:158:9: sparse:     got void *
   drivers/video/console/vgacon.c:159:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/console/vgacon.c:159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/console/vgacon.c:159:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:159:9: sparse:     got void *
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/video/console/vgacon.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/video/console/vgacon.c:158:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:158:9: sparse:     got void *
   drivers/video/console/vgacon.c:159:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/video/console/vgacon.c:159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/video/console/vgacon.c:159:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/video/console/vgacon.c:159:9: sparse:     got void *
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
--
>> drivers/staging/comedi/drivers/dt282x.c:448:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt282x.c:448:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt282x.c:448:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:448:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:468:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:508:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt282x.c:508:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt282x.c:508:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:508:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:509:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:510:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:544:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:550:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:555:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:565:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:599:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:603:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:611:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:619:23: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:699:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:706:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:721:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:729:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:731:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:739:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:743:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:757:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:760:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:786:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:788:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:790:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:869:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt282x.c:887:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt282x.c:899:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt282x.c:899:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt282x.c:899:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/multiq3.c:77:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/multiq3.c:77:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/multiq3.c:77:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:77:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:88:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/multiq3.c:88:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/multiq3.c:88:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:88:18: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:112:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:120:23: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:121:24: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:144:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:156:19: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:167:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:189:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:192:17: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:195:23: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:196:25: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:197:25: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:224:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:225:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:226:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:227:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:228:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:229:9: sparse:     got void *
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/multiq3.c:230:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/dt2815.c:65:18: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2815.c:65:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2815.c:65:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:65:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt2815.c:103:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2815.c:103:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2815.c:103:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:103:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2815.c:109:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2815.c:109:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2815.c:109:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:109:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2815.c:180:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2815.c:180:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2815.c:180:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:180:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2815.c:186:26: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2815.c:186:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2815.c:186:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:186:26: sparse:     got void *
   drivers/staging/comedi/drivers/dt2815.c:191:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2815.c:191:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2815.c:191:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:191:25: sparse:     got void *
   drivers/staging/comedi/drivers/dt2815.c:200:33: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2815.c:200:33: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2815.c:200:33: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2815.c:200:33: sparse:     got void *
--
>> drivers/staging/comedi/drivers/s526.c:179:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/s526.c:179:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/s526.c:179:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:179:9: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:180:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:180:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:180:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:180:9: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:189:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/s526.c:189:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/s526.c:189:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:189:15: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:190:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:190:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:190:17: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:190:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:235:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:235:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:235:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:235:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:241:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:241:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:241:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:241:25: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:314:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:314:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:314:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:314:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:324:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:324:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:324:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:324:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:332:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:332:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:332:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:332:25: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:351:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:351:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:351:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:351:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:361:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:361:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:361:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:361:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:369:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:369:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:369:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:369:25: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:388:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:388:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:388:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:388:9: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:423:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:423:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:423:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:423:18: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:426:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:426:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:426:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:426:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:457:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:457:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:457:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:457:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:465:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:465:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:465:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:465:23: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:483:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:483:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:483:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:483:9: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:488:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:488:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:488:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:488:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:489:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:489:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:489:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:489:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:507:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:507:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:507:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:507:17: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:509:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:509:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:509:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:509:19: sparse:     got void *
   drivers/staging/comedi/drivers/s526.c:545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/s526.c:545:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/s526.c:545:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/s526.c:545:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/pcl724.c:87:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl724.c:87:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl724.c:87:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl724.c:87:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl724.c:89:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcl724.c:92:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl724.c:92:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl724.c:92:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl724.c:92:16: sparse:     got void *
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
>> drivers/staging/comedi/drivers/das1800.c:355:16: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das1800.c:355:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das1800.c:355:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:355:16: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:356:24: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:416:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das1800.c:416:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das1800.c:416:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:416:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:432:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:433:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:434:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:453:31: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:456:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:469:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:479:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:528:18: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:536:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:816:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:817:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:826:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:830:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:911:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:914:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:916:17: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:920:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:921:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:922:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:934:18: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:952:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:954:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:955:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das1800.c:956:9: sparse:     got void *
   drivers/staging/comedi/drivers/das1800.c:964:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das1800.c:964:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das1800.c:964:9: sparse:     expected void volatile [noderef] __iomem *addr
--
>> drivers/staging/comedi/drivers/das6402.c:140:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das6402.c:140:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das6402.c:140:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:140:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:146:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:146:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:146:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:146:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:147:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:147:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:147:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:147:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:148:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:148:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:148:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:148:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:153:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:153:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:153:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:153:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:160:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:160:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:160:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:160:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:168:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/das6402.c:168:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/das6402.c:168:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:168:15: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:182:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:182:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:182:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:182:18: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:234:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:234:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:234:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:234:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:241:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:241:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:241:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:241:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:355:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:355:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:355:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:355:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:362:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:362:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:362:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:362:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:372:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:372:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:372:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:372:18: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:392:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:392:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:392:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:392:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:397:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:397:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:397:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:397:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:433:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:433:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:433:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:433:17: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:460:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:460:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:460:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:460:25: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:466:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:466:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:466:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:466:25: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:468:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:468:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:468:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:468:25: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:487:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:487:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:487:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:487:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:497:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:497:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:497:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:497:19: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:508:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:508:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:508:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:508:17: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:520:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:520:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:520:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:520:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:526:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:526:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:526:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:526:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:535:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:535:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:535:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:535:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:540:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:540:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:540:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:540:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:543:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:543:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:543:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:543:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:544:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:544:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:544:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:544:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:545:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:545:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:545:9: sparse:     got void *
   drivers/staging/comedi/drivers/das6402.c:548:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/das6402.c:548:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/das6402.c:548:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/das6402.c:548:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/dt2811.c:187:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2811.c:187:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2811.c:187:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:187:15: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:188:16: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:204:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:209:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/dt2811.c:209:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/dt2811.c:209:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:209:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:237:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:248:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:296:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:299:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:466:18: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:506:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:507:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:520:19: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:531:17: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:541:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:543:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:544:9: sparse:     got void *
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/dt2811.c:545:9: sparse:     got void *

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=670d0a4b10704667765f7d18f7592993d02783aa
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 670d0a4b10704667765f7d18f7592993d02783aa
vim +/__iomem +158 drivers/video/console/vgacon.c

^1da177e4c3f41 Linus Torvalds  2005-04-16  138  
^1da177e4c3f41 Linus Torvalds  2005-04-16  139  /*
^1da177e4c3f41 Linus Torvalds  2005-04-16  140   * By replacing the four outb_p with two back to back outw, we can reduce
^1da177e4c3f41 Linus Torvalds  2005-04-16  141   * the window of opportunity to see text mislocated to the RHS of the
^1da177e4c3f41 Linus Torvalds  2005-04-16  142   * console during heavy scrolling activity. However there is the remote
^1da177e4c3f41 Linus Torvalds  2005-04-16  143   * possibility that some pre-dinosaur hardware won't like the back to back
^1da177e4c3f41 Linus Torvalds  2005-04-16  144   * I/O. Since the Xservers get away with it, we should be able to as well.
^1da177e4c3f41 Linus Torvalds  2005-04-16  145   */
^1da177e4c3f41 Linus Torvalds  2005-04-16  146  static inline void write_vga(unsigned char reg, unsigned int val)
^1da177e4c3f41 Linus Torvalds  2005-04-16  147  {
^1da177e4c3f41 Linus Torvalds  2005-04-16  148  	unsigned int v1, v2;
^1da177e4c3f41 Linus Torvalds  2005-04-16  149  	unsigned long flags;
^1da177e4c3f41 Linus Torvalds  2005-04-16  150  
^1da177e4c3f41 Linus Torvalds  2005-04-16  151  	/*
^1da177e4c3f41 Linus Torvalds  2005-04-16  152  	 * ddprintk might set the console position from interrupt
^1da177e4c3f41 Linus Torvalds  2005-04-16  153  	 * handlers, thus the write has to be IRQ-atomic.
^1da177e4c3f41 Linus Torvalds  2005-04-16  154  	 */
6b2c1800f1d3a6 Thomas Gleixner 2009-07-25  155  	raw_spin_lock_irqsave(&vga_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  156  	v1 = reg + (val & 0xff00);
^1da177e4c3f41 Linus Torvalds  2005-04-16  157  	v2 = reg + 1 + ((val << 8) & 0xff00);
^1da177e4c3f41 Linus Torvalds  2005-04-16 @158  	outw(v1, vga_video_port_reg);
^1da177e4c3f41 Linus Torvalds  2005-04-16  159  	outw(v2, vga_video_port_reg);
6b2c1800f1d3a6 Thomas Gleixner 2009-07-25  160  	raw_spin_unlock_irqrestore(&vga_lock, flags);
^1da177e4c3f41 Linus Torvalds  2005-04-16  161  }
^1da177e4c3f41 Linus Torvalds  2005-04-16  162  

:::::: The code at line 158 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--mP3DRpeJDSE+ciuQ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--mP3DRpeJDSE+ciuQ--
