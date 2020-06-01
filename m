Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B4056C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:00:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D9420734
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 21:00:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728657AbgFAVAU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 17:00:20 -0400
Received: from mga02.intel.com ([134.134.136.20]:51056 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726124AbgFAVAU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 17:00:20 -0400
IronPort-SDR: Z2TWKt4ddVXQ4Pq8IlX1jQbdliTy/48fox6287R59j7ftXn8VkvSblLjmMlizjJrU2xJmk+zbl
 I46joSePA3Vw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Jun 2020 14:00:19 -0700
IronPort-SDR: wuvk2Ruh6TAh5RePuQ5+4JrP2By/2bM/zIuLJSvvqOs39clzkTRfiUl8J8+iFhxoE29zqXJmkl
 WVch1c7uaJvQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,462,1583222400"; 
   d="scan'208";a="304005959"
Received: from lkp-server01.sh.intel.com (HELO 78d03bb9d680) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 01 Jun 2020 14:00:18 -0700
Received: from kbuild by 78d03bb9d680 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jfrXd-0000B2-EG; Mon, 01 Jun 2020 21:00:17 +0000
Date:   Tue, 02 Jun 2020 04:59:49 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 0cfc1b7f2f935584bdd6ef5d9a08a258a16d0a11
Message-ID: <5ed56c45./0Q7wexMHG4ZOcaX%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 0cfc1b7f2f935584bdd6ef5d9a08a258a16d0a11  xen: Add missing include to hvm_op.h

i386-tinyconfig vmlinux size:

+-------+------------------------------------+------------------------------------------+
| DELTA |               SYMBOL               |                  COMMIT                  |
+-------+------------------------------------+------------------------------------------+
|  +169 | TOTAL                              | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
|  +167 | TEXT                               | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
| +2048 | idt_table                          | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
|  +154 | init.text                          | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
|   +85 | idt_setup_apic_and_irq_gates()     | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
|  -136 | arch/x86/events/zhaoxin/built-in.* | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
| -2048 | idt_table                          | 5a7462b1f9c1..0cfc1b7f2f93 (ALL COMMITS) |
+-------+------------------------------------+------------------------------------------+

elapsed time: 484m

configs tested: 83
configs skipped: 3

The following configs have been built successfully.
More configs may be tested in the coming days.

arm64                            allyesconfig
arm64                               defconfig
arm64                            allmodconfig
arm64                             allnoconfig
arm                                 defconfig
arm                              allyesconfig
arm                              allmodconfig
arm                               allnoconfig
h8300                       h8s-sim_defconfig
arm                       imx_v4_v5_defconfig
mips                     decstation_defconfig
arm                          collie_defconfig
i386                              allnoconfig
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
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc                            allyesconfig
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
