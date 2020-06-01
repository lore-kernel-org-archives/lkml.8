Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DFF05C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:19:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BFC17206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:19:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726289AbgFAFTO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:19:14 -0400
Received: from mga07.intel.com ([134.134.136.100]:28450 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725972AbgFAFTM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:19:12 -0400
IronPort-SDR: ERc4XmdWgi9A0A8n1jqgfSi71F9pZKQI6zb9xJ/PWZ0XlZ1ZejituXnhhD2wHiu+us4NOMPKNO
 2NJP9M89IF7w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:19:11 -0700
IronPort-SDR: 8ZZUNxK6ZA2V7GOStjyqKd4VK2SQDb/hE21br2YGspPbb/wreH4+g6YicqR4BMfT+Y9A+lBf13
 j5EsnCT1P/Sw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="268201976"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 31 May 2020 22:19:10 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcqr-0000Eo-Hp; Mon, 01 Jun 2020 05:19:09 +0000
Date:   Mon, 01 Jun 2020 13:18:21 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:irq/core] BUILD SUCCESS
 76fe06c1e68b8f8dfb63d5b268623830dcb16ed0
Message-ID: <5ed48f9d.6VsYGR/xBLd07G/j%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  irq/core
branch HEAD: 76fe06c1e68b8f8dfb63d5b268623830dcb16ed0  Merge tag 'irqchip-5.8' of git://git.kernel.org/pub/scm/linux/kernel/git/maz/arm-platforms into irq/core

elapsed time: 2567m

configs tested: 146
configs skipped: 20

The following configs have been built successfully.
More configs may be tested in the coming days.

arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
mips                         mpc30x_defconfig
mips                       rbtx49xx_defconfig
m68k                        stmark2_defconfig
um                           x86_64_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
arm                         vf610m4_defconfig
arm                        trizeps4_defconfig
powerpc                      ppc44x_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
powerpc                      mgcoge_defconfig
arm                          pxa168_defconfig
nds32                             allnoconfig
s390                              allnoconfig
mips                           ip27_defconfig
arc                 nsimosci_hs_smp_defconfig
mips                           mtx1_defconfig
sh                            shmin_defconfig
microblaze                          defconfig
arm                         shannon_defconfig
powerpc                      ppc6xx_defconfig
powerpc64                        alldefconfig
microblaze                    nommu_defconfig
arm                             pxa_defconfig
c6x                        evmc6678_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
arm                        multi_v7_defconfig
arm                       mainstone_defconfig
arm                            hisi_defconfig
powerpc                     mpc83xx_defconfig
m68k                          multi_defconfig
m68k                             allyesconfig
sh                          sdk7780_defconfig
mips                        jmr3927_defconfig
riscv                               defconfig
sh                           cayman_defconfig
sh                            titan_defconfig
arm                       netwinder_defconfig
parisc                generic-32bit_defconfig
sh                          rsk7264_defconfig
arm                        spear6xx_defconfig
m68k                           sun3_defconfig
sh                           se7619_defconfig
arc                     haps_hs_smp_defconfig
arm                         at91_dt_defconfig
sh                             espt_defconfig
arm                        realview_defconfig
arm                      footbridge_defconfig
arm                     davinci_all_defconfig
c6x                                 defconfig
x86_64                              defconfig
i386                              allnoconfig
riscv                          rv32_defconfig
um                               alldefconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
c6x                         dsk6455_defconfig
riscv                    nommu_virt_defconfig
sh                        apsh4ad0a_defconfig
sh                           se7343_defconfig
mips                          rm200_defconfig
arm                        mvebu_v5_defconfig
arm                         assabet_defconfig
xtensa                           alldefconfig
powerpc                      tqm8xx_defconfig
sh                           se7750_defconfig
xtensa                         virt_defconfig
arm                        multi_v5_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
xtensa                              defconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
microblaze                        allnoconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
s390                                defconfig
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
um                               allyesconfig
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25
x86_64                                  kexec

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
