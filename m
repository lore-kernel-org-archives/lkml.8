Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3333C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:14:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9A76D20724
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 00:14:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728189AbgGFAON (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 20:14:13 -0400
Received: from mga11.intel.com ([192.55.52.93]:57730 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727970AbgGFAOM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 20:14:12 -0400
IronPort-SDR: y7zQBLLZjTL1oGWOx2pLxaq5zjAhCS+fcsWlzg851n9KrbKf1ihsFjHA+SdX+1sRRh/UYWH1G+
 SW4ZOhNTd3Wg==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="145450001"
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; 
   d="gz'50?scan'50,208,50";a="145450001"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 05 Jul 2020 16:19:29 -0700
IronPort-SDR: WD0U7WuYPdz2YzXyXETe055KwdJ9maHa3jq8zDOvg2rGrmS1b0xFrG1apDelEnd5or3XQzA5EI
 x/EHn3es3Imw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,317,1589266800"; 
   d="gz'50?scan'50,208,50";a="314985625"
Received: from lkp-server01.sh.intel.com (HELO 6dc8ab148a5d) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 05 Jul 2020 16:19:27 -0700
Received: from kbuild by 6dc8ab148a5d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsDuw-0001zk-JH; Sun, 05 Jul 2020 23:19:26 +0000
Date:   Mon, 6 Jul 2020 07:19:16 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: arch/powerpc/math-emu/math.c:237:13: sparse: sparse: incorrect type
 in initializer (different address spaces)
Message-ID: <202007060705.bEmx6y0Y%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="gKMricLos+KVdGMg"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--gKMricLos+KVdGMg
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   bb5a93aaf25261321db0c499cde7da6ee9d8b164
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   2 weeks ago
config: powerpc64-randconfig-s032-20200705 (attached as .config)
compiler: powerpc-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-3-gfa153962-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=powerpc64 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   arch/powerpc/math-emu/math.c:228:21: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/math-emu/math.c:228:31: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/math-emu/math.c:228:41: sparse: sparse: Using plain integer as NULL pointer
   arch/powerpc/math-emu/math.c:228:51: sparse: sparse: Using plain integer as NULL pointer
>> arch/powerpc/math-emu/math.c:237:13: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected unsigned int [noderef] __user *__gu_addr @@     got unsigned int [usertype] * @@
>> arch/powerpc/math-emu/math.c:237:13: sparse:     expected unsigned int [noderef] __user *__gu_addr
   arch/powerpc/math-emu/math.c:237:13: sparse:     got unsigned int [usertype] *
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
>> drivers/dma/ppc4xx/adma.c:688:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
>> drivers/dma/ppc4xx/adma.c:688:38: sparse:     expected void [noderef] __iomem *
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
>> drivers/dma/ppc4xx/adma.c:1187:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1187:25: sparse:     expected struct dma_regs *dma_reg
>> drivers/dma/ppc4xx/adma.c:1187:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:1188:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1188:34: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1190:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1190:25: sparse:     expected struct xor_regs *xor_reg
>> drivers/dma/ppc4xx/adma.c:1190:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1191:36: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1191:36: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1138:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1138:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1147:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1147:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1157:49: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1159:38: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:911:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:911:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
   drivers/dma/ppc4xx/adma.c:912:40: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:912:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:929:37: sparse: sparse: cast to restricted __le32
   drivers/dma/ppc4xx/adma.c:974:32: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:974:32: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:979:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:979:40: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:984:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:984:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:985:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:985:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:986:34: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:986:34: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:993:55: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:993:55: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:995:51: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:995:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:997:51: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:997:51: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:999:46: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:999:46: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1008:35: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1027:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     expected struct dma_regs *dma_reg
   drivers/dma/ppc4xx/adma.c:1027:25: sparse:     got struct dma_regs [noderef] __iomem *dma_reg
>> drivers/dma/ppc4xx/adma.c:1031:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1031:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:31: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned short * @@
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1032:60: sparse:     got unsigned short *
   drivers/dma/ppc4xx/adma.c:1038:25: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1038:25: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1039:37: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1039:37: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1053:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct xor_regs *xor_reg @@     got struct xor_regs [noderef] __iomem *xor_reg @@
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     expected struct xor_regs *xor_reg
   drivers/dma/ppc4xx/adma.c:1053:48: sparse:     got struct xor_regs [noderef] __iomem *xor_reg
   drivers/dma/ppc4xx/adma.c:1055:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1055:25: sparse:     expected void [noderef] __iomem *
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
   drivers/dma/ppc4xx/adma.c:1066:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1066:33: sparse:     got unsigned int *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void [noderef] __iomem * @@     got unsigned int * @@
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     expected void [noderef] __iomem *
   drivers/dma/ppc4xx/adma.c:1067:22: sparse:     got unsigned int *
>> drivers/dma/ppc4xx/adma.c:1080:48: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct dma_regs *dma_reg @@     got struct dma_regs [noderef] __iomem *dma_reg @@
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

vim +237 arch/powerpc/math-emu/math.c

^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  224  
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  225  int
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  226  do_mathemu(struct pt_regs *regs)
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  227  {
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  228  	void *op0 = 0, *op1 = 0, *op2 = 0, *op3 = 0;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  229  	unsigned long pc = regs->nip;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  230  	signed short sdisp;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  231  	u32 insn = 0;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  232  	int idx = 0;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  233  	int (*func)(void *, void *, void *, void *);
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  234  	int type = 0;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  235  	int eflag, trap;
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16  236  
^1da177e4c3f41 arch/ppc/math-emu/math.c Linus Torvalds 2005-04-16 @237  	if (get_user(insn, (u32 *)pc))

:::::: The code at line 237 was first introduced by commit
:::::: 1da177e4c3f41524e886b7f1b8a0c1fc7321cac2 Linux-2.6.12-rc2

:::::: TO: Linus Torvalds <torvalds@ppc970.osdl.org>
:::::: CC: Linus Torvalds <torvalds@ppc970.osdl.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--gKMricLos+KVdGMg
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
4AcYW3mfFSuc4Dh5S/k/ABRFC3sHAgA=

--gKMricLos+KVdGMg--
