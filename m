Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DF0EDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:36:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB2E020659
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 02:36:57 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726011AbgENCg4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 22:36:56 -0400
Received: from mga14.intel.com ([192.55.52.115]:48749 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725895AbgENCg4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 22:36:56 -0400
IronPort-SDR: ddwHQ7jI6Csmyn3h04NfbL20Ja0noSINLfLOyNybVMm3+hce84ILXPEbEEjYHl3OpxgMIFcgJ0
 Eq1MIV8v3n2g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 19:36:55 -0700
IronPort-SDR: uHaF1o94MY1758wZ6tBXyGzbj+CuUFwHvOqmtiDa8begXcrGK0tYZy6w7p4hPK8Kje0cYa04Di
 X/REmB4w5V1A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="297868968"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by fmsmga002.fm.intel.com with ESMTP; 13 May 2020 19:36:54 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZ3jy-0006KY-5Y; Thu, 14 May 2020 10:36:54 +0800
Date:   Thu, 14 May 2020 10:36:43 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:locking/kcsan] BUILD SUCCESS
 ffed638b6a2180da8fd002a46632d746af72b299
Message-ID: <5ebcaebb.CFDhn4QIodngiN1S%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  locking/kcsan
branch HEAD: ffed638b6a2180da8fd002a46632d746af72b299  READ_ONCE: Fix comment describing 2x32-bit atomicity

elapsed time: 853m

configs tested: 130
configs skipped: 11

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
m68k                             allyesconfig
sparc                            allyesconfig
mips                          rm200_defconfig
riscv                    nommu_virt_defconfig
mips                      pistachio_defconfig
xtensa                           alldefconfig
sh                           se7722_defconfig
arm                        cerfcube_defconfig
arm                         assabet_defconfig
openrisc                         alldefconfig
parisc                              defconfig
m68k                          amiga_defconfig
mips                malta_qemu_32r6_defconfig
i386                              allnoconfig
s390                       zfcpdump_defconfig
m68k                       m5249evb_defconfig
m68k                          sun3x_defconfig
sh                           se7619_defconfig
mips                        qi_lb60_defconfig
arc                        nsim_700_defconfig
arm                         lubbock_defconfig
arm                          tango4_defconfig
sh                            shmin_defconfig
mips                           mtx1_defconfig
mips                        nlm_xlr_defconfig
arm                         s3c2410_defconfig
sh                ecovec24-romimage_defconfig
arc                            hsdk_defconfig
arm                          iop32x_defconfig
riscv                             allnoconfig
mips                      pic32mzda_defconfig
mips                  mips_paravirt_defconfig
arm                         orion5x_defconfig
riscv                          rv32_defconfig
powerpc                      ppc44x_defconfig
m68k                       m5475evb_defconfig
sh                   rts7751r2dplus_defconfig
arm                         shannon_defconfig
nios2                            alldefconfig
sh                   secureedge5410_defconfig
arm                      footbridge_defconfig
arc                          axs101_defconfig
mips                     loongson1c_defconfig
c6x                        evmc6472_defconfig
um                               alldefconfig
arm                        clps711x_defconfig
powerpc                    adder875_defconfig
parisc                generic-64bit_defconfig
arm                        vexpress_defconfig
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
parisc                           allyesconfig
parisc                           allmodconfig
powerpc                             defconfig
powerpc                          allyesconfig
powerpc                          rhel-kconfig
powerpc                          allmodconfig
powerpc                           allnoconfig
x86_64               randconfig-a005-20200513
x86_64               randconfig-a003-20200513
x86_64               randconfig-a006-20200513
x86_64               randconfig-a004-20200513
x86_64               randconfig-a001-20200513
x86_64               randconfig-a002-20200513
riscv                            allyesconfig
riscv                               defconfig
riscv                            allmodconfig
s390                             allyesconfig
s390                              allnoconfig
s390                             allmodconfig
s390                                defconfig
x86_64                              defconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allmodconfig
um                                allnoconfig
um                               allyesconfig
um                                  defconfig
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
