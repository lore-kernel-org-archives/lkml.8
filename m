Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3893BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:20:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F134B20715
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 11:20:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHMLUQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 07:20:16 -0400
Received: from mga09.intel.com ([134.134.136.24]:38019 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726204AbgHMLUN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 07:20:13 -0400
IronPort-SDR: guC8oq3zMuyjx8lg2AuJnyzRsUxaa2vwVNNJ0fyRoDnxVbOagQKHAQkhbwhirNyFtZwPAnPyX4
 65feKd6oFnjg==
X-IronPort-AV: E=McAfee;i="6000,8403,9711"; a="155323307"
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="gz'50?scan'50,208,50";a="155323307"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Aug 2020 04:15:07 -0700
IronPort-SDR: KOLF4cHvoHhCzSd7tsqAEQfLHco80W76rSmVab3gCsV0okHvTeb65ugB39iLI5aYevxZv5oUkF
 yv6Xr3V8ZtYg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.76,308,1592895600"; 
   d="gz'50?scan'50,208,50";a="495829511"
Received: from lkp-server01.sh.intel.com (HELO 7f1ebb311643) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 13 Aug 2020 04:15:05 -0700
Received: from kbuild by 7f1ebb311643 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k6BCK-0000a1-JE; Thu, 13 Aug 2020 11:15:04 +0000
Date:   Thu, 13 Aug 2020 19:14:15 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration
 of function 'write_sysreg'
Message-ID: <202008131911.NEJaqu0X%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="rwEMma7ioTxnRzrJ"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--rwEMma7ioTxnRzrJ
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Peng,

FYI, the error/warning still remains.

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   dc06fe51d26efc100ac74121607c01a454867c91
commit: d82bcef5157de1368c08244a846ab968b3e5cb7e soc: imx: select ARM_GIC_V3 for i.MX8M
date:   4 weeks ago
config: arm-randconfig-r021-20200811 (attached as .config)
compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
reproduce (this is a W=1 build):
        wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
        chmod +x ~/bin/make.cross
        git checkout d82bcef5157de1368c08244a846ab968b3e5cb7e
        # save the attached .config to linux build tree
        COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 

If you fix the issue, kindly add following tag as appropriate
Reported-by: kernel test robot <lkp@intel.com>

All errors (new ones prefixed by >>):

   In file included from include/linux/irqchip/arm-gic-v3.h:662,
                    from drivers/irqchip/irq-gic-v3.c:24:
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_PMR_EL1':
>> arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration of function 'write_sysreg' [-Werror=implicit-function-declaration]
      44 |  write_sysreg(val, a32);   \
         |  ^~~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:51:1: note: in expansion of macro 'CPUIF_MAP'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         | ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:20: error: implicit declaration of function '__ACCESS_CP15' [-Werror=implicit-function-declaration]
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                    ^~~~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:34: note: each undeclared identifier is reported only once for each function it appears in
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_PMR_EL1':
>> arch/arm/include/asm/arch_gicv3.h:48:9: error: implicit declaration of function 'read_sysreg' [-Werror=implicit-function-declaration]
      48 |  return read_sysreg(a32);   \
         |         ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:51:1: note: in expansion of macro 'CPUIF_MAP'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         | ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R0_EL1':
   arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R0_EL1':
   arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:30:21: note: in expansion of macro '__ICC_AP0Rx'
      30 | #define ICC_AP0R0   __ICC_AP0Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:52:11: note: in expansion of macro 'ICC_AP0R0'
      52 | CPUIF_MAP(ICC_AP0R0, ICC_AP0R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R1_EL1':
   arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R1_EL1':
   arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
--
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R3_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:39:21: note: in expansion of macro '__ICC_AP1Rx'
      39 | #define ICC_AP1R3   __ICC_AP1Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:59:11: note: in expansion of macro 'ICC_AP1R3'
      59 | CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:35:48: error: 'c9' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:39:21: note: in expansion of macro '__ICC_AP1Rx'
      39 | #define ICC_AP1R3   __ICC_AP1Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:59:11: note: in expansion of macro 'ICC_AP1R3'
      59 | CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP1R3_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:39:21: note: in expansion of macro '__ICC_AP1Rx'
      39 | #define ICC_AP1R3   __ICC_AP1Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:59:11: note: in expansion of macro 'ICC_AP1R3'
      59 | CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:35:48: error: 'c9' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:39:21: note: in expansion of macro '__ICC_AP1Rx'
      39 | #define ICC_AP1R3   __ICC_AP1Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:59:11: note: in expansion of macro 'ICC_AP1R3'
      59 | CPUIF_MAP(ICC_AP1R3, ICC_AP1R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_eoir':
   arch/arm/include/asm/arch_gicv3.h:18:35: error: 'c12' undeclared (first use in this function)
      18 | #define ICC_EOIR1   __ACCESS_CP15(c12, 0, c12, 1)
         |                                   ^~~
   arch/arm/include/asm/arch_gicv3.h:68:20: note: in expansion of macro 'ICC_EOIR1'
      68 |  write_sysreg(irq, ICC_EOIR1);
         |                    ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_dir':
   arch/arm/include/asm/arch_gicv3.h:19:34: error: 'c12' undeclared (first use in this function)
      19 | #define ICC_DIR    __ACCESS_CP15(c12, 0, c11, 1)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:74:20: note: in expansion of macro 'ICC_DIR'
      74 |  write_sysreg(val, ICC_DIR);
         |                    ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:19:42: error: 'c11' undeclared (first use in this function)
      19 | #define ICC_DIR    __ACCESS_CP15(c12, 0, c11, 1)
         |                                          ^~~
   arch/arm/include/asm/arch_gicv3.h:74:20: note: in expansion of macro 'ICC_DIR'
      74 |  write_sysreg(val, ICC_DIR);
         |                    ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_iar':
   arch/arm/include/asm/arch_gicv3.h:20:34: error: 'c12' undeclared (first use in this function)
      20 | #define ICC_IAR1   __ACCESS_CP15(c12, 0, c12, 0)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:80:28: note: in expansion of macro 'ICC_IAR1'
      80 |  u32 irqstat = read_sysreg(ICC_IAR1);
         |                            ^~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_ctlr':
   arch/arm/include/asm/arch_gicv3.h:23:34: error: 'c12' undeclared (first use in this function)
      23 | #define ICC_CTLR   __ACCESS_CP15(c12, 0, c12, 4)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:89:20: note: in expansion of macro 'ICC_CTLR'
      89 |  write_sysreg(val, ICC_CTLR);
         |                    ^~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_ctlr':
   arch/arm/include/asm/arch_gicv3.h:23:34: error: 'c12' undeclared (first use in this function)
      23 | #define ICC_CTLR   __ACCESS_CP15(c12, 0, c12, 4)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:95:21: note: in expansion of macro 'ICC_CTLR'
      95 |  return read_sysreg(ICC_CTLR);
         |                     ^~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_grpen1':
   arch/arm/include/asm/arch_gicv3.h:25:37: error: 'c12' undeclared (first use in this function)
      25 | #define ICC_IGRPEN1   __ACCESS_CP15(c12, 0, c12, 7)
         |                                     ^~~
   arch/arm/include/asm/arch_gicv3.h:100:20: note: in expansion of macro 'ICC_IGRPEN1'
     100 |  write_sysreg(val, ICC_IGRPEN1);
         |                    ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_sgi1r':
>> arch/arm/include/asm/arch_gicv3.h:21:21: error: implicit declaration of function '__ACCESS_CP15_64' [-Werror=implicit-function-declaration]
      21 | #define ICC_SGI1R   __ACCESS_CP15_64(0, c12)
         |                     ^~~~~~~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:106:20: note: in expansion of macro 'ICC_SGI1R'
     106 |  write_sysreg(val, ICC_SGI1R);
         |                    ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:21:41: error: 'c12' undeclared (first use in this function)
      21 | #define ICC_SGI1R   __ACCESS_CP15_64(0, c12)
         |                                         ^~~
   arch/arm/include/asm/arch_gicv3.h:106:20: note: in expansion of macro 'ICC_SGI1R'
     106 |  write_sysreg(val, ICC_SGI1R);
         |                    ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_sre':
   arch/arm/include/asm/arch_gicv3.h:24:34: error: 'c12' undeclared (first use in this function)
      24 | #define ICC_SRE    __ACCESS_CP15(c12, 0, c12, 5)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:111:21: note: in expansion of macro 'ICC_SRE'
     111 |  return read_sysreg(ICC_SRE);
         |                     ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_sre':
   arch/arm/include/asm/arch_gicv3.h:24:34: error: 'c12' undeclared (first use in this function)
      24 | #define ICC_SRE    __ACCESS_CP15(c12, 0, c12, 5)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:116:20: note: in expansion of macro 'ICC_SRE'
     116 |  write_sysreg(val, ICC_SRE);
         |                    ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_bpr1':
   arch/arm/include/asm/arch_gicv3.h:26:34: error: 'c12' undeclared (first use in this function)
      26 | #define ICC_BPR1   __ACCESS_CP15(c12, 0, c12, 3)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:122:20: note: in expansion of macro 'ICC_BPR1'
     122 |  write_sysreg(val, ICC_BPR1);
         |                    ^~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_pmr':
   arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:127:21: note: in expansion of macro 'ICC_PMR'
     127 |  return read_sysreg(ICC_PMR);
         |                     ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:127:21: note: in expansion of macro 'ICC_PMR'
     127 |  return read_sysreg(ICC_PMR);
         |                     ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_write_pmr':
   arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:132:20: note: in expansion of macro 'ICC_PMR'
     132 |  write_sysreg(val, ICC_PMR);
         |                    ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:132:20: note: in expansion of macro 'ICC_PMR'
     132 |  write_sysreg(val, ICC_PMR);
         |                    ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_rpr':
   arch/arm/include/asm/arch_gicv3.h:27:34: error: 'c12' undeclared (first use in this function)
      27 | #define ICC_RPR    __ACCESS_CP15(c12, 0, c11, 3)
         |                                  ^~~
   arch/arm/include/asm/arch_gicv3.h:137:21: note: in expansion of macro 'ICC_RPR'
     137 |  return read_sysreg(ICC_RPR);
         |                     ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:27:42: error: 'c11' undeclared (first use in this function)
      27 | #define ICC_RPR    __ACCESS_CP15(c12, 0, c11, 3)
         |                                          ^~~
   arch/arm/include/asm/arch_gicv3.h:137:21: note: in expansion of macro 'ICC_RPR'
     137 |  return read_sysreg(ICC_RPR);
         |                     ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h:138:1: warning: control reaches end of non-void function [-Wreturn-type]
     138 | }
         | ^
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_ctlr':
   arch/arm/include/asm/arch_gicv3.h:96:1: warning: control reaches end of non-void function [-Wreturn-type]
      96 | }
         | ^
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_sre':
   arch/arm/include/asm/arch_gicv3.h:112:1: warning: control reaches end of non-void function [-Wreturn-type]
     112 | }
         | ^
   arch/arm/include/asm/arch_gicv3.h: In function 'gic_read_pmr':
   arch/arm/include/asm/arch_gicv3.h:128:1: warning: control reaches end of non-void function [-Wreturn-type]
     128 | }
         | ^
   cc1: some warnings being treated as errors
