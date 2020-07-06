Return-Path: <SRS0=eGSO=AR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	LONGWORDS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C23D4C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:09:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A04B42075B
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Jul 2020 09:09:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728590AbgGFJJC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Jul 2020 05:09:02 -0400
Received: from mga17.intel.com ([192.55.52.151]:36912 "EHLO mga17.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728024AbgGFJJC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jul 2020 05:09:02 -0400
IronPort-SDR: OEMkME77SOmWVbmrGmHxTkequ/bcvJZ36RFBjBwvx8kfHS9hG+5fQz8rZjZXOksSX+L3DJ2r4I
 9KFEebalLKdA==
X-IronPort-AV: E=McAfee;i="6000,8403,9673"; a="127452251"
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="127452251"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 06 Jul 2020 02:09:01 -0700
IronPort-SDR: /9z4r49cQ2xT1ALtSeX/xGAFoxe+gADZeD2O7PrkfzgVsUAsSit5+AL9Cy/v5o8+AJPk6LrL4k
 nJVXkr6ZKqFQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,318,1589266800"; 
   d="scan'208";a="296939641"
Received: from lkp-server01.sh.intel.com (HELO 82346ce9ac16) ([10.239.97.150])
  by orsmga002.jf.intel.com with ESMTP; 06 Jul 2020 02:08:59 -0700
Received: from kbuild by 82346ce9ac16 with local (Exim 4.92)
        (envelope-from <lkp@intel.com>)
        id 1jsN7T-00009Y-25; Mon, 06 Jul 2020 09:08:59 +0000
Date:   Mon, 06 Jul 2020 17:08:12 +0800
From:   kernel test robot <lkp@intel.com>
To:     "x86-ml" <x86@kernel.org>
Cc:     linux-kernel@vger.kernel.org
Subject: [tip:master] BUILD SUCCESS
 220dbf4aaa5b574f67ce23fa4d7b0104515bc60e
Message-ID: <5f02e9fc.XQ750krCH2k8+06c%lkp@intel.com>
User-Agent: Heirloom mailx 12.5 6/20/10
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

tree/branch: https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git  master
branch HEAD: 220dbf4aaa5b574f67ce23fa4d7b0104515bc60e  Merge branch 'WIP.core/headers'

elapsed time: 804m

configs tested: 156
configs skipped: 16

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
sh                                  defconfig
arm                      tct_hammer_defconfig
powerpc64                           defconfig
sh                        dreamcast_defconfig
arm                         orion5x_defconfig
mips                           ip22_defconfig
riscv                            alldefconfig
h8300                    h8300h-sim_defconfig
arm                         s3c2410_defconfig
mips                        vocore2_defconfig
arm                         assabet_defconfig
xtensa                              defconfig
arm                      jornada720_defconfig
xtensa                         virt_defconfig
sh                          landisk_defconfig
sh                          rsk7264_defconfig
arm                          ep93xx_defconfig
m68k                        stmark2_defconfig
sh                           se7780_defconfig
um                           x86_64_defconfig
powerpc                          g5_defconfig
powerpc                      pmac32_defconfig
microblaze                          defconfig
sh                          r7785rp_defconfig
openrisc                         allyesconfig
sparc                            alldefconfig
mips                  mips_paravirt_defconfig
sh                     sh7710voipgw_defconfig
nios2                            alldefconfig
m68k                            q40_defconfig
mips                      malta_kvm_defconfig
sh                        edosk7760_defconfig
powerpc                       maple_defconfig
arc                        vdk_hs38_defconfig
mips                         bigsur_defconfig
mips                          rb532_defconfig
arm                           tegra_defconfig
mips                          ath25_defconfig
s390                          debug_defconfig
c6x                        evmc6457_defconfig
arm                          gemini_defconfig
arm                         bcm2835_defconfig
mips                          ath79_defconfig
mips                 decstation_r4k_defconfig
mips                         rt305x_defconfig
sh                          rsk7269_defconfig
sparc64                          alldefconfig
powerpc                         wii_defconfig
arm                  colibri_pxa300_defconfig
arm                            mps2_defconfig
arm                        oxnas_v6_defconfig
arm                              zx_defconfig
arc                          axs103_defconfig
arm                           efm32_defconfig
arc                                 defconfig
arm                          prima2_defconfig
powerpc                      ppc64e_defconfig
h8300                            alldefconfig
sh                             espt_defconfig
um                             i386_defconfig
sh                           se7721_defconfig
arm                           corgi_defconfig
mips                malta_qemu_32r6_defconfig
arm                            pleb_defconfig
arm                          lpd270_defconfig
arm                        neponset_defconfig
sh                            migor_defconfig
openrisc                    or1ksim_defconfig
alpha                               defconfig
sh                          polaris_defconfig
sh                   sh7724_generic_defconfig
ia64                              allnoconfig
powerpc                 mpc8272_ads_defconfig
arm                       versatile_defconfig
um                            kunit_defconfig
arm                              alldefconfig
sh                           se7206_defconfig
xtensa                generic_kc705_defconfig
m68k                        mvme16x_defconfig
m68k                           sun3_defconfig
sh                           se7705_defconfig
xtensa                          iss_defconfig
i386                             allyesconfig
i386                                defconfig
i386                              debian-10.3
i386                              allnoconfig
ia64                             allmodconfig
ia64                                defconfig
ia64                             allyesconfig
m68k                             allmodconfig
m68k                              allnoconfig
m68k                                defconfig
m68k                             allyesconfig
nios2                               defconfig
nios2                            allyesconfig
openrisc                            defconfig
c6x                              allyesconfig
c6x                               allnoconfig
nds32                               defconfig
nds32                             allnoconfig
csky                             allyesconfig
csky                                defconfig
alpha                            allyesconfig
xtensa                           allyesconfig
h8300                            allyesconfig
h8300                            allmodconfig
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
sparc                            allyesconfig
sparc                               defconfig
sparc64                             defconfig
sparc64                           allnoconfig
sparc64                          allyesconfig
sparc64                          allmodconfig
um                               allyesconfig
um                                allnoconfig
um                                  defconfig
um                               allmodconfig
x86_64                               rhel-7.6
x86_64                    rhel-7.6-kselftests
x86_64                               rhel-8.3
x86_64                                  kexec
x86_64                                   rhel
x86_64                         rhel-7.2-clear
x86_64                                    lkp
x86_64                              fedora-25

---
0-DAY CI Kernel Test Service, Intel Corporation
https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
