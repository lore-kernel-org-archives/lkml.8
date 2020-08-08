Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80617C433DF
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:54:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47149206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 16:54:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726389AbgHHQyN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 12:54:13 -0400
Received: from mga09.intel.com ([134.134.136.24]:26671 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726200AbgHHQxx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 12:53:53 -0400
IronPort-SDR: wIWYXQMAae5j0/vFEI3BatBvtp751NtAc5YUxWhs7nnJ2Zrr/P0D4cHkInWL5vKjhcmfwQ6k/W
 KcPw+tOfiDYg==
X-IronPort-AV: E=McAfee;i="6000,8403,9707"; a="154468339"
X-IronPort-AV: E=Sophos;i="5.75,450,1589266800"; 
   d="gz'50?scan'50,208,50";a="154468339"
X-Amp-Result: UNKNOWN
X-Amp-Original-Verdict: FILE UNKNOWN
X-Amp-File-Uploaded: False
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Aug 2020 09:50:44 -0700
IronPort-SDR: GT8yChcOnu9gKw7QxjcOTUp5VyiBOYdjbKP5L4DiTMxoMgnhJdfs1wVxumrMLekYS2bI5z0m+z
 iSVLnxPewyIQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,450,1589266800"; 
   d="gz'50?scan'50,208,50";a="493877808"
Received: from lkp-server02.sh.intel.com (HELO 65e25449d42f) ([10.239.97.151])
  by fmsmga006.fm.intel.com with ESMTP; 08 Aug 2020 09:50:42 -0700
Received: from kbuild by 65e25449d42f with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k4S3N-0000DB-Jh; Sat, 08 Aug 2020 16:50:41 +0000
Date:   Sun, 9 Aug 2020 00:50:29 +0800
From:   kernel test robot <lkp@intel.com>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Shawn Guo <shawnguo@kernel.org>
Subject: arch/arm/include/asm/arch_gicv3.h:44:2: error: implicit declaration
 of function 'write_sysreg'
Message-ID: <202008090026.iSBoPr53%lkp@intel.com>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="GvXjxJ+pjyke8COw"
Content-Disposition: inline
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--GvXjxJ+pjyke8COw
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
head:   449dc8c97089a6e09fb2dac4d92b1b7ac0eb7c1e
commit: d82bcef5157de1368c08244a846ab968b3e5cb7e soc: imx: select ARM_GIC_V3 for i.MX8M
date:   4 weeks ago
config: arm-randconfig-p002-20200808 (attached as .config)
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
>> arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
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
>> arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
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
>> arch/arm/include/asm/arch_gicv3.h:22:34: error: 'c4' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                  ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:22:41: error: 'c6' undeclared (first use in this function)
      22 | #define ICC_PMR    __ACCESS_CP15(c4, 0, c6, 0)
         |                                         ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:51:11: note: in expansion of macro 'ICC_PMR'
      51 | CPUIF_MAP(ICC_PMR, ICC_PMR_EL1)
         |           ^~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R0_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
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
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
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
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
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
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
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
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
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
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
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
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:31:21: note: in expansion of macro '__ICC_AP0Rx'
      31 | #define ICC_AP0R1   __ICC_AP0Rx(1)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:53:11: note: in expansion of macro 'ICC_AP0R1'
      53 | CPUIF_MAP(ICC_AP0R1, ICC_AP0R1_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R2_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R2_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
>> arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:32:21: note: in expansion of macro '__ICC_AP0Rx'
      32 | #define ICC_AP0R2   __ICC_AP0Rx(2)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:54:11: note: in expansion of macro 'ICC_AP0R2'
      54 | CPUIF_MAP(ICC_AP0R2, ICC_AP0R2_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP0R3_EL1':
>> arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP0R3_EL1':
   arch/arm/include/asm/arch_gicv3.h:29:40: error: 'c12' undeclared (first use in this function)
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:29:48: error: 'c8' undeclared (first use in this function); did you mean 'u8'?
      29 | #define __ICC_AP0Rx(x)   __ACCESS_CP15(c12, 0, c8, 4 | x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:33:21: note: in expansion of macro '__ICC_AP0Rx'
      33 | #define ICC_AP0R3   __ICC_AP0Rx(3)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:55:11: note: in expansion of macro 'ICC_AP0R3'
      55 | CPUIF_MAP(ICC_AP0R3, ICC_AP0R3_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R0_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:35:48: error: 'c9' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:44:20: note: in definition of macro 'CPUIF_MAP'
      44 |  write_sysreg(val, a32);   \
         |                    ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'read_ICC_AP1R0_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                        ^~~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:35:48: error: 'c9' undeclared (first use in this function)
      35 | #define __ICC_AP1Rx(x)   __ACCESS_CP15(c12, 0, c9, x)
         |                                                ^~
   arch/arm/include/asm/arch_gicv3.h:48:21: note: in definition of macro 'CPUIF_MAP'
      48 |  return read_sysreg(a32);   \
         |                     ^~~
   arch/arm/include/asm/arch_gicv3.h:36:21: note: in expansion of macro '__ICC_AP1Rx'
      36 | #define ICC_AP1R0   __ICC_AP1Rx(0)
         |                     ^~~~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h:56:11: note: in expansion of macro 'ICC_AP1R0'
      56 | CPUIF_MAP(ICC_AP1R0, ICC_AP1R0_EL1)
         |           ^~~~~~~~~
   arch/arm/include/asm/arch_gicv3.h: In function 'write_ICC_AP1R1_EL1':
   arch/arm/include/asm/arch_gicv3.h:35:40: error: 'c12' undeclared (first use in this function)
..

vim +/write_sysreg +44 arch/arm/include/asm/arch_gicv3.h

d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  17  
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  18  #define ICC_EOIR1			__ACCESS_CP15(c12, 0, c12, 1)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01 @19  #define ICC_DIR				__ACCESS_CP15(c12, 0, c11, 1)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  20  #define ICC_IAR1			__ACCESS_CP15(c12, 0, c12, 0)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01 @21  #define ICC_SGI1R			__ACCESS_CP15_64(0, c12)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01 @22  #define ICC_PMR				__ACCESS_CP15(c4, 0, c6, 0)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  23  #define ICC_CTLR			__ACCESS_CP15(c12, 0, c12, 4)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  24  #define ICC_SRE				__ACCESS_CP15(c12, 0, c12, 5)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  25  #define ICC_IGRPEN1			__ACCESS_CP15(c12, 0, c12, 7)
91ef84428a86b7 Daniel Thompson       2016-08-19  26  #define ICC_BPR1			__ACCESS_CP15(c12, 0, c12, 3)
e99da7c6f51b48 Julien Thierry        2019-01-31  27  #define ICC_RPR				__ACCESS_CP15(c12, 0, c11, 3)
d5cd50d318f70f Jean-Philippe Brucker 2015-10-01  28  
d6062a6d62c643 Marc Zyngier          2018-03-09 @29  #define __ICC_AP0Rx(x)			__ACCESS_CP15(c12, 0, c8, 4 | x)
d6062a6d62c643 Marc Zyngier          2018-03-09  30  #define ICC_AP0R0			__ICC_AP0Rx(0)
d6062a6d62c643 Marc Zyngier          2018-03-09  31  #define ICC_AP0R1			__ICC_AP0Rx(1)
d6062a6d62c643 Marc Zyngier          2018-03-09  32  #define ICC_AP0R2			__ICC_AP0Rx(2)
d6062a6d62c643 Marc Zyngier          2018-03-09  33  #define ICC_AP0R3			__ICC_AP0Rx(3)
d6062a6d62c643 Marc Zyngier          2018-03-09  34  
d6062a6d62c643 Marc Zyngier          2018-03-09 @35  #define __ICC_AP1Rx(x)			__ACCESS_CP15(c12, 0, c9, x)
d6062a6d62c643 Marc Zyngier          2018-03-09  36  #define ICC_AP1R0			__ICC_AP1Rx(0)
d6062a6d62c643 Marc Zyngier          2018-03-09  37  #define ICC_AP1R1			__ICC_AP1Rx(1)
d6062a6d62c643 Marc Zyngier          2018-03-09  38  #define ICC_AP1R2			__ICC_AP1Rx(2)
d6062a6d62c643 Marc Zyngier          2018-03-09  39  #define ICC_AP1R3			__ICC_AP1Rx(3)
d6062a6d62c643 Marc Zyngier          2018-03-09  40  
a078bedf17c2e4 Vladimir Murzin       2016-09-12  41  #define CPUIF_MAP(a32, a64)			\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  42  static inline void write_ ## a64(u32 val)	\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  43  {						\
a078bedf17c2e4 Vladimir Murzin       2016-09-12 @44  	write_sysreg(val, a32);			\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  45  }						\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  46  static inline u32 read_ ## a64(void)		\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  47  {						\
a078bedf17c2e4 Vladimir Murzin       2016-09-12 @48  	return read_sysreg(a32); 		\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  49  }						\
a078bedf17c2e4 Vladimir Murzin       2016-09-12  50  

:::::: The code at line 44 was first introduced by commit
:::::: a078bedf17c2e43819fea54bdfd5793845142e3a ARM: gic-v3: Introduce 32-to-64-bit mappings for GICv3 cpu registers

:::::: TO: Vladimir Murzin <vladimir.murzin@arm.com>
:::::: CC: Christoffer Dall <christoffer.dall@linaro.org>

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org

--GvXjxJ+pjyke8COw
Content-Type: application/gzip
Content-Disposition: attachment; filename=".config.gz"
Content-Transfer-Encoding: base64

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

--GvXjxJ+pjyke8COw--
