Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01AD1C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:47:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CCCF12067B
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 22:47:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728517AbgFIWrK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 18:47:10 -0400
Received: from mga02.intel.com ([134.134.136.20]:59734 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728108AbgFIWrJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 18:47:09 -0400
IronPort-SDR: GczMb++UhNMjfaOuUuPXkJeMWL/L54eahF1hjnj7Ove/ZlU0/9EQLFAgmsZ4tiN8MT5kIBL4MS
 kia2EC1lmFkg==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Jun 2020 15:47:08 -0700
IronPort-SDR: vqvjx+g/Fn9wBptkHlfrNuYRt3+MZIxqFVRuKczEB4wYzvO3Vp050OeCzHWGp2z69Poiw5FBPz
 xQmxIvnmkC+Q==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,493,1583222400"; 
   d="scan'208";a="306403125"
Received: from lkp-server01.sh.intel.com (HELO 4a187143b92d) ([10.239.97.150])
  by orsmga008.jf.intel.com with ESMTP; 09 Jun 2020 15:47:07 -0700
Received: from kbuild by 4a187143b92d with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jin1O-0000A2-G5; Tue, 09 Jun 2020 22:47:06 +0000
Date:   Wed, 10 Jun 2020 06:46:22 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/urgent] BUILD SUCCESS
 7778d8417b74aded842eeb372961cfc460417fa0
Message-ID: <5ee0113e.HaZSQlZ/bV1dG1x0%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/urgent
branch HEAD: 7778d8417b74aded842eeb372961cfc460417fa0  x86/vdso: Unbreak paravirt VDSO clocks

i386-tinyconfig vmlinux size:

+-------+----------------------------+---------------------------------------------------------------------------+
| DELTA |           SYMBOL           |                                  COMMIT                                   |
+-------+----------------------------+---------------------------------------------------------------------------+
|  +194 | TOTAL                      | be25d1b5ea6a..7778d8417b74 (ALL COMMITS)                                  |
|  +116 | TOTAL                      | 21998a351512 x86/speculation: Avoid force-disabling IBPB based on STIBP a |
|   +50 | TOTAL                      | dbbe2ad02e9d x86/speculation: Prevent rogue cross-process SSBD shutdown   |
|  +194 | TEXT                       | be25d1b5ea6a..7778d8417b74 (ALL COMMITS)                                  |
|  +116 | TEXT                       | 21998a351512 x86/speculation: Avoid force-disabling IBPB based on STIBP a |
|   +50 | TEXT                       | dbbe2ad02e9d x86/speculation: Prevent rogue cross-process SSBD shutdown   |
|  +104 | altinstructions            | dbbe2ad02e9d x86/speculation: Prevent rogue cross-process SSBD shutdown   |
|   +72 | altinstr_aux               | dbbe2ad02e9d x86/speculation: Prevent rogue cross-process SSBD shutdown   |
|   +65 | arch_prctl_spec_ctrl_set() | be25d1b5ea6a..7778d8417b74 (ALL COMMITS)                                  |
|   +50 | arch_prctl_spec_ctrl_set() | 21998a351512 x86/speculation: Avoid force-disabling IBPB based on STIBP a |
|   +64 | arch_prctl_spec_ctrl_get() | 21998a351512 x86/speculation: Avoid force-disabling IBPB based on STIBP a |
+-------+----------------------------+---------------------------------------------------------------------------+

elapsed time: 485m

configs tested: 119
configs skipped: 4

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
m68k                         amcore_defconfig
mips                       rbtx49xx_defconfig
um                                  defconfig
sh                     magicpanelr2_defconfig
arm                           h3600_defconfig
sparc                            allyesconfig
powerpc                    mvme5100_defconfig
openrisc                 simple_smp_defconfig
arm                              zx_defconfig
mips                        nlm_xlr_defconfig
sh                             shx3_defconfig
sh                 kfr2r09-romimage_defconfig
arm                          moxart_defconfig
arc                         haps_hs_defconfig
m68k                            mac_defconfig
c6x                               allnoconfig
arm                        oxnas_v6_defconfig
um                                allnoconfig
arc                            hsdk_defconfig
m68k                          sun3x_defconfig
m68k                        m5272c3_defconfig
m68k                        stmark2_defconfig
arm                       omap2plus_defconfig
i386                             alldefconfig
s390                              allnoconfig
parisc                generic-32bit_defconfig
arm                          ep93xx_defconfig
s390                                defconfig
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
i386                 randconfig-a001-20200607
i386                 randconfig-a006-20200607
i386                 randconfig-a002-20200607
i386                 randconfig-a005-20200607
i386                 randconfig-a004-20200607
i386                 randconfig-a003-20200607
i386                 randconfig-a014-20200607
i386                 randconfig-a015-20200607
i386                 randconfig-a011-20200607
i386                 randconfig-a016-20200607
i386                 randconfig-a012-20200607
i386                 randconfig-a013-20200607
x86_64               randconfig-a002-20200607
x86_64               randconfig-a001-20200607
x86_64               randconfig-a006-20200607
x86_64               randconfig-a003-20200607
x86_64               randconfig-a004-20200607
x86_64               randconfig-a005-20200607
riscv                            allyesconfig
riscv                             allnoconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                             allmodconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allyesconfig
um                               allmodconfig
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
