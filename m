Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66C72C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:41:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77DCB206F6
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 23:41:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727885AbgHCXlz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 19:41:55 -0400
Received: from mga06.intel.com ([134.134.136.31]:18354 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726350AbgHCXly (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 19:41:54 -0400
IronPort-SDR: G0qOeAw7e5gzgjWnW0Eky7BUFdo9qem4qYu+xgm8HmX7nHRlFUtaRFp6gTqVIhcxJBqKfjDLt9
 p4hMFEKe/qfg==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="213761635"
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="213761635"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 03 Aug 2020 16:41:54 -0700
IronPort-SDR: bmkyKFeW5lZyeKRGAe2eohz307LW6/ncv5RsbbfJXEPm8V5Vsovkc9cvkZ3TJ5/Mzayr7KRAIw
 erqt1gCNFi/g==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,431,1589266800"; 
   d="scan'208";a="306107025"
Received: from lkp-server02.sh.intel.com (HELO 84ccfe698a63) ([10.239.97.151])
  by orsmga002.jf.intel.com with ESMTP; 03 Aug 2020 16:41:53 -0700
Received: from kbuild by 84ccfe698a63 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2k5Y-0000Ig-Dw; Mon, 03 Aug 2020 23:41:52 +0000
Date:   Tue, 04 Aug 2020 07:41:44 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 992414a18cd4de05fa3f8ff7e1c29af758bdee1a
Message-ID: <5f28a0b8.rkypfjWH7Ix//dK8%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/core
branch HEAD: 992414a18cd4de05fa3f8ff7e1c29af758bdee1a  Merge branch 'locking/nmi' into locking/core, to pick up completed topic branch

Error/Warning in current branch:

arch/mips/include/asm/smp.h:28:19: error: static declaration of 'raw_smp_processor_id' follows non-static declaration
arch/sparc/include/asm/percpu_64.h:19:25: error: '__local_per_cpu_offset' undeclared (first use in this function); did you mean 'per_cpu_offset'?
include/asm-generic/percpu.h:31:40: error: implicit declaration of function 'raw_smp_processor_id' [-Werror=implicit-function-declaration]

Error/Warning ids grouped by kconfigs:

recent_errors
|-- arm-allmodconfig
|   `-- include-asm-generic-percpu.h:error:implicit-declaration-of-function-raw_smp_processor_id
|-- arm-allyesconfig
|   `-- include-asm-generic-percpu.h:error:implicit-declaration-of-function-raw_smp_processor_id
|-- mips-allmodconfig
|   |-- arch-mips-include-asm-smp.h:error:static-declaration-of-raw_smp_processor_id-follows-non-static-declaration
|   `-- include-asm-generic-percpu.h:error:implicit-declaration-of-function-raw_smp_processor_id
|-- mips-allyesconfig
|   |-- arch-mips-include-asm-smp.h:error:static-declaration-of-raw_smp_processor_id-follows-non-static-declaration
|   `-- include-asm-generic-percpu.h:error:implicit-declaration-of-function-raw_smp_processor_id
|-- openrisc-randconfig-r013-20200803
|   `-- include-asm-generic-percpu.h:error:implicit-declaration-of-function-raw_smp_processor_id
`-- sparc-allyesconfig
    `-- arch-sparc-include-asm-percpu_64.h:error:__local_per_cpu_offset-undeclared-(first-use-in-this-function)

elapsed time: 724m

configs tested: 89
configs skipped: 5

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                            lart_defconfig
arc                 nsimosci_hs_smp_defconfig
sparc64                             defconfig
m68k                             allmodconfig
arm                    vt8500_v6_v7_defconfig
mips                        omega2p_defconfig
mips                     loongson1c_defconfig
m68k                       bvme6000_defconfig
xtensa                           alldefconfig
arm                       aspeed_g4_defconfig
arc                          axs101_defconfig
powerpc                    amigaone_defconfig
sh                   sh7770_generic_defconfig
mips                        bcm47xx_defconfig
h8300                    h8300h-sim_defconfig
nds32                             allnoconfig
powerpc                          alldefconfig
mips                      bmips_stb_defconfig
arm                        magician_defconfig
arm                             pxa_defconfig
sh                             sh03_defconfig
mips                         db1xxx_defconfig
arm                        trizeps4_defconfig
parisc                           alldefconfig
mips                           ip32_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
c6x                              allyesconfig
nds32                               defconfig
nios2                            allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
arc                                 defconfig
sh                               allmodconfig
parisc                              defconfig
s390                             allyesconfig
parisc                           allyesconfig
s390                                defconfig
i386                             allyesconfig
sparc                            allyesconfig
sparc                               defconfig
i386                                defconfig
mips                             allyesconfig
mips                             allmodconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
i386                 randconfig-a004-20200803
i386                 randconfig-a005-20200803
i386                 randconfig-a001-20200803
i386                 randconfig-a002-20200803
i386                 randconfig-a003-20200803
i386                 randconfig-a006-20200803
x86_64               randconfig-a013-20200803
x86_64               randconfig-a011-20200803
x86_64               randconfig-a012-20200803
x86_64               randconfig-a016-20200803
x86_64               randconfig-a015-20200803
x86_64               randconfig-a014-20200803
i386                 randconfig-a011-20200803
i386                 randconfig-a012-20200803
i386                 randconfig-a015-20200803
i386                 randconfig-a014-20200803
i386                 randconfig-a013-20200803
i386                 randconfig-a016-20200803
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
x86_64                                   rhel
x86_64                           allyesconfig
x86_64                    rhel-7.6-kselftests
x86_64                              defconfig
x86_64                               rhel-8.3
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
