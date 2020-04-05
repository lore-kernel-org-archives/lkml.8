Return-Path: <SRS0=MDzn=5V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EA65AC2BA15
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:05:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBE0B20672
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Apr 2020 02:05:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgDECFb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Apr 2020 22:05:31 -0400
Received: from mga03.intel.com ([134.134.136.65]:49741 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726386AbgDECFb (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Apr 2020 22:05:31 -0400
IronPort-SDR: d/jP6199URUur0PXVF1cy0ZjLqD317pNePbdgQIqm+/yPVbyn4w/q9jWcjPWLVIB8FjVrNWQKt
 GQbeUkW6x9FA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2020 19:05:30 -0700
IronPort-SDR: XVPVJ77k4EnemnElrV8rmZV2XGIkbk10TinbRbDrDlD9JneRmKf/uArvF6E9Ap0doM7Y3/7fFK
 3G5wIYfb2/dg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,346,1580803200"; 
   d="scan'208";a="285501231"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 04 Apr 2020 19:05:29 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jKufA-0008b8-Ii; Sun, 05 Apr 2020 10:05:28 +0800
Date:   Sun, 05 Apr 2020 10:04:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [rcu:rcu/next] BUILD SUCCESS
 c9a503a8ebd23b1b2c0728e18ad7df9f710cb377
Message-ID: <5e893caf.VKufG1tn8402lGpD%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git  rcu/next
branch HEAD: c9a503a8ebd23b1b2c0728e18ad7df9f710cb377  rcu: Remove self-stack-trace when all quiescent states seen

elapsed time: 482m

configs tested: 146
configs skipped: 0

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                              allmodconfig
arm                               allnoconfig
arm                              allyesconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm64                            allyesconfig
arm                           efm32_defconfig
arm                         at91_dt_defconfig
arm                        shmobile_defconfig
arm64                               defconfig
arm                          exynos_defconfig
arm                        multi_v5_defconfig
arm                           sunxi_defconfig
arm                        multi_v7_defconfig
sparc                            allyesconfig
powerpc                           allnoconfig
powerpc                       ppc64_defconfig
h8300                    h8300h-sim_defconfig
sparc64                          allyesconfig
mips                              allnoconfig
riscv                            allyesconfig
sh                                allnoconfig
parisc                           allyesconfig
nios2                         3c120_defconfig
s390                             alldefconfig
i386                              allnoconfig
i386                             alldefconfig
i386                             allyesconfig
i386                                defconfig
ia64                             alldefconfig
ia64                             allmodconfig
ia64                              allnoconfig
ia64                             allyesconfig
ia64                                defconfig
nios2                         10m50_defconfig
c6x                        evmc6678_defconfig
xtensa                          iss_defconfig
c6x                              allyesconfig
xtensa                       common_defconfig
openrisc                 simple_smp_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
csky                                defconfig
nds32                             allnoconfig
nds32                               defconfig
h8300                     edosk2674_defconfig
h8300                       h8s-sim_defconfig
m68k                             allmodconfig
m68k                       m5475evb_defconfig
m68k                          multi_defconfig
m68k                           sun3_defconfig
arc                              allyesconfig
arc                                 defconfig
microblaze                      mmu_defconfig
microblaze                    nommu_defconfig
powerpc                             defconfig
powerpc                          rhel-kconfig
mips                           32r2_defconfig
mips                         64r6el_defconfig
mips                             allmodconfig
mips                             allyesconfig
mips                      fuloong2e_defconfig
mips                      malta_kvm_defconfig
parisc                            allnoconfig
parisc                generic-64bit_defconfig
parisc                generic-32bit_defconfig
x86_64               randconfig-a001-20200405
x86_64               randconfig-a002-20200405
x86_64               randconfig-a003-20200405
i386                 randconfig-a001-20200405
i386                 randconfig-a002-20200405
i386                 randconfig-a003-20200405
mips                 randconfig-a001-20200405
nds32                randconfig-a001-20200405
m68k                 randconfig-a001-20200405
parisc               randconfig-a001-20200405
alpha                randconfig-a001-20200405
riscv                randconfig-a001-20200405
c6x                  randconfig-a001-20200405
h8300                randconfig-a001-20200405
microblaze           randconfig-a001-20200405
nios2                randconfig-a001-20200405
sparc64              randconfig-a001-20200405
csky                 randconfig-a001-20200405
openrisc             randconfig-a001-20200405
s390                 randconfig-a001-20200405
sh                   randconfig-a001-20200405
xtensa               randconfig-a001-20200405
x86_64               randconfig-c001-20200405
x86_64               randconfig-c002-20200405
x86_64               randconfig-c003-20200405
i386                 randconfig-c001-20200405
i386                 randconfig-c002-20200405
i386                 randconfig-c003-20200405
x86_64               randconfig-d001-20200405
x86_64               randconfig-d002-20200405
x86_64               randconfig-d003-20200405
i386                 randconfig-d001-20200405
i386                 randconfig-d002-20200405
i386                 randconfig-d003-20200405
x86_64               randconfig-f001-20200405
x86_64               randconfig-f002-20200405
x86_64               randconfig-f003-20200405
i386                 randconfig-f001-20200405
i386                 randconfig-f002-20200405
i386                 randconfig-f003-20200405
x86_64               randconfig-g001-20200405
x86_64               randconfig-g002-20200405
x86_64               randconfig-g003-20200405
i386                 randconfig-g001-20200405
i386                 randconfig-g002-20200405
i386                 randconfig-g003-20200405
arc                  randconfig-a001-20200405
arm                  randconfig-a001-20200405
arm64                randconfig-a001-20200405
ia64                 randconfig-a001-20200405
powerpc              randconfig-a001-20200405
sparc                randconfig-a001-20200405
riscv                            allmodconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                    nommu_virt_defconfig
riscv                          rv32_defconfig
s390                             allmodconfig
s390                              allnoconfig
s390                             allyesconfig
s390                          debug_defconfig
s390                                defconfig
s390                       zfcpdump_defconfig
sh                               allmodconfig
sh                          rsk7269_defconfig
sh                  sh7785lcr_32bit_defconfig
sh                            titan_defconfig
sparc                               defconfig
sparc64                          allmodconfig
sparc64                           allnoconfig
sparc64                             defconfig
um                                  defconfig
um                             i386_defconfig
um                           x86_64_defconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