..

vim +/write_sysreg +44 arch/arm/include/asm/arch_gicv3.h

d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  17  
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  18  #define ICC_EOIR1			__ACCESS_CP15(c12, 0, c12, 1)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  19  #define ICC_DIR				__ACCESS_CP15(c12, 0, c11, 1)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  20  #define ICC_IAR1			__ACCESS_CP15(c12, 0, c12, 0)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01 @21  #define ICC_SGI1R			__ACCESS_CP15_64(0, c12)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01 @22  #define ICC_PMR				__ACCESS_CP15(c4, 0, c6, 0)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  23  #define ICC_CTLR			__ACCESS_CP15(c12, 0, c12, 4)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  24  #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  25  #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
91ef84428a86b75 Daniel Thompson       2016-08-19  26  #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
e99da7c6f51b487 Julien Thierry        2019-01-31  27  #define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)
d5cd50d318f70fc Jean-Philippe Brucker 2015-10-01  28  
d6062a6d62c643a Marc Zyngier          2018-03-09  29  #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
d6062a6d62c643a Marc Zyngier          2018-03-09  30  #define ICC_AP0R0			__ICC_AP0Rx(0)
d6062a6d62c643a Marc Zyngier          2018-03-09  31  #define ICC_AP0R1			__ICC_AP0Rx(1)
d6062a6d62c643a Marc Zyngier          2018-03-09  32  #define ICC_AP0R2			__ICC_AP0Rx(2)
d6062a6d62c643a Marc Zyngier          2018-03-09  33  #define ICC_AP0R3			__ICC_AP0Rx(3)
d6062a6d62c643a Marc Zyngier          2018-03-09  34  
d6062a6d62c643a Marc Zyngier          2018-03-09  35  #define __ICC_AP1Rx(x)			__ACCESS_CP15(c12, 0, c9, x)
d6062a6d62c643a Marc Zyngier          2018-03-09  36  #define ICC_AP1R0			__ICC_AP1Rx(0)
d6062a6d62c643a Marc Zyngier          2018-03-09  37  #define ICC_AP1R1			__ICC_AP1Rx(1)
d6062a6d62c643a Marc Zyngier          2018-03-09  38  #define ICC_AP1R2			__ICC_AP1Rx(2)
d6062a6d62c643a Marc Zyngier          2018-03-09  39  #define ICC_AP1R3			__ICC_AP1Rx(3)
d6062a6d62c643a Marc Zyngier          2018-03-09  40  
a078bedf17c2e43 Vladimir Murzin       2016-09-12  41  #define CPUIF_MAP(a32, a64)			\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  42  static inline void write_ ## a64(u32 val)	\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  43  {						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12 @44  	write_sysreg(val, a32);			\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  45  }						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  46  static inline u32 read_ ## a64(void)		\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  47  {						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12 @48  	return read_sysreg(a32); 		\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  49  }						\
a078bedf17c2e43 Vladimir Murzin       2016-09-12  50  

:::::: The code at line 44 was first introduced by commit
:::::: a078bedf17c2e43819fea54bdfd5793845142e3a ARM: gic-v3: Introduce 32-to-64-bit mappings for GICv3 cpu registers

:::::: TO: Vladimir Murzin <vladimir.murzin@arm.com>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--rwEMma7ioTxnRzrJ
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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
TUy7uBLj6tREC6LoUWO6qIIQUP0f3dzPRdTjAQA=

--rwEMma7ioTxnRzrJ--
