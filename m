Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA6BC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 337552076C
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 12:02:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728872AbgHKMBw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 08:01:52 -0400
Received: from mga07.intel.com ([134.134.136.100]:49413 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728469AbgHKMBu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 08:01:50 -0400
IronPort-SDR: vas9/gOHJyrul5Jm9eFpCPVQ2ZoHT77NxdIIDsILwhs1iP1chsyixpu6rb51XzEU7OqbYz1dDN
 CCXY5i4fp5VQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9709"; a="218052184"
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="gz'50?scan'50,208,50";a="218052184"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 Aug 2020 04:55:09 -0700
IronPort-SDR: MmayiUUD0FUvbVG/vLVZxe3nhxs2Q+u/zQs3tvJk46bFKLXECAmi+qpvNJfLq+orX5LY/b9CQa
 AHC3D7PjjRtA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,461,1589266800"; 
   d="gz'50?scan'50,208,50";a="368929854"
Received: from lkp-server01.sh.intel.com (HELO 71729f5ca340) ([10.239.97.150])
  by orsmga001.jf.intel.com with ESMTP; 11 Aug 2020 04:55:07 -0700
Received: from kbuild by 71729f5ca340 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k5Srz-0000Z6-97; Tue, 11 Aug 2020 11:55:07 +0000
Date:   Tue, 11 Aug 2020 19:54:43 +0800
From:   kernel test robot <lkp@intel.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: drivers/tty/cyclades.c:3084:41: sparse: sparse: incorrect type in
 argument 1 (different address spaces)
Message-ID: <202008111932.QminvJTW%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="ReaqsoxgOBHFXBhH"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ReaqsoxgOBHFXBhH
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   00e4db51259a5f936fec1424b884f029479d3981
commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
date:   8 weeks ago
config: mips-randconfig-s031-20200811 (attached as .config)
compiler: mips64-linux-gcc (GCC) 9.3.0
reproduce:
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        # apt-get install sparse
        # sparse version: v0.6.2-168-g9554805c-dirty
        git checkout 670d0a4b10704667765f7d18f7592993d02783aa
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>


sparse warnings: (new ones prefixed by >>)

   drivers/tty/cyclades.c:3077:68: sparse: sparse: incorrect type in initializer (different address spaces) @@     expected struct FIRM_ID *firm_id @@     got void [noderef] __iomem * @@
   drivers/tty/cyclades.c:3077:68: sparse:     expected struct FIRM_ID *firm_id
   drivers/tty/cyclades.c:3077:68: sparse:     got void [noderef] __iomem *
>> drivers/tty/cyclades.c:3084:41: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned int * @@
>> drivers/tty/cyclades.c:3084:41: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/cyclades.c:3084:41: sparse:     got unsigned int *
   drivers/tty/cyclades.c:3083:34: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct ZFW_CTRL *zfw_ctrl @@     got void [noderef] __iomem * @@
   drivers/tty/cyclades.c:3083:34: sparse:     expected struct ZFW_CTRL *zfw_ctrl
   drivers/tty/cyclades.c:3083:34: sparse:     got void [noderef] __iomem *
   drivers/tty/cyclades.c:3085:45: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct CH_CTRL [noderef] __iomem *ch_ctrl @@     got struct CH_CTRL * @@
   drivers/tty/cyclades.c:3085:45: sparse:     expected struct CH_CTRL [noderef] __iomem *ch_ctrl
   drivers/tty/cyclades.c:3085:45: sparse:     got struct CH_CTRL *
   drivers/tty/cyclades.c:3086:46: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected struct BUF_CTRL [noderef] __iomem *buf_ctrl @@     got struct BUF_CTRL * @@
   drivers/tty/cyclades.c:3086:46: sparse:     expected struct BUF_CTRL [noderef] __iomem *buf_ctrl
   drivers/tty/cyclades.c:3086:46: sparse:     got struct BUF_CTRL *
   drivers/tty/cyclades.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
   arch/mips/include/asm/io.h:354:1: sparse: sparse: cast to restricted __le32
--
>> drivers/tty/serial/ip22zilog.c:114:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
>> drivers/tty/serial/ip22zilog.c:114:22: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:114:22: sparse:     got unsigned char volatile *
>> drivers/tty/serial/ip22zilog.c:116:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
>> drivers/tty/serial/ip22zilog.c:116:25: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:116:25: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:125:22: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:125:22: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:125:22: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:127:24: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:127:24: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:127:24: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:138:33: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:138:33: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:138:33: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:144:24: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:144:24: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:144:24: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:148:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:148:42: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:148:42: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:170:26: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:170:26: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:170:26: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:256:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:256:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:256:29: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:263:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:263:42: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:263:42: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:268:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:268:29: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:268:29: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:318:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:318:25: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:318:25: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:321:30: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:321:30: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:321:30: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:361:47: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:361:47: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:361:47: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:390:42: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:390:42: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:390:42: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:408:40: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:408:40: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:408:40: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:421:27: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:421:27: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:421:27: sparse:     got unsigned char volatile *
>> drivers/tty/serial/ip22zilog.c:432:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:441:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:441:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:441:44: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:459:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:464:44: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:464:44: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:464:44: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:546:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:580:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:586:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:586:25: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:586:25: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:597:39: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:597:39: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:597:39: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:608:48: sparse: sparse: incorrect type in argument 2 (different address spaces) @@     expected void volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:608:48: sparse:     expected void volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:608:48: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:629:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:641:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:658:41: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:691:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:701:27: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:715:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:722:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:722:34: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:722:34: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:782:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:896:41: sparse: sparse: cast removes address space '__iomem' of expression
>> drivers/tty/serial/ip22zilog.c:1100:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __iomem *membase @@     got char * @@
>> drivers/tty/serial/ip22zilog.c:1100:57: sparse:     expected unsigned char [noderef] __iomem *membase
   drivers/tty/serial/ip22zilog.c:1100:57: sparse:     got char *
   drivers/tty/serial/ip22zilog.c:1101:57: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected unsigned char [noderef] __iomem *membase @@     got char * @@
   drivers/tty/serial/ip22zilog.c:1101:57: sparse:     expected unsigned char [noderef] __iomem *membase
   drivers/tty/serial/ip22zilog.c:1101:57: sparse:     got char *
>> drivers/tty/serial/ip22zilog.c:1205:29: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
>> drivers/tty/serial/ip22zilog.c:1205:29: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ip22zilog.c:1205:29: sparse:     got void *
   drivers/tty/serial/ip22zilog.c:1209:34: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *addr @@     got void * @@
   drivers/tty/serial/ip22zilog.c:1209:34: sparse:     expected void const volatile [noderef] __iomem *addr
   drivers/tty/serial/ip22zilog.c:1209:34: sparse:     got void *
   drivers/tty/serial/ip22zilog.c:494:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:495:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:495:25: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:495:25: sparse:     got unsigned char volatile *
   drivers/tty/serial/ip22zilog.c:494:19: sparse: sparse: cast removes address space '__iomem' of expression
   drivers/tty/serial/ip22zilog.c:495:25: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got unsigned char volatile * @@
   drivers/tty/serial/ip22zilog.c:495:25: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/tty/serial/ip22zilog.c:495:25: sparse:     got unsigned char volatile *
--
>> drivers/misc/mic/vop/vop_main.c:551:58: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected void const volatile [noderef] __iomem *mem @@     got restricted __le64 * @@
>> drivers/misc/mic/vop/vop_main.c:551:58: sparse:     expected void const volatile [noderef] __iomem *mem
   drivers/misc/mic/vop/vop_main.c:551:58: sparse:     got restricted __le64 *
   drivers/misc/mic/vop/vop_main.c:560:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct mic_device_ctrl *dc @@     got struct mic_device_ctrl [noderef] __iomem *dc @@
   drivers/misc/mic/vop/vop_main.c:560:49: sparse:     expected struct mic_device_ctrl *dc
   drivers/misc/mic/vop/vop_main.c:560:49: sparse:     got struct mic_device_ctrl [noderef] __iomem *dc
   drivers/misc/mic/vop/vop_main.c:579:49: sparse: sparse: incorrect type in argument 1 (different address spaces) @@     expected struct mic_device_ctrl *dc @@     got struct mic_device_ctrl [noderef] __iomem *dc @@
   drivers/misc/mic/vop/vop_main.c:579:49: sparse:     expected struct mic_device_ctrl *dc
   drivers/misc/mic/vop/vop_main.c:579:49: sparse:     got struct mic_device_ctrl [noderef] __iomem *dc
   drivers/misc/mic/vop/vop_main.c: note: in included file (through arch/mips/include/asm/mmiowb.h, include/linux/spinlock.h, include/linux/seqlock.h, ...):
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64
   arch/mips/include/asm/io.h:356:1: sparse: sparse: cast to restricted __le64

vim +3084 drivers/tty/cyclades.c

f0737579424dd2 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3040  
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3041  /*
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3042   * ---------------------------------------------------------------------
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3043   * cy_init() and friends
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3044   *
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3045   * cy_init() is called at boot-time to initialize the serial driver.
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3046   * ---------------------------------------------------------------------
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3047   */
^1da177e4c3f41 drivers/char/cyclades.c Linus Torvalds 2005-04-16  3048  
9671f09921d93e drivers/tty/cyclades.c  Bill Pemberton 2012-11-19  3049  static int cy_init_card(struct cyclades_card *cinfo)
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3050  {
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3051  	struct cyclades_port *info;
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3052  	unsigned int channel, port;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3053  
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3054  	spin_lock_init(&cinfo->card_lock);
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3055  	cinfo->intr_enabled = 0;
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3056  
963118eef9e670 drivers/char/cyclades.c Jiri Slaby     2009-06-11  3057  	cinfo->ports = kcalloc(cinfo->nports, sizeof(*cinfo->ports),
963118eef9e670 drivers/char/cyclades.c Jiri Slaby     2009-06-11  3058  			GFP_KERNEL);
dd025c0c7a047b drivers/char/cyclades.c Jiri Slaby     2007-05-08  3059  	if (cinfo->ports == NULL) {
dd025c0c7a047b drivers/char/cyclades.c Jiri Slaby     2007-05-08  3060  		printk(KERN_ERR "Cyclades: cannot allocate ports\n");
dd025c0c7a047b drivers/char/cyclades.c Jiri Slaby     2007-05-08  3061  		return -ENOMEM;
dd025c0c7a047b drivers/char/cyclades.c Jiri Slaby     2007-05-08  3062  	}
dd025c0c7a047b drivers/char/cyclades.c Jiri Slaby     2007-05-08  3063  
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3064  	for (channel = 0, port = cinfo->first_line; channel < cinfo->nports;
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3065  			channel++, port++) {
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3066  		info = &cinfo->ports[channel];
44b7d1b37f786c drivers/char/cyclades.c Alan Cox       2008-07-16  3067  		tty_port_init(&info->port);
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3068  		info->magic = CYCLADES_MAGIC;
875b206b5f4971 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3069  		info->card = cinfo;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3070  		info->line = port;
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3071  
44b7d1b37f786c drivers/char/cyclades.c Alan Cox       2008-07-16  3072  		info->port.closing_wait = CLOSING_WAIT_DELAY;
44b7d1b37f786c drivers/char/cyclades.c Alan Cox       2008-07-16  3073  		info->port.close_delay = 5 * HZ / 10;
2c7fea992104b5 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3074  		init_completion(&info->shutdown_wait);
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3075  
2693f485c22d18 drivers/char/cyclades.c Jiri Slaby     2009-06-11  3076  		if (cy_is_Z(cinfo)) {
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3077  			struct FIRM_ID *firm_id = cinfo->base_addr + ID_ADDRESS;
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3078  			struct ZFW_CTRL *zfw_ctrl;
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3079  
f0737579424dd2 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3080  			info->port.ops = &cyz_port_ops;
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3081  			info->type = PORT_STARTECH;
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3082  
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3083  			zfw_ctrl = cinfo->base_addr +
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19 @3084  				(readl(&firm_id->zfwctrl_addr) & 0xfffff);
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3085  			info->u.cyz.ch_ctrl = &zfw_ctrl->ch_ctrl[channel];
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3086  			info->u.cyz.buf_ctrl = &zfw_ctrl->buf_ctrl[channel];
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3087  
101b81590d8df0 drivers/char/cyclades.c Jiri Slaby     2009-06-11  3088  			if (cinfo->hw_ver == ZO_V1)
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3089  				info->xmit_fifo_size = CYZ_FIFO_SIZE;
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3090  			else
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3091  				info->xmit_fifo_size = 4 * CYZ_FIFO_SIZE;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3092  #ifdef CONFIG_CYZ_INTR
a8497b31fee650 drivers/tty/cyclades.c  Kees Cook      2017-10-24  3093  			timer_setup(&info->rx_full_timer, cyz_rx_restart, 0);
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3094  #endif
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3095  		} else {
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3096  			unsigned short chip_number;
963118eef9e670 drivers/char/cyclades.c Jiri Slaby     2009-06-11  3097  			int index = cinfo->bus_index;
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3098  
f0737579424dd2 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3099  			info->port.ops = &cyy_port_ops;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3100  			info->type = PORT_CIRRUS;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3101  			info->xmit_fifo_size = CyMAX_CHAR_FIFO;
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3102  			info->cor1 = CyPARITY_NONE | Cy_1_STOP | Cy_8_BITS;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3103  			info->cor2 = CyETC;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3104  			info->cor3 = 0x08;	/* _very_ small rcv threshold */
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3105  
f0eefdc30e55e7 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3106  			chip_number = channel / CyPORTS_PER_CHIP;
3aeea5b9221008 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3107  			info->u.cyy.base_addr = cinfo->base_addr +
3aeea5b9221008 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3108  				(cy_chip_offset[chip_number] << index);
3aeea5b9221008 drivers/char/cyclades.c Jiri Slaby     2009-09-19  3109  			info->chip_rev = cyy_readb(info, CyGFRCR);
15ed6cc0ba6b7b drivers/char/cyclades.c Alan Cox       2008-04-30  3110  
15ed6cc0ba6b7b drivers/char/cyclades.c Alan Cox       2008-04-30  3111  			if (info->chip_rev >= CD1400_REV_J) {
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3112  				/* It is a CD1400 rev. J or later */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3113  				info->tbpr = baud_bpr_60[13];	/* Tx BPR */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3114  				info->tco = baud_co_60[13];	/* Tx CO */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3115  				info->rbpr = baud_bpr_60[13];	/* Rx BPR */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3116  				info->rco = baud_co_60[13];	/* Rx CO */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3117  				info->rtsdtr_inv = 1;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3118  			} else {
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3119  				info->tbpr = baud_bpr_25[13];	/* Tx BPR */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3120  				info->tco = baud_co_25[13];	/* Tx CO */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3121  				info->rbpr = baud_bpr_25[13];	/* Rx BPR */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3122  				info->rco = baud_co_25[13];	/* Rx CO */
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3123  				info->rtsdtr_inv = 0;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3124  			}
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3125  			info->read_status_mask = CyTIMEOUT | CySPECHAR |
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3126  				CyBREAK | CyPARITY | CyFRAME | CyOVERRUN;
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3127  		}
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3128  
0809e2671d804f drivers/char/cyclades.c Jiri Slaby     2007-05-08  3129  	}
3046d50ea58676 drivers/char/cyclades.c Jiri Slaby     2007-05-08  3130  

:::::: The code at line 3084 was first introduced by commit
:::::: f0eefdc30e55e761facf645bd1be1339b21c30e6 cyclades: avoid addresses recomputation

:::::: TO: Jiri Slaby <jirislaby@gmail.com>
:::::: CC: Live-CD User <linux@linux.site>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--ReaqsoxgOBHFXBhH
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
HKv1wdj/Aw+Azf2ExwEA

--ReaqsoxgOBHFXBhH--
