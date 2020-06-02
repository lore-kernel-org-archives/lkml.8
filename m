Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6B801C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4672E20734
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726408AbgFBKrS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:47:18 -0400
Received: from mga17.intel.com ([192.55.52.151]:7849 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726110AbgFBKrR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:47:17 -0400
IronPort-SDR: XKef0mR+JHOWCsq9V7SYr23MWHVb99EtovCg1HGAaVXZVJOL1dmrCN7Amp8jCYDq7qiI9Eer4D
 0PhwLziTs16Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jun 2020 03:47:17 -0700
IronPort-SDR: HWmK1wDtGMolRalcvqUC73eHLRZxrHPsk9UsO4or12Gw6pdE/8Cbv5nrx/iZoZJkjsZoSKs/NI
 0FPRuGI9lfKg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,464,1583222400"; 
   d="scan'208";a="304194394"
Received: from lkp-server01.sh.intel.com (HELO 886b752aa57b) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 02 Jun 2020 03:47:15 -0700
Received: from kbuild by 886b752aa57b with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jg4Rv-0000AV-1u; Tue, 02 Jun 2020 10:47:15 +0000
Date:   Tue, 02 Jun 2020 18:46:31 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 4b1f63084d3ebd14c3ef2cd4e8732c25bcd8381d
Message-ID: <5ed62e07.B1t2R+x6AlO41qTF%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 4b1f63084d3ebd14c3ef2cd4e8732c25bcd8381d  x86/xen: Unbreak hypervisor callback on 32bit

i386-tinyconfig vmlinux size:

+-------+------------------------------------+------------------------------------------------------------+
| DELTA |               SYMBOL               |                           COMMIT                           |
+-------+------------------------------------+------------------------------------------------------------+
|  +170 | TOTAL                              | 5a7462b1f9c1..4b1f63084d3e (ALL COMMITS)                   |
|  +167 | TEXT                               | 5a7462b1f9c1..4b1f63084d3e (ALL COMMITS)                   |
| +2048 | idt_table                          | 5a7462b1f9c1..4b1f63084d3e (ALL COMMITS)                   |
|  +154 | init.text                          | 5a7462b1f9c1..4b1f63084d3e (ALL COMMITS)                   |
|  +136 | arch/x86/events/zhaoxin/built-in.* | 4b1f63084d3e x86/xen: Unbreak hypervisor callback on 32bit |
|   +85 | idt_setup_apic_and_irq_gates()     | 5a7462b1f9c1..4b1f63084d3e (ALL COMMITS)                   |
| -2048 | idt_table                          | 5a7462b1f9c1..4b1f63084d3e (ALL COMMITS)                   |
+-------+------------------------------------+------------------------------------------------------------+

elapsed time: 792m

configs tested: 83
configs skipped: 2

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
xtensa                generic_kc705_defconfig
openrisc                         alldefconfig
arm                        neponset_defconfig
arm                      jornada720_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                              allnoconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                           sun3_defconfig
m68k                                defconfig
m68k                             allyesconfig
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
microblaze                        allnoconfig
arc                                 defconfig
arc                              allyesconfig
sh                               allmodconfig
sh                                allnoconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
openrisc                         allyesconfig
mips                             allyesconfig
mips                              allnoconfig
mips                             allmodconfig
parisc                            allnoconfig
parisc                              defconfig
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
powerpc                             defconfig
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
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
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
x86_64                              fedora-25
x86_64                                  kexec
x86_64                                   rhel
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                         rhel-7.2-clear
x86_64                                    lkp

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
