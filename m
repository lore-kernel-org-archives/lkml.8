Return-Path: <SRS0=iZCi=CS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.2 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27965C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A8C462177B
	for <linux-kernel@archiver.kernel.org>; Wed,  9 Sep 2020 01:09:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729048AbgIIBJZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 8 Sep 2020 21:09:25 -0400
Received: from mga05.intel.com ([192.55.52.43]:54258 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726002AbgIIBJY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Sep 2020 21:09:24 -0400
IronPort-SDR: CfK97WI6toZpUBzXIMf6MPmKAqX4DADEG2C23nJE/UWAJxxwqPRpN1gqWvG4xQBE7PL21OlrXX
 vycmBsGQb/iQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9738"; a="243067423"
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="gz'50?scan'50,208,50";a="243067423"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2020 18:09:17 -0700
IronPort-SDR: /rdqLLHjDHXZ9ug3SX/mBXrDyK6ykrZiT+0lYRE/NfSquo3vw+IZobdDPlR1mhxpkDYmlbxdjo
 FU5McuNCkT0g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,407,1592895600"; 
   d="gz'50?scan'50,208,50";a="336604818"
Received: from lkp-server01.sh.intel.com (HELO fc0154cbc871) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 08 Sep 2020 18:09:15 -0700
Received: from kbuild by fc0154cbc871 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1kFobq-0000IM-Eb; Wed, 09 Sep 2020 01:09:14 +0000
Date:   Wed, 9 Sep 2020 09:08:32 +0800
From:   kernel test robot <lkp@intel.com>
To:     Krzysztof Kozlowski <krzk@kernel.org>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Arnd Bergmann <arnd@arndb.de>
Subject: arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse:
 incorrect type in argument 1 (different address spaces)
Message-ID: <202009090927.pz8P9gCV%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="WIyZ46R2i8wDzkSu"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--WIyZ46R2i8wDzkSu
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   34d4ddd359dbcdf6c5fb3f85a179243d7a1cb7f8
commit: 8f28ca6bd8211214faf717677bbffe375c2a6072 iomap: constify ioreadX() iomem argument (as in generic implementation)
date:   4 weeks ago
config: powerpc64-randconfig-s032-20200909 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-191-g10164920-dirty
        git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   arch/powerpc/platforms/44x/ppc476.c:237:17: sparse: sparse: cast removes address space '__iomem' of expression
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned char [usertype] * @@
>> arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     expected void const [noderef] __iomem *
   arch/powerpc/platforms/44x/ppc476.c:242:34: sparse:     got unsigned char [usertype] *
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void volatile [noderef] __iomem *addr @@     got unsigned char [usertype] *[assigned] fpga @@
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     expected void volatile [noderef] __iomem *addr
   arch/powerpc/platforms/44x/ppc476.c:244:17: sparse:     got unsigned char [usertype] *[assigned] fpga
--
   drivers/dma/ppc4xx/adma.c:73:1: sparse: sparse: symbol 'ppc440spe_adma_chan_list' was not declared. Should it be static?
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:140:17: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:543:35: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] sg1l @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     expected unsigned int [usertype] sg1l
   drivers/dma/ppc4xx/adma.c:543:35: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:544:35: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:544:35: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:544:35: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:590:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:590:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:590:23: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:629:23: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:629:23: sparse:     expected unsigned int [usertype]
   drivers/dma/ppc4xx/adma.c:629:23: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:630:23: sparse: sparse: invalid assignment: |=
   drivers/dma/ppc4xx/adma.c:630:23: sparse:    left side has type unsigned int
   drivers/dma/ppc4xx/adma.c:630:23: sparse:    right side has type restricted __le32
   drivers/dma/ppc4xx/adma.c:655:34: sparse: sparse: incorrect type in assignment (different base types) @@     expected unsigned int [usertype] cnt @@     got restricted __le32 [usertype] @@
   drivers/dma/ppc4xx/adma.c:655:34: sparse:     expected unsigned int [usertype] cnt
   drivers/dma/ppc4xx/adma.c:655:34: sparse:     got restricted __le32 [usertype]
   drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:688:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:689:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:689:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:690:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:690:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:691:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:691:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:738:69: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:1187:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1188:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
>> drivers/dma/ppc4xx/adma.c:1188:34: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1190:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1191:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1138:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1147:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:911:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:912:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:974:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:979:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:985:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:986:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:999:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1038:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1039:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1053:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1055:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1062:41: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1064:39: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1065:25: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     expected void const [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1080:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1080:48: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1090:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1090:26: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1210:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1210:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1214:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1214:30: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:2777:62: sparse: sparse: Using plain integer as NULL pointer
   drivers/dma/ppc4xx/adma.c:4094:14: sparse: sparse: too many warnings

# https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8f28ca6bd8211214faf717677bbffe375c2a6072
git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
git fetch --no-tags linus master
git checkout 8f28ca6bd8211214faf717677bbffe375c2a6072
vim +242 arch/powerpc/platforms/44x/ppc476.c

228d55053397e6 arch/powerpc/platforms/44x/currituck.c Tony Breeds     2011-11-30  218  
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  219  static int board_rev = -1;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  220  static int __init ppc47x_get_board_rev(void)
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  221  {
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  222  	int reg;
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  223  	u8 *fpga;
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  224  	struct device_node *np = NULL;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  225  
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  226  	if (of_machine_is_compatible("ibm,currituck")) {
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  227  		np = of_find_compatible_node(NULL, NULL, "ibm,currituck-fpga");
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  228  		reg = 0;
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  229  	} else if (of_machine_is_compatible("ibm,akebono")) {
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  230  		np = of_find_compatible_node(NULL, NULL, "ibm,akebono-fpga");
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  231  		reg = 2;
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  232  	}
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  233  
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  234  	if (!np)
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  235  		goto fail;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  236  
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06  237  	fpga = (u8 *) of_iomap(np, 0);
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  238  	of_node_put(np);
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  239  	if (!fpga)
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  240  		goto fail;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  241  
2a2c74b2efcb1a arch/powerpc/platforms/44x/ppc476.c    Alistair Popple 2014-03-06 @242  	board_rev = ioread8(fpga + reg) & 0x03;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  243  	pr_info("%s: Found board revision %d\n", __func__, board_rev);
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  244  	iounmap(fpga);
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  245  	return 0;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  246  
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  247  fail:
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  248  	pr_info("%s: Unable to find board revision\n", __func__);
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  249  	return 0;
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  250  }
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  251  machine_arch_initcall(ppc47x, ppc47x_get_board_rev);
ab9a4183fddf23 arch/powerpc/platforms/44x/currituck.c Alistair Popple 2013-05-09  252  

:::::: The code at line 242 was first introduced by commit
:::::: 2a2c74b2efcb1a0ca3fdcb5fbb96ad8de6a29177 IBM Akebono: Add the Akebono platform

:::::: TO: Alistair Popple <alistair@popple.id.au>
:::::: CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--WIyZ46R2i8wDzkSu
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--WIyZ46R2i8wDzkSu--
