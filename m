Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 110EBC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:28:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D355E20738
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 09:28:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHBJ2F (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 05:28:05 -0400
Received: from mga12.intel.com ([192.55.52.136]:25084 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726376AbgHBJ2F (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 05:28:05 -0400
IronPort-SDR: R4xdlsNetfiRL+fspwwcVlqsCxi+SxshrXd2jgu6dW5q9zisblzr2EKM98g90UMvXDeHq+6qp7
 184Brq4KbN6Q==
X-IronPort-AV: E=McAfee;i="6000,8403,9700"; a="131552624"
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="131552624"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2020 02:28:04 -0700
IronPort-SDR: 4jB6dDPDOG6L71UZZ3nbVEScqxI2u3WiQ3V6L57k6G3VNJ11mBhnkwoHjY3JrE/b2LNsWgLLH+
 9XT3mYo68NxA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,425,1589266800"; 
   d="scan'208";a="466139422"
Received: from lkp-server01.sh.intel.com (HELO e21119890065) ([10.239.97.150])
  by orsmga005.jf.intel.com with ESMTP; 02 Aug 2020 02:28:03 -0700
Received: from kbuild by e21119890065 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1k2AHi-0001Zw-Jv; Sun, 02 Aug 2020 09:28:02 +0000
Date:   Sun, 02 Aug 2020 17:27:46 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/core] BUILD REGRESSION
 a68415c27ff366970be132c266aa859ad706af33
Message-ID: <5f268712.XasVVJFfttYwAlIA%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/core
branch HEAD: a68415c27ff366970be132c266aa859ad706af33  Merge branch 'lkmm' of git://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu into locking/core

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
`-- sparc-allyesconfig
    `-- arch-sparc-include-asm-percpu_64.h:error:__local_per_cpu_offset-undeclared-(first-use-in-this-function)

elapsed time: 806m

configs tested: 69
configs skipped: 2

arm                                 defconfig
arm64                            allyesconfig
arm64                               defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                       omap2plus_defconfig
sh                               alldefconfig
mips                     loongson1c_defconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
arc                              allyesconfig
nds32                             allnoconfig
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
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a006-20200802
x86_64               randconfig-a001-20200802
x86_64               randconfig-a004-20200802
x86_64               randconfig-a003-20200802
x86_64               randconfig-a002-20200802
x86_64               randconfig-a005-20200802
i386                 randconfig-a004-20200802
i386                 randconfig-a005-20200802
i386                 randconfig-a001-20200802
i386                 randconfig-a002-20200802
i386                 randconfig-a003-20200802
i386                 randconfig-a006-20200802
i386                 randconfig-a011-20200802
i386                 randconfig-a012-20200802
i386                 randconfig-a015-20200802
i386                 randconfig-a014-20200802
i386                 randconfig-a013-20200802
i386                 randconfig-a016-20200802
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
