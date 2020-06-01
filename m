Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A4A2C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:15:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D9A422073E
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 05:15:23 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725970AbgFAFPW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 01:15:22 -0400
Received: from mga09.intel.com ([134.134.136.24]:12680 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725788AbgFAFPT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 01:15:19 -0400
IronPort-SDR: FkTAgASmzU0TuV6TpxTn0x/NOr9ZvW2AgUwpJPKNV6CU8KmIIIsbnU7N6udRdlP1qlSGhNM5XM
 XDR2HmAPfh4w==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 May 2020 22:15:18 -0700
IronPort-SDR: IMW4rECuuNaXOa/pINZCBmS7hhnkk5xO6VJx8un0irf891rkJ8jPzUt8/jokZzMWOWqNuPzYdx
 7h6cU6pMVjjw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,459,1583222400"; 
   d="scan'208";a="470194788"
Received: from lkp-server01.sh.intel.com (HELO 49d03d9b0ee7) ([10.239.97.150])
  by fmsmga005.fm.intel.com with ESMTP; 31 May 2020 22:15:17 -0700
Received: from kbuild by 49d03d9b0ee7 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfcn6-0000BU-F2; Mon, 01 Jun 2020 05:15:16 +0000
Date:   Mon, 01 Jun 2020 13:14:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD REGRESSION
 5980d208e5ef28455e9e8b08f6250b443a2f0893
Message-ID: <5ed48ecc.51gSqIDEP0nAH0ct%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 5980d208e5ef28455e9e8b08f6250b443a2f0893  x86/idt: Consolidate idt functionality

Error/Warning in current branch:

arch/x86/kernel/idt.c:177:43: error: expected ';' before ')' token
arch/x86/kernel/idt.c:177:43: error: expected statement before ')' token
arch/x86/kernel/idt.c:177:45: error: expected expression before '==' token

Error/Warning ids grouped by kconfigs:

recent_errors
`-- i386-randconfig-c001-20200529
    |-- arch-x86-kernel-idt.c:error:expected-before-)-token
    |-- arch-x86-kernel-idt.c:error:expected-expression-before-token
    `-- arch-x86-kernel-idt.c:error:expected-statement-before-)-token


i386-tinyconfig vmlinux size:

+-------+--------------------------------+------------------------------------------+
| DELTA |             SYMBOL             |                  COMMIT                  |
+-------+--------------------------------+------------------------------------------+
|  +171 | TOTAL                          | 5a7462b1f9c1..5980d208e5ef (ALL COMMITS) |
|  +167 | TEXT                           | 5a7462b1f9c1..5980d208e5ef (ALL COMMITS) |
| +2048 | idt_table                      | 5a7462b1f9c1..5980d208e5ef (ALL COMMITS) |
|  +154 | init.text                      | 5a7462b1f9c1..5980d208e5ef (ALL COMMITS) |
|   +85 | idt_setup_apic_and_irq_gates() | 5a7462b1f9c1..5980d208e5ef (ALL COMMITS) |
| -2048 | idt_table                      | 5a7462b1f9c1..5980d208e5ef (ALL COMMITS) |
+-------+--------------------------------+------------------------------------------+

elapsed time: 2564m

configs tested: 112
configs skipped: 8

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
mips                         mpc30x_defconfig
mips                       rbtx49xx_defconfig
m68k                        stmark2_defconfig
um                           x86_64_defconfig
m68k                       m5249evb_defconfig
sh                   sh7770_generic_defconfig
arm                         vf610m4_defconfig
arm                        trizeps4_defconfig
powerpc                      pasemi_defconfig
sparc                       sparc64_defconfig
mips                  decstation_64_defconfig
mips                          ath79_defconfig
arm                             pxa_defconfig
c6x                        evmc6678_defconfig
m68k                        m5407c3_defconfig
sh                               j2_defconfig
arm                        multi_v7_defconfig
sh                          sdk7780_defconfig
mips                        jmr3927_defconfig
riscv                               defconfig
sh                           cayman_defconfig
arm                     davinci_all_defconfig
c6x                                 defconfig
x86_64                              defconfig
i386                              allnoconfig
riscv                          rv32_defconfig
arc                           tb10x_defconfig
arm                        mvebu_v7_defconfig
powerpc                mpc7448_hpc2_defconfig
xtensa                              defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                               defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
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
i386                 randconfig-a013-20200529
i386                 randconfig-a011-20200529
i386                 randconfig-a012-20200529
i386                 randconfig-a015-20200529
i386                 randconfig-a016-20200529
i386                 randconfig-a014-20200529
riscv                            allyesconfig
riscv                             allnoconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
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
