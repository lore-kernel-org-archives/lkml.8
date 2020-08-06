Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B19C47438
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C52C123109
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 11:05:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728903AbgHFIXn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Aug 2020 04:23:43 -0400
Received: from mga12.intel.com ([192.55.52.136]:27899 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728489AbgHFIXm (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Aug 2020 04:23:42 -0400
IronPort-SDR: 7//40icR+mrEahl9TQ67XKKgWtLDsUe7dXCrrg95g9jN9pqSpms0gsp6hR6qSo7iNydVLilL8M
 /2apRgnVGzfw==
X-IronPort-AV: E=McAfee;i="6000,8403,9704"; a="132301653"
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="gz'50?scan'50,208,50";a="132301653"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Aug 2020 01:10:25 -0700
IronPort-SDR: uxWWAk3f2tjT9hDd63O3Q+52pVNMOPFehxwZPK7qVFFAR7lIfZtrkC0S7EahzRMxeBEUHEYR8i
 Di+UzWoSkTzQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,441,1589266800"; 
   d="gz'50?scan'50,208,50";a="293228788"
Received: from lkp-server02.sh.intel.com (HELO 37a337f97289) ([10.239.97.151])
  by orsmga006.jf.intel.com with ESMTP; 06 Aug 2020 01:10:23 -0700
Received: from kbuild by 37a337f97289 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k3ayk-0001BW-II; Thu, 06 Aug 2020 08:10:22 +0000
Date:   Thu, 6 Aug 2020 16:09:18 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/staging/comedi/drivers/pcl730.c:223:25: sparse: sparse: cast
 removes address space '__iomem' of expression
Message-ID: <202008061605.KjkZGRp7%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="5vNYLRcllDrimb99"
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--5vNYLRcllDrimb99
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   47ec5303d73ea344e84f46660fff693c57641386
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   7 weeks ago
config: riscv-randconfig-s031-20200806 (attached as .config)
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

>> drivers/staging/comedi/drivers/pcl730.c:223:25: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl730.c:223:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl730.c:223:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:223:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:225:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:227:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:229:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:243:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcl730.c:243:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcl730.c:243:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:243:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:245:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:247:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcl730.c:249:25: sparse:     got void *
--
>> drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/c6xdigio.c:54:26: sparse:     got void *
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/c6xdigio.c:77:15: sparse:     got void *
   drivers/staging/comedi/drivers/c6xdigio.c: note: in included file (through arch/riscv/include/asm/io.h, include/linux/io.h, include/linux/irq.h, ...):
   include/asm-generic/io.h:580:9: sparse: sparse: cast removes address space '__iomem' of expression
   include/asm-generic/io.h:580:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   include/asm-generic/io.h:580:9: sparse:     expected void volatile [noderef] __iomem *addr
   include/asm-generic/io.h:580:9: sparse:     got void *
--
>> drivers/staging/comedi/drivers/ni_atmio16d.c:153:9: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_atmio16d.c:153:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_atmio16d.c:153:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:153:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:154:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:154:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:154:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:154:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:155:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:155:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:155:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:155:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:156:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:156:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:156:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:156:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:157:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:157:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:157:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:157:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:158:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:158:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:158:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:158:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:159:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:159:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:159:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:159:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:161:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:161:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:161:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:161:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:162:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:162:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:162:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:162:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:163:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:163:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:163:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:163:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:164:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:164:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:164:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:164:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:165:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:165:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:165:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:165:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:166:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:166:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:166:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:166:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:167:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:167:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:167:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:167:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:169:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:169:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:169:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:169:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:170:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:170:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:170:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:170:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:171:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:171:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:171:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:171:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:172:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:172:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:172:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:172:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:173:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:173:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:173:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:173:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:174:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:174:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:174:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:174:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:175:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:175:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:175:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:175:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:177:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:177:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:177:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:177:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:178:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:178:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:178:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:178:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:179:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:179:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:179:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:179:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:180:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:180:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:180:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:180:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:181:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:181:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:181:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:181:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:182:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:182:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:182:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:182:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:183:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:183:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:183:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:183:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:185:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:185:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:185:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:185:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:194:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:194:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:194:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:194:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:195:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:195:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:195:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:195:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:196:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:196:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:196:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:196:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:198:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:198:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:198:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:198:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:199:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:199:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:199:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:199:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:200:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:200:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:200:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:200:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:201:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:201:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:201:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:201:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:203:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:203:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:203:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:203:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:204:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:204:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:204:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:204:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:205:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:205:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:205:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:205:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:206:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:206:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:206:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:206:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:208:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:208:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:208:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:208:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:210:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:210:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:210:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:210:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:211:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:211:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:211:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:211:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:214:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:214:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:214:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:214:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:217:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:217:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:217:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:217:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:218:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:218:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:218:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:218:9: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:227:15: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/ni_atmio16d.c:227:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/ni_atmio16d.c:227:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:227:15: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:305:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:305:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:305:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:305:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:309:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:309:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/ni_atmio16d.c:309:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/ni_atmio16d.c:309:17: sparse:     got void *
   drivers/staging/comedi/drivers/ni_atmio16d.c:310:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/ni_atmio16d.c:310:17: sparse: sparse: too many warnings
--
>> drivers/staging/comedi/drivers/pcmmio.c:195:17: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmmio.c:195:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmmio.c:195:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:195:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:196:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:196:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:196:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:196:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:197:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:197:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:197:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:197:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:199:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:199:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:199:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:199:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:200:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:200:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:200:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:200:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:201:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:201:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:201:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:201:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:202:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:202:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:202:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:202:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:218:23: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/staging/comedi/drivers/pcmmio.c:218:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/staging/comedi/drivers/pcmmio.c:218:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:218:23: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:219:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:219:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:219:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:219:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:220:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:220:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:220:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:220:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:222:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:222:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:222:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:222:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:223:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:223:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:223:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:223:23: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:224:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:224:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:224:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:224:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:225:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:225:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:225:25: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:225:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:367:20: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:367:20: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:367:20: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:367:20: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:524:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:524:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:524:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:524:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:571:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:571:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:571:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:571:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:577:15: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:577:15: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:577:15: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:577:15: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:578:16: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:578:16: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:578:16: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:578:16: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:581:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:581:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:581:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:581:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:587:23: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:587:23: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:587:23: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:587:23: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:588:24: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:588:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:588:24: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:588:24: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:607:18: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:607:18: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:607:18: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:607:18: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:638:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:638:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:638:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:638:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:639:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:639:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:639:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:639:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:640:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:640:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:640:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:640:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:650:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:650:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:650:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:650:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:651:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:651:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:651:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:651:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:652:17: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:652:17: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:652:17: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:652:17: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:691:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:691:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:691:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:691:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:693:25: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:693:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:693:25: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:693:25: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:712:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:712:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:712:9: sparse:     expected void volatile [noderef] __iomem *addr
   drivers/staging/comedi/drivers/pcmmio.c:712:9: sparse:     got void *
   drivers/staging/comedi/drivers/pcmmio.c:714:9: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/staging/comedi/drivers/pcmmio.c:714:9: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got void * @@
   drivers/staging/comedi/drivers/pcmmio.c:714:9: sparse:     expected void volatile [noderef] __iomem *addr

vim +/__iomem +223 drivers/staging/comedi/drivers/pcl730.c

a32b885ebe456d H Hartley Sweeten 2013-06-05  211  
d015d96103afd9 H Hartley Sweeten 2013-06-05  212  static int pcl730_do_insn_bits(struct comedi_device *dev,
d015d96103afd9 H Hartley Sweeten 2013-06-05  213  			       struct comedi_subdevice *s,
d015d96103afd9 H Hartley Sweeten 2013-06-05  214  			       struct comedi_insn *insn,
d015d96103afd9 H Hartley Sweeten 2013-06-05  215  			       unsigned int *data)
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  216  {
d015d96103afd9 H Hartley Sweeten 2013-06-05  217  	unsigned long reg = (unsigned long)s->private;
b3ff824a81e897 H Hartley Sweeten 2013-08-30  218  	unsigned int mask;
d015d96103afd9 H Hartley Sweeten 2013-06-05  219  
b3ff824a81e897 H Hartley Sweeten 2013-08-30  220  	mask = comedi_dio_update_state(s, data);
d015d96103afd9 H Hartley Sweeten 2013-06-05  221  	if (mask) {
d015d96103afd9 H Hartley Sweeten 2013-06-05  222  		if (mask & 0x00ff)
d015d96103afd9 H Hartley Sweeten 2013-06-05 @223  			outb(s->state & 0xff, dev->iobase + reg);
9382c06e2d192a Dan Carpenter     2013-11-07  224  		if ((mask & 0xff00) && (s->n_chan > 8))
d015d96103afd9 H Hartley Sweeten 2013-06-05  225  			outb((s->state >> 8) & 0xff, dev->iobase + reg + 1);
9382c06e2d192a Dan Carpenter     2013-11-07  226  		if ((mask & 0xff0000) && (s->n_chan > 16))
85a17285745cf4 H Hartley Sweeten 2013-06-06 @227  			outb((s->state >> 16) & 0xff, dev->iobase + reg + 2);
9382c06e2d192a Dan Carpenter     2013-11-07  228  		if ((mask & 0xff000000) && (s->n_chan > 24))
85a17285745cf4 H Hartley Sweeten 2013-06-06  229  			outb((s->state >> 24) & 0xff, dev->iobase + reg + 3);
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  230  	}
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  231  
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  232  	data[1] = s->state;
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  233  
a2714e3e42e746 H Hartley Sweeten 2012-06-18  234  	return insn->n;
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  235  }
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  236  
82e71174ae2a67 H Hartley Sweeten 2013-06-06  237  static unsigned int pcl730_get_bits(struct comedi_device *dev,
82e71174ae2a67 H Hartley Sweeten 2013-06-06  238  				    struct comedi_subdevice *s)
96a2d5f0a1e8ef José Luis Sánchez 2009-02-19  239  {
74f14a58b95cbc H Hartley Sweeten 2013-06-05  240  	unsigned long reg = (unsigned long)s->private;
145ff35bab0c64 H Hartley Sweeten 2013-06-06  241  	unsigned int val;
145ff35bab0c64 H Hartley Sweeten 2013-06-06  242  
145ff35bab0c64 H Hartley Sweeten 2013-06-06 @243  	val = inb(dev->iobase + reg);
145ff35bab0c64 H Hartley Sweeten 2013-06-06  244  	if (s->n_chan > 8)
145ff35bab0c64 H Hartley Sweeten 2013-06-06  245  		val |= (inb(dev->iobase + reg + 1) << 8);
82e71174ae2a67 H Hartley Sweeten 2013-06-06  246  	if (s->n_chan > 16)
82e71174ae2a67 H Hartley Sweeten 2013-06-06  247  		val |= (inb(dev->iobase + reg + 2) << 16);
82e71174ae2a67 H Hartley Sweeten 2013-06-06  248  	if (s->n_chan > 24)
82e71174ae2a67 H Hartley Sweeten 2013-06-06  249  		val |= (inb(dev->iobase + reg + 3) << 24);
82e71174ae2a67 H Hartley Sweeten 2013-06-06  250  
82e71174ae2a67 H Hartley Sweeten 2013-06-06  251  	return val;
82e71174ae2a67 H Hartley Sweeten 2013-06-06  252  }
74f14a58b95cbc H Hartley Sweeten 2013-06-05  253  

:::::: The code at line 223 was first introduced by commit
:::::: d015d96103afd9e2e7617e92a49a635dd8ee2a37 staging: comedi: pcl730: tidy up pcl730_do_insn()

:::::: TO: H Hartley Sweeten <hsweeten@visionengravers.com>
:::::: CC: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--5vNYLRcllDrimb99
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--5vNYLRcllDrimb99--
