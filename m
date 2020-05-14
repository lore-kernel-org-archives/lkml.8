Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF89EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:20:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A3F3720690
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 03:20:24 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726090AbgENDUX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 23:20:23 -0400
Received: from mga18.intel.com ([134.134.136.126]:55653 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725860AbgENDUX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 23:20:23 -0400
IronPort-SDR: U6orCHx7MISXGPUfZlLIf0h3WtsL5eLwdfQaz7PI1bD5ntKCPihqkgjMPNwt3yS3uzwfNMOUaq
 xw1Qtlc31JnA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 May 2020 20:20:22 -0700
IronPort-SDR: U6iY5f0v2kf5BOjKqutUFKtotL1Kq9VSUb4w5XTaYz4LUBCPG5o6fb4BCUni4PROAS9TQQNnJe
 dR3nUlkKfwpg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,390,1583222400"; 
   d="scan'208";a="262697501"
Received: from lkp-server01.sh.intel.com (HELO lkp-server01) ([10.239.97.150])
  by orsmga003.jf.intel.com with ESMTP; 13 May 2020 20:20:20 -0700
Received: from kbuild by lkp-server01 with local (Exim 4.89)
        (envelope-from <lkp@intel.com>)
        id 1jZ4Q0-0006uJ-5n; Thu, 14 May 2020 11:20:20 +0800
Date:   Thu, 14 May 2020 11:19:52 +0800
From:   kbuild test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:x86/entry] BUILD SUCCESS
 82ff351052bcc4bf49dc966960f563d25f54d22b
Message-ID: <5ebcb8d8.k+x73a6OR5jd9XH/%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  x86/entry
branch HEAD: 82ff351052bcc4bf49dc966960f563d25f54d22b  x86/idt: Keep spurious entries unset in system_vectors

elapsed time: 483m

configs tested: 158
configs skipped: 13

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
sparc                            allyesconfig
m68k                             allyesconfig
h8300                     edosk2674_defconfig
mips                     decstation_defconfig
sh                          rsk7201_defconfig
parisc                              defconfig
m68k                          amiga_defconfig
mips                malta_qemu_32r6_defconfig
i386                              allnoconfig
arm                     davinci_all_defconfig
arc                          axs101_defconfig
m68k                        mvme16x_defconfig
arc                              alldefconfig
sh                          sdk7786_defconfig
arm                            hisi_defconfig
arm                          exynos_defconfig
arm                            mps2_defconfig
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
riscv                    nommu_virt_defconfig
mips                        nlm_xlr_defconfig
arm                         s3c2410_defconfig
powerpc                      chrp32_defconfig
arm                     eseries_pxa_defconfig
xtensa                    xip_kc705_defconfig
arm                           h3600_defconfig
arm                         nhk8815_defconfig
powerpc                    adder875_defconfig
mips                 pnx8335_stb225_defconfig
sh                   sh7770_generic_defconfig
arm                            dove_defconfig
mips                 decstation_r4k_defconfig
arm                          moxart_defconfig
sh                               allmodconfig
sh                             espt_defconfig
arm                            xcep_defconfig
microblaze                          defconfig
arm                         orion5x_defconfig
mips                      pic32mzda_defconfig
mips                  mips_paravirt_defconfig
riscv                          rv32_defconfig
powerpc                      ppc44x_defconfig
arm                         at91_dt_defconfig
sh                           se7724_defconfig
arc                             nps_defconfig
arm                             rpc_defconfig
powerpc                       holly_defconfig
arm                           h5000_defconfig
arm                          pxa910_defconfig
sh                          rsk7203_defconfig
arm                         assabet_defconfig
m68k                                defconfig
arm                           sama5_defconfig
sh                        sh7785lcr_defconfig
arm                         shannon_defconfig
nios2                            alldefconfig
sh                   secureedge5410_defconfig
arm                      footbridge_defconfig
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
i386                 randconfig-a006-20200513
i386                 randconfig-a005-20200513
i386                 randconfig-a003-20200513
i386                 randconfig-a001-20200513
i386                 randconfig-a004-20200513
i386                 randconfig-a002-20200513
x86_64               randconfig-a005-20200513
x86_64               randconfig-a003-20200513
x86_64               randconfig-a006-20200513
x86_64               randconfig-a004-20200513
x86_64               randconfig-a001-20200513
x86_64               randconfig-a002-20200513
i386                 randconfig-a012-20200513
i386                 randconfig-a016-20200513
i386                 randconfig-a014-20200513
i386                 randconfig-a011-20200513
i386                 randconfig-a013-20200513
i386                 randconfig-a015-20200513
riscv                            allyesconfig
riscv                             allnoconfig
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
